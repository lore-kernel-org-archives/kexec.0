Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15346C25B75
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqWrBWq9U3iBQ8QcujLfTxSx0omA/HjmH2NEp6/MkuI=; b=kL2TixEsA3530O
	+o1lXCAn8iobBLv2t2LoCy/zU+gm2Imx9KgMpvQJjxlemN1n6ML4BUq1qqIfHXZuP20NzCjC9brXm
	wWdYOkon8SW17PfI6LdzY5jJOGDc8qBGHFKmfsajX6w9NGBNYGhPKNoN1zQoiiZDsRV5ANjTWMQKU
	6mwmBAr/ijgqsr4h4sOPaDIrcf5grG3fOcDrX8RruLKmtbfkyd/DuX/AbGJSytUokdRTstoeZ8Bg7
	NjeUoeHLmTTz8gP/JSYzY7RbWkySqQAkj7RgVxD9pw9vL5tgkd+PRBVxHv3aCEN/+S/sGAxC0d4hy
	ooP6tkdFCAKaP4OSh9RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCGqd-00000003r9o-2cvu;
	Wed, 29 May 2024 10:47:59 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCGqa-00000003r97-2S37
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 10:47:58 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-52b4fcbf078so358052e87.0
        for <kexec@lists.infradead.org>; Wed, 29 May 2024 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716979674; x=1717584474; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwTOdZ/RFlQPDVFnmQ6lMLq54IcHFFkkOCYIgsO+Y4g=;
        b=OdNiJ5MRBZfCXBV8yBSWTNkuqggR3T8T69xHd8nya0OW+HqzoNoUHfciJ8moYEF3RG
         22ioEdPYU6/7UorEXTXotYYXWD4X3HkoVEelK6fiS4tDuYjuq3HtPZfGZt0DoN+l7/Km
         fRcE1TzuQYQqVDbKYlC6IeQUeaGFXzQbjW90DVBsvqbtd9MHvZFFhUYie2n59Rhdb5Zl
         yUV9j10YdfDu4CUQf4AEiScQ7xxaLbFhboVDNjMnvKL9Sov/PJ+p52cNeBTWFlFW2Lc9
         RL9L9BCw8wZb9jsv6dvmOWapDa3bS1ScjaoDw4t0Z+5pEAlt9XoO0wfaew6bOLOtX4k/
         9qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716979674; x=1717584474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwTOdZ/RFlQPDVFnmQ6lMLq54IcHFFkkOCYIgsO+Y4g=;
        b=soKSXFW/OUMIWfE+tm76ExVO3/lM9sn+SO1ZjwxpuBKVpwjePcCMrUTkWkwMgjWbCT
         NqFz+kVqUHHz1GHGl14STWIhUMWMlCbG3p/egrtpaCyT2MeTFUP2wXlaZq6p5h3n0SC1
         fbIeEuJRlzfc15JmS3QEhr1NlDsYQnD7o5sGf2ToVTmgQKeEoLlCI9UVInSvTZvd+QQE
         2D1QPCuGjuyWS7xmkX0CH09pW8O1FboBMOO82SA1RBfzQOMW+6ZNbQ9dtsMb0wVIWw7n
         vE0tKSIpxMJhjDsw6kf/d0WipjowLpbB5JQQr7+spzoZdgth2wtXLhHosL+2cxlvin+O
         ml6w==
X-Forwarded-Encrypted: i=1; AJvYcCXoDmlibfEj5sOz8EQRfzYgNqvdXzc3urqjIRV11rZ8HbvNLE5UrZ4l2iVgBKh9V80vju8qxeB9YEn7GfuV4UEUW4CwRkdiymR1
X-Gm-Message-State: AOJu0YxP0roU/24+qxrvGg0iL52rCQk1IC7tpSkH7fOYINKiU1bEPF7T
	9SREBByirZ5Xu+LHvsSeToUL2UXNkeUcKk4AOP42ZcSkLRmYEhV9do44SHqEljo=
