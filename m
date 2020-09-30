Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNYNN-00044I-Hg
 for kexec@lists.infradead.org; Wed, 30 Sep 2020 09:26:33 +0000
Subject: Re: [PATCH v2 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
References: <20200924124647.300080-1-egorenar@linux.ibm.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <9c96aed0-866d-c108-c8f3-a7e846828d30@redhat.com>
Date: Wed, 30 Sep 2020 17:25:54 +0800
MIME-Version: 1.0
In-Reply-To: <20200924124647.300080-1-egorenar@linux.ibm.com>
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
To: Alexander Egorenkov <egorenar@linux.ibm.com>, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, christian.brauner@ubuntu.com

SGksIEFsZXhhbmRlcgoK5ZyoIDIwMjDlubQwOeaciDI05pelIDIwOjQ2LCBBbGV4YW5kZXIgRWdv
cmVua292IOWGmemBkzoKPiBUaGUgb2Zmc2V0IG9mIHRoZSBmaWVsZCAnaW5pdF91dHNfbnMubmFt
ZScgaGFzIGNoYW5nZWQKPiBzaW5jZQo+IAo+IGNvbW1pdCA5YTU2NDkzZjY5NDJjMGUyZGYxNTc5
OTg2MTI4NzIxZGE5NmUwMGQ4Cj4gQXV0aG9yOiBLaXJpbGwgVGtoYWkgPGt0a2hhaUB2aXJ0dW96
em8uY29tPgo+IERhdGU6ICAgTW9uIEF1ZyAzIDEzOjE2OjIxIDIwMjAgKzAzMDAKPiAKPiAgICAg
dXRzOiBVc2UgZ2VuZXJpYyBuc19jb21tb246OmNvdW50Cj4gCj4gTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8xNTk2NDQ5NzgxNjcuNjA0ODEyLjE3NzM1ODY1MDQzNzQ0MTIxMDcuc3Rn
aXRAbG9jYWxob3N0LmxvY2FsZG9tYWluCj4gCj4gTWFrZSB0aGUgb2Zmc2V0IG9mIHRoZSBmaWVs
ZCAndXRzX25hbWVzcGFjZS5uYW1lJyBhdmFpbGFibGUKPiBpbiBWTUNPUkVJTkZPIGJlY2F1c2Ug
dG9vbHMgbGlrZSAnY3Jhc2gtdXRpbGl0eScgYW5kCj4gJ21ha2VkdW1wZmlsZScgbXVzdCBiZSBh
YmxlIHRvIHJlYWQgaXQgZnJvbSBjcmFzaCBkdW1wcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kZXIgRWdvcmVua292IDxlZ29yZW5hckBsaW51eC5pYm0uY29tPgo+IC0tLQo+ICBrZXJuZWwv
Y3Jhc2hfY29yZS5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvY3Jhc2hfY29yZS5jIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+
IGluZGV4IDEwNmU0NTAwZmQ1My4uMTczZmRjMjYxODgyIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9j
cmFzaF9jb3JlLmMKPiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gQEAgLTQ0Nyw2ICs0NDcs
NyBAQCBzdGF0aWMgaW50IF9faW5pdCBjcmFzaF9zYXZlX3ZtY29yZWluZm9faW5pdCh2b2lkKQo+
ICAJVk1DT1JFSU5GT19QQUdFU0laRShQQUdFX1NJWkUpOwo+ICAKPiAgCVZNQ09SRUlORk9fU1lN
Qk9MKGluaXRfdXRzX25zKTsKPiArCVZNQ09SRUlORk9fT0ZGU0VUKHV0c19uYW1lc3BhY2UsIG5h
bWUpOwoKU2luY2UgdGhlIG5ldyBzeW1ib2wgaXMgZXhwb3J0ZWQsIHdvdWxkIHlvdSBtaW5kIGFk
ZGluZyBpdCB0byBEb2N1bWVudGF0aW9uL2tkdW1wL3ZtY29yZWluZm8udHh0ID8KClRoYW5rcy4K
TGlhbmJvCj4gIAlWTUNPUkVJTkZPX1NZTUJPTChub2RlX29ubGluZV9tYXApOwo+ICAjaWZkZWYg
Q09ORklHX01NVQo+ICAJVk1DT1JFSU5GT19TWU1CT0xfQVJSQVkoc3dhcHBlcl9wZ19kaXIpOwo+
IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
