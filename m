Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203D2C27C53
	for <kexec@archiver.kernel.org>; Wed, 12 Jun 2024 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rlOwV0gktFULYGfh1GYIXDvA+JKUKpTY/VNEWZVVvk4=; b=JrDwngV+mcNgiY
	EMYY9y/C3W1CQ4bR9QlyYJLNVo7bWxOn2BaY4gWZwyPdzVOJnApslgef1qS3jIQZqDfz3UweOavV6
	hy5kDKhPzeVyihqzi6AdRq/yxrcxxfAyfaSLDPPloi6JruOEP6iVuV436oQA3TshTHAoE+ZKQ0sOK
	95tcIrrgWc6YBi7WthKNRdape8pgbQwC1XSjWQButVhdq8sgqf1jdBksDVDhWm/qc28EjUJnf7Am8
	EYKsRhUA+2VMIS6PLC6OgDRQOcdeqizhY3eO0vBnntZdiZ6lzbVskT4zs1D1gSpGuWqNnYQegH7lK
	EA/9RMzbhtAC2D03c96g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHMoC-0000000CXmt-1KFJ;
	Wed, 12 Jun 2024 12:10:32 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHMo9-0000000CXlS-1lyk
	for kexec@lists.infradead.org;
	Wed, 12 Jun 2024 12:10:30 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so41617165e9.0
        for <kexec@lists.infradead.org>; Wed, 12 Jun 2024 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718194224; x=1718799024; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1E6gKaYfsGolM4dsZnb6DX/G/+das4ShQn/qg2O/U=;
        b=OKgWe2U37/nv+ELDUi+Y6c4FGpnkpDU1A8n4v31VoA2u6zQu5dd4zdSEaNEAXAxHhl
         zEJ8rIwolkqjCizG8M1JzZkNGIdkmdsvANFn89h7DpqLd5oq1LMuXjtD06nQL3HN9hNP
         URCS4VMoq95ONk7epxFAWclPLnfpJ+jPT4CDlm3hbjmBntWraMZwNcD7t0d0DF8A032L
         VOch2GaoyCMKckFJl7KB8yxk5sgWgxi3v0kyv/vJH9RqTKFKc/vOJFemMxBuyDw5z44s
         6N4Dkv5bu36wzBDIPl1Muex2P0nlG5F6EgHWZkwedBkX6dPKGuKNWCXLrhqUZvtRcIj0
         yrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718194224; x=1718799024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1E6gKaYfsGolM4dsZnb6DX/G/+das4ShQn/qg2O/U=;
        b=Nzy7Sh2ZcqqLJOFQ0cpt7QHOoluWQ2pMsChipTXnZBnEvFx+kTIAziUXIo4lYCB3Nn
         wpV0y0eV9atuCRyJHwjY+NEoMzIOJxLPwVWLnWsRvXKOCVY9WKcgzP4RzCe6YSe+H3eJ
         Epnv+7ZLwK27nkgxn5yZhWjMEcbpUndgawUmFVGcp7hwFqL+bSfADwgCgHWAT5ogLRZ8
         0p2HlcbX8JQOYW3CWvlro9HoPQu0ENESsxRShkpRSRkLj5im43inuAGz/RZWFQ/W0K/x
         pfznx6LHFh7k32KGQUKwT6kwtzZasK8BRraWf/jyBIR43cc+SLykApgetHE0b2sZSwp3
         c74Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvPncEPmzt/HHUwAxfLUDtK+JIKQ7BseQyU5BnWUEIzorOKrNTj32Xv+vksCD+DgrQ/SDKEQASTeHZWazklUAPTsAbf62hzTmL
X-Gm-Message-State: AOJu0Yzk3FA6fkJM6pAxLdnCXf9uvo+fZsgyeHBBis5X8bSHStMMKVd6
	swMGemnqbOr4eTO2Ve/l2FNomVdGi4fpzFBIxTeLsgdY9bAuw321yr+7fcE2OtE=
X-Google-Smtp-Source: AGHT+IGGKvFvAX2vsyi3iCxH0IVdZ+RZyQGv87uHYkT/9vnp4Qg0weBEeK0OIcuDUpXL8dTTvAYelw==
X-Received: by 2002:a05:600c:3108:b0:421:7f23:8c5c with SMTP id 5b1f17b1804b1-422866c0c13mr16496455e9.28.1718194224388;
        Wed, 12 Jun 2024 05:10:24 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0c8f5373sm13444819f8f.6.2024.06.12.05.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 05:10:24 -0700 (PDT)
