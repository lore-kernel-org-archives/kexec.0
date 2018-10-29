Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH7nj-0003S3-3l
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 13:41:53 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
From: lijiang <lijiang@redhat.com>
Message-ID: <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
Date: Mon, 29 Oct 2018 21:41:26 +0800
MIME-Version: 1.0
In-Reply-To: <20181029114414.GA11408@MiWiFi-R3L-srv>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, x86@kernel.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQxMOaciDI55pelIDE5OjQ0LCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAxMC8y
OS8xOCBhdCAwNjoxMnBtLCBsaWppYW5nIHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVj
XzY0LmMKPj4gaW5kZXggNGM4YWNkZmRjNWE3Li4zY2M5NzVlN2ZmOGYgMTAwNjQ0Cj4+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL21hY2hpbmVfa2V4ZWNfNjQuYwo+PiBAQCAtMzUyLDExICszNTIsMTYgQEAgdm9pZCBtYWNo
aW5lX2tleGVjKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+Pgo+ICB2b2lkIGFyY2hfY3Jhc2hfc2F2
ZV92bWNvcmVpbmZvKHZvaWQpCj4gIHsKPiArICAgICAgIHU2NCBzbWVfbWFzayA9IHNtZV9tZV9t
YXNrOwo+ICsKPiAKPiBUaGlzIG1heSBsb29rcyBiZXR0ZXIuCj4gCgpPaywgdGhhbmtzIGZvciB5
b3VyIGNvbW1lbnQuCgo+ICAgICAgICAgVk1DT1JFSU5GT19OVU1CRVIocGh5c19iYXNlKTsKPiAg
ICAgICAgIFZNQ09SRUlORk9fU1lNQk9MKGluaXRfdG9wX3BndCk7Cj4gICAgICAgICB2bWNvcmVp
bmZvX2FwcGVuZF9zdHIoIk5VTUJFUihwZ3RhYmxlX2w1X2VuYWJsZWQpPSVkXG4iLAo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHBndGFibGVfbDVfZW5hYmxlZCgpKTsKPiAKPiArICAgICAgIFZN
Q09SRUlORk9fTlVNQkVSKHNtZV9tYXNrKTsKPiArCj4gICNpZmRlZiBDT05GSUdfTlVNQQo+ICAg
ICAgICAgVk1DT1JFSU5GT19TWU1CT0wobm9kZV9kYXRhKTsKPiAgICAgICAgIFZNQ09SRUlORk9f
TEVOR1RIKG5vZGVfZGF0YSwgTUFYX05VTU5PREVTKTsKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
