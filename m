Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lP8nc-0006Aa-Ir
 for kexec@lists.infradead.org; Wed, 24 Mar 2021 19:04:17 +0000
Received: by mail-pg1-x529.google.com with SMTP id r17so15314357pgi.0
 for <kexec@lists.infradead.org>; Wed, 24 Mar 2021 12:04:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <32011616573677@mail.yandex-team.ru>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <32011616573677@mail.yandex-team.ru>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From: Stephen Boyd <swboyd@chromium.org>
Date: Wed, 24 Mar 2021 12:04:08 -0700
Message-ID: <161661264804.3012082.14951998760354509511@swboyd.mtv.corp.google.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, "x86@kernel.org" <x86@kernel.org>

SFRNTCBtYWlsPwoKUXVvdGluZyBLb25zdGFudGluIEtobGVibmlrb3YgKDIwMjEtMDMtMjQgMDE6
MjM6NTUpCj4gMjQuMDMuMjAyMSwgMDU6MDQsICJTdGVwaGVuIEJveWQiIDxzd2JveWRAY2hyb21p
dW0ub3JnPjoKPiDCoAo+IExvb2tzIHRvbyBub2lzeSBmb3IgbWUuIE1heWJlIHByaW50IGlkIGlu
IHRoZSBsaW5lICJNb2R1bGVzIGxpbmtlZCBpbjoiPwo+IEkgc3VwcG9zZSBvbmx5IG91dC1vZi10
cmVlIG1vZHVsZXMgbmVlZCB0aGlzPwo+IMKgCgpQbGVhc2Ugc2VlIHRoaXMgbm90ZSBpbiBwYXRj
aCA0OgoKT3JpZ2luYWxseSwgSSBwdXQgdGhpcyBvbiB0aGUgJXBTIGZvcm1hdCwgYnV0IHRoYXQg
d2FzIHF1aWNrbHkgcmVqZWN0ZWQKZ2l2ZW4gdGhhdCAlcFMgaXMgdXNlZCBpbiBvdGhlciBwbGFj
ZXMgc3VjaCBhcyBmdHJhY2Ugd2hlcmUgYnVpbGQgSURzCmFyZW4ndCBtZWFuaW5nZnVsLiBUaGVy
ZSB3YXMgc29tZSBkaXNjdXNzaW9ucyBvbiB0aGUgbGlzdCB0byBwdXQgZXZlcnkKbW9kdWxlIGJ1
aWxkIElEIGludG8gdGhlICJNb2R1bGVzIGxpbmtlZCBpbjoiIHNlY3Rpb24gb2YgdGhlIHN0YWNr
dHJhY2UKbWVzc2FnZSBidXQgdGhhdCBxdWlja2x5IGJlY29tZXMgdmVyeSBoYXJkIHRvIHJlYWQg
b25jZSB5b3UgaGF2ZSBtb3JlCnRoYW4gdGhyZWUgb3IgZm91ciBtb2R1bGVzIGxpbmtlZCBpbi4g
SXQgYWxzbyBwcm92aWRlcyB0b28gbXVjaAppbmZvcm1hdGlvbiB3aGVuIHdlIGRvbid0IGV4cGVj
dCBlYWNoIG1vZHVsZSB0byBiZSB0cmF2ZXJzZWQgaW4gYQpzdGFja3RyYWNlLiBIYXZpbmcgdGhl
IGJ1aWxkIElEIGZvciBtb2R1bGVzIHRoYXQgYXJlbid0IGltcG9ydGFudCBqdXN0Cm1ha2VzIHRo
aW5ncyBtZXNzeS4gU3BsaXR0aW5nIGl0IHRvIG11bHRpcGxlIGxpbmVzIGZvciBlYWNoIG1vZHVs
ZQpxdWlja2x5IGV4cGxvZGVzIHRoZSBudW1iZXIgb2YgbGluZXMgcHJpbnRlZCBpbiBhbiBvb3Bz
IHRvbywgcG9zc2libHkKd3JhcHBpbmcgdGhlIHdhcm5pbmcgb2ZmIHRoZSBjb25zb2xlLiBBbmQg
ZmluYWxseSwgdHJ5aW5nIHRvIHN0YXNoIGF3YXkKZWFjaCBtb2R1bGUgdXNlZCBpbiBhIGNhbGxz
dGFjayB0byBwcm92aWRlIHRoZSBJRCBvZiBlYWNoIHN5bWJvbCBwcmludGVkCmlzIGN1bWJlcnNv
bWUgYW5kIHdvdWxkIHJlcXVpcmUgY2hhbmdlcyB0byBlYWNoIGFyY2hpdGVjdHVyZSB0byBzdGFz
aAphd2F5IG1vZHVsZXMgYW5kIHJldHVybiB0aGVpciBidWlsZCBJRHMgb25jZSB1bndpbmRpbmcg
aGFzIGNvbXBsZXRlZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
