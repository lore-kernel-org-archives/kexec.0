Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QFZKt-0003pV-1d
	for kexec@lists.infradead.org; Thu, 28 Apr 2011 22:05:23 +0000
Date: Fri, 29 Apr 2011 07:05:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: remove duplicated backup_src_start field from
	struct crash_elf_info
Message-ID: <20110428220515.GI3610@verge.net.au>
References: <1303875207-9273-1-git-send-email-amwang@redhat.com>
	<20110427150151.GB7790@redhat.com> <4DB91DFC.4060708@redhat.com>
	<20110428131539.GA7883@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110428131539.GA7883@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Cong Wang <amwang@redhat.com>

T24gVGh1LCBBcHIgMjgsIDIwMTEgYXQgMDk6MTU6MzlBTSAtMDQwMCwgVml2ZWsgR295YWwgd3Jv
dGU6Cj4gT24gVGh1LCBBcHIgMjgsIDIwMTEgYXQgMDM6NTc6NDhQTSArMDgwMCwgQ29uZyBXYW5n
IHdyb3RlOgo+ID4g5LqOIDIwMTHlubQwNOaciDI35pelIDIzOjAxLCBWaXZlayBHb3lhbCDlhpnp
gZM6Cj4gPiA+QW1lcmlnbywKPiA+ID4KPiA+ID5Ob3cgd2hvIHdpbGwgZG8gZm9sbG93aW5nIGlu
aXRpYWxpemF0aW9uIGZvciBwcGM/Cj4gPiA+Cj4gPiA+aW5mby0+YmFja3VwX3NyY19zdGFydCA9
IEJBQ0tVUF9TUkNfU1RBUlQ7Cj4gPiA+aW5mby0+YmFja3VwX3N6ID0gQkFDS1VQX1NSQ19FTkQg
LSBCQUNLVVBfU1JDX1NUQVJUICsgMTsKPiA+ID4KPiA+ID5JIHRoaW5rIEkgaGF2ZSBjb25jZXJu
IGZvciBtaXBzIHRvby4KPiA+IAo+ID4gUmlnaHQsIHdlIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGVt
IGluIGxvYWRfY3Jhc2hkdW1wX3NlZ21lbnRzKCkuCj4gPiAKPiA+IEhvdyBhYm91dCB0aGUgYXR0
YWNoZWQgcGF0Y2g/IEl0IGlzIHVudGVzdGVkLgo+ID4gCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
QU5HIENvbmcgPGFtd2FuZ0ByZWRoYXQuY29tPgo+IAo+IE9rLCB0aGlzIG9uZSBsb29rcyBiZXR0
ZXIuCgpWaXZlaywgY2FuIEkgdGFrZSB0aGF0IGFzIGFuIEFja2VkLWJ5PwoKQ29uZywgY2FuIHlv
dSBjbGFyaWZ5IGlmIEkgbmVlZCB0byByZXZlcnQgYW55IG9mIHlvdXIgcmVjZW50IHBhdGNoZXMg
b3IKbm90PwoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
