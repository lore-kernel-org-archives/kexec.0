Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1556C27C52
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G4JAUsIo3r94TdGo20qltHQfSB+93/D7iSfzn6uB1bA=; b=YiYsyAILFW8mB9
	iaGLHOZxYUhGWWOJ6DzTMDeNxBuVdEasrwFlXgIWg0hjS4PVXD43IxPbcurrgkPWTEQzrLCn9Nr9Z
	CU+ircwGGJ7VOPjDCzJsY7Qxx7a2sfzBXLNtIlY+HUA66rKKGvUS7bqZCeiS/X9tQEg47nRmTMYQb
	UploEsG8cMfH3IWeCOE47HKOGir23awH4op6F9SxN9n6a8r/nuhNPJvv5IVe4pttTvhdsvlv8pV7/
	FNX8zI1I83ee0u5/GVd0u3jyFcugZjRfhsI3/E4vbc6voRaToImlDK3Ixaw4yRt+07OE3QXYEBo+K
	otJ9y2IARbbpX7qJ7opA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHOc-00000000f5L-0gff;
	Mon, 03 Jun 2024 23:47:22 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHOX-00000000f4W-3ngO
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 23:47:19 +0000
Received: from [IPV6:2607:fb90:3707:40b:a32e:4449:b3a:891d] ([IPv6:2607:fb90:3707:40b:a32e:4449:b3a:891d])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 453MhgU5475578
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 15:43:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 453MhgU5475578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717454626;
	bh=wuD6WLaEWhP4n3Qasi9wvzUCa2upP1PV62NIREW0BKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBToC2O4KGQk197cIv7t84JmESw/VZTY3yCo3LqaSIXdLNAqfkAdoAN+wohABjwpV
	 GG8YdHXGo0U45ht4clybrH6eJ/AiZIL2nz1YNbWGmte1xbtzL3wkn7penFxvDyij1J
	 w1sPlUp39rOPmBXa3KDRfbxxVxioSumuNPHXOXJoU60YnM/WXbT8vWyCloinAqoZ+E
	 lAArupSy4TdrTTju+IaHtBBQsQHt8qzCikfK/2TAoD86qTyqGlwTzhL4m2ipVvPsk+
	 mp0olUR+8EO4Z6RjUV5pc3lZiwOYm3IvGz1v+NNFEsPXVh1CpFmDZisWBu3BX+ytNL
	 s7upucbc1rdrQ==
Message-ID: <2b661d91-badc-4c90-9a9a-fe82635cf514@zytor.com>
Date: Mon, 3 Jun 2024 15:43:41 -0700
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
X-CRM114-CacheID: sfid-20240603_164718_077732_0BE646CC 
X-CRM114-Status: UNSURE (   7.26  )
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
IGptcCAxZgo+IAoKU29ycnkgaWYgdGhpcyBpcyBhIGR1cGxpY2F0ZTsgc29tZXRoaW5nIHN0cmFu
Z2UgaGFwcGVuZWQgd2l0aCBteSBlbWFpbC4KCklmIHlvdSBhcmUgY2xlYW5pbmcgdXAgdGhpcyBj
b2RlIGFueXdheS4uLgoKdGhpcyB3aG9sZSBwaWVjZSBvZiBjb2RlIGNhbiBiZSBzaW1wbGlmaWVk
IHRvOgoKCWFuZCAkKFg4Nl9DUjRfUEFFIHwgWDg2X0NSNF9MQTU3KSwgJXIxM2QKCW1vdiAlcjEz
LCAlY3I0CgpUaGUgUEFFIGJpdCBpbiAlcjEzIGlzIGd1YXJhbnRlZWQgdG8gYmUgc2V0LCBhbmQg
JXIxMyBpcyBkZWFkIGFmdGVyIHRoaXMuCgoJLWhwYQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
