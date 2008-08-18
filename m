Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KV2TN-0003Ii-QP
	for kexec@lists.infradead.org; Mon, 18 Aug 2008 11:00:30 +0000
Date: Mon, 18 Aug 2008 13:00:25 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: makedumpfile fails on SGI machine
Message-ID: <20080818130025.0282e471@halley.suse.de>
In-Reply-To: <48A9228A.3070005@mxs.nes.nec.co.jp>
References: <20080730161416.47605c30@halley.suse.de>
	<4891197D.10400@mxs.nes.nec.co.jp>
	<20080731104726.035850be@halley.suse.de>
	<48919306.80103@mxs.nes.nec.co.jp>
	<20080731131823.3c7c97b2@halley.suse.de>
	<4891A3CB.9040805@mxs.nes.nec.co.jp>
	<48984275.5070409@mxs.nes.nec.co.jp>
	<20080805171143.773c2465@halley.suse.de>
	<48A9228A.3070005@mxs.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

SGksCgoqIEtlbidpY2hpIE9obWljaGkgWzIwMDgtMDgtMTggMTY6MTldOgo+IEJlcm5oYXJkIFdh
bGxlIHdyb3RlOgo+ID4gKiBLZW4naWNoaSBPaG1pY2hpIFsyMDA4LTA4LTA1IDIxOjA3XToKPiA+
PiBCVFcsIEknZCBsaWtlIHRvIGtub3cgc29tZSBjb25kaXRpb25zIG9mIHRoaXMgcHJvYmxlbS4K
PiA+PiBTbyBwbGVhc2UgbGV0IG1lIGtub3cgdGhlIG1ha2VkdW1wZmlsZSBjb21tYW5kbGluZSB3
aGljaCB5b3UgcnVuLgo+ID4+ICBFeC4gIyBtYWtlZHVtcGZpbGUgLWQgMzEgLXggdm1saW51eCAv
cHJvYy92bWNvcmUgZHVtcGZpbGUKPiA+IAo+ID4gICAjIG1ha2VkdW1wZmlsZSAtZCAzIC1EIHZt
Y29yZS5zbGVzMTEgdm1jb3JlLnNsZXMxMS5maWx0ZXJlZAo+ID4gCj4gPj4gSSBkb3VidCB0aGF0
IG1ha2VkdW1wZmlsZSBjYW5ub3QgZGlzdGluZ3Vpc2ggdGhlIHBndGFibGUgY29ycmVjdGx5Lgo+
ID4+IEkgY3JlYXRlZCB0aGUgZGVidWdnaW5nIHBhdGNoLiBQbGVhc2UgcnVuIG1ha2VkdW1wZmls
ZS0xLjIuNyBhcHBsaWVkCj4gPj4gd2l0aCBpdCBieSAnLUQnIG9wdGlvbiwgYW5kIHJlcG9ydCB0
aGUgb3V0cHV0Lgo+ID4+IEFjY29yZGluZyB0byB5b3VyIGtlcm5lbCAuY29uZmlnIGZpbGUsIHRo
ZSBvdXRwdXQgc2hvdWxkIGNvbnRhaW4KPiA+PiAiUEFHRVRBQkxFXzRMIDogT04iLgo+ID4gCj4g
PiBTZWUgdGhlIGF0dGFjaG1lbnQuCj4gCj4gVGhhbmtzIGZvciB0aGUgbG9nLgo+IG1ha2VkdW1w
ZmlsZSBjYW4gZGlzdGluZ3Vpc2ggdGhlIHBndGFibGUgY29ycmVjdGx5Lgo+IAo+IENhbiB0aGUg
Y3Jhc2ggdXRpbGl0eSB0cmFuc2xhdGUgdGhlIHZpcnR1YWwgYWRkcmVzcyAweGEwMDA3ZmZmOGY5
MDAwMDAKPiB0byBwaHlzaWNhbCBhZGRyZXNzID8gUGxlYXNlIHJ1biB0aGUgZm9sbG93aW5nIHN1
YmNvbW1hbmQgb24gdGhlIGNyYXNoCj4gdXRpbGl0eS4KPiAKPiBjcmFzaD4gdnRvcCAweGEwMDA3
ZmZmOGY5MDAwMDAKCmNyYXNoPiB2dG9wIDB4YTAwMDdmZmY4ZjkwMDAwMCAgClZJUlRVQUwgICAg
ICAgICAgIFBIWVNJQ0FMICAgICAgICAKYTAwMDdmZmY4ZjkwMDAwMCAgKG5vdCBtYXBwZWQpCgpQ
QUdFIERJUkVDVE9SWTogYTAwMDAwMDEwMDkxNDAwMAogICBQR0Q6IGEwMDAwMDAxMDA5MTQwMDAg
PT4gMzAwMzBiYzAwMAogICBQVUQ6IGUwMDAwMDMwMDMwYmZmZjggPT4gMzAwMzBjMDAwMAogICBQ
TUQ6IGUwMDAwMDMwMDMwYzNlMzggPT4gMzAwMzBjNDAwMAogICBQVEU6IGUwMDAwMDMwMDMwYzcy
MDAgPT4gMAoKCkJ1dCBJIGd1ZXNzIHRoYXQncyBub3JtYWwgd2l0aCB2aXJ0dWFsIG1lbW9yeSBt
YXBzOgoKJCB6Z3JlcCBWSVJUVUFMX00gL3Byb2MvY29uZmlnLmd6IApDT05GSUdfVklSVFVBTF9N
RU1fTUFQPXkKCgpCZXJuaGFyZAotLSAKQmVybmhhcmQgV2FsbGUsIFNVU0UgTElOVVggUHJvZHVj
dHMgR21iSCwgQXJjaGl0ZWN0dXJlIERldmVsb3BtZW50CgrigJxNYWtlIGV2ZXJ5dGhpbmcgYXMg
c2ltcGxlIGFzIHBvc3NpYmxlLCBidXQgbm90IHNpbXBsZXIu4oCdCiAgICAgICAtLSBBbGJlcnQg
RWluc3RlaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
