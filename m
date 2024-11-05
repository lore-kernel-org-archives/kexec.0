Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB1DD40CE4
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 22:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9k6uAq9lCoihNg6i8LRnIbmCJWfcUs0vzWZ0saxcYM=; b=fCsqtOq6a7UOzK
	4XN2Zk1koKxjsz082wDQldFVk/U8z5ysCA5PMtSnN8lFu95/QQGLSbOHZUgWGQf+iXnR3Zu1/NDU2
	q9IHTBtgCAKvkl63utTd0p52jcEeuWy4voebjksumA9dC1MQBS2qETReG5hhUoQfEGWNJe8PKmU3K
	4gzmV1dho8ey41pKDIMiKM88ZmYLCZqHtdqHAxemUklxB9rj84vDE9rH33Cugj5bKyU5TONum5LdO
	ErN4SmeBVQ2LF0l55NusfUKL8e21k/2d/5S/3ssI0ZT6bXOckl8lzySi4staxiH6OQemmfmovOq6O
	eiDYChk0KNkyKtTrOncw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8SUo-000000013eu-1jRP;
	Tue, 05 Nov 2024 22:57:58 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8SUl-000000013eV-05Rr
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 22:57:56 +0000
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5MvSdh424848
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:57:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5MvSdh424848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730847450;
	bh=FxTpXSTQa9JsCRn1p6lVgcE0xkUvR08XuNrFIpNz3kg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eo6NVK9jCY9J0ahyD46pfe20rkRWwCv3gYYK9no9YYO75yZQwG0KXsDvzIlzn2t+Y
	 sJsRzkedETZLV47rytFOOM+htDCKqVGHXUrvuaKISN3n3Tbjh3MSiN/3EdFV72eK+i
	 dOvOCFw6qI9qW3GNFvN7zEBEChBaBeyWnd9ZyqpBX/Vbwn53ssIcrXuAeTXmGDfz3E
	 4SAyfFwmkoJaQ8Zxg9bFMu/MnsabftcqrbWeRaL4AyGEq0qaldV+4noXc6b+NoWYte
	 F1HjHM2G7LkMlwUQwSC7rkmvFGbb2fVZMX91Ai+bnJ7padfBVs3nDL6yW8+B32J/te
	 9DvbzHydENhjQ==
Message-ID: <3a91abd7-5edd-4f4e-bb15-fb9c91f64cc9@zytor.com>
Date: Tue, 5 Nov 2024 14:57:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
 <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
 <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
Content-Language: en-US
In-Reply-To: <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_145755_071662_CC985FC9 
X-CRM114-Status: UNSURE (   8.32  )
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

T24gMTEvNS8yNCAxNDoyNywgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cj4gCj4gSSBkb24ndCBrbm93
IGlmIGl0IGlzIG5lY2Vzc2FyeSwgYnV0IHlvdSBjYW4gZG8gc29tZXRoaW5nIGxpa2UgdGhpcyB0
byAKPiBtYWtlIGFic29sdXRlbHkgc3VyZSB5b3UgZG9uJ3QgZW5kIHVwIHdpdGggbm9uLXJlbGF0
aXZlIHN5bWJvbCByZWZlcmVuY2VzOgo+IAo+IHN0YXRpYyBpbmxpbmUgX19jb25zdGZ1bmMgdm9p
ZCAqIHN5bV9hZGRyKGNvbnN0IHZvaWQgKnN5bSkKPiB7Cj4gIMKgwqDCoMKgdm9pZCAqYWRkcjsK
PiAgwqDCoMKgwqBhc20oImxlYSAlYzEoJSVyaXApLCUwIiA6ICI9ciIgKGFkZHIpIDogImkiIChz
eW0pKTsKPiAgwqDCoMKgwqByZXR1cm4gYWRkcjsKPiB9Cj4gCgpDb21waWxpbmcgd2l0aCAiLWZw
aWMgLWZ2aXNpYmlsaXR5PWhpZGRlbiAtbWNtb2RlbD1tZWRpdW0iIGNhbiBhbHNvIGJlIAp1c2Vk
IHRvIHN1cHByZXNzIG5vbi1yZWxhdGl2ZSByZWZlcmVuY2VzLiBJZiB5b3UgaGF2ZSBleHRlcm5h
bCBzeW1ib2wgCnJlZmVyZW5jZXMgdGhleSBhdCBsZWFzdCAqc2hvdWxkKiBiZSBlbWl0dGVkIGFz
IEdPVFBDUkVMWCByZWxvY2F0aW9ucyAKd2hpY2ggdGhlIGxpbmtlciBzaG91bGQgcmVsYXggdG8g
cmVsYXRpdmUgcmVmZXJlbmNlczsgaG93ZXZlciwgSSB3b3VsZCAKdGhpbmsgdGhhdCB5b3UgcmVh
bGx5IGRvbid0IHdhbnQgYW55IG9mIHRob3NlIDopCgoJLWhwYQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
