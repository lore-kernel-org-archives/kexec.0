Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMY28-00042O-0E
 for kexec@lists.infradead.org; Tue, 04 Aug 2015 08:57:17 +0000
Received: by wibxm9 with SMTP id xm9so156161794wib.0
 for <kexec@lists.infradead.org>; Tue, 04 Aug 2015 01:56:53 -0700 (PDT)
Date: Tue, 4 Aug 2015 10:56:51 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to
 panic on NMI
Message-ID: <20150804085651.GC18509@dhcp22.suse.cz>
References: <55B6E2A3.8070004@hitachi.com>
 <04EAB7311EE43145B2D3536183D1A8445491D5E8@GSjpTKYDCembx31.service.hitachi.net>
 <20150729082329.GA15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491DB5E@GSjpTKYDCembx31.service.hitachi.net>
 <20150729092157.GC15801@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491F23A@GSjpTKYDCembx31.service.hitachi.net>
 <20150730074812.GA9387@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A8445491FC55@GSjpTKYDCembx31.service.hitachi.net>
 <20150730122747.GA3954@dhcp22.suse.cz>
 <04EAB7311EE43145B2D3536183D1A844549220E7@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A844549220E7@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gRnJpIDMxLTA3LTE1IDExOjIzOjAwLCDmsrPlkIjoi7Hlro8gLyBLQVdBSe+8jEhJREVISVJP
