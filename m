Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbdqI-0006D8-GO
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 01:15:59 +0000
Message-ID: <57BA51E0.1070902@cn.fujitsu.com>
Date: Mon, 22 Aug 2016 09:14:08 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>	<1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>	<20160818111854.362bb972@lwn.net>	<57B653D1.8060106@cn.fujitsu.com>
 <20160819095740.1cccc073@lwn.net>
In-Reply-To: <20160819095740.1cccc073@lwn.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, xlpang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

T24gMDgvMTkvMjAxNiAxMTo1NyBQTSwgSm9uYXRoYW4gQ29yYmV0IHdyb3RlOgo+IE9uIEZyaSwg
MTkgQXVnIDIwMTYgMDg6MzM6MjEgKzA4MDAKPiAiWmhvdSwgV2Vuamlhbi/lkajmlofliZEiIDx6
aG91d2otZm5zdEBjbi5mdWppdHN1LmNvbT4gd3JvdGU6Cj4KPj4gSSB3YXMgYWxzbyBjb25mdXNl
ZCBieSBtYXhjcHVzIGFuZCBucl9jcHVzIGJlZm9yZSB3cml0aW5nIHRoaXMgcGF0Y2guCj4+IEkg
dGhpbmsgaXQgaXMgYSBnb29kIGNob2ljZSB0byBkZXNjcmliZSBpdCBpbiBrZXJuZWwtcGFyYW1l
dGVycy50eHQuCj4+Cj4+IFRoZW4sIG9ubHkgdHdvIHRoaW5ncyBuZWVkIHRvIGJlIGRvbmUgSSB0
aGluay4KPj4gT25lIGlzIG1vdmUgdGhlIGFib3ZlIGRlc2NyaXB0aW9uIHRvIG1heGNwdXM9IGlu
IGtlcm5lbC1wYXJhbWV0ZXJzLnR4dC4KPj4gQW5kIHRoZSBvdGhlciBpcyByZXBsYWNlIG1heGNw
dXMgd2l0aCBtYXhjcHVzL25yX2NwdXMgaW4ga2R1bXAudHh0Lgo+Pgo+PiBIb3cgZG8geW91IHRo
aW5rPwo+Cj4gVGhhdCBpcyBub3QgcXVpdGUgd2hhdCBJIGhhZCBpbiBtaW5kLCBzb3JyeS4gIFdo
YXQgSSB3b3VsZCByZWFsbHkgbGlrZSB0bwo+IHNlZSBpbiBrZXJuZWwtcGFyYW1ldGVycy50eHQg
aXMgYW4gZXhwbGFuYXRpb24gb2YgaG93IHRob3NlIHR3byBwYXJhbWV0ZXJzCj4gZGlmZmVyIC0g
d2hhdCBkbyB0aGV5IGRvIGRpZmZlcmVudGx5IGFuZCBob3cgc2hvdWxkIGEgdXNlciBjaG9vc2Ug
b25lIG92ZXIKPiB0aGUgb3RoZXI/ICBXaGF0IHdlIGhhdmUgbm93IG9mZmVycyBubyBndWlkYW5j
ZSBpbiB0aGF0IG1hdHRlci4KPgoKSSB0aG91Z2h0IGFib3V0IGl0LiBJIHRoaW5rIHVzZXIgbWF5
IG5vdCBuZWVkIHRoaXMuCldoYXQgdXNlciByZWFsbHkgd2FudCB0byBrbm93IGlzIGhvdyB0byBj
aG9vc2UuCkFuZCBpdCBpcyBhbHNvIG5vdCBhIGhhcmQgd29yay4gSWYgbnJfY3B1cyBpcyBub3Qg
c3VwcG9ydGVkIGJ5IHRoZSBBUkNILCB1c2UgbWF4Y3B1cy4KT3RoZXJ3aXNlLCBucl9jcHVzLiBU
aGUgcmVhc29uIHdoeSBtYXhjcHVzIHN0aWxsIGV4aXN0cyBpcyBucl9jcHVzIGNhbid0IGJlIHN1
cHBvcnRlZApieSBzb21lIEFSQ0hlcy4KCkkgdGhpbmsgaXQgbWF5IGJlIHdoeSB0aGUgYXV0aG9y
IGRpZG4ndCB3cml0ZSB0b28gbXVjaCBkZXNjcmlwdGlvbiBvZiBpdC4KCj4gSSBzdXNwZWN0IHRo
YXQgbWF5IGJlIGEgYml0IG1vcmUgdGhhbiB5b3UgaGFkIHNpZ25lZCB1cCB0byBkby4gIEFzIGFu
Cj4gaW50ZXJtZWRpYXRlIHN0ZXAsIGhvdyBhYm91dCB0aGlzOiByYXRoZXIgdGhhbiB0YWNraW5n
IG9uIHRob3NlIGxpbmVzIGluCj4ga2R1bXAudHh0LCByZXdyaXRlIHRoYXQgcGFyYWdyYXBoIHRv
IHNpbXBseSBzYXkgd2hhdCB0aGUgcmVhZGVyIHNob3VsZAo+IHVzZS4gIElmIG5yX2NwdXMgaXMg
Z29vZCBmb3IgZXZlcnlib2R5LCBqdXN0IHNheSB0aGF0LCBidXQgeW91ciBwcmV2aW91cwo+IHBh
dGNoIHN1Z2dlc3RzIHRoYXQgdGhlIHNpdHVhdGlvbiBpc24ndCBxdWl0ZSB0aGF0IHNpbXBsZT8K
PgoKQWN0dWFsbHksIGlmIG5yX2NwdXMgYWx3YXlzIHVzYWJsZSwgdGhlcmUgd29uJ3QgYmUgdGhl
c2UgZGlzY3Vzc2lvbnMuCgoKLS0gClRoYW5rcwpaaG91CgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
