Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC028C25B78
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w2Tlg4R1YI3stU2xlPsMh0PgW4OaJMzAc4GKMKW0P8k=; b=0VmnKDXSzefTCm
	RzcBqLs8a5F79iLD2lrN0eoI4CT4t7RUYXN7i9mwLt/rFNh3zzjPkvAzzCk8nOw060r4z0LA7doHB
	2sGMcmh9wqUbA5JE82JHT9932M8bHmWD48ANso2F9t43XIZVaoWIG+U9ctjclAxy5eKrScXbWay/Q
	PxCh7fUJJGkTN1g+vvQKn4rbg2yq3Xg2pZ6YIGBt2rai8LuyFIb70rmNH1K8EPgkyIOZY1fzIid6i
	MJ7mJmKnKharKhK0HqXFIpK1L7dPurwq7oy22JJId3hKMdS3h8Xv6gzSSdlzSM5K6WBLvCGjnQNt+
	/yOR2IFsFlIdUif9n9ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHOZ-00000000f4w-2kPJ;
	Mon, 03 Jun 2024 23:47:19 +0000
Received: from terminus.zytor.com ([198.137.202.136])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHOW-00000000f4E-2qUw
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 23:47:18 +0000
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 453EhCwn3610090
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 07:43:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 453EhCwn3610090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717425794;
	bh=sOv2pml39rCUmYtq263pd0Mke6ArsY5AX7diMAElB7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6kPfk5mkSk5h0hAkB5UJ45Gs5fwkaIkIuhFTy8KR1NFWRKyqxjf62B+INqAcQtYS
	 1K1lC+HHZJuFQJH2hrVwQHOc06tWtoXdTqdjxCtihWqxWYG502lPDyIQ4rkBMhLEhX
	 K5hZO67HdOTy/G6fEJulnDhrID0NSaitVzskOa4cHmaexkEmC7pQImZo+W84PK6HAo
	 bnuJkaQAPQoM+KjEcz2CDmaFd2wNeI3Zuz5LkufhuWzQsKUTxlzUbNf3l2hZnESq6D
	 qE+/LWd5MSggxOHt2HBe0b+7WMwUp6U2gtRzKKnfqNHrh1XhfRO17fyfW7MrCcVKLc
	 kcU1XkhpOZnLg==
Message-ID: <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
Date: Mon, 3 Jun 2024 07:43:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: Nikolay Borisov <nik.borisov@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish"
 <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_164716_724859_D5EE0A3E 
X-CRM114-Status: UNSURE (   8.57  )
X-CRM114-Notice: Please train this message.
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

T24gNS8yOS8yNCAwMzo0NywgTmlrb2xheSBCb3Jpc292IHdyb3RlOgo+Pgo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TIAo+PiBiL2FyY2gveDg2L2tl
cm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUwo+PiBpbmRleCA1NmNhYjFiYjI1ZjUuLjA4NWVlZjVj
MzkwNCAxMDA2NDQKPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5T
Cj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUwo+PiBAQCAtMTQ4
LDkgKzE0OCwxMCBAQCBTWU1fQ09ERV9TVEFSVF9MT0NBTF9OT0FMSUdOKGlkZW50aXR5X21hcHBl
ZCkKPj4gwqDCoMKgwqDCoMKgICovCj4+IMKgwqDCoMKgwqAgbW92bMKgwqDCoCAkWDg2X0NSNF9Q
QUUsICVlYXgKPj4gwqDCoMKgwqDCoCB0ZXN0ccKgwqDCoCAkWDg2X0NSNF9MQTU3LCAlcjEzCj4+
IC3CoMKgwqAganrCoMKgwqAgMWYKPj4gK8KgwqDCoCBqesKgwqDCoCAuTG5vX2xhNTcKPj4gwqDC
oMKgwqDCoCBvcmzCoMKgwqAgJFg4Nl9DUjRfTEE1NywgJWVheAo+PiAtMToKPj4gKy5Mbm9fbGE1
NzoKPj4gKwo+PiDCoMKgwqDCoMKgIG1vdnHCoMKgwqAgJXJheCwgJWNyNAo+PiDCoMKgwqDCoMKg
IGptcCAxZgo+IAo+IFRoYXQgam1wIDFmIGJlY29tZXMgcmVkdW5kYW50IG5vdyBhcyBpdCBzaW1w
bHkganVtcHMgMSBsaW5lIGJlbG93Lgo+IAoKVWguLi4gYW0gSSB0aGUgb25seSBwZXJzb24gdG8g
bm90aWNlIHRoYXQgQUxMIHRoYXQgaXMgbmVlZGVkIGhlcmUgaXM6CgoJYW5kbCAkKFg4Nl9DUjRf
UEFFfFg4Nl9DUjRfTEE1NyksICVyMTNkCgltb3ZxICVyMTMsICVyYXgKCi4uLiBzaW5jZSAlcjEz
IGlzIGRlYWQgYWZ0ZXJ3YXJkcywgYW5kIFBBRSAqd2lsbCogaGF2ZSBiZWVuIHNldCBpbiAlcjEz
IAphbHJlYWR5PwoKSSBkb24ndCBiZWxpZXZlIHRoYXQgdGhpcyBzcGVjaWZpYyBqbXAgaXMgYWN0
dWFsbHkgbmVlZGVkIC0tIHRoZXJlIGFyZSAKc2V2ZXJhbCBtb3JlIHN5bmNocm9uaXppbmcganVt
cHMgbGF0ZXIgLS0gYnV0IGl0IGRvZXNuJ3QgaHVydC4KCkhvd2V2ZXIsIGlmIHRoZSBlZmZvcnQg
aXMgZm9yIGltcHJvdmluZyB0aGUgcmVhZGFiaWxpdHksIGl0IG1pZ2h0IGJlIAp3b3J0aHdoaWxl
IHRvIGVuY2Fwc3VsYXRlIHRoZSAiam1wIDFmOyAxOiIgYXMgYSBtYWNybywgZS5nLiAiU1lOQ19D
T0RFIi4KCgktaHBhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
