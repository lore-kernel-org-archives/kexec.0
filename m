Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRhSc-007VBW-NE
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 20:29:09 +0000
Subject: Re: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
 <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
 <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Message-ID: <f8069662-7515-b524-a589-7e4785d07585@oracle.com>
Date: Wed, 31 Mar 2021 13:28:07 -0700
In-Reply-To: <b7c635e2-e607-03bb-30f4-66bd00bff69e@infradead.org>
Content-Language: en-US
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
To: Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

T24gMy8zMS8yMSAxMTo0MyBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IE9uIDMvMzAvMjEgMjoz
NSBQTSwgQW50aG9ueSBZem5hZ2Egd3JvdGU6Cj4+IFByZXNlcnZlZC1hY3Jvc3Mta2V4ZWMgbWVt
b3J5IG9yIFBLUkFNIGlzIGEgbWV0aG9kIGZvciBzYXZpbmcgbWVtb3J5Cj4+IHBhZ2VzIG9mIHRo
ZSBjdXJyZW50bHkgZXhlY3V0aW5nIGtlcm5lbCBhbmQgcmVzdG9yaW5nIHRoZW0gYWZ0ZXIga2V4
ZWMKPj4gYm9vdCBpbnRvIGEgbmV3IG9uZS4gVGhpcyBjYW4gYmUgdXRpbGl6ZWQgZm9yIHByZXNl
cnZpbmcgZ3Vlc3QgVk0gc3RhdGUsCj4+IGxhcmdlIGluLW1lbW9yeSBkYXRhYmFzZXMsIHByb2Nl
c3MgbWVtb3J5LCBldGMuIGFjcm9zcyByZWJvb3QuIFdoaWxlCj4+IERSQU0tYXMtUE1FTSBvciBh
Y3R1YWwgcGVyc2lzdGVudCBtZW1vcnkgY291bGQgYmUgdXNlZCB0byBhY2NvbXBsaXNoCj4+IHRo
ZXNlIHRoaW5ncywgUEtSQU0gcHJvdmlkZXMgdGhlIGxhdGVuY3kgb2YgRFJBTSB3aXRoIHRoZSBm
bGV4aWJpbGl0eQo+PiBvZiBkeW5hbWljYWxseSBkZXRlcm1pbmluZyB0aGUgYW1vdW50IG9mIG1l
bW9yeSB0byBwcmVzZXJ2ZS4KPj4KPiAuLi4KPgo+PiBPcmlnaW5hbGx5LWJ5OiBWbGFkaW1pciBE
YXZ5ZG92IDx2ZGF2eWRvdi5kZXZAZ21haWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBBbnRob255
IFl6bmFnYSA8YW50aG9ueS55em5hZ2FAb3JhY2xlLmNvbT4KPj4gLS0tCj4+ICBpbmNsdWRlL2xp
bnV4L3BrcmFtLmggfCAgNDcgKysrKysrKysrKysrKwo+PiAgbW0vS2NvbmZpZyAgICAgICAgICAg
IHwgICA5ICsrKwo+PiAgbW0vTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsKPj4gIG1tL3BrcmFt
LmMgICAgICAgICAgICB8IDE3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAyMzYgaW5zZXJ0aW9ucygrKQo+PiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvcGtyYW0uaAo+PiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IG1tL3BrcmFtLmMKPj4KPj4gZGlmZiAtLWdpdCBhL21tL3BrcmFtLmMgYi9tbS9wa3Jh
bS5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTllNDY2
MWIyZmI3Cj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvbW0vcGtyYW0uYwo+PiBAQCAtMCwwICsx
LDE3OSBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4gKyNpbmNs
dWRlIDxsaW51eC9lcnIuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9nZnAuaD4KPj4gKyNpbmNsdWRl
IDxsaW51eC9rZXJuZWwuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9tbS5oPgo+PiArI2luY2x1ZGUg
PGxpbnV4L3BrcmFtLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPj4gKwo+IEhpLAo+
Cj4gVGhlcmUgYXJlIHNldmVyYWwgZG9jIGJsb2NrcyB0aGF0IGJlZ2luIHdpdGggIi8qKiIgYnV0
IHRoYXQgYXJlIG5vdAo+IGluIGtlcm5lbC1kb2MgZm9ybWF0ICgvKiogbWVhbnMga2VybmVsLWRv
YyBmb3JtYXQgd2hlbiBpbnNpZGUgdGhlIGtlcm5lbAo+IHNvdXJjZSB0cmVlKS4KPgo+IFBsZWFz
ZSBlaXRoZXIgY2hhbmdlIHRob3NlIHRvICIvKiIgb3IgY29udmVydCB0aGVtIHRvIGtlcm5lbC1k
b2MgZm9ybWF0Lgo+IFRoZSBsYXR0ZXIgaXMgcHJlZmVyYWJsZSBmb3IgZXhwb3J0ZWQgaW50ZXJm
YWNlcy4KVGhhbmsgeW91LsKgIEknbGwgZml4IHRoZXNlIHVwLgoKPgo+PiArLyoqCj4+ICsgKiBD
cmVhdGUgYSBwcmVzZXJ2ZWQgbWVtb3J5IG5vZGUgd2l0aCBuYW1lIEBuYW1lIGFuZCBpbml0aWFs
aXplIHN0cmVhbSBAcHMKPj4gKyAqIGZvciBzYXZpbmcgZGF0YSB0byBpdC4KPj4gKyAqCj4+ICsg
KiBAZ2ZwX21hc2sgc3BlY2lmaWVzIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBtYXNrIHRvIGJlIHVz
ZWQgd2hlbiBzYXZpbmcgZGF0YS4KPj4gKyAqCj4+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2Vzcywg
LWVycm5vIG9uIGZhaWx1cmUuCj4+ICsgKgo+PiArICogQWZ0ZXIgdGhlIHNhdmUgaGFzIGZpbmlz
aGVkLCBwa3JhbV9maW5pc2hfc2F2ZSgpIChvciBwa3JhbV9kaXNjYXJkX3NhdmUoKSBpbgo+PiAr
ICogY2FzZSBvZiBmYWlsdXJlKSBpcyB0byBiZSBjYWxsZWQuCj4+ICsgKi8KPgo+IGIpIGZyb20g
cGF0Y2ggMDAvNDM6Cj4KPiAgZG9jdW1lbnRhdGlvbi9jb3JlLWFwaS94YXJyYXkucnN0ICAgICAg
IHwgICAgOCArCj4KPiBIb3cgZGlkICJkb2N1bWVudGF0aW9uIiBiZWNvbWUgbG93ZXIgY2FzZSAo
aW5zdGVhZCBvZiBEb2N1bWVudGF0aW9uKT8KVGhhdCBpcyBvZGQuwqAgVGhlIHBhdGNoICg0MSkg
aGFzIGl0IGNvcnJlY3QuCgpBbnRob255Cgo+Cj4KPiB0aGFua3MuCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
