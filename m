Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvRMU-0008KI-Ev
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 21:54:00 +0000
Message-ID: <790c68ce-070d-c391-0c3a-4637c616fa5e@linux.vnet.ibm.com>
Date: Thu, 9 Dec 2021 16:53:33 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Content-Language: en-US
References: <cover.1637862358.git.msuchanek@suse.de>
 <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
 <c3c9c6e4-6371-2f5a-ac94-fa4389d5dbe5@linux.vnet.ibm.com>
 <20211209092155.GO117207@kunlun.suse.cz>
From: Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20211209092155.GO117207@kunlun.suse.cz>
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
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: keyrings@vger.kernel.org, kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Frank van der Linden <fllinden@amazon.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Sven Schnelle <svens@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Ck9uIDEyLzkvMjEgMDQ6MjEsIE1pY2hhbCBTdWNow6FuZWsgd3JvdGU6Cj4gSGVsbG8sCkhpLAo+
IE9uIFdlZCwgRGVjIDA4LCAyMDIxIGF0IDA4OjUxOjQ3UE0gLTA1MDAsIE5heW5hIHdyb3RlOgo+
PiBPbiAxMS8yNS8yMSAxMzowMiwgTWljaGFsIFN1Y2hhbmVrIHdyb3RlOgo+Pj4gQ29weSB0aGUg
Y29kZSBmcm9tIHMzOTB4Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIFN1Y2hhbmVrPG1z
dWNoYW5la0BzdXNlLmRlPgo+Pj4gLS0tCj4+PiAgICBhcmNoL3Bvd2VycGMvS2NvbmZpZyAgICAg
ICAgfCAxMSArKysrKysrKysrKwo+Pj4gICAgYXJjaC9wb3dlcnBjL2tleGVjL2VsZl82NC5jIHwg
MzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgICAyIGZpbGVzIGNo
YW5nZWQsIDQ3IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L0tjb25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZwo+Pj4gaW5kZXggYWMwYzUxNTU1MmZkLi5l
Y2MxMjI3YTc3ZjEgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZwo+Pj4gKysr
IGIvYXJjaC9wb3dlcnBjL0tjb25maWcKPj4+IEBAIC01NjEsNiArNTYxLDE3IEBAIGNvbmZpZyBL
RVhFQ19GSUxFCj4+PiAgICBjb25maWcgQVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZCj4+PiAgICAJ
ZGVmX2Jvb2wgS0VYRUNfRklMRQo+Pj4KPj4+ICtjb25maWcgS0VYRUNfU0lHCj4+PiArCWJvb2wg
IlZlcmlmeSBrZXJuZWwgc2lnbmF0dXJlIGR1cmluZyBrZXhlY19maWxlX2xvYWQoKSBzeXNjYWxs
Igo+Pj4gKwlkZXBlbmRzIG9uIEtFWEVDX0ZJTEUgJiYgTU9EVUxFX1NJR19GT1JNQVQKPj4gQWZ0
ZXIgbWFudWFsbHkgYXBwbHlpbmcgdGhlIHBhdGNoLCB0aGUgYnVpbGQgaXMgZmFpbGluZyB3aXRo
IHRoZSBmb2xsb3dpbmcKPj4gZXJyb3I6Cj4+Cj4+IGJ1aWxkIGZhaWxlZCB3aXRoIGVycm9yICJh
cmNoL3Bvd2VycGMva2V4ZWMvZWxmXzY0Lm86IEluIGZ1bmN0aW9uCj4+IGBlbGY2NF92ZXJpZnlf
c2lnJzoKPj4gL3Jvb3Qva2VybmVsL2xpbnVzL2xpbnV4L2FyY2gvcG93ZXJwYy9rZXhlYy9lbGZf
NjQuYzoxNjA6IHVuZGVmaW5lZAo+PiByZWZlcmVuY2UgdG8gYHZlcmlmeV9hcHBlbmRlZF9zaWdu
YXR1cmUnIgo+IFRoaXMgcGF0Y2ggZG9lcyBub3QgYWRkIGNhbGwgdG8gdmVyaWZ5X2FwcGVuZGVk
X3NpZ25hdHVyZS4KPgo+IE1heWJlIHlvdSBhcHBsaWVkIHRoZSBmb2xsb3dpbmcgcGF0Y2ggYXMg
d2VsbD8KClllcywgSSB0cmllZCBidWlsZCBhZnRlciBhcHBseWluZyBhbGwgdGhlIHBhdGNoZXMu
CgpUaGFua3MgJiBSZWdhcmRzLAoKIMKgwqDCoCAtIE5heW5hCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
