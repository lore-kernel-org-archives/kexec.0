Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlE09-0000DU-LN
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 14:55:23 +0000
Subject: Re: [PATCH v3 7/7] kexec_elf: remove unused variable in
 kexec_elf_load()
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-8-svens@stackframe.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5ff70f9b-905d-000d-af59-cba5c37f9328@c-s.fr>
Date: Wed, 10 Jul 2019 16:55:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190710142944.2774-8-svens@stackframe.org>
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

CgpMZSAxMC8wNy8yMDE5IMOgIDE2OjI5LCBTdmVuIFNjaG5lbGxlIGEgw6ljcml0wqA6Cj4gYmFz
ZSB3YXMgbmV2ZXIgdW5zaWduZWQsIHNvIHdlIGNhbiByZW1vdmUgaXQuCgpEbyB5b3UgbWVhbiBu
ZXZlciBhc3NpZ25lZCA/CgoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBTdmVuIFNjaG5lbGxlIDxzdmVu
c0BzdGFja2ZyYW1lLm9yZz4KClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3Rv
cGhlLmxlcm95QGMtcy5mcj4KCj4gLS0tCj4gICBrZXJuZWwva2V4ZWNfZWxmLmMgfCA3ICsrLS0t
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19lbGYuYyBiL2tlcm5lbC9rZXhlY19lbGYuYwo+
IGluZGV4IGI3ZTQ3ZGRkN2NhZC4uYTU2ZWM1NDgxZTcxIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9r
ZXhlY19lbGYuYwo+ICsrKyBiL2tlcm5lbC9rZXhlY19lbGYuYwo+IEBAIC0zNDgsNyArMzQ4LDcg
QEAgaW50IGtleGVjX2VsZl9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlLCBzdHJ1Y3QgZWxmaGRy
ICplaGRyLAo+ICAgCQkJIHN0cnVjdCBrZXhlY19idWYgKmtidWYsCj4gICAJCQkgdW5zaWduZWQg
bG9uZyAqbG93ZXN0X2xvYWRfYWRkcikKPiAgIHsKPiAtCXVuc2lnbmVkIGxvbmcgYmFzZSA9IDAs
IGxvd2VzdF9hZGRyID0gVUlOVF9NQVg7Cj4gKwl1bnNpZ25lZCBsb25nIGxvd2VzdF9hZGRyID0g
VUlOVF9NQVg7Cj4gICAJaW50IHJldDsKPiAgIAlzaXplX3QgaTsKPiAgIAo+IEBAIC0zNzAsNyAr
MzcwLDcgQEAgaW50IGtleGVjX2VsZl9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlLCBzdHJ1Y3Qg
ZWxmaGRyICplaGRyLAo+ICAgCQlrYnVmLT5idWZzeiA9IHNpemU7Cj4gICAJCWtidWYtPm1lbXN6
ID0gcGhkci0+cF9tZW1zejsKPiAgIAkJa2J1Zi0+YnVmX2FsaWduID0gcGhkci0+cF9hbGlnbjsK
PiAtCQlrYnVmLT5idWZfbWluID0gcGhkci0+cF9wYWRkciArIGJhc2U7Cj4gKwkJa2J1Zi0+YnVm
X21pbiA9IHBoZHItPnBfcGFkZHI7Cj4gICAJCXJldCA9IGtleGVjX2FkZF9idWZmZXIoa2J1Zik7
Cj4gICAJCWlmIChyZXQpCj4gICAJCQlnb3RvIG91dDsKPiBAQCAtMzgwLDkgKzM4MCw2IEBAIGlu
dCBrZXhlY19lbGZfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSwgc3RydWN0IGVsZmhkciAqZWhk
ciwKPiAgIAkJCWxvd2VzdF9hZGRyID0gbG9hZF9hZGRyOwo+ICAgCX0KPiAgIAo+IC0JLyogVXBk
YXRlIGVudHJ5IHBvaW50IHRvIHJlZmxlY3QgbmV3IGxvYWQgYWRkcmVzcy4gKi8KPiAtCWVoZHIt
PmVfZW50cnkgKz0gYmFzZTsKPiAtCj4gICAJKmxvd2VzdF9sb2FkX2FkZHIgPSBsb3dlc3RfYWRk
cjsKPiAgIAlyZXQgPSAwOwo+ICAgIG91dDoKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
