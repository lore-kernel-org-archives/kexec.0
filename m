Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AD6EB64D9
	for <kexec@archiver.kernel.org>; Thu,  6 Jul 2023 06:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AaXSYRDt7TMKXSBxzx92V/i3kE8c7yv/Yi3wVjngBJ8=; b=TUDZmkl11w7AA9
	TMu7XG0Ad6HQT3Xumy5CT88S3hs0TiXok+rBeV5jPTAR5T1CVER37ia8Rl6Ln01Bvb3U0Z1KmjIJD
	kSCw+hzhSM0wgRQXlHZq8fRbaspUMppAEdV3PTB0yyuSccwwERY5n6hhOMcfxE2K+qsukIoXyCBoQ
	LK0oDKNxO1Ithkduu8T58MkVcq60Oz/E3Zxgm/3AynkQFQifJ/POXtq8XyXm4GIu3WSjryy+VSoME
	VCRj6XkH/thb564iSzleQ7qqnobFGgvEyTTWMuGdk+bUipvYiRftUQp3i+jr/Ps1x4ZqaQJBh8L3V
	0dZNoPu63tYo4BDwGeHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHIjM-000gMf-0e;
	Thu, 06 Jul 2023 06:44:44 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHIjI-000gJA-1X
	for kexec@lists.infradead.org;
	Thu, 06 Jul 2023 06:44:42 +0000
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxRnB2d43zTm85;
	Thu,  6 Jul 2023 14:43:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 14:44:29 +0800
