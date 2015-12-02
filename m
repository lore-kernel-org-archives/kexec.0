Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a49WT-000763-Pz
 for kexec@lists.infradead.org; Wed, 02 Dec 2015 15:40:50 +0000
Date: Wed, 2 Dec 2015 16:40:23 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20151202154023.GH3783@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs>
 <20151125095457.GB29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454A3B032@GSjpTKYDCembx31.service.hitachi.net>
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gV2VkLCBEZWMgMDIsIDIwMTUgYXQgMTE6NTc6MzhBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBXZSBjYW4gZG8gc28sIGJ1dCBJIHRoaW5rIHJlc2V0
dGluZyBwYW5pY19jcHUgYWx3YXlzIHdvdWxkIGJlCj4gc2ltcGxlciBhbmQgc2FmZXIuCgpXZWxs
LCBJIHRoaW5rIGV4ZWN1dGluZyBjb2RlIG5lZWRsZXNzbHkgKmVzcGVjaWFsbHkqIGF0IHBhbmlj
IHRpbWUgaXMKbm90IGFsbCB0aGF0IHJvc3kgZWl0aGVyLgoKQmVzaWRlcyBzb21ldGhpbmcgbGlr
ZSB0aGlzOgoKCXN0YXRpYyBib29sIGtleGVjX2ZhaWxlZDsKCgkuLi4KCiAgICAgICAgaWYgKGNy
YXNoX2tleGVjX3Bvc3Rfbm90aWZpZXJzICYmICFrZXhlY19mYWlsZWQpCgkJa2V4ZWNfZmFpbGVk
ID0gX19jcmFzaF9rZXhlYyhOVUxMKTsKCmlzIGFzIHNpbXBsZSBhcyBpdCBnZXRzLgoKLS0gClJl
Z2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KCkVDTyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdo
ZW4geW91IHJlcGx5LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
