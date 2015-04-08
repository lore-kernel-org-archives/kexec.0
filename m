Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YfuAf-0001nY-5A
 for kexec@lists.infradead.org; Wed, 08 Apr 2015 17:53:49 +0000
Message-ID: <55256B2A.4070001@linux.intel.com>
Date: Wed, 08 Apr 2015 12:53:46 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86_64: Add support to build kexec-tools with x32 ABI
References: <1427386798-6793-1-git-send-email-anibal.limon@linux.intel.com>
 <551EBA32.8090208@linux.intel.com> <20150406010447.GD23396@verge.net.au>
 <5522AC83.4090006@linux.intel.com> <20150407012350.GA27486@verge.net.au>
In-Reply-To: <20150407012350.GA27486@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

SGkgU2ltb24sCgpJIGRpZCBtb3JlIHRlc3RpbmcgYW5kIGZvdW5kIHRoYXQgdGhlIHBhdGNoIGNh
dXNlcyBhIGZhaWwgd2hlbiB0cnkgdG8gCmNvbXBpbGUgd2l0aCB6bGliIGFuZCBvdGhlciBhcmNo
IG5vdAp4ODZfNjQsIGl0J3MgcmVsYXRlZCB0byBBQ19FR1JFUF9DUFAgbmVlZHMgcHJldmlvdXMg
QUNfUFJPR19DQy4KCkkgc2VudCBhIHBhdGNoIGZvciB0aGF0LAoKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvcGlwZXJtYWlsL2tleGVjLzIwMTUtQXByaWwvMDEzNTU0Lmh0bWwKClNvcnJ5IGZv
ciB0aGUgcHJvYmxlbXMgdGhhdCBpIG1heSBoYXZlIGNhdXNlZC4KCktpbmQgcmVnYXJkcywKICAg
ICBhbGltb24KCk9uIDA2LzA0LzE1IDIwOjIzLCBTaW1vbiBIb3JtYW4gd3JvdGU6Cj4gT24gTW9u
LCBBcHIgMDYsIDIwMTUgYXQgMTA6NTU6NDdBTSAtMDUwMCwgQW7DrWJhbCBMaW3Ds24gd3JvdGU6
Cj4+IE9uIDA1LzA0LzE1IDIwOjA0LCBTaW1vbiBIb3JtYW4gd3JvdGU6Cj4+PiBPbiBGcmksIEFw
ciAwMywgMjAxNSBhdCAxMDowNTowNkFNIC0wNjAwLCBBbsOtYmFsIExpbcOzbiB3cm90ZToKPj4+
PiBBbnkgY29tbWVudCBvciBmZWVkYmFjaz8KPj4+IEkgZmVlbCBsaWtlIEkgYW0gbWlzc2luZyBz
b21ldGhpbmcgb2J2aW91cywgYnV0Cj4+PiBjb3VsZCB5b3UgZXhwbGFpbiB0aGUgdXNlIGNhc2Ug
YSBsaXR0bGUgbW9yZSBjbGVhcmx5Pwo+PiBJJ20gd29ya2luZyBpbiB0aGUgWW9jdG8gUHJvamVj
dCBlbmFibGluZyB4MzIgQUJJIHN1cHBvcnQsIHRoZSB4MzIgQUJJCj4+IGVuYWJsZXMKPj4gcHJv
Z3JhbXMgdG8gd29yayB3aXRoIDMyLWJpdCBhZGRyZXNzIHNwYWNlIGFuZCBzdXBwb3J0IG9mIGJl
bmVmaXRzIG9mIDY0LWJpdAo+PiBtb2RlCj4+IGxpa2UgcmVnaXN0ZXIgY2FsbGluZyBjb252ZW50
aW9uLCB0aGlzIGltcHJvdmVzIHBlcmZvcm1hbmNlIGluIHNvbWUKPj4gYXBwbGljYXRpb25zLAo+
PiBkZXRhaWxzIFsxXVsyXS4KPj4KPj4gSSBkb24ndCBrbm93IGlmIHRoaXMgYW5zd2VyIHlvdXIg
cXVlc3Rpb24/Cj4gVGhhbmtzLCB0aGF0IGFuc3dlcnMgbXkgcXVlc3Rpb24gdmVyeSB3ZWxsLgo+
IEkgaGF2ZSBhcHBsaWVkIHlvdXIgcGF0Y2guCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
