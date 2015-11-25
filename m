Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1bjF-0004Ap-9R
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 15:11:30 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Wed, 25 Nov 2015 15:11:05 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A2C71E@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs> <20151124104853.GC3785@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A2A425@GSjpTKYDCembx31.service.hitachi.net>
 <20151125085620.GA29499@pd.tnic>
 <04EAB7311EE43145B2D3536183D1A84454A2B929@GSjpTKYDCembx31.service.hitachi.net>
 <20151125095758.GC29499@pd.tnic>
In-Reply-To: <20151125095758.GC29499@pd.tnic>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: 'Borislav Petkov' <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

PiBPbiBXZWQsIE5vdiAyNSwgMjAxNSBhdCAwOTo0NjozN0FNICswMDAwLCDmsrPlkIjoi7Hlro8g
LyBLQVdBSe+8jEhJREVISVJPIHdyb3RlOg0KLi4uDQo+ID4gSSBwcmVmZXIgdGhpcywgYnV0IHdl
IG1pZ2h0IHdhbnQgdG8gYWRkIHNvbWUgbW9yZSBwcmVmaXggb3Igc3VmZml4Lg0KPiA+IEZvciBl
eGFtcGxlLCAiY29uZGl0aW9uYWxseV9ydW5fY3Jhc2hfbm1pX2NhbGxiYWNrIi4NCj4gDQo+IFRo
YXQncyB1bm5lY2Vzc2FyeSBJTU8uIElmIHlvdSBuZWVkIHRvIGV4cHJlc3MgdGhhdCwgeW91IGNv
dWxkIHdyaXRlDQo+IHRoYXQgaW4gYSBjb21tZW50IGFib3ZlIHRoZSBmdW5jdGlvbiBkZWZpbml0
aW9uLiBBbnlvbmUgd2hvIGxvb2tzIGF0DQo+IHRoZSBjb2RlIHRoZW4gd2lsbCBrbm93IHRoYXQg
aXQgaXMgY29uZGl0aW9uYWwsIGxpa2Ugc28gbWFueSBvdGhlcg0KPiBrZXJuZWwgZnVuY3Rpb25z
LiA6KQ0KDQpPSywgSSdsbCB1c2UgYSBzaW1wbGUgb25lIHdpdGggYSBjb21tZW50Lg0KDQpSZWdh
cmRzLA0KDQotLQ0KSGlkZWhpcm8gS2F3YWkNCkhpdGFjaGksIEx0ZC4gUmVzZWFyY2ggJiBEZXZl
bG9wbWVudCBHcm91cA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
