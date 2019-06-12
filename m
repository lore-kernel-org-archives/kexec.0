Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hasAG-00086A-RH
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 01:35:02 +0000
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
References: <20190430074421.7852-1-lijiang@redhat.com>
 <20190430074421.7852-3-lijiang@redhat.com> <20190515133006.GG24212@zn.tnic>
 <4707fb2d-b7d3-34e3-a488-8aa9bdca05f1@redhat.com>
 <0650D79F-2B12-4A80-A37A-F318B5C9ECBC@alien8.de>
From: lijiang <lijiang@redhat.com>
Message-ID: <065dfaab-089b-2329-905a-e1dfbd2f3b3f@redhat.com>
Date: Wed, 12 Jun 2019 09:34:27 +0800
MIME-Version: 1.0
In-Reply-To: <0650D79F-2B12-4A80-A37A-F318B5C9ECBC@alien8.de>
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
To: Boris Petkov <bp@alien8.de>
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwNeaciDE25pelIDE2OjE1LCBCb3JpcyBQZXRrb3Yg5YaZ6YGTOgo+IE9uIE1h
eSAxNiwgMjAxOSAzOjEyOjI2IEFNIEdNVCswMjowMCwgbGlqaWFuZyA8bGlqaWFuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4gT0ssIGkgd2lsbCBtb2RpZnkgaXQgYWNjb3JkaW5nIHRvIHlvdXIgc3Vn
Z2VzdGlvbiBhbmQgcG9zdCBhZ2Fpbi4KPiAKPiBObyBuZWVkIC0gaSBmaXhlZCBpdCB1cCBhbHJl
YWR5LiAKPiAKCkhpLCB1bnRpbCBub3csIGkgaGF2ZW4ndCBzZWVuIHRoZSB1cHN0cmVhbSBicmFu
Y2ggcGljayB1cCB0aGlzIHBhdGNoIHNlcmllcywKYW55IHVwZGF0ZXM/CgpUaGFua3MuCkxpYW5i
bwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
