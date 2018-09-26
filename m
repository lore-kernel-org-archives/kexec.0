Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5631-0006iC-Os
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 09:24:02 +0000
Subject: Re: [PATCH 0/3] find_next_iomem_res() fixes
References: <20180921073211.20097-2-lijiang@redhat.com>
 <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <1894f2ba-42ab-c044-ea0c-63eab98d9815@redhat.com>
Date: Wed, 26 Sep 2018 17:22:55 +0800
MIME-Version: 1.0
In-Reply-To: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, akpm@linux-foundation.org, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, dan.j.williams@intel.com, bp@suse.de, dyoung@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

CgrlnKggMjAxOOW5tDA55pyIMjXml6UgMDY6MTQsIEJqb3JuIEhlbGdhYXMg5YaZ6YGTOgo+IEhp
IExpYW5ibywKPiAKPiBUaGVzZSB0aHJlZSBwYXRjaGVzIGFyZSBhIHBvc3NpYmxlIHJlcGxhY2Vt
ZW50IGZvciB5b3VyIGZpcnN0IHBhdGNoCj4gKCJbUEFUQ0ggMS8zIHYzXSByZXNvdXJjZTogZml4
IGFuIGVycm9yIHdoaWNoIHdhbGtzIHRocm91Z2ggaW9tZW0KPiByZXNvdXJjZXMiKS4KPiAKPiBJ
IHRoaW5rIHRoZSBpbnRlcmZhY2Ugb2YgZmluZF9uZXh0X2lvbWVtX3JlcygpIGNhbiBiZSBpbXBy
b3ZlZCB0byBtYWtlCj4gdGhlIGNvZGUgZWFzaWVyIHRvIHJlYWQgYW5kIGFsc28gYXZvaWQgdGhl
IGVycm9ycyB5b3UncmUgZml4aW5nLgo+IAo+IEkgY2FuJ3QgdGVzdCB0aGVzZSwgc28gdGhleSd2
ZSBvbmx5IGJlZW4gY29tcGlsZWQuICBJZiB5b3UgY2FuIHRlc3QKPiB0aGVtIGFuZCBpZiB5b3Ug
bGlrZSB0aGVtLCBmZWVsIGZyZWUgdG8gaW5jb3Jwb3JhdGUgdGhlbSBpbnRvIHlvdXIKPiBzZXJp
ZXMuICBJZiBub3QsIGp1c3QgZHJvcCB0aGVtIChidXQgcGxlYXNlIGF0IGxlYXN0IGZpeCB0aGUg
c2FtZQo+IGVycm9yIGluIHdhbGtfc3lzdGVtX3JhbV9yYW5nZSgpKS4KPiAKSGksIEJqb3JuClNv
cnJ5IGZvciBteSBsYXRlIHJlcGx5IGFib3V0IHRoaXMuIE5vIG5lZWQgdG8gaW5jb3Jwb3JhdGUg
dGhlbSBpbnRvCm15IHBhdGNoIHNlcmllcywgeW91IG1pZ2h0IGZyZWVseSBzdWJtaXQgdGhlbSB0
byB1cHN0cmVhbS4KCkkgd2lsbCB0ZXN0IHlvdXIgcGF0Y2hlcyB3aGV0aGVyIGl0IGNhbiBhbHNv
IHdvcmsgd2VsbCBmb3IgbXkgY2FzZSwgYW5kCnlvdSB3aWxsIGdldCBmZWVkYmFjayBhYm91dCBt
eSB0ZXN0IGxhdGVyLgoKVGhhbmtzLgpMaWFuYm8KCj4gLS0tCj4gCj4gQmpvcm4gSGVsZ2FhcyAo
Myk6Cj4gICAgICAgeDg2L2tleGVjOiBDb3JyZWN0IEtFWEVDX0JBQ0tVUF9TUkNfRU5EIG9mZi1i
eS1vbmUgZXJyb3IKPiAgICAgICByZXNvdXJjZTogSW5jbHVkZSByZXNvdXJjZSBlbmQgaW4gd2Fs
a18qKCkgaW50ZXJmYWNlcwo+ICAgICAgIHJlc291cmNlOiBGaXggZmluZF9uZXh0X2lvbWVtX3Jl
cygpIGl0ZXJhdGlvbiBpc3N1ZQo+IAo+IAo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5o
IHwgICAgMiAtCj4gIGtlcm5lbC9yZXNvdXJjZS5jICAgICAgICAgICAgfCAgIDk2ICsrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQz
IGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4ga2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