IHdyb3RlOgo+ID4gRnJvbTogTWljaGFsIEhvY2tvIFttYWlsdG86bWhvY2tvQGtlcm5lbC5vcmdd
ClsuLi5dCj4gPiBJIGFtIHNheWluZyB0aGF0IHdhdGNoZG9nX292ZXJmbG93X2NhbGxiYWNrIG1p
Z2h0IHRyaWdnZXIgb24gbW9yZSBDUFVzCj4gPiBhbmQgcGFuaWMgZnJvbSBOTUkgY29udGV4dCBh
cyB3ZWxsLiBTbyB0aGlzIGlzIG5vdCByZWR1Y2VkIHRvIHRoZSBOTUkKPiA+IGJ1dHRvbiBzZW5k
cyBOTUkgdG8gbW9yZSBDUFVzLgo+IAo+IEkgdW5kZXJzdGFuZC4gIFNvLCBJIGhhdmUgdG8gYWxz
byBtb2RpZnkgd2F0Y2hkb2dfb3ZlcmZsb3dfY2FsbGJhY2sKPiB0byBjYWxsIG5taV9wYW5pYygp
LgoKeWVzLgoKWy4uLl0KPiA+ID4gVGhlcmUgaXMgYSB0aW1lb3V0IG9mIDEwMDBtcyBpbiBubWlf
c2hvb3Rkb3duX2NwdXMoKSwgc28gSSBkb24ndCBrbm93Cj4gPiA+IHdoeSBDUFUgMTMwIHdhaXRz
IHNvIGxvbmcuICBJJ2xsIHRyeSB0byBjb25zaWRlciBmb3IgYSB3aGlsZS4KPiA+IAo+ID4gWWVz
LCBJIGRvIG5vdCB1bmRlcnN0YW5kIHRoZSB0aW1pbmcgaGVyZSBlaXRoZXIgYW5kIHRoZSBmYWN0
IHRoYXQgdGhlCj4gPiBsb2cgaXMgYSBjb21wbGV0ZSBtZXNzIGluIHRoZSBpbXBvcnRhbnQgcGFy
dHMgZG9lc24ndCBoZWxwIGEgd2VlIGJpdC4KPiAKPiBJJ20gaW50ZXJlc3RlZCBpbiB3aGVyZSAi
a2VybmVsIHBhbmljIC1ub3Qgc3luY2luZzogIiBpcy4KPiBJdCBtYXkgZ2l2ZSB1cyBhIGNsdWUu
CgpUaGlzIG9uZSBpcyBsb3N0IGluIHRoZSBtYW5nbGVkIHRleHQ6ClsgIDE2Ny44NDM3NzFdIFU8
MD5bICAxNjcuODQzNzcxXSBoaHVoLiBOTUkgcmVjZWl2ZWQgZm9yIHVua248MD48MD5bICAxNjcu
ODQzNzY1XSBVaFsgIDE2Tk04NDM3NzRJIG93biByZWEgcmVpdmVkIGZvciB1bmtub3c8MCByICAx
Nm4gMmQgNzY1XSBVaGh1aC4gQ1BVIHJlY2VpMTEuIDwwa25vd24gcmVhc29uIDcuIG9uNzcwXSBL
ZXI8WyAtIG5vdCBybiBOTUk6bmljIC0gbm90IGNvbnR0IHNpbmcKCjwwID5bIDogTm90IGNvbi5p
bnU0MzdhemVkIGFuZCBjb25mdXNlZCwgYl0gRHRyeWluZ2FlZCBhbm51ZQoKZnUgMTY3Ljh1dCB0
cnlpbmc+WyAgIHRvIDcuPDAzNzcgMTY3Ljg0Mzc3NV0gVTwwPlsgIDE2Ny44NDM3NzZdIF1oaHUu
aXZlZCBmb3IgdTNua25vd24gck1hc29uIDMgcmUgb2l2ZWQgZm9yIFtuazE2Ny44NDM3ODFdICAx
Lgo8LiBOMD5bICAxNjcuODQzNzgxXSBVaC4gTk1JIHJlY2VuIDNkIG9uIENQVSAwLmk8ID5bIG5v
d29uIDNkIG9uXSBDaGh1aC5NSQplY2VpdmVkWyBvcjcuODQzbmtub1VoaHVoLnduIHJNYXNvbiBl
M2QgY2VDUGl2VWQgMTIwLgo8MG5rPm5vIDE2Ny53bjg0M2Fzb24gM25hIHMgcDEyMC4KbzwwZXIg
c2F2aSBkNiBlODQzYWI4OF0gRG8geWV1IGhhdmUgYQo8dHJhbmdlMD5bIGVyIHNhdmluZyBtb2Rl
IGUgbmFibDFkPzc8NF1bICAxNjcgODRodTk0XU1JdWguIE5jZUlpdmVkIGZvciB1bmtub3duIHJl
YXMgdmRmb3IgMW5vM3dhczA+WyAyZCA2Ny44NDM4MG9uIENJIHJVZSAxMmUuCml2ZTdkOHUzODAw
d24gcnZlYXNlbyBmMmQgb24gQ1BvMy5yPCB1PmtbbyAxIHJlYTZzLm8yZDggb28geW91IGhuIGFQ
dmUgPDBzdD5hIGUgcG93ZXIgMXM3Ljg0MzgxNl0gRG8geW9hdXYgbmcgbW9hZGUgZW5ic2xyYT9u
Z1sgZSAxNjcuODQzOHA0MW9dZXIgc2hodWhhdmkubmdJcm9lbml2ZWQgZmJsZWQ/bmtub3cKPCBy
ZWFzbzA+IDJkIG9uIFtQVTE2MjYuNDFdMD4gICBVaDY3LmguIE5NMzg3SV0gcmVjZWloZWQgZm9y
IC5ua25vd24gcmVhc29uICAyTm4gTUMgVSBjZWl2ZWQgZm9yIC4KW3NvbiAyZCBvbiBDUFUgNi4K
PCAgMTYwPjcuODQ2Ny44NDg3M10gVWhodWguIDNNSSByZWNlaXZlZCA5MDggbyBrbnN0cmEKWyBu
MTY3Ljg0MzkwOF0gRG8geWdvIHBhdmUgd2VzdHJhbmdlc2EgcHZudiBtb2RlIGVuYWJsZW5nIG1v
ZGUgZWQ/Cm48YjBlZD8KLS0gCk1pY2hhbCBIb2NrbwpTVVNFIExhYnMKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
