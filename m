Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zj16o-0003mS-E4
 for kexec@lists.infradead.org; Mon, 05 Oct 2015 08:26:59 +0000
Date: Mon, 5 Oct 2015 10:27:04 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151005082704.GA23259@nazgul.tnic>
References: <20150930115548.GI2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
 <20151001062733.GL2881@worktop.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A8445499D30D@GSjpTKYDCembx31.service.hitachi.net>
 <20151001084335.GA3764@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499DB92@GSjpTKYDCembx31.service.hitachi.net>
 <20151001110110.GA3544@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A8445499ED83@GSjpTKYDCembx31.service.hitachi.net>
 <20151002074721.GA16538@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A844549A4557@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 'Peter Zijlstra' <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gTW9uLCBPY3QgMDUsIDIwMTUgYXQgMDI6MDM6NThBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiBUaGF0J3MgZGlmZmVyZW50IGZyb20gbXkgcG9pbnQg
b2Ygdmlldy4gIEknbSBub3QgZ29pbmcgdG8gcGFzcwo+IHNvbWUgZGF0YSBmcm9tIHRoZSBmaXJz
dCBrZXJuZWwgdG8gdGhlIHNlY29uZCBrZXJuZWwuIEknbSBqdXN0IGdvaW5nIHRvCj4gcHJvdmlk
ZSBhIGNvbmZpZ3VyYWJsZSBvcHRpb24gZm9yIHRoZSBzZWNvbmQga2VybmVsIHRvIHVzZXJzLgoK
RHVkZSwgV1RGPyEgWW91J3JlIGFkZGluZyBhIGtlcm5lbCBjb21tYW5kIGxpbmUgd2hpY2ggaXMg
c3VwcG9zZWQgdG8KYmUgdXNlZCAqb25seSogYnkgdGhlIGtkdW1wIGtlcm5lbC4gQnV0IG5vb28s
IGl0IGlzIHRoZXJlIGluIHRoZSBvcGVuCmFuZCB2aXNpYmxlIHRvIHBlb3BsZS4gQW5kIGFueW9u
ZSBjYW4gdHlwZSBpdCBpbiBkdXJpbmcgYm9vdC4gQU5EIFRIQVQKU0hPVUxETidUIEJFIFBPU1NJ
QkxFIElOIFRIRSBGSVJTVCBQTEFDRSEKClRoaXMgaW5mb3JtYXRpb24gaXMgc3RyaWN0bHkgZm9y
IHRoZSBrZHVtcCBrZXJuZWwgLSBpdCBzaG91bGRuJ3QgYmUgYQpnZW5lcmljIGNvbW1hbmQgbGlu
ZSBvcHRpb24uIEhvdyBoYXJkIGl0IGlzIHRvIHVuZGVyc3RhbmQgdGhhdCBzaW1wbGUKZmFjdD8h
Cgo8c25pcCBvYnZpb3VzIHVzZSBjYXNlPgoKPiBJIHRoaW5rIHdlIHNob3VsZCB1c2UgdGhlIEVM
RiBoZWFkZXIgb25seSBpZiB0aGUgcGFzc2VkIGluZm9ybWF0aW9uCj4gaXMgc2F2ZWQgdG8gYSBj
cmFzaCBkdW1wLgoKU28gd2hhdD8hIEVMRiBoZWFkZXIgd2lsbCBjb250YWluIHRoZSBhZGRpdGlv
bmFsIGJpdCBvZiBpbmZvcm1hdGlvbiB0aGF0CnRoZSBzZWNvbmQga2VybmVsIHdhc24ndCByZWFj
dGluZyB0byBOTUlzLiBCdXQgdGhhdCdzIGZpbmUsIHRoYXQgKmlzKgp0aGUgZGVzaXJlZCBiZWhh
dmlvciBhbnl3YXkuCgpBbGwgSSdtIHNheWluZyBpcywgdGhpcyBpcyBhIHN0cmljdCBrZHVtcCBr
ZXJuZWwgImNvbW1hbmQiLCBzbyB0byBzcGVhaywKYW5kIGl0IGRvZXNuJ3QgYmVsb25nIHdpdGgg
dGhlIGdlbmVyaWMga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXJzLgoKLS0gClJlZ2FyZHMv
R3J1c3MsCiAgICBCb3Jpcy4KCkVDTyB0aXAgIzEwMTogVHJpbSB5b3VyIG1haWxzIHdoZW4geW91
IHJlcGx5LgotLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
