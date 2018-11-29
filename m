Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSBqm-0001gn-Un
 for kexec@lists.infradead.org; Thu, 29 Nov 2018 02:14:46 +0000
Subject: Re: [PATCH 1/2 RESEND v7] resource: add the new I/O resource
 descriptor 'IORES_DESC_RESERVED'
References: <20181124051223.19994-1-lijiang@redhat.com>
 <20181124051223.19994-2-lijiang@redhat.com>
 <ae405fe9-94fd-3fb7-decd-c7821cf95b7d@intel.com>
 <460c5552-a48e-3523-275a-7f94d0f08f9b@redhat.com>
 <703ce20d-be09-9b8d-d457-5b002a50dff7@intel.com>
 <d84fbefb-f856-c600-5207-c63f48b1b308@redhat.com>
 <4ff951f6-c1bf-ff98-b70b-a138e54488af@intel.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <4e072e7c-52d2-9ead-2494-4c90b5465ea1@redhat.com>
Date: Thu, 29 Nov 2018 10:14:14 +0800
MIME-Version: 1.0
In-Reply-To: <4ff951f6-c1bf-ff98-b70b-a138e54488af@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, bhe@redhat.com, ard.biesheuvel@linaro.org, peterz@infradead.org, x86@kernel.org, kexec@lists.infradead.org, tony.luck@intel.com, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTjlubQxMeaciDI55pelIDAwOjAyLCBEYXZlIEhhbnNlbiDlhpnpgZM6Cj4gT24gMTEv
MjcvMTggNzo1MSBQTSwgbGlqaWFuZyB3cm90ZToKPj4gQnV0IG5vdywgdGhlICdFODIwX1RZUEVf
UkVTRVJWRUQnIHR5cGUgaXMgY29udmVydGVkIHRvIHRoZSBkZXNjcmlwdG9yICdJT1JFU19ERVND
X1JFU0VSVkVEJwo+PiBpbnN0ZWFkIG9mICdJT1JFU19ERVNDX05PTkUnLCBpdCBoYXMgYmVlbiBj
aGFuZ2VkIGFuZCB0aGUgdmFsdWUgb2YgJ21lbV9mbGFncy5kZXNjX290aGVyJwo+PiBpcyBlcXVh
bCB0byAndHJ1ZScuIFRoaXMgaXMgd3JvbmcuCj4gCj4gVGhhbmtzIGZvciB0aGUgaW1wcm92ZWQg
ZGVzY3JpcHRpb24gb2YgdGhlIHByb2JsZW0uICBTZWVtcyB0byBhbGwgbWFrZQo+IHNlbnNlIG5v
dy4KPiAKPiBDb3VsZCB5b3UgaW5jbHVkZSB0aGlzIGluIHRoZSBjaGFuZ2Vsb2cgZm9yIHRoZSBu
ZXh0IHZlcnNpb24/Cj4gCgpPaywgaSB3aWxsIGluY2x1ZGUgdGhlc2UgY2hhbmdlcyBpbiBwYXRj
aCB2OC4gQWxzbyB0aGFua3MgZm9yIHlvdXIgYWR2aWNlLgoKUmVnYXJkcywKTGlhbmJvCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
