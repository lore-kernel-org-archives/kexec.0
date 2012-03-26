Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCEcK-0000fs-Qz
 for kexec@lists.infradead.org; Mon, 26 Mar 2012 18:26:09 +0000
Received: by iaky10 with SMTP id y10so10283383iak.36
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2012 11:25:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120326180729.GB5398@tango.0pointer.de>
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
 <20120322223646.GC26794@verge.net.au>
 <20120326180729.GB5398@tango.0pointer.de>
From: Marti Raudsepp <marti@juffo.org>
Date: Mon, 26 Mar 2012 21:25:16 +0300
Message-ID: <CABRT9RBa-x661VxvvinD6BPdFc0sharst-h9mgz0kht6aQr76Q@mail.gmail.com>
Subject: Re: Doing kexec reboot right in systemd
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lennart Poettering <lennart@poettering.net>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, Simon Horman <horms@verge.net.au>, kexec list <kexec@lists.infradead.org>

T24gTW9uLCBNYXIgMjYsIDIwMTIgYXQgMjE6MDcsIExlbm5hcnQgUG9ldHRlcmluZwo8bGVubmFy
dEBwb2V0dGVyaW5nLm5ldD4gd3JvdGU6Cj4gTWFydGksIHNvcnJ5IGZvciBjaGFuZ2luZyBteSBt
aW5kIG9uIHRoaXM6IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZAo+IHByZXAgYSBwYXRjaCBm
b3IgdGhpcyBmb3Igc3lzdGVtZCBpdHNlbGYuCgpEJ29oLCBJIGFscmVhZHkgcHJlcGFyZWQgYSBw
YXRjaCBmb3Iga2V4ZWMsIGFsdGhvdWdoIEkgaGF2ZW4ndCBzZW50IGl0IG91dCB5ZXQuCgo+IEht
bSwgc28gc2luY2UgdGhpcyB3b3VsZCB0aGVuIGJlbG9uZyBpbiB0aGUgc2h1dGRvd24gcGF0aCBv
ZiBzeXN0ZW1kLAo+IGFuZCBvbmx5IGJlIGFkZGVkIGZvciB0aGUga2V4ZWMgc2h1dGRvd24gcGF0
aCBJIGFjdHVhbGx5IHRoaW5rIGl0IHdvdWxkCj4gbWFrZSBtb3JlIHNlbnNlIHRvIGFkZCB0aGlz
IGludG8gc3lzdGVtZCBpdHNlbGYgaW5zdGVhZCBvZiBrZXhlYy10b29scywKPiB0byBlbnN1cmUg
dGhlIHJpZ2h0IG9yZGVyaW5nLgoKVW0sIHdoeSBpcyBpbmNsdWRpbmcgaW4gc3lzdGVtZCBuZWNl
c3NhcnkgZm9yIGd1YXJhbnRlZWluZyBvcmRlcj8KU2VlbXMgbGlrZSB0aGlzIHNob3VsZCBkbyBp
dC4uLgoKW1VuaXRdCkRlZmF1bHREZXBlbmRlbmNpZXM9bm8KQmVmb3JlPXNodXRkb3duLnRhcmdl
dCB1bW91bnQudGFyZ2V0IGZpbmFsLnRhcmdldApbSW5zdGFsbF0KV2FudGVkQnk9a2V4ZWMudGFy
Z2V0Cgo+IEknZCBsaWtlIHRvIGtlZXAga2V4ZWMudGFyZ2V0IGRpZmZlcmVudCBmcm9tIHJlYm9v
dC50YXJnZXQgYnkKPiBkZWZhdWx0LCBzbyB0aGF0IHBlb3BsZSBoYXZlIGJvdGggb3B0aW9ucyBh
dmFpbGFibGUuCgpGYWlyIGVub3VnaC4KCj4gYSkgd2UgaW50cm9kdWNlIGtleGVjLWxvYWQuc2Vy
dmljZSB3aGljaCBpcyBhbHdheXMgaW4gdGhlIGtleGVjLnRhcmdldAo+IMKgIHNodXRkb3duIHBh
dGgsIG5ldmVyIGluIHJlYm9vdC50YXJnZXQuIERvZXNuJ3QgbmVlZCB0byBiZSBlbmFibGVkLgo+
Cj4gYikga2V4ZWMtbG9hZC5zZXJ2aWNlIGJlY29tZXMgYSBOT1AgaWYgYSBrZXJuZWwgaXMgYWxy
ZWFkeSBsb2FkZWQKPgo+IGMpICJzeXN0ZW1jdGwgcmVib290IiBjb250aW51ZXMgdG8gY2hlY2sg
d2hldGhlciBhIGtlcm5lbCBpcyBhbHJlYWR5Cj4gwqAgbG9hZGVkLCBhbmQgaWYgc28gcmVzdWx0
cyBpbiBrZXhlYy50YXJnZXQgYmVpbmcgc3RhcnRlZCByYXRoZXIgdGhhbgo+IMKgIHJlYm9vdC50
YXJnZXQKPgo+IGQpIElmIHRoZSB1c2VyIHdhbnRzIHRoYXQgdGhlIG1hY2hpbmUgaXMgYWx3YXlz
IHJlYm9vdGVkIHZpYSBrZXhlYywKPiDCoCBuZXZlciB3aXRoIHRyYWRpdGlvbmFsIHJlYm9vdCwg
aGUgY2FuIG1hbnVhbGx5IGNyZWF0ZSBhIHN5bWxpbmsKPiDCoCAvZXRjL3N5c3RlbWQvc3lzdGVt
L3JlYm9vdC50YXJnZXQgdG8KPiDCoCAvZXRjL3N5c3RlbWQvc3lzdGVtL2tleGVjLnRhcmdldC4K
ClllYWgsIGFncmVlZC4KClJlZ2FyZHMsCk1hcnRpCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
