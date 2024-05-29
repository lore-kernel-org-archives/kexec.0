Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED9DC27C44
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EktxzDZbX2CSPnYMJAgFVelouJiuWTySfYG9OZCQ3IY=; b=FnUFe8cRzKc8Eo
	1aiVjXryys6isLOn4GupUmURNjCp58NLQVLc6L9ckgzZlQ39vP1u/5g4VzjpIJY3IR58x/Qb9sigP
	MUiGEkV/yI6ac496preEVyrt4d+oIhLqASnxt03uSLU1aBS60C1RYMupRtEoymdtMvAhCf8C25BO3
	EX58FIiFhcmo+gDkkIbjzXzqsyFvn87YJwoFZloLpAjmyJJ5nFTUKAcE7YIE1KIxCGQySrXSCyvtU
	nw6+Hita9t5opnSoE/JxcAqBlH4V9CjRBdf88X5peEu76MGFXKe8BZa4J1VlnznpHBgLaDvcamN1X
	eiy4IO1VndEMeAnCgkLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCIV0-000000047ou-0RmT;
	Wed, 29 May 2024 12:33:46 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCIUu-000000047lZ-2g6w
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 12:33:42 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a59a352bbd9so142098866b.1
        for <kexec@lists.infradead.org>; Wed, 29 May 2024 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1716986017; x=1717590817; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjz4o7E9Vi+goRaYpgYsPsr72HU+LspMKlqcruc8gzU=;
        b=NVehkTtA6qSvOKr4yV9LgPHEx/P722Yd6FlFsvqQ+x8qbu9c5ptJiI5EUSrJZ3g7Nh
         uTqwys/+EMO1SUwJt+wnAqG1+o6f8DWyALcElZBWmZAkQsvf3Lzf8Vek9lMaQ1SGptIl
         X6U814K6ZLDYgBvkN/nx4HqkBDpiHDwbAdEE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986017; x=1717590817;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjz4o7E9Vi+goRaYpgYsPsr72HU+LspMKlqcruc8gzU=;
        b=wyqNz28sndDJf70j0VyKr1HsuOrXJD2AE/tAIIVejGXos3xVLjQd/CQ0/y4vo3f55F
         1Bm7qUl3oFkJN2Dlvq1r7AvoYMW33tW9snZUtFx/hLXUCtBBgGSHkfkmQ6x4vhOCq8k8
         CCEAjzNkTC6lC6TBeGi8EeiPabkp98PuvaqEogC1Jx+Fa4wD3B9L8gN+ieeLbj0hmKPN
         BhitGydIv9NdHmo8F1LKz/JAz0HiIeyZgJPLmY2mAqciIDllldgO5MWWp8F8sS0SZi0e
         Ile2eYCEfoHpE8PH5XbI+PunHZotiHNLAWJrPJTtVG/5g4rLEYVsue1nD1pSHvtRxqDz
         E9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTfWS4sg+t3YEsyK236BD9782BKOcxtI482gWIiyWp3dKM1he/II1ERV6Nvlf1HxH5jEi0v6JmzcxGsiM48BVXDGiwpicbZoSo
X-Gm-Message-State: AOJu0YwOU3Blu543CihDc13hbm/EoxslrOC6PCxLJ7n8NlozSxfkxRqv
	aaiZfXx+WqIJLNeUfKesqeflo14hAPcZEydH40pEtokJFKJkFKbulxHo5m7CHC0=
X-Google-Smtp-Source: AGHT+IGiLc7AgUl827FgV2aZOE13ynn0TtZqmMLpd+MxfDu7nEToYL/rmYy1RVA6e8sosXqFNMmqag==
X-Received: by 2002:a17:906:40c8:b0:a62:a48c:1123 with SMTP id a640c23a62f3a-a642d2775bamr178860766b.5.1716986017274;
        Wed, 29 May 2024 05:33:37 -0700 (PDT)
