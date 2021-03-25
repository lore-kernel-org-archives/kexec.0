Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPZIU-002Lzf-4K
 for kexec@lists.infradead.org; Thu, 25 Mar 2021 23:21:52 +0000
Received: by mail-pf1-x433.google.com with SMTP id h3so3590831pfr.12
 for <kexec@lists.infradead.org>; Thu, 25 Mar 2021 16:21:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324085543.GA2660708@infradead.org>
 <dbb430e1-2223-9df0-2563-4b017d6b409d@sony.com>
Subject: Re: [PATCH v2 00/12] Add build ID to stacktraces
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 25 Mar 2021 16:21:46 -0700
Message-ID: <161671450646.3012082.10177164412320557022@swboyd.mtv.corp.google.com>
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
To: Christoph Hellwig <hch@infradead.org>, peter enderborg <peter.enderborg@sony.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Young <dyoung@redhat.com>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Olsa <jolsa@kernel.org>, kexec@lists.infradead.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sasha Levin <sashal@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>, x86@kernel.org

UXVvdGluZyBwZXRlciBlbmRlcmJvcmcgKDIwMjEtMDMtMjUgMDQ6MDY6MTcpCj4gT24gMy8yNC8y
MSA5OjU1IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiA+IE9uIFR1ZSwgTWFyIDIzLCAy
MDIxIGF0IDA3OjA0OjMxUE0gLTA3MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToKPiA+PiAgeDUgOiAw
MDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAwMDAwMDAwMDAwMQo+ID4+ICB4MyA6IDAwMDAwMDAw
MDAwMDAwMDggeDIgOiBmZmZmZmY5M2ZlZjI1YTcwCj4gPj4gIHgxIDogZmZmZmZmOTNmZWYxNTc4
OCB4MCA6IGZmZmZmZmUzNjIyMzUyZTAKPiA+PiAgQ2FsbCB0cmFjZToKPiA+PiAgIGxrZHRtX1dB
Uk5JTkcrMHgyOC8weDMwIFtsa2R0bSBlZDUwMTlmZGY1ZTUzYmUzN2NiMWJhNzg5OTI5MmQ3ZTE0
M2IyNTllXQo+ID4+ICAgZGlyZWN0X2VudHJ5KzB4MTZjLzB4MWI0IFtsa2R0bSBlZDUwMTlmZGY1
ZTUzYmUzN2NiMWJhNzg5OTI5MmQ3ZTE0M2IyNTllXQo+ID4gWWlrZXMuICBObywgcGxlYXNlIGRv
IG5vdCBtYWtlIHRoZSBiYWNrdHJhY2VzIGEgY29tcGxldGUgbWVzcyBmb3IKPiA+IHNvbWV0aGlu
ZyB0aGF0IHNlcnZlcyBhYnNvbHV0ZWx5IG5vIG5lZWQuCgpJdCBzZXJ2ZXMgYSBuZWVkLiBQbGVh
c2UgbG9vayBhdCB0aGUgcGF0Y2hlcyB0byB1bmRlcnN0YW5kIHRoYXQgSSdtCmFkZGluZyB0aGUg
YnVpbGRpZCB0byBhdXRvbWF0aWNhbGx5IGZpbmQgdGhlIGFzc29jaWF0ZWQgZGVidWcKaW5mb3Jt
YXRpb24gb24gZGlzdHJvcy4KCj4gCj4gV291bGQgYSAidmVyYm9zZSIgZmxhZyBiZSBhY2NlcHRh
YmxlIHNvbHV0aW9uP8KgwqDCoCBTb21ldGhpbmcgbGlrZSB3cml0ZSAxIHRvIC9zeXMva2VybmVs
L2RlYnVnL3ZlcmJvc2Vfc3RhY2sgdG8gZ2V0IHRoZSBleHRyYSBpbmZvLgo+IAo+IEkgdGhpbmsg
SSBzZWUgYSBuZWVkIGZvciBpdC4KPiAKCk9yIGEga2VybmVsIGNvbmZpZyBvcHRpb24gYW5kIGEg
Y29tbWFuZGxpbmUgcGFyYW1ldGVyPyBUaGF0IHdvdWxkIGJlIE9LCmZvciBtZSBhcyBJIHNhaWQg
b24gdjEgb2YgdGhpcyBzZXJpZXMuIEknbGwgYWRkIHRoYXQgaW4gZm9yIHRoZSBuZXh0CnBhdGNo
IHNlcmllcyBnaXZlbiBhbGwgdGhlIGRpc3Rhc3RlIGZvciBzb21lIG1vcmUgaGV4IGNoYXJhY3Rl
cnMgbmV4dCB0bwp0aGUgbW9kdWxlIG5hbWUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
