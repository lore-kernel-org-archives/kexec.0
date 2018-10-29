Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH4XS-00064s-Vz
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 10:12:56 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv> <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
Date: Mon, 29 Oct 2018 18:12:19 +0800
MIME-Version: 1.0
In-Reply-To: <20181029095738.GB20101@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQxMOaciDI55pelIDE3OjU3LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgT2N0IDI5LCAyMDE4IGF0IDA1OjI5OjE2UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IE9rLCBpIHdpbGwgY2hhbmdlIGl0IHRvIGEgbG9jYWwgdmFyaWFibGUgYW5kIGV4cG9ydCBpdC4K
PiAKPiBXaHkgZG8geW91IGhhdmUgdG8gZXhwb3J0IGl0IGF0IGFsbD8hCj4gCgpJIG1lYW4gdGhh
dCBpIHdpbGwgd3JpdGUgdGhlIHZhbHVlIG9mIGxvY2FsIHZhcmlhYmxlIHRvIHRoZSB2bWNvcmVp
bmZvLiBGb3IgZXhhbXBsZToKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9r
ZXhlY182NC5jIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYwppbmRleCA0Yzhh
Y2RmZGM1YTcuLjNjYzk3NWU3ZmY4ZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL21hY2hp
bmVfa2V4ZWNfNjQuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jCkBA
IC0zNTIsMTEgKzM1MiwxNiBAQCB2b2lkIG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1h
Z2UpCgogdm9pZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyh2b2lkKQogeworICAgICAgIHU2
NCBzbWVfbWFzayA9IDA7CisKICAgICAgICBWTUNPUkVJTkZPX05VTUJFUihwaHlzX2Jhc2UpOwog
ICAgICAgIFZNQ09SRUlORk9fU1lNQk9MKGluaXRfdG9wX3BndCk7CiAgICAgICAgdm1jb3JlaW5m
b19hcHBlbmRfc3RyKCJOVU1CRVIocGd0YWJsZV9sNV9lbmFibGVkKT0lZFxuIiwKICAgICAgICAg
ICAgICAgICAgICAgICAgcGd0YWJsZV9sNV9lbmFibGVkKCkpOwoKKyAgICAgICBzbWVfbWFzayA9
IHNtZV9tZV9tYXNrOworICAgICAgIFZNQ09SRUlORk9fTlVNQkVSKHNtZV9tYXNrKTsKKwogI2lm
ZGVmIENPTkZJR19OVU1BCiAgICAgICAgVk1DT1JFSU5GT19TWU1CT0wobm9kZV9kYXRhKTsKICAg
ICAgICBWTUNPUkVJTkZPX0xFTkdUSChub2RlX2RhdGEsIE1BWF9OVU1OT0RFUyk7Ci0tIAoKCkJl
Y2F1c2UgdGhlIGNyYXNoIGtlcm5lbCdzIHBhZ2UgdGFibGUocGdkL3B1ZC9wbWQvcHRlKSBjb250
YWlucwp0aGUgbWVtb3J5IGVuY3J5cHRpb24gbWFzayhiaXQgNDcpLCBtYWtlZHVtcGZpbGUgbmVl
ZHMgdG8gcmVtb3ZlCnRoZSBzbWUgbWFzayB0byBvYnRhaW4gdGhlIHRydWUgcGh5c2ljYWwgYWRk
cmVzcy4KCgpUaGFua3MuCkxpYW5ibwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
