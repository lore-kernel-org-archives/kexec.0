Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH3rl-0008JH-CC
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 09:31:45 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv> <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv> <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
From: lijiang <lijiang@redhat.com>
Message-ID: <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
Date: Mon, 29 Oct 2018 17:29:16 +0800
MIME-Version: 1.0
In-Reply-To: <20181029083118.GC1884@MiWiFi-R3L-srv>
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

5ZyoIDIwMTjlubQxMOaciDI55pelIDE2OjMxLCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAxMC8y
OS8xOCBhdCAwMzo1OXBtLCBsaWppYW5nIHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVj
XzY0LmMKPj4gaW5kZXggNGM4YWNkZmRjNWE3Li5kZTM2Mzc5NmVkMjAgMTAwNjQ0Cj4+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPj4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL21hY2hpbmVfa2V4ZWNfNjQuYwo+PiBAQCAtMjksNiArMjksOSBAQAo+PiAgI2luY2x1ZGUg
PGFzbS9zZXR1cC5oPgo+PiAgI2luY2x1ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+Cj4+Cj4+ICt1NjQg
c21lX21hc2s7Cj4+ICtFWFBPUlRfU1lNQk9MKHNtZV9tYXNrKTsKPiAKPiBXb25kZXJpbmcgd2h5
IGl0IGlzIGdsb2JhbC4gV2hvIGVsc2Ugd2lsbCB1c2UgaXQ/Cj4gCkluIGdlbmVyYWwsIG5vIG5l
ZWQgdG8gZXhwb3J0IHRoZSBzeW1ib2wgb2YgbG9jYWwgdmFyaWFibGUuCgpPaywgaSB3aWxsIGNo
YW5nZSBpdCB0byBhIGxvY2FsIHZhcmlhYmxlIGFuZCBleHBvcnQgaXQuCgpUaGFua3MuCkxpYW5i
bwoKPj4gKwo+PiAgI2lmZGVmIENPTkZJR19LRVhFQ19GSUxFCj4+ICBjb25zdCBzdHJ1Y3Qga2V4
ZWNfZmlsZV9vcHMgKiBjb25zdCBrZXhlY19maWxlX2xvYWRlcnNbXSA9IHsKPj4gICAgICAgICAg
ICAgICAgICZrZXhlY19iekltYWdlNjRfb3BzLAo+PiBAQCAtMzU3LDYgKzM2MCw5IEBAIHZvaWQg
YXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkKPj4gICAgICAgICB2bWNvcmVpbmZvX2Fw
cGVuZF9zdHIoIk5VTUJFUihwZ3RhYmxlX2w1X2VuYWJsZWQpPSVkXG4iLAo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICBwZ3RhYmxlX2w1X2VuYWJsZWQoKSk7Cj4+Cj4+ICsgICAgICAgc21lX21h
c2sgPSBzbWVfbWVfbWFzazsKPj4gKyAgICAgICBWTUNPUkVJTkZPX05VTUJFUihzbWVfbWFzayk7
Cj4+ICsKPj4gICNpZmRlZiBDT05GSUdfTlVNQQo+PiAgICAgICAgIFZNQ09SRUlORk9fU1lNQk9M
KG5vZGVfZGF0YSk7Cj4+ICAgICAgICAgVk1DT1JFSU5GT19MRU5HVEgobm9kZV9kYXRhLCBNQVhf
TlVNTk9ERVMpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
