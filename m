Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwO2I-0001vP-UN
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 07:10:24 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1491536950.4184.10.camel@linux.vnet.ibm.com>
References: <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
MIME-Version: 1.0
Date: Fri, 07 Apr 2017 08:09:54 +0100
Message-ID: <21572.1491548994@warthog.procyon.org.uk>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Chun-Yi Lee <jlee@suse.com>, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com, Dave Young <dyoung@redhat.com>

TWltaSBab2hhciA8em9oYXJAbGludXgudm5ldC5pYm0uY29tPiB3cm90ZToKCj4gPiA+ICsJaWYg
KCFJU19FTkFCTEVEKENPTkZJR19LRVhFQ19WRVJJRllfU0lHKSAmJiBrZXJuZWxfaXNfbG9ja2Vk
X2Rvd24oKSkKPiA+ID4gKwkJcmV0dXJuIC1FUEVSTTsKPiA+ID4gKwo+ID4gPiAgCj4gCj4gSU1B
IGNhbiBiZSB1c2VkIHRvIHZlcmlmeSBmaWxlIHNpZ25hdHVyZXMgdG9vLCBiYXNlZCBvbiB0aGUg
TFNNIGhvb2tzCj4gaW4gwqBrZXJuZWxfcmVhZF9maWxlX2Zyb21fZmQoKS4gwqBDT05GSUdfS0VY
RUNfVkVSSUZZX1NJRyBzaG91bGQgbm90IGJlCj4gcmVxdWlyZWQuCgpPa2F5LCBmYWlyIGVub3Vn
aC4gIEkgY2FuIHN0aWNrIGluIGFuIE9SIHdpdGggYW4gSVNfRU5BQkxFRCBvbiBzb21lIElNQQpz
eW1ib2wuICBDT05GSUdfSU1BX0tFWEVDIG1heWJlPyAgQW5kIGFsc28gcmVxdWlyZSBJTUEgYmUg
ZW5hYmxlZD8KCkRhdmlkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
