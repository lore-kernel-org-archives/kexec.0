Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E7EB64DA
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=te2TlXIT98E4asu9u17zY3FlX49OLO/bpOsyX4r8jso=; b=1nYXioUPbUGGHZ
	i4cD52Y44Z2E4qhH8++dS/vfHDTJOZ083wym0A3cZmjwNooq/c7uKoiFQf4yZGodXyQxmJq5Mudch
	BpyAW9vFxrFhKgTd/Yq0tyI0XZgVozexKk16o/r+mBetQ2C6HG1J/v8SCtdEqIYUZmVpekGsC/c9e
	HDWv+MH4RZatyW8xo2ydBtiNFTqsmpPXPiiASBpXmWXScPsq6muU9tjbUYsp5CUVQOI4vbQ0sWj93
	lII2hoAq74ZK9+yRk8uCPh9lLbseeF+2t0e0qMiPD69tjDRswiMCpwYUVdR251f/ZHSYTlmDXJABO
	AHXJancfvcXe9VWh8VYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHiYF-004LtE-0v;
	Fri, 07 Jul 2023 10:18:59 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHiYC-004LhB-1p
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 10:18:58 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1688725121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d3houmsYkGVGZJ+TnslUxorhkLSwL4n9/p70tnZL7A=;
	b=y4doa5DKfOzdCF21tIHXXGEp7Tighcyi2aqc4+bE5su2grB8igK69DcILbae5lykTRs5JV
	PYm8S351m8I52i6O6betlp1NJBOuaDOhcpSjHpAf5gkPS4ql4bPs59vUfRwN0hS9oBxuGZ
	HjfgVjqt5FZpSyJuXRwsWXqLu6J3UyRqhFNdrmogJQ1uVYvApG4e2Mrb+3YSpKMjw+Fuhg
	aRPDRjqsb/hyTS0kFyDNsh6kwdQIYmX8MSLyHPhJp7wTnbDAeNbh9ORfvwHzHkqL0p85+B
	TOR0s68ZDsmb21uc+eK6qJ/CoWkJZQt1mKvLGEyZipI8aM+1MJbfWzOqwFeCDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1688725121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2d3houmsYkGVGZJ+TnslUxorhkLSwL4n9/p70tnZL7A=;
	b=9tdprbeuz34HJLn6OXpF/f1dsXMyUURUW2bxIbsBMyXUbdtkctVG/W3f9EIP518gzZTyL0
	btin56Kv04H/BoDg==
To: Baokun Li <libaokun1@huawei.com>
Cc: arjan@linux.intel.com, ashok.raj@intel.com, ashok.raj@linux.intel.com,
 ebiederm@xmission.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, tony.luck@intel.com,
 tonyb@cybernetics.com, x86@kernel.org, yangerkun <yangerkun@huawei.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Baokun Li
 <libaokun1@huawei.com>
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
In-Reply-To: <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com> <87ttui91jo.ffs@tglx>
 <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
