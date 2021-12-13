Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwZVC-007Y2W-1m
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 00:47:39 +0000
Message-ID: <17153a1c-86c6-6ffd-35d6-5329829661df@linux.vnet.ibm.com>
Date: Sun, 12 Dec 2021 19:46:53 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Content-Language: en-US
References: <cover.1637862358.git.msuchanek@suse.de>
 <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
From: Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
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
To: Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org
Cc: kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Frank van der Linden <fllinden@amazon.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Sven Schnelle <svens@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Ck9uIDExLzI1LzIxIDEzOjAyLCBNaWNoYWwgU3VjaGFuZWsgd3JvdGU6Cj4gQ29weSB0aGUgY29k
ZSBmcm9tIHMzOTB4Cj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgU3VjaGFuZWsgPG1zdWNoYW5l
a0BzdXNlLmRlPgo+IC0tLQo+ICAgYXJjaC9wb3dlcnBjL0tjb25maWcgICAgICAgIHwgMTEgKysr
KysrKysrKysKPiAgIGFyY2gvcG93ZXJwYy9rZXhlYy9lbGZfNjQuYyB8IDM2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL0tjb25maWcgYi9hcmNoL3Bvd2Vy
cGMvS2NvbmZpZwo+IGluZGV4IGFjMGM1MTU1NTJmZC4uZWNjMTIyN2E3N2YxIDEwMDY0NAo+IC0t
LSBhL2FyY2gvcG93ZXJwYy9LY29uZmlnCj4gKysrIGIvYXJjaC9wb3dlcnBjL0tjb25maWcKPiBA
QCAtNTYxLDYgKzU2MSwxNyBAQCBjb25maWcgS0VYRUNfRklMRQo+ICAgY29uZmlnIEFSQ0hfSEFT
X0tFWEVDX1BVUkdBVE9SWQo+ICAgCWRlZl9ib29sIEtFWEVDX0ZJTEUKPgo+ICtjb25maWcgS0VY
RUNfU0lHCj4gKwlib29sICJWZXJpZnkga2VybmVsIHNpZ25hdHVyZSBkdXJpbmcga2V4ZWNfZmls
ZV9sb2FkKCkgc3lzY2FsbCIKPiArCWRlcGVuZHMgb24gS0VYRUNfRklMRSAmJiBNT0RVTEVfU0lH
X0ZPUk1BVAo+ICsJaGVscAo+ICsJICBUaGlzIG9wdGlvbiBtYWtlcyBrZXJuZWwgc2lnbmF0dXJl
IHZlcmlmaWNhdGlvbiBtYW5kYXRvcnkgZm9yCj4gKwkgIHRoZSBrZXhlY19maWxlX2xvYWQoKSBz
eXNjYWxsLgo+ICsKClJlc2VuZGluZyBteSBsYXN0IHJlc3BvbnNlIGFzIGxvb2tzIGxpa2UgaXQg
ZGlkbid0IGdvIHRocm91Z2ggbWFpbGluZyAKbGlzdCBiZWNhdXNlIG9mIHNvbWUgd3JvbmcgZm9y
bWF0dGluZy4gTXkgYXBvbG9naWVzIHRvIHRob3NlIHdobyBhcmUgCnJlY2VpdmluZyBpdCB0d2lj
ZS4KClNpbmNlIHBvd2VycGMgYWxzbyBzdXBwb3J0cyBJTUFfQVJDSF9QT0xJQ1kgZm9yIGtlcm5l
bCBpbWFnZSBzaWduYXR1cmUgCnZlcmlmaWNhdGlvbiwgcGxlYXNlIGluY2x1ZGUgdGhlIGZvbGxv
d2luZzoKCiJBbiBhbHRlcm5hdGl2ZSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIHBvd2VycGMgYXJj
aCBpcyBJTUFfQVJDSF9QT0xJQ1kuIApJdCB2ZXJpZmllcyB0aGUgYXBwZW5kZWQga2VybmVsIGlt
YWdlIHNpZ25hdHVyZSBhbmQgYWRkaXRpb25hbGx5IAppbmNsdWRlcyBib3RoIHRoZSBzaWduZWQg
YW5kIHVuc2lnbmVkIGZpbGUgaGFzaGVzIGluIHRoZSBJTUEgbWVhc3VyZW1lbnQgCmxpc3QsIGV4
dGVuZHMgdGhlIElNQSBQQ1IgaW4gdGhlIFRQTSwgYW5kIHByZXZlbnRzIGJsYWNrbGlzdGVkIGJp
bmFyeSAKa2VybmVsIGltYWdlcyBmcm9tIGJlaW5nIGtleGVjJ2QuIgoKVGhhbmtzICYgUmVnYXJk
cywKCiDCoMKgwqAgLSBOYXluYQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
