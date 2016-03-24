Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aixqW-0001uS-2x
 for kexec@lists.infradead.org; Thu, 24 Mar 2016 05:30:13 +0000
Message-ID: <56F37AEA.3050306@cn.fujitsu.com>
Date: Thu, 24 Mar 2016 13:28:10 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4] Improve the performance of --num-threads -d 31
References: <1457483231-2092-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160315063430.GA12981@dhcp-128-25.nay.redhat.com>
 <56EB6C06.30205@cn.fujitsu.com>
 <20160318041622.GB29025@dhcp-128-25.nay.redhat.com>
 <56EB96B8.7010103@cn.fujitsu.com>
In-Reply-To: <56EB96B8.7010103@cn.fujitsu.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGVsbG8gTWluZmVpLAoKSG93IGRvIHRoZXNlIHR3byBwYXRjaGVzIHdvcms/CgotLSAKVGhhbmtz
Clpob3UKCk9uIDAzLzE4LzIwMTYgMDE6NDggUE0sICJaaG91LCBXZW5qaWFuL+WRqOaWh+WJkSIg
d3JvdGU6Cj4gT24gMDMvMTgvMjAxNiAxMjoxNiBQTSwgTWluZmVpIEh1YW5nIHdyb3RlOgo+PiBP
biAwMy8xOC8xNiBhdCAxMDo0NmFtLCAiWmhvdSwgV2Vuamlhbi/lkajmlofliZEiIHdyb3RlOgo+
Pj4gSGVsbG8gTWluZmVpLAo+Pj4KPj4+IFNpbmNlIEkgY2FuJ3QgcHJvZHVjZSB0aGUgYnVnLCBJ
IHJldmlld2VkIHRoZSBwYXRjaCBhbmQgd3JvdGUgYW4gaW5jcmVtZW50IHBhdGNoLgo+Pj4gVGhv
dWdoIHRoZXJlIGFyZSBzb21lIGJ1Z3MgaW4gdGhlIGluY3JlbWVudCBwYXRjaCwKPj4+IEkgd29u
ZGVyIGlmIHRoZSBwcmV2aW91cyBidWcgc3RpbGwgZXhpc3RzIHdpdGggdGhpcyBwYXRjaC4KPj4+
IENvdWxkIHlvdSBoZWxwIG1lIGNvbmZpcm0gaXQ/Cj4+Cj4+IE9rLiBJIHdpbGwgaGVscCB2ZXJp
ZnkgdGhpcyBpbmNyZWFzaW5nIHBhdGNoLgo+Pgo+Cj4gVGhhbmsgeW91IHZlcnkgbXVjaC4KPgo+
Pj4KPj4+IEFuZCBJIGhhdmUgYW5vdGhlciBxdWVzdGlvbi4KPj4+IERpZCBpdCBvbmx5IG9jY3Vy
IGluIHBhdGNoIHY0Pwo+Pgo+PiBUaGlzIGlzc3VlIGRvZXNuJ3QgZXhpc3QgaW4gdjMuIEkgaGF2
ZSBwYXN0ZWQgdGhlIHRlc3QgcmVzdWx0IHdpdGgKPj4gLS1udW0tdGhyZWFkIDMyIGluIHRoYXQg
dGhyZWFkLgo+Pgo+PiBhcHBsaWVkIG1ha2VkdW1wZmlsZSB3aXRoIG9wdGlvbiAtZCAzMSAtLW51
bS10aHJlYWRzIDMyCj4+IHJlYWwgICAgM20zLjUzM3MKPgo+IE9oLCB0aGVuIHRoZSBwYXRjaCBp
biB0aGUgcHJldmlvdXMgbWFpbCBtYXkgbm90IHdvcmsuCj4KPiBJJ20gYXBwcmVjaWF0ZWQgaWYg
eW91IGNhbiBhbHNvIHRlc3QgdGhlIHBhdGNoIGluIHRoaXMgbGV0dGVyLgo+Cj4gSSBpbnRyb2R1
Y2VkIHNlbWFwaG9yZSB0byBmaXggdGhlIGJ1ZyBpbiB0aGUgdjMuCj4gU28gSSB3YW50IHRvIGtu
b3cgaWYgaXQgaXMgdGhpcyB3aGljaCBhZmZlY3RzIHRoZSByZXN1bHQuCj4gVGhlIGF0dGFjaGVk
IHBhdGNoIGlzIGJhc2VkIG9uIHY0LCB1c2VkIHRvIHJlbW92ZSBzZW1hb2hvcmUuCj4KPgo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBrZXhlYyBt
YWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+CgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