Message-ID: <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
Date: Thu, 6 Jul 2023 14:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
CC: <arjan@linux.intel.com>, <ashok.raj@intel.com>,
	<ashok.raj@linux.intel.com>, <ebiederm@xmission.com>,
	<linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
	<thomas.lendacky@amd.com>, <tony.luck@intel.com>, <tonyb@cybernetics.com>,
	<x86@kernel.org>, yangerkun <yangerkun@huawei.com>, Baoquan He
	<bhe@redhat.com>, <kexec@lists.infradead.org>, Baokun Li
	<libaokun1@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com> <87ttui91jo.ffs@tglx>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87ttui91jo.ffs@tglx>
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_234440_922093_80C52E86 
X-CRM114-Status: GOOD (  19.14  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyMy83LzUgMTY6NTksIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBPbiBNb24sIEp1bCAw
MyAyMDIzIGF0IDExOjQ0LCBCYW9rdW4gTGkgd3JvdGU6Cj4KPj4gV2hlbiBJIG1hbnVhbGx5IHRy
aWdnZXIgcGFuaWMgaW4gYSBxdW1lIHg4NiBWTSB3aXRoCj4+Cj4+ICAgwqDCoMKgwqDCoMKgIGBl
Y2hvIGMgPiAvcHJvYy9zeXNycS10cmlnZ2VyYCwKPj4KPj4gICDCoEkgZmluZCB0aGF0IHRoZSBW
TSB3aWxsIHByb2JhYmx5IHJlYm9vdCBkaXJlY3RseSwgYnV0IHRoZQo+PiBQQU5JQ19USU1FT1VU
IGlzIDAuCj4+IFRoaXMgcHJldmVudHMgdXMgZnJvbSBleHBvcnRpbmcgdGhlIHZtY29yZSB2aWEg
cGFuaWMsIGFuZCBldmVuIGlmIHdlIHN1Y2NlZWQKPj4gaW4gcGFuaWMgZXhwb3J0aW5nIHRoZSB2
bWNvcmUsIHRoZSBwcm9jZXNzZXMgaW4gdGhlIHZtY29yZSBhcmUgbW9zdGx5Cj4+IHN0b3BfdGhp
c19jcHUoKS4gQnkgZGljaG90b21pemluZyB3ZSBmb3VuZCB0aGUgcGF0Y2ggdGhhdCBpbnRyb2R1
Y2VkIHRoZQo+PiBiZWhhdmlvciBjaGFuZ2UKPj4KPj4gICDCoMKgIDQ1ZTM0YzhhZjU4ZiAoIng4
Ni9zbXA6IFB1dCBDUFVzIGludG8gSU5JVCBvbiBzaHV0ZG93biBpZiBwb3NzaWJsZSIpLAo+IEJh
aCwgSSBtaXNzZWQgdGhhdCB0aGlzIGlzIHVzZWQgYnkgY3Jhc2ggdG9vLiBTbyBpZiB0aGlzIGhh
cHBlbnMgdG8gYmUKPiBpbnZva2VkIG9uIGFuIEFQLCBpLmUuIG5vdCBvbiBDUFUgMCwgdGhlbiB0
aGUgSU5JVCB3aWxsIHJlc2V0IHRoZQo+IG1hY2hpbmUuIEZpeCBiZWxvdy4KPgo+IFRoYW5rcywK
Pgo+ICAgICAgICAgIHRnbHgKPiAtLS0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Nt
cGJvb3QuYyBiL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMKPiBpbmRleCBlZDJkNTE5NjBhN2Qu
LmUxYWEyY2Q3NzM0YiAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYwo+IEBAIC0xMzQ4LDYgKzEzNDgsMTQgQEAg
Ym9vbCBzbXBfcGFya19vdGhlcl9jcHVzX2luX2luaXQodm9pZCkKPiAgIAlpZiAoYXBpYy0+d2Fr
ZXVwX3NlY29uZGFyeV9jcHVfNjQgfHwgYXBpYy0+d2FrZXVwX3NlY29uZGFyeV9jcHUpCj4gICAJ
CXJldHVybiBmYWxzZTsKPiAgIAo+ICsJLyoKPiArCSAqIElmIHRoaXMgaXMgYSBjcmFzaCBzdG9w
IHdoaWNoIGRvZXMgbm90IGV4ZWN1dGUgb24gdGhlIGJvb3QgQ1BVLAo+ICsJICogdGhlbiB0aGlz
IGNhbm5vdCB1c2UgdGhlIElOSVQgbWVjaGFuaXNtIGJlY2F1c2UgSU5JVCB0byB0aGUgYm9vdAo+
ICsJICogQ1BVIHdpbGwgcmVzZXQgdGhlIG1hY2hpbmUuCj4gKwkgKi8KPiArCWlmICh0aGlzX2Nw
dSkKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICAgCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkg
ewo+ICAgCQlpZiAoY3B1ID09IHRoaXNfY3B1KQo+ICAgCQkJY29udGludWU7ClRoaXMgcGF0Y2gg
ZG9lcyBmaXggdGhlIHByb2JsZW0gb2YgcmVib290aW5nIGF0IHBhbmljLCBidXQgdGhlIGV4cG9y
dGVkIApzdGFjawpzdGF5cyBhdCBzdG9wX3RoaXNfY3B1KCkgbGlrZSBiZWxvdywgaW5zdGVhZCBv
ZiBzaG93aW5nIHdoYXQgdGhlIApjb3JyZXNwb25kaW5nCnByb2Nlc3MgaXMgZG9pbmcgYXMgYmVm
b3JlLgoKUElEOiA2ODHCoMKgwqDCoMKgIFRBU0s6IGZmZmY5YWMyNDI5ZDMwODDCoCBDUFU6IDLC
oMKgwqAgQ09NTUFORDogImZzc3RyZXNzIgogwqAjMCBbZmZmZmIwMDIwMDE4NGZkMF0gc3RvcF90
aGlzX2NwdSBhdCBmZmZmZmZmZjg5YTRmZmQ4CiDCoCMxIFtmZmZmYjAwMjAwMTg0ZmU4XSBfX3N5
c3ZlY19yZWJvb3QgYXQgZmZmZmZmZmY4OWE5NDIxMwogwqAjMiBbZmZmZmIwMDIwMDE4NGZmMF0g
c3lzdmVjX3JlYm9vdCBhdCBmZmZmZmZmZjhhZWU3NDkxCi0tLSA8SVJRIHN0YWNrPiAtLS0KIMKg
wqDCoCBSSVA6IDAwMDAwMDAwMDAwMDAwMTDCoCBSU1A6IDAwMDAwMDAwMDAwMDAwMTjCoCBSRkxB
R1M6IGZmZmZiMDAyMDBmOGJkMDgKIMKgwqDCoCBSQVg6IGZmZmY5YWMyNTZmZGE5ZDjCoCBSQlg6
IDAwMDAwMDAwMDk5NzNhODXCoCBSQ1g6IGZmZmY5YWMyNTZmZGEwNzgKIMKgwqDCoCBSRFg6IGZm
ZmY5YWMyNDQxNmUzMDDCoCBSU0k6IGZmZmY5YWMyNTZmZGE5ZTDCoCBSREk6IGZmZmZmZmZmZmZm
ZmZmZmYKIMKgwqDCoCBSQlA6IGZmZmY5YWMyNDQzYTVmODjCoMKgIFI4OiAwMDAwMDAwMDAwMDAw
MDAwwqDCoCBSOTogZmZmZjlhYzI0MjJlZWVhMAogwqDCoMKgIFIxMDogZmZmZjlhYzI1NmZkYTlk
OMKgIFIxMTogMDAwMDAwMDAwMDU0OTkyMcKgIFIxMjogZmZmZjlhYzI0MjJlZWVhMAogwqDCoMKg
IFIxMzogZmZmZjlhYzI1MWNkMjNjOMKgIFIxNDogZmZmZjlhYzI0MjY5YTgwMMKgIFIxNTogZmZm
ZjlhYzI1MWNkMjE1MAogwqDCoMKgIE9SSUdfUkFYOiBmZmZmZmZmZjhhMTcxOWU0wqAgQ1M6IDAy
MDbCoCBTUzogZmZmZmZmZmY4YTE3MTljOApidDogV0FSTklORzogcG9zc2libHkgYm9ndXMgZXhj
ZXB0aW9uIGZyYW1lCgpEbyB5b3Uga25vdyBob3cgdGhpcyBoYXBwZW5lZD8gSSB3b3VsZCBiZSBn
cmF0ZWZ1bCBpZiB5b3UgY291bGQgZml4IGl0LgoKVGhhbmtzIQotLSAKV2l0aCBCZXN0IFJlZ2Fy
ZHMsCkJhb2t1biBMaQouCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
