/// @description

hp = 3;
i_frames = 0;

enum enemy_states {
	idle, attack, recover, hit, dead
}
state = enemy_states.idle;