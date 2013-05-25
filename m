Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgLD5-0005eB-Hy
 for kexec@lists.infradead.org; Sat, 25 May 2013 20:37:05 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com> <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com>
Date: Sat, 25 May 2013 13:36:09 -0700
In-Reply-To: <51A076FE.3060604@gmail.com> (Zhang Yanfei's message of "Sat, 25
 May 2013 16:31:58 +0800")
Message-ID: <8761y6ajba.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

WmhhbmcgWWFuZmVpIDx6aGFuZ3lhbmZlaS55ZXNAZ21haWwuY29tPiB3cml0ZXM6Cgo+IOS6jiAy
MDEz5bm0MDXmnIgyNeaXpSAxMTowMSwgRXJpYyBXLiBCaWVkZXJtYW4g5YaZ6YGTOgo+PiBaaGFu
ZyBZYW5mZWkgPHpoYW5neWFuZmVpLnllc0BnbWFpbC5jb20+IHdyaXRlczoKPj4gCj4+PiBIZWxs
byBFcmljLAo+Pj4KPj4+PiBUaGUgZnVuY3Rpb24gY29weV9vbGRtZW1fcGFnZSBhbHNvIGNvbmNl
cm5zIG1lLiAgSSBkb24ndCBoYXZlIGEgY2x1ZSB3aHkKPj4+PiB3ZSBkdXBsaWNhdGUgdGhhdCBm
dW5jdGlvbiBvbiBldmVyeSBhcmNoaXRlY3V0cmUgaW4gYSBzbGlnaHRseSBkaWZmZXJlbnQKPj4+
PiBmb3JtLiAgVGhlcmUgc2hvdWxkIGJlIGVub3VnaCBhYnN0cmFjdGlvbnMgaW4gdGhlIGtlcm5l
bCB0byBtYWtlIHRoYXQKPj4+PiB1bm5lY2Vzc2FyeS4gIEkgd291bGQgYmUgZ2xhZCB0byBzZWUg
dGhhdCBmdW5jdGlvbiBnbywgYW5kIHJlbW92ZSB0aGUKPj4+PiBwb3NzaWJpbGl0eSBvZiBjb25m
dXNpb24gdGhhdCBoYXBwZW5lZCBvbiBzMzkwLgo+Pj4KPj4+IFlvdSBtZWFuIHdlIHNob3VsZCBo
YXZlIGEgY29tbW9uIGNvcHlfb2xkbWVtX3BhZ2UgZm9yIGFsbCBhcmNoaXRlY3R1cmVzPyBBbmQK
Pj4+IGp1c3QgbGlrZSB2aXZlayBzYWlkIGFib3ZlLCBmb3IgczM5MCwgd2Ugc2hvdWxkIHB1dCB0
aGUgc3dhcCBpbmZvIGluIHRoZSBlbGYKPj4+IGhlYWRlcnMgaW5zdGVhZCBvZiBkb2luZyB0aGF0
IGluIGNvcHlfb2xkbWVtX3BhZ2UuCj4+IAo+PiBFeGFjdGx5Lgo+PiAKPj4gVGhlIHVzZXIgc3Bh
Y2UgY2hhbmdlIGluIC9zYmluL2tleGVjIHNob3VsZCBldmVuIGJlIGJhY2t3YXJkcyBjb21wYXRp
YmxlCj4+IGZvciBzMzkwLiAgU28gZml4aW5nIC9zYmluL2tleGVjIHNob3VsZCBwcm9iYWJseSBj
b21lIGZpcnN0Lgo+PiAKPgo+IEkgYW0ga2luZCBvZiBub3Qgc3VyZSBhYm91dCB0aGUgImJhY2t3
YXJkcyBjb21wYXRpYmxlIGZvciBzMzkwIiB5b3UgbWVhbnQuCj4KPiBGb3IgczM5MCwgaWYgd2Ug
cHV0IHN3YXAgaW5mbyBpbnRvIHRoZSBlbGYgaGVhZGVyLCBUaGlzIHdpbGwgY2hhbmdlIC9zYmlu
L2tleGVjLgo+IEJ1dCBhdCB0aGlzIHBvaW50LCBjb3B5X29sZG1lbV9wYWdlIGlzIHN0aWxsIGRv
aW5nIHRoZSBzd2FwIHdoZW4gd2UgdHJ5IHRvIHJlYWQKPiB0aGUgcGFnZXMgYW1vbmcgWzAgLSBP
TERNRU1fU0laRV0gYW5kIFtPTERNRU1fQkFTRSAtIE9MRE1FTV9CQVNFICsgT0xETUVNX1NJWkVd
Lgo+IFNvIHJlbW92aW5nIHRoZSBzd2FwIGluIGNvcHlfb2xkbWVtX3BhZ2Ugc2hvdWxkIGJlIGRv
bmUgYXQgdGhlIHNhbWUgdGltZS4KPiBOZXcga2V4ZWMgd2l0aCBvbGQga2VybmVscyB3b3VsZCBm
YWlsIGFuZCBvbGQga2V4ZWMgd2l0aCBuZXcga2VybmVscyB3b3VsZCBmYWlsIHRvby4KPgo+IFNv
IGNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBtb3JlIGFib3V0IHRoZSAiImJhY2t3YXJkcyBjb21w
YXRpYmxlIi4gQW5kIHBsZWFzZQo+IGNvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZy4KCkl0IGxvb2tz
IGxpa2UgbXkgbWlzcmVhZGluZyBvZiB0aGluZ3MuICBJIHdhcyBub3QgZXhwZWN0aW5nIHRoZSBl
eGlzdGluZwpjb3B5X29sZG1lbV9wYWdlIHRvIGRvIGEgY29tcGxldGUgc3dhcCBvZiBhZGRyZXNz
ZXMuICBJIHdhcyBleHBlY3RpbmcKc29tZXRoaW5nIGxpa2UgdGhlIHJlc3VsdCBvYnRhaW5lZCBi
eSBkb2luZyBhIGhlYWRlciBzd2FwIHdpdGggdGhlIEVMRgpoZWFkZXJzIHdoZXJlIHBhcnQgb2Yg
dGhlIGFkZHJlc3Mgd2FzIHRyYW5zbGF0ZWQgYW5kIHRoZSByZXN0IHdhcyBzaW1wbHkKbm90IG1l
bnRpb25lZC4KCkJ1dCBmcm9tIG90aGVyIHJlcGxpZXMgaXQgYXBwZWFycyB0aGVyZSBpc24ndCBh
IHByb2JsZW0uCgpFcmljCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
