use v6;
unit module RawSocket;

use NativeCall;

sub socket(int32, int32, int32) returns int32 is native("clib/p6rawsocket") is symbol('p6_socket') is export { ... }

sub send(int32, int32, int32) returns size_t is native("clib/p6rawsocket") is symbol('p6_send') is export { ... }
