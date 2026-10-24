extends VBoxContainer

@export var mailing_list_label: Label
@export var line_and_confirm_container: Control
@export var email_line_edit: LineEdit
@export var subscribe_button: Button
@export var mailing_list_ok_label: Label
@export var mailing_list_invalid_label: Label
@export var mailing_list_err_label: Label
@export var http_request: HTTPRequest
@export var after_focus_target: Control

enum MAILING_RESULT{
	OK, 
	INVALID_EMAIL, 
	ERR
}

var using_keyboard: = true:
	set(value):
		using_keyboard = value
		_update_visible()
var connection_made: = true:
	set(value):
		connection_made = value
		_update_visible()

func _ready() -> void :
	InputMethodWatcher.controller_changed.connect(_on_controller_changed)
	_on_controller_changed(InputMethodWatcher.current_input_method)

	email_line_edit.text_submitted.connect(_on_subscribe_button_pressed.unbind(1))
	subscribe_button.pressed.connect(_on_subscribe_button_pressed)

	_check_connection()






func _on_controller_changed(new_controller: InputMethodWatcher.INPUT_METHOD) -> void :
	using_keyboard = new_controller == InputMethodWatcher.INPUT_METHOD.KEYBOARD

func _on_subscribe_button_pressed():
	var text: = email_line_edit.text

	if not "@" in text:
		_display_line_edit(false, MAILING_RESULT.INVALID_EMAIL)
		return

	var result: = http_request.request("https://qwerty.asd" + text)
	_display_line_edit(false, MAILING_RESULT.ERR)

func _check_connection():
	var connection_http_request: = HTTPRequest.new()
	add_child(connection_http_request)

	connection_http_request.request_completed.connect(
		func request_completed(result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray):
			connection_made = result == HTTPRequest.RESULT_SUCCESS
			connection_http_request.queue_free()
	)

	var request_result: = connection_http_request.request("https://qwerty.asdahdfga")

	if not request_result:
		connection_made = false

func _display_line_edit(visible_value: bool, mailing_result: MAILING_RESULT = MAILING_RESULT.ERR):
	mailing_list_label.visible = visible_value
	line_and_confirm_container.visible = visible_value

	mailing_list_ok_label.visible = false
	mailing_list_invalid_label.visible = false
	mailing_list_err_label.visible = false

	if not visible_value:
		match mailing_result:
			MAILING_RESULT.OK:
				mailing_list_ok_label.visible = true
				after_focus_target.grab_focus()
				await get_tree().create_timer(tr("MAILING_LIST_OK").length() * 0.1).timeout
			MAILING_RESULT.INVALID_EMAIL:
				mailing_list_invalid_label.visible = true
				after_focus_target.grab_focus()
				await get_tree().create_timer(tr("MAILING_LIST_INVALID").length() * 0.1).timeout
			MAILING_RESULT.ERR:
				mailing_list_err_label.visible = true
				after_focus_target.grab_focus()
				await get_tree().create_timer(tr("MAILING_LIST_ERR").length() * 0.1).timeout
		email_line_edit.text = ""
		_display_line_edit(true)

func _update_visible() -> void :
	var new_value: = using_keyboard and connection_made

	if not new_value:
		if email_line_edit.has_focus() or subscribe_button.has_focus():
			after_focus_target.grab_focus()

	visible = new_value
