Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 21 Aug 2015 01:17:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 0/4] Fix race issues among panic, NMI and crash_kexec
Message-ID: <20150820231748.GG3161@worktop.event.rightround.com>
References: <20150806054543.25766.29590.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150806054543.25766.29590.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

ClVzZXItQWdlbnQ6IFN0R2l0LzAuMTYKCkZ3aXcsIHN0Z2l0IGlzIGJyb2tlbiB3cnQgc2VuZGlu
ZyBlbWFpbCwgYWxsIHlvdXIgZW1haWxzIGhhdmUgdGhlIGV4YWN0CnNhbWUgdGltZXN0YW1wLCB3
aGljaCBtZWFucyB0aGF0IHRoZSBlbWFpbHMgd2lsbCBiZSBvcmRlcmVkIG9uIHJlY2VpdmVkCnRp
bWVzdGFtcCB3aGVuIHRocmVhZGVkIGFuZCBnZW5lcmF0ZSB0aGUgYmVsb3cgbWVzczoKCgogQXVn
IDA2IEhpZGVoaXJvIEthd2FpICAoMS45SykgW1YzIFBBVENIIDAvNF0gRml4IHJhY2UgaXNzdWVz
IGFtb25nIHBhbmljLCBOTUkgYW5kIGNyYXNoX2tleGVjCiBBdWcgMDYgSGlkZWhpcm8gS2F3YWkg
ICgyLjRLKSDilJzilIA+W1YzIFBBVENIIDMvNF0ga2V4ZWM6IEZpeCByYWNlIGJldHdlZW4gcGFu
aWMoKSBhbmQgY3Jhc2hfa2V4ZWMoKSBjYWxsZWQgZGlyZWN0bHkKIEF1ZyAwNiBIaWRlaGlybyBL
YXdhaSAgKDQuOUspIOKUnOKUgD5bVjMgUEFUQ0ggMS80XSBwYW5pYy94ODY6IEZpeCByZS1lbnRy
YW5jZSBwcm9ibGVtIGR1ZSB0byBwYW5pYyBvbiBOTUkKIEF1ZyAwNiBIaWRlaGlybyBLYXdhaSAg
KDUuM0spIOKUnOKUgD5bVjMgUEFUQ0ggMi80XSBwYW5pYy94ODY6IEFsbG93IGNwdXMgdG8gc2F2
ZSByZWdpc3RlcnMgZXZlbiBpZiB0aGV5IGFyZSBsb29waW5nIGluIE5NSSBjb250ZXh0CiBBdWcg
MDYgSGlkZWhpcm8gS2F3YWkgICgyLjVLKSDilJzilIA+W1YzIFBBVENIIDQvNF0geDg2L2FwaWM6
IEludHJvZHVjZSBub2V4dG5taSBib290IG9wdGlvbgoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