Received: from [10.125.231.30] ([217.156.233.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a637386898bsm95138766b.220.2024.05.29.05.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:33:37 -0700 (PDT)
Message-ID: <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
Date: Wed, 29 May 2024 13:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: Borislav Petkov <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
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
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_053341_001237_7D660039 
X-CRM114-Status: GOOD (  21.50  )
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

T24gMjkvMDUvMjAyNCAxMjoyOCBwbSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOgo+IE9uIFdlZCwg
TWF5IDI5LCAyMDI0IGF0IDAyOjE3OjI5UE0gKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90
ZToKPj4+IFRoYXQgam1wIDFmIGJlY29tZXMgcmVkdW5kYW50IG5vdyBhcyBpdCBzaW1wbHkganVt
cHMgMSBsaW5lIGJlbG93Lgo+Pj4KPj4gTm90aGluZyBjaGFuZ2VkIHdydCB0aGlzIGp1bXAuIEl0
IGRhdGVzIGJhY2sgdG8gaW5pdGlhbCBrZXhlYwo+PiBpbXBsZW1lbnRhdGlvbi4KPj4KPj4gU2Vl
IDUyMzRmNWViMDRhYiAoIltQQVRDSF0ga2V4ZWM6IHg4Nl82NCBrZXhlYyBpbXBsZW1lbnRhdGlv
biIpLgo+Pgo+PiBCdXQgSSBkb24ndCBzZWUgZnVuY3Rpb25hbCBuZWVkIGluIGl0Lgo+Pgo+PiBB
bnl3YXksIGl0IGlzIG91dHNpZGUgb2YgdGhlIHNjb3BlIG9mIHRoZSBwYXRjaC4KPiBZYXAsIEtp
cmlsbCBkaWQgd2hhdCBOaWtvbGF5IHNob3VsZCd2ZSBkb25lIC0gZ2l0IGFyY2hlb2xvZ3kuIFBs
ZWFzZQo+IGRvbid0IGZvcmdldCB0byBkbyB0aGF0IG5leHQgdGltZS4KPgo+IEFuZCBiYWNrIGlu
IHRoZSBkYXkgdGhleSBkaWRuJ3QgY29tbWVudCBub24tb2J2aW91cyB0aGluZ3MgYmVjYXVzZQo+
IGNvbW1lbnRpbmcgaXMgZm9yIGxvc2Vycy4gOi1cCj4KPiBTbyB0aGF0IHVuY29uZGl0aW9uYWwg
Zm9yd2FyZCBqdW1wIGVpdGhlciBmbHVzaGVzIGJyYW5jaCBwcmVkaWN0aW9uIG9uCj4gc29tZSBv
bGQgdWFyY2ggb3Igc29tZXRoaW5nIGVsc2Ugd2VpcmQsIHVhcmNoLXNwZWNpYWwuCj4KPiBJIGRv
dWJ0IHdlIGNhbiByZW1vdmUgaXQganVzdCBsaWtlIHRoYXQuCj4KPiBMZW1tZSBhZGQgQW5keSAt
IGhlIHNob3VsZCBrbm93LgoKU2VlbXMgSSd2ZSBnYWluZWQgYSByZXB1dGF0aW9uLi4uCgpqbXAg
MWYgZGF0ZXMgYmFjayB0byB5ZSBvbGRlIDgwODYsIHdoaWNoIHN0YXJ0ZWQgdGhlIHdob2xlIHRy
ZW5kIG9mIHRoZQppbnN0cnVjdGlvbiBwb2ludGVyIGp1c3QgYmVpbmcgYSBmaWdtZW50IG9mIHRo
ZSBJU0EncyBpbWFnaW5hdGlvblsxXS4KCkhhcmR3YXJlIG1haW50YWlucyB0aGUgcG9pbnRlciB0
byB0aGUgbmV4dCBieXRlIHRvIGZldGNoICh0aGUgcHJlZmV0Y2gKcXVldWUgd2FzIHVwIHRvIDYg
Ynl0ZXMpLCBhbmQgdGhlcmUgd2FzIGEgbWljcm8tb3AgdG8gc3VidHJhY3QgdGhlCmN1cnJlbnQg
bGVuZ3RoIG9mIHRoZSBwcmVmZXRjaCBxdWV1ZSBmcm9tIHRoZSBhY2N1bXVsYXRvci4KCkluIHRo
b3NlIGRheXMsIHRoZSBwcmVmZXRjaCBxdWV1ZSB3YXMgbm90IGNvaGVyZW50IHdpdGggbWFpbiBt
ZW1vcnksIGFuZApqdW1wcyAoYmVpbmcgYSBkaXNjb250aW51aXR5IGluIHRoZSBpbnN0cnVjdGlv
biBzdHJlYW0pIHNpbXBseSBmbHVzaGVkCnRoZSBwcmVmZXRjaCBxdWV1ZS4KClRoaXMgd2FzIG5l
Y2Vzc2FyeSBhZnRlciBtb2RpZnlpbmcgZXhlY3V0YWJsZSBjb2RlLCBiZWNhdXNlIG90aGVyd2lz
ZQp5b3UgY291bGQgZW5kIHVwIGV4ZWN1dGluZyBzdGFsZSBieXRlcyBmcm9tIHRoZSBwcmVmZXRj
aCBxdWV1ZSBhbmQgdGhlbgpub24tc3RhbGUgYnl0ZXMgdGhlcmVhZnRlci7CoCAoT3RoZXJ3aXNl
IGtub3duIGFzIHRoZSB3YXkgdG8gZGlzdGluZ3Vpc2gKdGhlIDgwODYgZnJvbSB0aGUgODA4OCBi
ZWNhdXNlIHRoZSBsYXR0ZXIgb25seSBoYWQgYSA0IGJ5dGUgcHJlZmV0Y2ggcXVldWUuKQoKQW55
d2F5LsKgIEl0J3MgaG93IHlvdSB1c2VkIHRvIHNwZWxsICJzZXJpYWxpc2luZyBvcGVyYXRpb24i
IGJlZm9yZSB0aGF0CnRlcm0gZXZlciBlbnRlcmVkIHRoZSBhcmNoaXRlY3R1cmUuwqAgTGludXgg
c3RpbGwgc3VwcG9ydHMgQ1BVcyBwcmlvciB0bwp0aGUgUGVudGl1bSwgc28gc3RpbGwgbmVlZHMg
dG8gY2FyZSBhYm91dCBwcmVmZXRjaCBxdWV1ZXMgaW4gdGhlIDQ4Ni4KCkhvd2V2ZXIsIHRoaXMg
ZXhhbXBsZSBhcHBlYXJzIHRvIGJlIGluIDY0Yml0IGNvZGUgYW5kIGZvbGxvd2luZyBhIHdyaXRl
CnRvIENSNCB3aGljaCB3aWxsIGJlIGZ1bGx5IHNlcmlhbGlzaW5nLCBzbyBpdCdzIHByb2JhYmx5
IGNvcHkmcGFzdGUgZnJvbQozMmJpdCBjb2RlIHdoZXJlIGl0IHdvdWxkIGJlIG5lY2Vzc2FyeSBp
biBwcmluY2lwbGUuCgp+QW5kcmV3CgpbMV0KaHR0cHM6Ly93d3cucmlnaHRvLmNvbS8yMDIzLzAx
L2luc2lkZS04MDg2LXByb2Nlc3NvcnMtaW5zdHJ1Y3Rpb24uaHRtbCNmbjpwYwoKSW4gZmFjdCwg
YW55b25lIHdobyBoYXNuJ3Qgc2hvdWxkIHJlYWQgdGhlIGVudGlyZSBzZXJpZXMgb24gdGhlIDgw
ODYsCmh0dHBzOi8vd3d3LnJpZ2h0by5jb20vcC9pbmRleC5odG1sCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
