Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FC6EB64DA
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3rhapC/CF0p8gGb5lq12ytLTQ1adUYq1UovzOIU2jjA=; b=MyV0fTePzeferR
	RiEsLAa/B76fU/K2/DKetNpl+FWihHGZupOwqYtppw/WTEAovIFpgK8hL72tdptzUXef6yXqPpw/t
	TjE+oq0EaGAgtUn14ns+nr4u4/huAnXznW58EGErontzxX5/KMRbhg3+/EVSisXWA8ecm41Kk5M15
	gOCHRBbZgpSyAuVih4E0LUvNGlMtQip24SK/pQZry+TLmLOsEDTzx+o6MW/redj30CyHaaoyFQUyv
	6A1OlbBnyL+qGr8QSFjsjyPxzGhBQvXwp8B+hoqACQEiAmH94rMUxex7QnES9rSu9DBVl1Togf85H
	9U33nq8Vz4WSJRImtzIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHklM-004e3y-2o;
	Fri, 07 Jul 2023 12:40:40 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHklI-004e1a-1h
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 12:40:38 +0000
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyCbD44WxztQVn;
	Fri,  7 Jul 2023 20:37:28 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:40:22 +0800
Message-ID: <60c2ec19-9848-b7f0-f8af-53be0cbaf319@huawei.com>
Date: Fri, 7 Jul 2023 20:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
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
 <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com> <87lefs81og.ffs@tglx>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87lefs81og.ffs@tglx>
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_054036_967926_9F7473B8 
X-CRM114-Status: GOOD (  19.24  )
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

