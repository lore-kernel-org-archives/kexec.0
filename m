Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHLwd-00007a-4v
 for kexec@lists.infradead.org; Tue, 30 Oct 2018 04:48:00 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
Date: Tue, 30 Oct 2018 12:46:52 +0800
MIME-Version: 1.0
In-Reply-To: <20181029134918.GB32150@zn.tnic>
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

5ZyoIDIwMTjlubQxMOaciDI55pelIDIxOjQ5LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgT2N0IDI5LCAyMDE4IGF0IDA5OjQxOjI2UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
PiAgICAgICAgIFZNQ09SRUlORk9fTlVNQkVSKHBoeXNfYmFzZSk7Cj4+PiAgICAgICAgIFZNQ09S
RUlORk9fU1lNQk9MKGluaXRfdG9wX3BndCk7Cj4+PiAgICAgICAgIHZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKHBndGFibGVfbDVfZW5hYmxlZCk9JWRcbiIsCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICBwZ3RhYmxlX2w1X2VuYWJsZWQoKSk7Cj4+Pgo+Pj4gKyAgICAgICBWTUNPUkVJ
TkZPX05VTUJFUihzbWVfbWFzayk7Cj4gCj4gV2hhdCBJJ20gc3RpbGwgbWlzc2luZyBmcm9tIHRo
ZSB3aG9sZSBmdW4gaXMgd2hlcmUgYXJlIHdlIGRvY3VtZW50aW5nCj4gdGhlIGNvbnRlbnRzIG9m
IHRoYXQgdm1jb3JlaW5mbyB0aGluZz8KPiAKCkknbSBub3Qgc3VyZSB3aGV0aGVyIHRoZSBmb2xs
b3dpbmcgZG9jdW1lbnQgaXMgd2hhdCB5b3UgbmVlZC4KRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGlu
Zy9zeXNmcy1rZXJuZWwtdm1jb3JlaW5mbwoKVGhhbmtzLgpMaWFuYm8KPiBJZiBub3QsIHdlIG5l
ZWQgaXQgZG9jdW1lbnRlZC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
