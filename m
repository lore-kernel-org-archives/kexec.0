Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1harrU-0002om-Ly
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 01:15:38 +0000
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic> <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic> <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic> <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <6d7f4c6f-9d7c-c316-ea53-0c6b8a7b9631@redhat.com>
Date: Wed, 12 Jun 2019 09:14:57 +0800
MIME-Version: 1.0
In-Reply-To: <20190610113747.GD5488@zn.tnic>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, Baoquan He <bhe@redhat.com>, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, tglx@linutronix.de

5ZyoIDIwMTnlubQwNuaciDEw5pelIDE5OjM3LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFNhdCwgSnVuIDA4LCAyMDE5IGF0IDA2OjI2OjU5UE0gKzA4MDAsIEJhb3F1YW4gSGUgd3JvdGU6
Cj4+IE9LLCBJIHNlZS4gVGhlbiBpdCBzaG91bGQgYmUgdGhlIGlzc3VlIHdlIGhhdmUgbWV0IGFu
ZCB0YWxrZWQgYWJvdXQgd2l0aAo+PiBUb20uCj4+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3Iv
MjAxOTA2MDQxMzQ5NTIuR0MyNjg5MUBNaVdpRmktUjNMLXNydgo+Pgo+PiBZb3UgY2FuIGFwcGx5
IFRvbSdzIHBhdGNoIGFzIGJlbG93LiBJIHRlc3RlZCBpdCwgaXQgY2FuIG1ha2Uga2V4ZWMKPj4g
a2VybmVsIHN1Y2NlZWQgdG8gYm9vdCwgYnV0IGZhaWxlZCBmb3Iga2R1bXAga2VybmVsIGJvb3Rp
bmcuIFRoZSBrZHVtcAo+PiBrZXJuZWwgY2FuIGJvb3QgdGlsbCB0aGUgZW5kIG9mIGtlcm5lbCBp
bml0aWFsaXphdGlvbiwgdGhlbiBoYW5nIHdpdGggYQo+PiBjYWxsIHRyYWNlLiBJIGhhdmUgcGFz
dGVkIHRoZSBsb2cgaW4gdGhlIGFib3ZlIHRocmVhZC4gSGF2ZW4ndCBnb3QgdGhlCj4+IHJlYXNv
bi4KPj4gaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzUwOGMyODUzLWRjNGYtNzBhNi02ZmE4LTk3
Yzk1MGRjMzFjNkBhbWQuY29tCj4gCj4gSSBjYW4gY29uZmlybSB0aGUgc2FtZSBvYnNlcnZhdGlv
bi4KPiAKQ3VycmVudGx5LCBpIGhhdmVuJ3Qgc2VlbiBhbnkgdXBkYXRlcyB5ZXQsIHNvIGknbSBu
b3Qgc3VyZSB3aGV0aGVyIHRoaXMgcGF0Y2gKcGFzc2VkIHlvdXIgdGVzdC4KClRoYW5rcy4KTGlh
bmJvCgo+IFRoeC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