T24gMjAyMy83LzcgMTg6MTgsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBPbiBUaHUsIEp1bCAw
NiAyMDIzIGF0IDE0OjQ0LCBCYW9rdW4gTGkgd3JvdGU6Cj4+IE9uIDIwMjMvNy81IDE2OjU5LCBU
aG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+PiArCS8qCj4+PiArCSAqIElmIHRoaXMgaXMgYSBjcmFz
aCBzdG9wIHdoaWNoIGRvZXMgbm90IGV4ZWN1dGUgb24gdGhlIGJvb3QgQ1BVLAo+Pj4gKwkgKiB0
aGVuIHRoaXMgY2Fubm90IHVzZSB0aGUgSU5JVCBtZWNoYW5pc20gYmVjYXVzZSBJTklUIHRvIHRo
ZSBib290Cj4+PiArCSAqIENQVSB3aWxsIHJlc2V0IHRoZSBtYWNoaW5lLgo+Pj4gKwkgKi8KPj4+
ICsJaWYgKHRoaXNfY3B1KQo+Pj4gKwkJcmV0dXJuIGZhbHNlOwoKVGhpcyBkb2VzIHNvbHZlIHRo
ZSBwcm9ibGVtIG9mIHg4NiBWTXMgbm90IHdhaXRpbmcgd2hlbiB0aGV5IHBhbmljLCBzbwoKUmVw
b3J0ZWQtYW5kLXRlc3RlZC1ieTogQmFva3VuIExpIDxsaWJhb2t1bjFAaHVhd2VpLmNvbT4KCj4+
IFRoaXMgcGF0Y2ggZG9lcyBmaXggdGhlIHByb2JsZW0gb2YgcmVib290aW5nIGF0IHBhbmljLCBi
dXQgdGhlCj4+IGV4cG9ydGVkIHN0YWNrIHN0YXlzIGF0IHN0b3BfdGhpc19jcHUoKSBsaWtlIGJl
bG93LCBpbnN0ZWFkIG9mIHNob3dpbmcKPj4gd2hhdCB0aGUgY29ycmVzcG9uZGluZyBwcm9jZXNz
IGlzIGRvaW5nIGFzIGJlZm9yZS4KPj4KPj4gUElEOiA2ODHCoMKgwqDCoMKgIFRBU0s6IGZmZmY5
YWMyNDI5ZDMwODDCoCBDUFU6IDLCoMKgwqAgQ09NTUFORDogImZzc3RyZXNzIgo+PiAgIMKgIzAg
W2ZmZmZiMDAyMDAxODRmZDBdIHN0b3BfdGhpc19jcHUgYXQgZmZmZmZmZmY4OWE0ZmZkOAo+PiAg
IMKgIzEgW2ZmZmZiMDAyMDAxODRmZThdIF9fc3lzdmVjX3JlYm9vdCBhdCBmZmZmZmZmZjg5YTk0
MjEzCj4+ICAgwqAjMiBbZmZmZmIwMDIwMDE4NGZmMF0gc3lzdmVjX3JlYm9vdCBhdCBmZmZmZmZm
ZjhhZWU3NDkxCj4+IC0tLSA8SVJRIHN0YWNrPiAtLS0KPj4gICDCoMKgwqAgUklQOiAwMDAwMDAw
MDAwMDAwMDEwwqAgUlNQOiAwMDAwMDAwMDAwMDAwMDE4wqAgUkZMQUdTOiBmZmZmYjAwMjAwZjhi
ZDA4Cj4+ICAgwqDCoMKgIFJBWDogZmZmZjlhYzI1NmZkYTlkOMKgIFJCWDogMDAwMDAwMDAwOTk3
M2E4NcKgIFJDWDogZmZmZjlhYzI1NmZkYTA3OAo+PiAgIMKgwqDCoCBSRFg6IGZmZmY5YWMyNDQx
NmUzMDDCoCBSU0k6IGZmZmY5YWMyNTZmZGE5ZTDCoCBSREk6IGZmZmZmZmZmZmZmZmZmZmYKPj4g
ICDCoMKgwqAgUkJQOiBmZmZmOWFjMjQ0M2E1Zjg4wqDCoCBSODogMDAwMDAwMDAwMDAwMDAwMMKg
wqAgUjk6IGZmZmY5YWMyNDIyZWVlYTAKPj4gICDCoMKgwqAgUjEwOiBmZmZmOWFjMjU2ZmRhOWQ4
wqAgUjExOiAwMDAwMDAwMDAwNTQ5OTIxwqAgUjEyOiBmZmZmOWFjMjQyMmVlZWEwCj4+ICAgwqDC
oMKgIFIxMzogZmZmZjlhYzI1MWNkMjNjOMKgIFIxNDogZmZmZjlhYzI0MjY5YTgwMMKgIFIxNTog
ZmZmZjlhYzI1MWNkMjE1MAo+PiAgIMKgwqDCoCBPUklHX1JBWDogZmZmZmZmZmY4YTE3MTllNMKg
IENTOiAwMjA2wqAgU1M6IGZmZmZmZmZmOGExNzE5YzgKPj4gYnQ6IFdBUk5JTkc6IHBvc3NpYmx5
IGJvZ3VzIGV4Y2VwdGlvbiBmcmFtZQo+Pgo+PiBEbyB5b3Uga25vdyBob3cgdGhpcyBoYXBwZW5l
ZD8gSSB3b3VsZCBiZSBncmF0ZWZ1bCBpZiB5b3UgY291bGQgZml4IGl0Lgo+IE5vLCBJIGRvbid0
LiBCdXQgdGhlcmUgaXMgY2xlYXJseSBhIGhpbnQ6Cj4KPj4gYnQ6IFdBUk5JTkc6IHBvc3NpYmx5
IGJvZ3VzIGV4Y2VwdGlvbiBmcmFtZQo+IFNvIHRoZSBleGNlcHRpb24gZnJhbWUgc2VlbXMgdG8g
YmUgY29ycnVwdGVkLiBJIGhhdmUgbm8gaWRlYSB3aHkuCj4KPiBUaGUgcXVlc3Rpb24gaXMsIHdo
ZXRoZXIgdGhpcyBnb2VzIGF3YXkgd2hlbiB5b3UgcmV2ZXJ0IHRoYXQgY29tbWl0IG9yIG5vdC4K
PiBJIGNhbid0IG9yYWNsZSB0aGF0IG91dCBmcm9tIHlvdXIgcmVwb3J0Lgo+Cj4gQ2FuIHlvdSBw
bGVhc2UgcmV2ZXJ0IDQ1ZTM0YzhhZjU4ZiBvbiB0b3Agb2YgTGludXMgdHJlZSBhbmQgdmVyaWZ5
IHRoYXQKPiBpdCBtYWtlcyB0aGUgaXNzdWUgZ28gYXdheT8KPgo+IFRoYW5rcywKPgo+ICAgICAg
ICAgIHRnbHgKWWVzLCB0aGUgc3RvcF90aGlzX2NwdSgpIGlzc3VlIHBlcnNpc3RlZCBhZnRlciBJ
IHJldmVydGVkIDQ1ZTM0YzhhZjU4ZiAKYW5kIGl0CmhhcyBub3RoaW5nIHRvIGRvIHdpdGggeW91
ciBwYXRjaCwgSSB3aWxsIHRyeSB0byBiaXNlY3QgdG8gZmluZCBvdXQgCndoaWNoIHBhdGNoCmlu
dHJvZHVjZWQgdGhlIGlzc3VlLgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgaGVscGluZyBsb2Nh
dGUgYW5kIHJlY3RpZnkgdGhlIHByb2JsZW0gdGhhdCB0aGUgeDg2ClZNIHBhbmljIGRvZXMgbm90
IHdhaXQhCgpDaGVlcnMhCi0tIApXaXRoIEJlc3QgUmVnYXJkcywKQmFva3VuIExpCi4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
