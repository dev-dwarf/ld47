/// @description

// Inherit the parent event
event_inherited();


idle_time = 1.5*60; // time between shots, rn 1 1/2 seconds
idle_timer = idle_time;

hp = 3;

state = enemy_states.attack;

attack_direction = 0;
dash_speed = 3;
attack_accel = 0.05;
attack_speed = 0;