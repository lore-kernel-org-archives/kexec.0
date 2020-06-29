Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpnCS-0008Pp-QB
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 06:23:29 +0000
Subject: Re: [PATCH 02/11] powerpc/kexec_file: mark PPC64 specific code
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319829236.16351.3935863082429593906.stgit@hbathini.in.ibm.com>
 <68d59c00-da02-b362-7bd9-a9631eca0fdd@csgroup.eu>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <29542b4a-eb44-5330-60e8-c0b0d294d72f@linux.ibm.com>
Date: Mon, 29 Jun 2020 11:53:08 +0530
MIME-Version: 1.0
In-Reply-To: <68d59c00-da02-b362-7bd9-a9631eca0fdd@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

SGkgQ2hyaXN0b3BoZQoKVGhhbmtzIGZvciB0aGUgcmV2aWV3Li4uCgpPbiAyNy8wNi8yMCAxMjox
MiBwbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToKPiAKPiAKPiBMZSAyNi8wNi8yMDIwIMOgIDIx
OjA0LCBIYXJpIEJhdGhpbmkgYSDDqWNyaXTCoDoKPj4gU29tZSBvZiB0aGUga2V4ZWNfZmlsZV9s
b2FkIGNvZGUgaXNuJ3QgUFBDNjQgc3BlY2lmaWMuIE1vdmUgUFBDNjQKPj4gc3BlY2lmaWMgY29k
ZSBmcm9tIGtleGVjL2ZpbGVfbG9hZC5jIHRvIGtleGVjL2ZpbGVfbG9hZF82NC5jLiBBbHNvLAo+
PiByZW5hbWUgcHVyZ2F0b3J5L3RyYW1wb2xpbmUuUyB0byBwdXJnYXRvcnkvdHJhbXBvbGluZV82
NC5TIGluIHRoZQo+PiBzYW1lIHNwaXJpdC4KPiAKPiBBdCB0aGUgdGltZSBiZWluZywgQ09ORklH
X0tFWEVDX0ZJTEUgZGVwZW5kcyBvbiBQUEM2NC4KClJpZ2h0LgoKPiBBcmUgeW91IHBsYW5uaW5n
IHRvIG1ha2UgaXQgd29yayBvbiBQUEMzMiBhcyB3ZWxsID8KCk5vLgoKPiBPdGhlcndpc2UgSSBk
b24ndCB1bmRlcnN0YW5kIHRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2guCgpCdXQgSSB3YW50IHRv
IG1ha2Ugc3VyZSB0aGUgY2hhbmdlcyBJIGFtIGFkZGluZyBpbiB0aGlzIHNlcmllcyBkbyBub3QK
Z2V0IGluIHRoZSB3YXkgb2YgYWRkaW5nIFBQQzMyIGNoYW5nZXMgd2hlbmV2ZXIgdGhleSBhcmUg
c3VibWl0dGVkIGFzIHRoZXJlCmlzIGNvbW1vbiBjb2RlIGN1cnJlbnRseSBhbmQgc29tZSBtb3Jl
IG9mIGl0IGluIHRoZSBjaGFuZ2VzIEkgYW0gYWRkaW5nCmluIHRoaXMgc2VyaWVzLi4uCgo+IEFs
c28sIHdoYXQgaXMgYmVpbmcgZG9uZSBpbiB0aGlzIHBhdGNoIHNlZW1zIHRvIGdvIGZhciBiZXlv
bmQgd2hhdCB5b3UgZGVzY3JpYmUgYWJvdmUuPiBJdCBpcyBwcm9wYWJseSB3b3J0aCBzcGxpdHRp
bmcgaW4gc2V2ZXJhbCBwYXRjaGVzIHdpdGggcHJvcGVyIGV4cGxhbmF0aW9uLgoKSG1tbS4uIEkg
ZG9uJ3Qgc2VlIGFueSBvdGhlciByZWFzb24gYmV5b25kIHdoYXQgSSBtZW50aW9uZWQgYWJvdmUu
CldpbGwgdHJ5IHRvIHNwbGl0IHRoZSBwYXRjaCBidXQgdGhlIGNoYW5nZWxvZyB3b3VsZCBzdGls
bCBiZSB0aGUgc2FtZSwgYWZhaWNzLgoKPiBDaHJpc3RvcGhlCj4gCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEhhcmkgQmF0aGluaSA8aGJhdGhpbmlAbGludXguaWJtLmNvbT4KPj4gLS0tCj4+IMKgIGFy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9rZXhlYy5owqDCoMKgwqDCoMKgIHzCoMKgIDExICsrKwo+
PiDCoCBhcmNoL3Bvd2VycGMva2V4ZWMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqAgMiAtCj4+IMKgIGFyY2gvcG93ZXJwYy9rZXhlYy9lbGZfNjQuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqDCoCA3ICstCj4+IMKgIGFyY2gvcG93ZXJwYy9rZXhlYy9maWxlX2xvYWQu
Y8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMzcgKystLS0tLS0tLQo+PiDCoCBhcmNoL3Bvd2VycGMv
a2V4ZWMvZmlsZV9sb2FkXzY0LmPCoMKgwqDCoMKgIHzCoCAxMDggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4+IMKgIGFyY2gvcG93ZXJwYy9wdXJnYXRvcnkvTWFrZWZpbGXCoMKgwqDC
oMKgwqDCoCB8wqDCoMKgIDQgKwo+PiDCoCBhcmNoL3Bvd2VycGMvcHVyZ2F0b3J5L3RyYW1wb2xp
bmUuU8KgwqDCoCB8wqAgMTE3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IMKg
IGFyY2gvcG93ZXJwYy9wdXJnYXRvcnkvdHJhbXBvbGluZV82NC5TIHzCoCAxMTcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgOCBmaWxlcyBjaGFuZ2VkLCAyNDggaW5zZXJ0
aW9ucygrKSwgMTU1IGRlbGV0aW9ucygtKQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9w
b3dlcnBjL2tleGVjL2ZpbGVfbG9hZF82NC5jCj4+IMKgIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNo
L3Bvd2VycGMvcHVyZ2F0b3J5L3RyYW1wb2xpbmUuUwo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9wb3dlcnBjL3B1cmdhdG9yeS90cmFtcG9saW5lXzY0LlMKClRoYW5rcwpIYXJpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
