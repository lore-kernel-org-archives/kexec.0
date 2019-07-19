Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hoTWu-0008Ny-Py
 for kexec@lists.infradead.org; Fri, 19 Jul 2019 14:06:38 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
In-Reply-To: <20190715072417.GA25659@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
 <20190710180518.GA6343@t470p.stackframe.org>
 <871rywhlq4.fsf@concordia.ellerman.id.au>
 <20190715072417.GA25659@t470p.stackframe.org>
Date: Sat, 20 Jul 2019 00:06:21 +1000
Message-ID: <87tvbi6rvm.fsf@concordia.ellerman.id.au>
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
To: Sven Schnelle <svens@stackframe.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, kexec@lists.infradead.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org

U3ZlbiBTY2huZWxsZSA8c3ZlbnNAc3RhY2tmcmFtZS5vcmc+IHdyaXRlczoKPiBIaSBNaWNoYWVs
LAo+Cj4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQgMDk6MDg6NTFQTSArMTAwMCwgTWljaGFlbCBF
bGxlcm1hbiB3cm90ZToKPj4gU3ZlbiBTY2huZWxsZSA8c3ZlbnNAc3RhY2tmcmFtZS5vcmc+IHdy
aXRlczoKPj4gPiBPbiBXZWQsIEp1bCAxMCwgMjAxOSBhdCAwNTowOToyOVBNICswMjAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOgo+PiA+PiBMZSAxMC8wNy8yMDE5IMOgIDE2OjI5LCBTdmVuIFNj
aG5lbGxlIGEgw6ljcml0wqA6Cj4+ID4+ID4gSXQgaGFkIG9ubHkgb25lIGRlZmluaXRpb24sIHNv
IGp1c3QgdXNlIHRoZSBmdW5jdGlvbiBkaXJlY3RseS4KPj4gPj4gCj4+ID4+IEl0IGhhZCBvbmx5
IG9uZSBkZWZpbml0aW9uIGJlY2F1c2UgaXQgd2FzIGZvciBwcGM2NCBvbmx5Lgo+PiA+PiBCdXQg
YXMgZmFyIGFzIEkgdW5kZXJzdGFuZCAoYXQgbGVhc3QgZnJvbSB0aGUgbmFtZSBvZiB0aGUgbmV3
IGZpbGUpLCB5b3UKPj4gPj4gd2FudCBpdCB0byBiZSBnZW5lcmljLCBkb24ndCB5b3UgPyBUaGVy
ZWZvcmUgSSBnZXQgb24gMzIgYml0cyBpdCB3b3VsZCBiZQo+PiA+PiBlbGYzMl90b19jcHUoKS4K
Pj4gPgo+PiA+IFRoYXQgYnJpbmdzIHVwIHRoZSBxdWVzdGlvbiB3aGV0aGVyIHdlIG5lZWQgdGhv
c2UgZW5kaWFuZXNzIGNvbnZlcnNpb25zLiBJIHdvdWxkCj4+ID4gYXNzdW1lIHRoYXQgdGhlIEVM
RiBmaWxlIGhhcyBhbHdheXMgdGhlIHNhbWUgZW5kaWFuZXNzIGFzIHRoZSBydW5uaW5nIGtlcm5l
bC4gU28KPj4gPiBpIHRoaW5rIHdlIGNvdWxkIGp1c3QgZHJvcCB0aGVtLiBXaGF0IGRvIHlvdSB0
aGluaz8KPj4gCj4+IFdlIHNob3VsZCBiZSBhYmxlIHRvIGtleGVjIGZyb20gYmlnIHRvIGxpdHRs
ZSBlbmRpYW4gb3IgdmljZSB2ZXJzYSwgc28KPj4gdGhleSBhcmUgbmVjZXNzYXJ5Lgo+Cj4gSSds
bCB1cGRhdGUgdGhlIHBhdGNoIHRvIGNoZWNrIGZvciBhIG5lZWRlZCAzMi82NCBiaXQgY29udmVy
c2lvbiBkdXJpbmcgcnVudGltZSwKPiBzbyB3ZSBjYW4gYWxzbyBrZXhlYyBmcm9tIDMyIHRvIDY0
IGJpdCBrZXJuZWxzIGFuZCB2aWNlIHZlcnNhLiBEb24ndCBrbm93Cj4gd2hldGhlciB0aGF0J3Mg
cG9zc2libGUgb24gcG93ZXJwYywgYnV0IGF0IGxlYXN0IG9uIHBhcmlzYyBpdCBpcy4KCk9uIHNv
bWUgb2YgdGhlIEZyZWVzY2FsZSAoTlhQKSBtYWNoaW5lcyB0aGF0IHNob3VsZCBhY3R1YWxseSBi
ZQpwb3NzaWJsZSwgdGhlIGhhcmR3YXJlIGNhbiBydW4gYSA2NCBvciAzMi1iaXQga2VybmVsLCBi
dXQgSSdtIG5vdCBzdXJlCmlmIGFueW9uZSBoYXMgYWN0dWFsbHkgdGVzdGVkIGtleGVjJ2luZyBm
cm9tIG9uZSB0byB0aGUgb3RoZXIuCgpjaGVlcnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
