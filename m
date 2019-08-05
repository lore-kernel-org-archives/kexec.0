Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hubRl-0004Bw-EF
 for kexec@lists.infradead.org; Mon, 05 Aug 2019 11:46:38 +0000
Subject: Re: [x86/boot] 5b51ae969e: kexec boot failed
References: <97f74c86-54bd-f165-ce33-b53ca48ab850@intel.com>
 <20190802075949.GA4681@dhcp-128-65.nay.redhat.com>
From: "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <d25662bc-c70c-7118-263a-63da41d5bcf1@intel.com>
Date: Mon, 5 Aug 2019 19:46:33 +0800
MIME-Version: 1.0
In-Reply-To: <20190802075949.GA4681@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, kexec@lists.infradead.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@suse.de>, lkp@01.org

SGksCgpPbiA4LzIvMjAxOSAzOjU5IFBNLCBEYXZlIFlvdW5nIHdyb3RlOgo+IEhpLAo+Cj4gT24g
MDgvMDIvMTkgYXQgMDM6NDhwbSwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4+IEZZSSwgd2Ug
bm90aWNlZCB0aGUgZm9sbG93aW5nIGNvbW1pdCAoYnVpbHQgd2l0aCBnY2MtNyk6Cj4+Cj4+IGNv
bW1pdDogNWI1MWFlOTY5ZTNkOGFiMDEzNGVlM2M5OGE3NjlhZDZkMmNjMmUyNCAoIng4Ni9ib290
OiBDYWxsIGdldF9yc2RwX2FkZHIoKSBhZnRlciBjb25zb2xlX2luaXQoKSIpCj4+IGh0dHBzOi8v
a2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdCAgbWFzdGVyCj4+Cj4+IGluIHRlc3RjYXNlOiBib290Cj4+Cj4+IG9uIHRlc3Qg
bWFjaGluZTogSW50ZWwoUikgQ29yZShUTSkgaTMtMzIyMCBDUFUgQCAzLjMwR0h6IHdpdGggNEcg
bWVtb3J5Cj4+Cj4+IFRoZSBjb21taXQgYnJva2Uga2V4ZWMgYm9vdCBvbiBwaHlzaWNhbCBtYWNo
aW5lcywgV2UgaGF2ZSB0byBzZXQgIm5va2FzbHIiIHRvIGtlcm5lbCBjbWRsaW5lIHRvIGF2b2lk
IHRoZSBpc3N1ZS4KPj4KPiBEb2VzIG1vdmluZyBsaW5lIG9mICJzYW5pdGl6ZV9ib290X3BhcmFt
cyhib290X3BhcmFtcyk7IiBhZnRlciBnZXRfcnNkcF9hZGRyKCkKPiBjYWxsYmFjayB3b3JrPwoK
SXQgZG9lc24ndCB3b3JrIHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaDoKCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jIApiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3Nl
ZC9taXNjLmMKaW5kZXggMjRlNjVhMGY3NTZkNi4uYTM3NDZlMTU0ZTk3MSAxMDA2NDQKLS0tIGEv
YXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21pc2MuYworKysgYi9hcmNoL3g4Ni9ib290L2NvbXBy
ZXNzZWQvbWlzYy5jCkBAIC0zNTEsOCArMzUxLDYgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9p
ZCAqZXh0cmFjdF9rZXJuZWwodm9pZCAKKnJtb2RlLCBtZW1wdHIgaGVhcCwKIMKgwqDCoMKgwqDC
oMKgIC8qIENsZWFyIGZsYWdzIGludGVuZGVkIGZvciBzb2xlbHkgaW4ta2VybmVsIHVzZS4gKi8K
IMKgwqDCoMKgwqDCoMKgIGJvb3RfcGFyYW1zLT5oZHIubG9hZGZsYWdzICY9IH5LQVNMUl9GTEFH
OwoKLcKgwqDCoMKgwqDCoCBzYW5pdGl6ZV9ib290X3BhcmFtcyhib290X3BhcmFtcyk7Ci0KIMKg
wqDCoMKgwqDCoMKgIGlmIChib290X3BhcmFtcy0+c2NyZWVuX2luZm8ub3JpZ192aWRlb19tb2Rl
ID09IDcpIHsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aWRtZW0gPSAoY2hhciAq
KSAweGIwMDAwOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpZHBvcnQgPSAweDNi
NDsKQEAgLTM3Myw2ICszNzEsOCBAQCBhc21saW5rYWdlIF9fdmlzaWJsZSB2b2lkICpleHRyYWN0
X2tlcm5lbCh2b2lkIAoqcm1vZGUsIG1lbXB0ciBoZWFwLAogwqDCoMKgwqDCoMKgwqDCoCAqLwog
wqDCoMKgwqDCoMKgwqAgYm9vdF9wYXJhbXMtPmFjcGlfcnNkcF9hZGRyID0gZ2V0X3JzZHBfYWRk
cigpOwoKK8KgwqDCoMKgwqDCoCBzYW5pdGl6ZV9ib290X3BhcmFtcyhib290X3BhcmFtcyk7CisK
IMKgwqDCoMKgwqDCoMKgIGRlYnVnX3B1dHN0cigiZWFybHkgY29uc29sZSBpbiBleHRyYWN0X2tl
cm5lbFxuIik7CgogwqDCoMKgwqDCoMKgwqAgZnJlZV9tZW1fcHRywqDCoMKgwqAgPSBoZWFwO8Kg
wqDCoMKgwqDCoMKgIC8qIEhlYXAgKi8KCkJlc3QgUmVnYXJkcywKUm9uZyBDaGVuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
