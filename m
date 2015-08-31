Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 31 Aug 2015 11:07:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20150831090733.GI19282@twins.programming.kicks-ass.net>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5914.stgit@softrs>
 <20150820230845.GF3161@worktop.event.rightround.com>
 <04EAB7311EE43145B2D3536183D1A8445493C868@GSjpTKYDCembx31.service.hitachi.net>
 <20150825145258.GS16853@twins.programming.kicks-ass.net>
 <04EAB7311EE43145B2D3536183D1A84454951595@GSjpTKYDCembx31.service.hitachi.net>
 <04EAB7311EE43145B2D3536183D1A8445495793E@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A8445495793E@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gTW9uLCBBdWcgMzEsIDIwMTUgYXQgMDg6NTM6MTFBTSArMDAwMCwg5rKz5ZCI6Iux5a6PIC8g
S0FXQUnvvIxISURFSElSTyB3cm90ZToKPiA+IEkgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uLiAg
SSBkb24ndCBpbnRlbmQgdG8gcGVybWl0IHRoZSByZWN1cnNpdmUKPiA+IGNhbGwgb2YgY3Jhc2hf
a2V4ZWMoKSBhcyBmb3IgJ29sZF9jcHUgIT0gdGhpc19jcHUnIGNoZWNrLiAgVGhhdCBpcwo+ID4g
bmVlZGVkIGZvciB0aGUgY2FzZSBvZiBwYW5pYygpIC0tPiBjcmFzaF9rZXhlYygpLiAgU2luY2Ug
cGFuaWNfY3B1IGhhcwo+ID4gYWxyZWFkeSBiZWVuIHNldCB0byB0aGlzX2NwdSBpbiBwYW5pYygp
IChwbGVhc2Ugc2VlIFBBVENIIDEvNCksIG5vIG9uZQo+ID4gY2FuIHJ1biBjcmFzaF9rZXhlYygp
IHdpdGhvdXQgJ29sZF9jcHUgIT0gdGhpc19jcHUnIGNoZWNrLgo+ID4gCj4gPiBJZiB5b3UgZG9u
J3QgbGlrZSB0aGlzIGNoZWNrLCBJIHdvdWxkIGFsc28gYmUgYWJsZSB0byBoYW5kbGUgdGhpcyBj
YXNlCj4gPiBsaWtlIGJlbG93Ogo+ID4gCj4gPiBjcmFzaF9rZXhlYygpCj4gPiB7Cj4gPiAJb2xk
X2NwdSA9IGF0b21pY19jbXB4Y2hnKCZwYW5pY19jcHUsIC0xLCB0aGlzX2NwdSk7Cj4gPiAJaWYg
KG9sZF9jcHUgIT0gLTEpCj4gPiAJCXJldHVybjsKPiA+IAo+ID4gCV9fY3Jhc2hfa2V4ZWMoKTsK
PiA+IH0KPiA+IAo+ID4gcGFuaWMoKQo+ID4gewo+ID4gCWF0b21pY19jbXB4Y2hnKCZwYW5pY19j
cHUsIC0xLCB0aGlzX2NwdSk7Cj4gPiAJX19jcmFzaF9rZXhlYygpOwo+ID4gLi4uCj4gPiAKPiAK
PiBJcyB0aGF0IE9LPwoKSSBzdXBwb3NlIHNvLCBidXQgSSB0aGluayBtZSBnZXR0aW5nIGNvbmZ1
c2VkIG1lYW5zIGNvbW1lbnRzIGNhbiBiZQphZGRlZC9pbXByb3ZlZC4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