Date: Fri, 07 Jul 2023 12:18:39 +0200
Message-ID: <87lefs81og.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_031856_764352_C51AA455 
X-CRM114-Status: GOOD (  16.23  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKdWwgMDYgMjAyMyBhdCAxNDo0NCwgQmFva3VuIExpIHdyb3RlOgo+IE9uIDIwMjMv
Ny81IDE2OjU5LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+ICsJLyoKPj4gKwkgKiBJZiB0aGlz
IGlzIGEgY3Jhc2ggc3RvcCB3aGljaCBkb2VzIG5vdCBleGVjdXRlIG9uIHRoZSBib290IENQVSwK
Pj4gKwkgKiB0aGVuIHRoaXMgY2Fubm90IHVzZSB0aGUgSU5JVCBtZWNoYW5pc20gYmVjYXVzZSBJ
TklUIHRvIHRoZSBib290Cj4+ICsJICogQ1BVIHdpbGwgcmVzZXQgdGhlIG1hY2hpbmUuCj4+ICsJ
ICovCj4+ICsJaWYgKHRoaXNfY3B1KQo+PiArCQlyZXR1cm4gZmFsc2U7Cgo+IFRoaXMgcGF0Y2gg
ZG9lcyBmaXggdGhlIHByb2JsZW0gb2YgcmVib290aW5nIGF0IHBhbmljLCBidXQgdGhlCj4gZXhw
b3J0ZWQgc3RhY2sgc3RheXMgYXQgc3RvcF90aGlzX2NwdSgpIGxpa2UgYmVsb3csIGluc3RlYWQg
b2Ygc2hvd2luZwo+IHdoYXQgdGhlIGNvcnJlc3BvbmRpbmcgcHJvY2VzcyBpcyBkb2luZyBhcyBi
ZWZvcmUuCj4KPiBQSUQ6IDY4McKgwqDCoMKgwqAgVEFTSzogZmZmZjlhYzI0MjlkMzA4MMKgIENQ
VTogMsKgwqDCoCBDT01NQU5EOiAiZnNzdHJlc3MiCj4gIMKgIzAgW2ZmZmZiMDAyMDAxODRmZDBd
IHN0b3BfdGhpc19jcHUgYXQgZmZmZmZmZmY4OWE0ZmZkOAo+ICDCoCMxIFtmZmZmYjAwMjAwMTg0
ZmU4XSBfX3N5c3ZlY19yZWJvb3QgYXQgZmZmZmZmZmY4OWE5NDIxMwo+ICDCoCMyIFtmZmZmYjAw
MjAwMTg0ZmYwXSBzeXN2ZWNfcmVib290IGF0IGZmZmZmZmZmOGFlZTc0OTEKPiAtLS0gPElSUSBz
dGFjaz4gLS0tCj4gIMKgwqDCoCBSSVA6IDAwMDAwMDAwMDAwMDAwMTDCoCBSU1A6IDAwMDAwMDAw
MDAwMDAwMTjCoCBSRkxBR1M6IGZmZmZiMDAyMDBmOGJkMDgKPiAgwqDCoMKgIFJBWDogZmZmZjlh
YzI1NmZkYTlkOMKgIFJCWDogMDAwMDAwMDAwOTk3M2E4NcKgIFJDWDogZmZmZjlhYzI1NmZkYTA3
OAo+ICDCoMKgwqAgUkRYOiBmZmZmOWFjMjQ0MTZlMzAwwqAgUlNJOiBmZmZmOWFjMjU2ZmRhOWUw
wqAgUkRJOiBmZmZmZmZmZmZmZmZmZmZmCj4gIMKgwqDCoCBSQlA6IGZmZmY5YWMyNDQzYTVmODjC
oMKgIFI4OiAwMDAwMDAwMDAwMDAwMDAwwqDCoCBSOTogZmZmZjlhYzI0MjJlZWVhMAo+ICDCoMKg
wqAgUjEwOiBmZmZmOWFjMjU2ZmRhOWQ4wqAgUjExOiAwMDAwMDAwMDAwNTQ5OTIxwqAgUjEyOiBm
ZmZmOWFjMjQyMmVlZWEwCj4gIMKgwqDCoCBSMTM6IGZmZmY5YWMyNTFjZDIzYzjCoCBSMTQ6IGZm
ZmY5YWMyNDI2OWE4MDDCoCBSMTU6IGZmZmY5YWMyNTFjZDIxNTAKPiAgwqDCoMKgIE9SSUdfUkFY
OiBmZmZmZmZmZjhhMTcxOWU0wqAgQ1M6IDAyMDbCoCBTUzogZmZmZmZmZmY4YTE3MTljOAo+IGJ0
OiBXQVJOSU5HOiBwb3NzaWJseSBib2d1cyBleGNlcHRpb24gZnJhbWUKPgo+IERvIHlvdSBrbm93
IGhvdyB0aGlzIGhhcHBlbmVkPyBJIHdvdWxkIGJlIGdyYXRlZnVsIGlmIHlvdSBjb3VsZCBmaXgg
aXQuCgpObywgSSBkb24ndC4gQnV0IHRoZXJlIGlzIGNsZWFybHkgYSBoaW50OgoKPiBidDogV0FS
TklORzogcG9zc2libHkgYm9ndXMgZXhjZXB0aW9uIGZyYW1lCgpTbyB0aGUgZXhjZXB0aW9uIGZy
YW1lIHNlZW1zIHRvIGJlIGNvcnJ1cHRlZC4gSSBoYXZlIG5vIGlkZWEgd2h5LgoKVGhlIHF1ZXN0
aW9uIGlzLCB3aGV0aGVyIHRoaXMgZ29lcyBhd2F5IHdoZW4geW91IHJldmVydCB0aGF0IGNvbW1p
dCBvciBub3QuCkkgY2FuJ3Qgb3JhY2xlIHRoYXQgb3V0IGZyb20geW91ciByZXBvcnQuCgpDYW4g
eW91IHBsZWFzZSByZXZlcnQgNDVlMzRjOGFmNThmIG9uIHRvcCBvZiBMaW51cyB0cmVlIGFuZCB2
ZXJpZnkgdGhhdAppdCBtYWtlcyB0aGUgaXNzdWUgZ28gYXdheT8KClRoYW5rcywKCiAgICAgICAg
dGdseAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