X-Google-Smtp-Source: AGHT+IEDNLfaKkjwilk2wM/7emdtUCiwRFG5fAyoCeXjb78CBxx0+9sY3lJLnzVD08O5h0N8LkpWdA==
X-Received: by 2002:a05:6512:4c4:b0:52a:fdcb:6652 with SMTP id 2adb3069b0e04-52afdcb66efmr721019e87.68.1716979673442;
        Wed, 29 May 2024 03:47:53 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd? ([2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm176411645e9.14.2024.05.29.03.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 03:47:53 -0700 (PDT)
Message-ID: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
Date: Wed, 29 May 2024 13:47:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_034756_653421_E07987E1 
X-CRM114-Status: GOOD (  13.39  )
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

CgpPbiAyOC4wNS4yNCDQsy4gMTI6NTUg0YcuLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6Cj4g
RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+Cj4gCj4gVGhhdCBpZGVudGl0eV9t
YXBwZWQoKSBmdW5jdGlvbnMgd2FzIGxvdmluZyB0aGF0ICIxIiBsYWJlbCB0byB0aGUgcG9pbnQK
PiBvZiBjb21wbGV0ZWx5IGNvbmZ1c2luZyBpdHMgcmVhZGVycy4KPiAKPiBVc2UgbmFtZWQgbGFi
ZWxzIGluIGVhY2ggcGxhY2UgZm9yIGNsYXJpdHkuCj4gCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Vz
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2IFBldGtvdiAoQU1EKSA8YnBAYWxpZW44LmRl
Pgo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxp
bnV4LmludGVsLmNvbT4KPiAtLS0KPiAgIGFyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxf
NjQuUyB8IDEzICsrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWxv
Y2F0ZV9rZXJuZWxfNjQuUyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUwo+
IGluZGV4IDU2Y2FiMWJiMjVmNS4uMDg1ZWVmNWMzOTA0IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUwo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9yZWxv
Y2F0ZV9rZXJuZWxfNjQuUwo+IEBAIC0xNDgsOSArMTQ4LDEwIEBAIFNZTV9DT0RFX1NUQVJUX0xP
Q0FMX05PQUxJR04oaWRlbnRpdHlfbWFwcGVkKQo+ICAgCSAqLwo+ICAgCW1vdmwJJFg4Nl9DUjRf
UEFFLCAlZWF4Cj4gICAJdGVzdHEJJFg4Nl9DUjRfTEE1NywgJXIxMwo+IC0JanoJMWYKPiArCWp6
CS5Mbm9fbGE1Nwo+ICAgCW9ybAkkWDg2X0NSNF9MQTU3LCAlZWF4Cj4gLTE6Cj4gKy5Mbm9fbGE1
NzoKPiArCj4gICAJbW92cQklcmF4LCAlY3I0Cj4gICAKPiAgIAlqbXAgMWYKClRoYXQgam1wIDFm
IGJlY29tZXMgcmVkdW5kYW50IG5vdyBhcyBpdCBzaW1wbHkganVtcHMgMSBsaW5lIGJlbG93LgoK
PiBAQCAtMTY1LDkgKzE2Niw5IEBAIFNZTV9DT0RFX1NUQVJUX0xPQ0FMX05PQUxJR04oaWRlbnRp
dHlfbWFwcGVkKQo+ICAgCSAqIHVzZWQgYnkga2V4ZWMuIEZsdXNoIHRoZSBjYWNoZXMgYmVmb3Jl
IGNvcHlpbmcgdGhlIGtlcm5lbC4KPiAgIAkgKi8KPiAgIAl0ZXN0cQklcjEyLCAlcjEyCj4gLQlq
eiAxZgo+ICsJanogLkxzbWVfb2ZmCj4gICAJd2JpbnZkCj4gLTE6Cj4gKy5Mc21lX29mZjoKPiAg
IAo+ICAgCW1vdnEJJXJjeCwgJXIxMQo+ICAgCWNhbGwJc3dhcF9wYWdlcwo+IEBAIC0xODcsNyAr
MTg4LDcgQEAgU1lNX0NPREVfU1RBUlRfTE9DQUxfTk9BTElHTihpZGVudGl0eV9tYXBwZWQpCj4g
ICAJICovCj4gICAKPiAgIAl0ZXN0cQklcjExLCAlcjExCj4gLQlqbnogMWYKPiArCWpueiAuTHJl
bG9jYXRlCj4gICAJeG9ybAklZWF4LCAlZWF4Cj4gICAJeG9ybAklZWJ4LCAlZWJ4Cj4gICAJeG9y
bCAgICAlZWN4LCAlZWN4Cj4gQEAgLTIwOCw3ICsyMDksNyBAQCBTWU1fQ09ERV9TVEFSVF9MT0NB
TF9OT0FMSUdOKGlkZW50aXR5X21hcHBlZCkKPiAgIAlyZXQKPiAgIAlpbnQzCj4gICAKPiAtMToK
PiArLkxyZWxvY2F0ZToKPiAgIAlwb3BxCSVyZHgKPiAgIAlsZWFxCVBBR0VfU0laRSglcjEwKSwg
JXJzcAo+ICAgCUFOTk9UQVRFX1JFVFBPTElORV9TQUZFCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
