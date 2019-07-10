Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlE7E-0002aT-6Y
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 15:02:41 +0000
Subject: Re: [PATCH v3 6/7] kexec_elf: remove Elf_Rel macro
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-7-svens@stackframe.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e9ad2137-f0a9-38e1-87a6-f4e215c87b53@c-s.fr>
Date: Wed, 10 Jul 2019 17:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190710142944.2774-7-svens@stackframe.org>
Content-Language: fr
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
To: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org
Cc: deller@gmx.de, linuxppc-dev@lists.ozlabs.org

CgpMZSAxMC8wNy8yMDE5IMOgIDE2OjI5LCBTdmVuIFNjaG5lbGxlIGEgw6ljcml0wqA6Cj4gSXQg
d2Fzbid0IHVzZWQgYW55d2hlcmUsIHNvIGxldHMgZHJvcCBpdC4KCkFuZCBhbHNvLCBpdCBpcyBh
bHJlYWR5IGRlZmluZWQgaW4gYXNtLWdlbmVyaWMvbW9kdWxlLmgKCj4gCj4gU2lnbmVkLW9mZi1i
eTogU3ZlbiBTY2huZWxsZSA8c3ZlbnNAc3RhY2tmcmFtZS5vcmc+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjLXMuZnI+Cgo+IC0tLQo+ICAga2VybmVs
L2tleGVjX2VsZi5jIHwgNCAtLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEva2VybmVsL2tleGVjX2VsZi5jIGIva2VybmVsL2tleGVjX2VsZi5j
Cj4gaW5kZXggOTllNmQ2M2I1ZGZjLi5iN2U0N2RkZDdjYWQgMTAwNjQ0Cj4gLS0tIGEva2VybmVs
L2tleGVjX2VsZi5jCj4gKysrIGIva2VybmVsL2tleGVjX2VsZi5jCj4gQEAgLTgsMTAgKzgsNiBA
QAo+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC90eXBlcy5o
Pgo+ICAgCj4gLSNpZm5kZWYgRWxmX1JlbAo+IC0jZGVmaW5lIEVsZl9SZWwJCUVsZjY0X1JlbAo+
IC0jZW5kaWYgLyogRWxmX1JlbCAqLwo+IC0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBlbGZfaXNf
ZWxmX2ZpbGUoY29uc3Qgc3RydWN0IGVsZmhkciAqZWhkcikKPiAgIHsKPiAgIAlyZXR1cm4gbWVt
Y21wKGVoZHItPmVfaWRlbnQsIEVMRk1BRywgU0VMRk1BRykgPT0gMDsKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
