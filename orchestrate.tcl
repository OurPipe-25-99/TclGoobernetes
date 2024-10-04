#!/usr/bin/tclsh

# Solves some issues with interop /w other CLI things
catch {console show};

puts "Tcl/Goobernetes task orchestrator monolith";

proc yt-dlp-args {} {
	set str	"";
	set 0 {-x};
	set 1 {--audio-format}; set 2 {mp3};
	set 3 {--embed-thumbnail};
	set 4 {--embed-metadata};
	set 5 {--write-info-json};
	for {set i 0} {$i < 6} {incr i} {
		if {$str eq ""} {set str [subst "$$i"]} else {
			set str "$str#[subst "$$i"]";
		};
	};
	set list [split $str "#"];
	return $list;
};

# From https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#filesystem-options:
#
# -a, --batch-file FILE           File containing URLs to download ("-" for
#                                 stdin), one URL per line. Lines starting
#                                 with "#", ";" or "]" are considered as
#                                 comments and ignored
#
# The ideal way to deal with this functionality would be to make -a an optional
# mode for orchestrator.tcl for when we are doing a batch download from multiple URLs.
proc get-batchfile {} {
	puts "ToDo";
};

proc yt-dlp {uri} {
	set args "";
	foreach arg [yt-dlp-args] {
		append args "$arg ";	
	};
	set exec_cmd "yt-dlp $args$uri";
	exec >&@stdout {*}$exec_cmd;  
	# {*} is new Tcl 8.5 syntax that helps reduce the use of eval.
	# eval exec $exec_cmd

	# catch { # Remove "child process exited abnormally" faux error.
	# 	exec >&@stdout {*}$exec_cmd;  
	# } err;
};

# puts "$argc: [lindex $argv 0]";

# yt-dlp "https://www.youtube.com/watch?v=8e63d7yW-qg";
# yt-dlp "https://www.youtube.com/watch?v=9LoEL_SHcn4";
yt-dlp "https://www.youtube.com/watch?v=VOzO5U576iM";
