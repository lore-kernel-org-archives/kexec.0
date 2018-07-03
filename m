Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faAsw-0005se-Qm
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 02:17:44 +0000
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
Date: Tue, 3 Jul 2018 10:17:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180702101451.GB28730@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQwN+aciDAy5pelIDE4OjE0LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgSnVsIDAyLCAyMDE4IGF0IDAzOjI2OjM1UE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90
ZToKPj4gQEAgLTEzMSw3ICsxMzIsOCBAQCBzdGF0aWMgdm9pZCBfX2lvcmVtYXBfY2hlY2tfbWVt
KHJlc291cmNlX3NpemVfdCBhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUsCj4+ICAgKiBjYWxsZXIg
c2hvdWxkbid0IG5lZWQgdG8ga25vdyB0aGF0IHNtYWxsIGRldGFpbC4KPj4gICAqLwo+PiAgc3Rh
dGljIHZvaWQgX19pb21lbSAqX19pb3JlbWFwX2NhbGxlcihyZXNvdXJjZV9zaXplX3QgcGh5c19h
ZGRyLAo+PiAtCQl1bnNpZ25lZCBsb25nIHNpemUsIGVudW0gcGFnZV9jYWNoZV9tb2RlIHBjbSwg
dm9pZCAqY2FsbGVyKQo+PiArCQl1bnNpZ25lZCBsb25nIHNpemUsIGVudW0gcGFnZV9jYWNoZV9t
b2RlIHBjbSwKPj4gKwkJdm9pZCAqY2FsbGVyLCBib29sIGVuY3J5cHRlZCkKPiAKPiBTbyBpbnN0
ZWFkIG9mIHNwcmlua2xpbmcgdGhhdCBAZW5jcnlwdGVkIGFyZ3VtZW50IGV2ZXJ5d2hlcmUgYW5k
IHRoZW4KPiBzZXR0aW5nIGl0IGJhc2VkIG9uIHNtZV9hY3RpdmUoKSAuLi4KPiAKPj4gIHsKPj4g
IAl1bnNpZ25lZCBsb25nIG9mZnNldCwgdmFkZHI7Cj4+ICAJcmVzb3VyY2Vfc2l6ZV90IGxhc3Rf
YWRkcjsKPj4gQEAgLTE5OSw3ICsyMDEsNyBAQCBzdGF0aWMgdm9pZCBfX2lvbWVtICpfX2lvcmVt
YXBfY2FsbGVyKHJlc291cmNlX3NpemVfdCBwaHlzX2FkZHIsCj4+ICAJICogcmVzdWx0aW5nIG1h
cHBpbmcuCj4+ICAJICovCj4+ICAJcHJvdCA9IFBBR0VfS0VSTkVMX0lPOwo+PiAtCWlmIChzZXZf
YWN0aXZlKCkgJiYgbWVtX2ZsYWdzLmRlc2Nfb3RoZXIpCj4+ICsJaWYgKChzZXZfYWN0aXZlKCkg
JiYgbWVtX2ZsYWdzLmRlc2Nfb3RoZXIpIHx8IGVuY3J5cHRlZCkKPiAKPiAuLi4gd2h5IGNhbid0
IHlvdSBzaW1wbHkgZG8geW91ciBjaGVja3M6Cj4gCj4gCXNtZV9hY3RpdmUoKSAmJiBpc19rZHVt
cF9rZXJuZWwoKQo+IAo+IGhlcmUgc28gdGhhdCBfX2lvcmVtYXBfY2FsbGVyKCkgY2FuIGF1dG9t
YXRpY2FsbHkgY2hvb3NlIHRoZSBwcm9wZXIKPiBwZ3Byb3QgdmFsdWUgd2hlbiBpb3JlbWFwcGlu
ZyB0aGUgbWVtb3J5IGluIHRoZSBrZHVtcCBrZXJuZWw/Cj4gCj4gQW5kIHRoaXMgd2F5IHRoZSBj
YWxsZXJzIGRvbid0IGV2ZW4gaGF2ZSB0byBjYXJlIHdoZXRoZXIgdGhlIG1lbW9yeSBpcwo+IGVu
Y3J5cHRlZCBvciBub3Q/Cj4gClRoYW5rIHlvdSwgQm9yaXMuIEknbSB2ZXJ5IGdsYWQgdG8gcmVh
ZCB5b3VyIGNvbW1lbnRzLiBUaGF0J3MgYSBnb29kIGlkZWEsIGJ1dCBpdCBoYXMgc29tZQp1bmVu
Y3J5cHRlZCBtZW1vcnkgaW4ga2R1bXAgbW9kZSwgZm9yIGV4YW1wbGUsIHRoZSBlbGZjb3JlaGRy
LiBJbiBmYWN0LCB0aGUgZWxmY29yZWhkciBhbmQKbm90ZXMgY2FsbCB0aGUgc2FtZSBmdW5jdGlv
bihyZWFkX2Zyb21fb2xkbWVtLT5pb3JlbWFwX2NhY2hlKSwgaW4gdGhpcyBjYXNlLCBpdCBpcyB2
ZXJ5CmRpZmZpY3VsdCB0byBwcm9wZXJseSByZW1hcCB0aGUgbWVtb3J5IGlmIHRoZSBjYWxsZXIg
ZG9uJ3QgY2FyZSB3aGV0aGVyIHRoZSBtZW1vcnkgaXMgZW5jcnlwdGVkLgoKUmVnYXJkcywKTGlh
bmJvCj4+ICAJCXByb3QgPSBwZ3Byb3RfZW5jcnlwdGVkKHByb3QpOwo+PiAgCj4+ICAJc3dpdGNo
IChwY20pIHsKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
