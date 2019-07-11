Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlWwm-0007GM-Qq
 for kexec@lists.infradead.org; Thu, 11 Jul 2019 11:09:10 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
In-Reply-To: <20190710180518.GA6343@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
 <20190710180518.GA6343@t470p.stackframe.org>
Date: Thu, 11 Jul 2019 21:08:51 +1000
Message-ID: <871rywhlq4.fsf@concordia.ellerman.id.au>
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
To: Sven Schnelle <svens@stackframe.org>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kexec@lists.infradead.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

U3ZlbiBTY2huZWxsZSA8c3ZlbnNAc3RhY2tmcmFtZS5vcmc+IHdyaXRlczoKPiBPbiBXZWQsIEp1
bCAxMCwgMjAxOSBhdCAwNTowOToyOVBNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOgo+
PiBMZSAxMC8wNy8yMDE5IMOgIDE2OjI5LCBTdmVuIFNjaG5lbGxlIGEgw6ljcml0wqA6Cj4+ID4g
SXQgaGFkIG9ubHkgb25lIGRlZmluaXRpb24sIHNvIGp1c3QgdXNlIHRoZSBmdW5jdGlvbiBkaXJl
Y3RseS4KPj4gCj4+IEl0IGhhZCBvbmx5IG9uZSBkZWZpbml0aW9uIGJlY2F1c2UgaXQgd2FzIGZv
ciBwcGM2NCBvbmx5Lgo+PiBCdXQgYXMgZmFyIGFzIEkgdW5kZXJzdGFuZCAoYXQgbGVhc3QgZnJv
bSB0aGUgbmFtZSBvZiB0aGUgbmV3IGZpbGUpLCB5b3UKPj4gd2FudCBpdCB0byBiZSBnZW5lcmlj
LCBkb24ndCB5b3UgPyBUaGVyZWZvcmUgSSBnZXQgb24gMzIgYml0cyBpdCB3b3VsZCBiZQo+PiBl
bGYzMl90b19jcHUoKS4KPgo+IFRoYXQgYnJpbmdzIHVwIHRoZSBxdWVzdGlvbiB3aGV0aGVyIHdl
IG5lZWQgdGhvc2UgZW5kaWFuZXNzIGNvbnZlcnNpb25zLiBJIHdvdWxkCj4gYXNzdW1lIHRoYXQg
dGhlIEVMRiBmaWxlIGhhcyBhbHdheXMgdGhlIHNhbWUgZW5kaWFuZXNzIGFzIHRoZSBydW5uaW5n
IGtlcm5lbC4gU28KPiBpIHRoaW5rIHdlIGNvdWxkIGp1c3QgZHJvcCB0aGVtLiBXaGF0IGRvIHlv
dSB0aGluaz8KCldlIHNob3VsZCBiZSBhYmxlIHRvIGtleGVjIGZyb20gYmlnIHRvIGxpdHRsZSBl
bmRpYW4gb3IgdmljZSB2ZXJzYSwgc28KdGhleSBhcmUgbmVjZXNzYXJ5LgoKY2hlZXJzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
