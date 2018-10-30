Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHMIc-0006NJ-FE
 for kexec@lists.infradead.org; Tue, 30 Oct 2018 05:10:44 +0000
Date: Tue, 30 Oct 2018 13:09:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
References: <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de

T24gMTAvMzAvMTggYXQgMTI6NDZwbSwgbGlqaWFuZyB3cm90ZToKPiDlnKggMjAxOOW5tDEw5pyI
Mjnml6UgMjE6NDksIEJvcmlzbGF2IFBldGtvdiDlhpnpgZM6Cj4gPiBPbiBNb24sIE9jdCAyOSwg
MjAxOCBhdCAwOTo0MToyNlBNICswODAwLCBsaWppYW5nIHdyb3RlOgo+ID4+PiAgICAgICAgIFZN
Q09SRUlORk9fTlVNQkVSKHBoeXNfYmFzZSk7Cj4gPj4+ICAgICAgICAgVk1DT1JFSU5GT19TWU1C
T0woaW5pdF90b3BfcGd0KTsKPiA+Pj4gICAgICAgICB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5V
TUJFUihwZ3RhYmxlX2w1X2VuYWJsZWQpPSVkXG4iLAo+ID4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBwZ3RhYmxlX2w1X2VuYWJsZWQoKSk7Cj4gPj4+Cj4gPj4+ICsgICAgICAgVk1DT1JFSU5G
T19OVU1CRVIoc21lX21hc2spOwo+ID4gCj4gPiBXaGF0IEknbSBzdGlsbCBtaXNzaW5nIGZyb20g
dGhlIHdob2xlIGZ1biBpcyB3aGVyZSBhcmUgd2UgZG9jdW1lbnRpbmcKPiA+IHRoZSBjb250ZW50
cyBvZiB0aGF0IHZtY29yZWluZm8gdGhpbmc/Cj4gPiAKPiAKPiBJJ20gbm90IHN1cmUgd2hldGhl
ciB0aGUgZm9sbG93aW5nIGRvY3VtZW50IGlzIHdoYXQgeW91IG5lZWQuCj4gRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy9zeXNmcy1rZXJuZWwtdm1jb3JlaW5mbwoKSXQgaXMgbm90IHRoZSBjb250
ZW50LCBJIHRoaW5rIGl0IGlzIGEgZ29vZCBjYXRjaCBmcm9tIEJvcmlzLCBpdCB3b3VsZApiZSBn
b29kIHRvIGRvY3VtZW50IHRoZSBleHBvcnRlZCB0aGluZ3MgaW4gc29tZXdoZXJlIGVnLgpEb2N1
bWVudGF0aW9uL2tkdW1wL3ZtY29yZWluZm8udHh0Cgo+IAo+IFRoYW5rcy4KPiBMaWFuYm8KPiA+
IElmIG5vdCwgd2UgbmVlZCBpdCBkb2N1bWVudGVkLgo+ID4gCgpUaGFua3MKRGF2ZQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
