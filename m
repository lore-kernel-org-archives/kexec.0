Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QCV0x-0006tb-QX
	for kexec@lists.infradead.org; Wed, 20 Apr 2011 10:52:08 +0000
Message-ID: <4DAEBAD2.5080004@redhat.com>
Date: Wed, 20 Apr 2011 18:52:02 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [Patch] kexec: fix the missing i386 part in commit 1100580b05e
References: <1303028945-15298-1-git-send-email-amwang@redhat.com>
	<20110418125802.GD30783@redhat.com>
	<4DAD8461.5050101@redhat.com> <4DADB63D.8050001@redhat.com>
	<20110419165359.GI31712@redhat.com>
In-Reply-To: <20110419165359.GI31712@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

5LqOIDIwMTHlubQwNOaciDIw5pelIDAwOjUzLCBWaXZlayBHb3lhbCDlhpnpgZM6Cj4gT24gV2Vk
LCBBcHIgMjAsIDIwMTEgYXQgMTI6MjA6MTNBTSArMDgwMCwgQ29uZyBXYW5nIHdyb3RlOgo+PiDk
uo4gMjAxMeW5tDA05pyIMTnml6UgMjA6NDcsIENvbmcgV2FuZyDlhpnpgZM6Cj4+PiDkuo4gMjAx
MeW5tDA05pyIMTjml6UgMjA6NTgsIFZpdmVrIEdveWFsIOWGmemBkzoKPj4+PiBIYXZlIHlvdSB2
ZXJpZmllZCB0aGUgY29udGVudHMgb2YgYmFja3VwIGFyZWE/IEkgd2FudCB0byBtYWtlIHN1cmUg
dGhhdAo+Pj4+IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyBhbmQgaW4gc2Vjb25kIGtlcm5lbCB3aGVu
IHdlIHJlYWQgdXAgdm1jb3JlLCB3ZQo+Pj4+IGRvIHJlYWQgY29udGVudHMgcHJvcGVybHkuCj4+
Pj4KPj4+Cj4+PiBOb3QgeWV0LCBJIGFtIHN0aWxsIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoYXQg
dGhlIHByb2JsZW0gaXMuCj4+PiBJIHdpbGwgc2VuZCBhbm90aGVyIHBhdGNoIG9uY2UgSSBrbm93
IGhvdyB0byBmaXggaXQsIHNvLCBhbHRob3VnaCB0aGlzCj4+PiBwYXRjaCBkb2Vzbid0IGZpeCB0
aGF0IHByb2JsZW0sIGl0IGlzIGNsZWFybHkgbmVlZGVkLgo+Pgo+PiBPaywgdGhlIGlzc3VlIEkg
ZGlzY3Vzc2VkIHdpdGggVml2ZWsgZG9lcyBfbm90XyBhcHBseSB0byB1cHN0cmVhbSwKPj4gdGhh
dCBpcyBhIG1pc3Rha2Ugd2hlbiBJIGJhY2twb3J0ZWQgdGhlIHBhdGNoIHRvIFJIRUw1Lgo+Pgo+
PiBTbywgZm9yIHVwc3RyZWFtIHRoZSBwYXRjaCBpbiB0aGlzIHRocmVhZCBpcyBlbm91Z2guCj4+
Cj4+IEhvcGUgdGhpcyBpcyBjbGVhciBub3cuCj4KPiBTbyBhZ2FpbiwgaGF2ZSB5b3UgZG9uZSB0
ZXN0aW5nIG9uIHVwc3RyZWFtIGtlcm5lbHMgdG8gbWFrZSBzdXJlIGJhY2t1cAo+IGFyZWEgY29u
dGVudHMgYXJlIGZpbmU/CgpJIGRpZCBhIGNyYXNoIHJlYm9vdCB0ZXN0IGFuZCBkaWRuJ3Qgc2Vl
IGFueSBwcm9ibGVtcywKYnV0IEkgZGlkbid0IGNoZWNrIHRoZSBiYWNrdXAgYXJlYSBjb250ZW50
cy4gOi0vCgpJIHdpbGwgbG9vayBhdCB0aGlzIHNob3J0bHkuCgpUaGFua3MuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
