Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hKYd3-00031z-Uo
 for kexec@lists.infradead.org; Sun, 28 Apr 2019 01:29:19 +0000
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com> <20190402103201.GF6826@zn.tnic>
 <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
 <20190426130226.GE4608@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <16ca1636-5025-82a5-fe22-2b409e8e515f@redhat.com>
Date: Sun, 28 Apr 2019 09:29:00 +0800
MIME-Version: 1.0
In-Reply-To: <20190426130226.GE4608@zn.tnic>
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
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwNOaciDI25pelIDIxOjAyLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IEZyaSwgQXByIDI2LCAyMDE5IGF0IDA5OjU5OjU0QU0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEhvcGUgdGhpcyBoZWxwLiBUaGFua3MuCj4gCj4gSXQgZG9lcyBoZWxwLCB5ZXMuIFdoZW4gdGhp
cyBleHBsYW5hdGlvbiBhYm92ZSBpcyBwYXJ0IG9mIHRoZSBjb21taXQKPiBtZXNzYWdlLCBpdCBo
ZWxwcyBpbW1lbnNlbHkhCgpPSywgaSB3aWxsIGFkZCB0aGVtIHRvIHRoZSBjb21taXQgbWVzc2Fn
ZSBhbmQgcG9zdCBhZ2Fpbi4KCj4gCj4gOi0pCj4gCj4+IFNvIHNvcnJ5IGZvciB0aGUgZGVsYXks
IGkgYW0gdHJ5aW5nIG15IGJlc3QgdG8gZXhwbGFpbiBpdCBpbiBkZXRhaWwuCj4gCj4gSSBkb24n
dCBjYXJlIGFib3V0IHRoZSBkZWxheSBhcyBsb25nIGFzIHRoZSBjb21taXQgbWVzc2FnZXMgcHJv
cGVybHkKPiBleHBsYWluIHdoeSB0aGUgY2hhbmdlIGlzIG5lZWRlZC4KPiAKPiBTbyB0aGFua3Mg
Zm9yIGRvaW5nIHRoYXQuCj4gCgpJdCdzIG15IHBsZWFzdXJlLiBUaGFua3MuCgpMaWFuYm8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