Message-ID: <6eb5c1b2-64d2-42fd-81c9-97c1ae65713f@suse.com>
Date: Wed, 12 Jun 2024 15:10:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_051029_482040_8BA92219 
X-CRM114-Status: GOOD (  10.29  )
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

CgpPbiAzLjA2LjI0INCzLiAxNzo0MyDRhy4sIEguIFBldGVyIEFudmluIHdyb3RlOgo+IE9uIDUv
MjkvMjQgMDM6NDcsIE5pa29sYXkgQm9yaXNvdiB3cm90ZToKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TIAo+Pj4gYi9hcmNoL3g4Ni9rZXJu
ZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMKPj4+IGluZGV4IDU2Y2FiMWJiMjVmNS4uMDg1ZWVmNWMz
OTA0IDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5T
Cj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMKPj4+IEBAIC0x
NDgsOSArMTQ4LDEwIEBAIFNZTV9DT0RFX1NUQVJUX0xPQ0FMX05PQUxJR04oaWRlbnRpdHlfbWFw
cGVkKQo+Pj4gwqDCoMKgwqDCoMKgICovCj4+PiDCoMKgwqDCoMKgIG1vdmzCoMKgwqAgJFg4Nl9D
UjRfUEFFLCAlZWF4Cj4+PiDCoMKgwqDCoMKgIHRlc3RxwqDCoMKgICRYODZfQ1I0X0xBNTcsICVy
MTMKPj4+IC3CoMKgwqAganrCoMKgwqAgMWYKPj4+ICvCoMKgwqAganrCoMKgwqAgLkxub19sYTU3
Cj4+PiDCoMKgwqDCoMKgIG9ybMKgwqDCoCAkWDg2X0NSNF9MQTU3LCAlZWF4Cj4+PiAtMToKPj4+
ICsuTG5vX2xhNTc6Cj4+PiArCj4+PiDCoMKgwqDCoMKgIG1vdnHCoMKgwqAgJXJheCwgJWNyNAo+
Pj4gwqDCoMKgwqDCoCBqbXAgMWYKPj4KPj4gVGhhdCBqbXAgMWYgYmVjb21lcyByZWR1bmRhbnQg
bm93IGFzIGl0IHNpbXBseSBqdW1wcyAxIGxpbmUgYmVsb3cuCj4+Cj4gCj4gVWguLi4gYW0gSSB0
aGUgb25seSBwZXJzb24gdG8gbm90aWNlIHRoYXQgQUxMIHRoYXQgaXMgbmVlZGVkIGhlcmUgaXM6
Cj4gCj4gIMKgwqDCoMKgYW5kbCAkKFg4Nl9DUjRfUEFFfFg4Nl9DUjRfTEE1NyksICVyMTNkCj4g
IMKgwqDCoMKgbW92cSAlcjEzLCAlcmF4Cj4gCj4gLi4uIHNpbmNlICVyMTMgaXMgZGVhZCBhZnRl
cndhcmRzLCBhbmQgUEFFICp3aWxsKiBoYXZlIGJlZW4gc2V0IGluICVyMTMgCj4gYWxyZWFkeT8K
PiAKPiBJIGRvbid0IGJlbGlldmUgdGhhdCB0aGlzIHNwZWNpZmljIGptcCBpcyBhY3R1YWxseSBu
ZWVkZWQgLS0gdGhlcmUgYXJlIAo+IHNldmVyYWwgbW9yZSBzeW5jaHJvbml6aW5nIGp1bXBzIGxh
dGVyIC0tIGJ1dCBpdCBkb2Vzbid0IGh1cnQuCj4gCj4gSG93ZXZlciwgaWYgdGhlIGVmZm9ydCBp
cyBmb3IgaW1wcm92aW5nIHRoZSByZWFkYWJpbGl0eSwgaXQgbWlnaHQgYmUgCj4gd29ydGh3aGls
ZSB0byBlbmNhcHN1bGF0ZSB0aGUgImptcCAxZjsgMToiIGFzIGEgbWFjcm8sIGUuZy4gIlNZTkNf
Q09ERSIuCgoKVGhlIHByZWNlZGluZyBtb3ZlIHRvIENSNCBpcyBpdHNlbGYgYSBzZXJpYWxpemlu
ZyBpbnN0cnVjdGlvbiwgbm8/Cgo+IAo+ICDCoMKgwqDCoC1ocGEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
