Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSafm-0007EE-LF
 for kexec@lists.infradead.org; Fri, 30 Nov 2018 04:45:04 +0000
Subject: Re: [PATCH 1/2 v8] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
References: <20181129080956.20776-1-lijiang@redhat.com>
 <20181129080956.20776-2-lijiang@redhat.com>
 <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <5bda3bfe-8ab2-3c3e-fc4d-6322d372e9ae@redhat.com>
Date: Fri, 30 Nov 2018 12:44:34 +0800
MIME-Version: 1.0
In-Reply-To: <20181130034129.GA26791@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: tony.luck@intel.com, fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMeaciDMw5pelIDExOjQxLCBEYXZlIFlvdW5nIOWGmemBkzoKPiBPbiAxMS8y
OS8xOCBhdCAwNDowOXBtLCBMaWFuYm8gSmlhbmcgd3JvdGU6Cj4+IFdoZW4gZG9pbmcga2V4ZWNf
ZmlsZV9sb2FkLCB0aGUgZmlyc3Qga2VybmVsIG5lZWRzIHRvIHBhc3MgdGhlIGU4MjAKPj4gcmVz
ZXJ2ZWQgcmFuZ2VzIHRvIHRoZSBzZWNvbmQga2VybmVsLiBCdXQga2VybmVsIGNhbiBub3QgZXhh
Y3RseQo+PiBtYXRjaCB0aGUgZTgyMCByZXNlcnZlZCByYW5nZXMgd2hlbiB3YWxraW5nIHRocm91
Z2ggdGhlIGlvbWVtIHJlc291cmNlcwo+PiB3aXRoIHRoZSBkZXNjcmlwdG9yICdJT1JFU19ERVND
X05PTkUnLCBiZWNhdXNlIHNldmVyYWwgZTgyMCB0eXBlcygKPj4gZS5nLiBFODIwX1RZUEVfUkVT
RVJWRURfS0VSTi9FODIwX1RZUEVfUkFNL0U4MjBfVFlQRV9VTlVTQUJMRS9FODIwCj4+IF9UWVBF
X1JFU0VSVkVEKSBhcmUgY29udmVydGVkIHRvIHRoZSBkZXNjcmlwdG9yICdJT1JFU19ERVNDX05P
TkUnLiBJdAo+PiBtYXkgcGFzcyB0aGVzZSBmb3VyIHR5cGVzIHRvIHRoZSBrZHVtcCBrZXJuZWws
IHRoYXQgaXMgbm90IGRlc2lyZWQgcmVzdWx0Lgo+Pgo+PiBTbywgdGhpcyBwYXRjaCBhZGRzIGEg
bmV3IEkvTyByZXNvdXJjZSBkZXNjcmlwdG9yICdJT1JFU19ERVNDX1JFU0VSVkVEJwo+PiBmb3Ig
dGhlIGlvbWVtIHJlc291cmNlcyBzZWFyY2ggaW50ZXJmYWNlcy4gSXQgaXMgaGVscGZ1bCB0byBl
eGFjdGx5Cj4+IG1hdGNoIHRoZSByZXNlcnZlZCByZXNvdXJjZSByYW5nZXMgd2hlbiB3YWxraW5n
IHRocm91Z2ggaW9tZW0gcmVzb3VyY2VzLgo+Pgo+PiBJbiBhZGRpdGlvbiwgc2luY2UgdGhlIG5l
dyBkZXNjcmlwdG9yICdJT1JFU19ERVNDX1JFU0VSVkVEJyBpcyBpbnRyb2R1Y2VkLAo+PiB0aGVz
ZSBjb2RlIG9yaWdpbmFsbHkgcmVsYXRlZCB0byB0aGUgZGVzY3JpcHRvciAnSU9SRVNfREVTQ19O
T05FJyBuZWVkIHRvCj4+IGJlIHVwZGF0ZWQuIE90aGVyd2lzZSwgaXQgd2lsbCBiZSBlYXNpbHkg
Y29uZnVzZWQgYW5kIGFsc28gY2F1c2Ugc29tZQo+PiBlcnJvcnMuIEJlY2F1c2UgdGhlICdFODIw
X1RZUEVfUkVTRVJWRUQnIHR5cGUgaXMgY29udmVydGVkIHRvIHRoZSBuZXcKPj4gZGVzY3JpcHRv
ciAnSU9SRVNfREVTQ19SRVNFUlZFRCcgaW5zdGVhZCBvZiAnSU9SRVNfREVTQ19OT05FJywgaXQg
aGFzIGJlZW4KPj4gY2hhbmdlZC4KPj4KPj4gU3VnZ2VzdGVkLWJ5OiBEYXZlIFlvdW5nIDxkeW91
bmdAcmVkaGF0LmNvbT4KPiAKPiBUaGlzIHdhcyBzdWdnZXN0ZWQgYnkgQm9yaXMgaW5zdGVhZCA6
KSAKPiAKClNvcnJ5IGZvciB0aGlzLCBpIGZvcmdvdCB0byBjaGFuZ2UgaXQuCkFuZCBpIHdpbGwg
Y29ycmVjdCB0aGlzIGluIG5leHQgdmVyc2lvbi4KClRoYW5rcy4KCj4+IFNpZ25lZC1vZmYtYnk6
IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gIGFyY2gvaWE2NC9r
ZXJuZWwvZWZpLmMgfCAgNCArKysrCj4+ICBhcmNoL3g4Ni9rZXJuZWwvZTgyMC5jIHwgIDIgKy0K
Pj4gIGFyY2gveDg2L21tL2lvcmVtYXAuYyAgfCAxMyArKysrKysrKysrKystCj4+ICBpbmNsdWRl
L2xpbnV4L2lvcG9ydC5oIHwgIDEgKwo+PiAga2VybmVsL3Jlc291cmNlLmMgICAgICB8ICA2ICsr
Ky0tLQo+PiAgNSBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQo+Pgo+Pgo+IFtzbmlwXQo+IAo+IFRoYW5rcwo+IERhdmUKPiAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
