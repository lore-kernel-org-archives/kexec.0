Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561EEC47258
	for <kexec@archiver.kernel.org>; Wed, 31 Jan 2024 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qi3MHp7qvL5rdtQqR6cASvaxjzxcEyW3JNPMj67+KnI=; b=AIswt7TcmcjuPP
	dnXvPLW0WtxwMm6KnCYQacDFNnAX3ygB/x3vU6twR0+EtIAs9Kob0jr9xGiBNIfTjItqsFu8KNFLG
	yko7uoGfV4lcJ1z12DYiVp5t+fwI6nEaFmqnZCz0n+cY45NfDfMth5zKEMiPYw49HMVLTf+WNNBxw
	cQ3RSrmDCO6cl60GvceliVBiYCxM5DJn4waFPJCaUVgE+fXzvskJb/ZrCYAjgonJ8jaal/Ph0j/d9
	ayzDZjfopjwyufoyS0T7dvZo6LOKmd0IFFsB3yw9QfO/GjvR0LdsKKGfrHebtjqTaDtS8saz3d/rm
	wq8PFM4rinGddfp5iNyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAAp-00000003SyV-3LZS;
	Wed, 31 Jan 2024 12:58:39 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAAn-00000003SxJ-1SRB
	for kexec@lists.infradead.org;
	Wed, 31 Jan 2024 12:58:38 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-511206d1c89so1898318e87.1
        for <kexec@lists.infradead.org>; Wed, 31 Jan 2024 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706705913; x=1707310713; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7ky/3M7B61YCAGNE0WXFX5+lOGZrN7occ3cCWK7ac0=;
        b=A3tXSbxcyVWe0zoW+I+TbS9wArHqlhk+9y5pm+K3oM0ZSroYPqfqHIcm0+RWfQrJOJ
         iwCZh1oxz7RWGlqSTf8mCdVUuW+b6xDdHtZqboe1awjBXB0l4lCDYHt8XoBvaYr2a5IG
         +TdSqYQrq7eyjiRgGp8Qtto3NFisA/eAPGpeIAD6HrTxA1j6EgWHOtFmR1/1cP8K8jkj
         Zm2/uFSrcHpsHN1jbqgne+zj3vysWLQQoFhgRSrjPCEt3m3Yhjk8tL5ZrajeBYV/ckPW
         yqDLt/dscxwVUdhpNTq1Yt0pgALa1YegB9ntcN3DKrT5wOWQWUT+Nd+Sj6gDaDyXeJyT
         mN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705913; x=1707310713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7ky/3M7B61YCAGNE0WXFX5+lOGZrN7occ3cCWK7ac0=;
        b=w8YkmjRN9C7BLSq0jMoIzJKtwX7B7vaaUY54LtnswA6injX2GEGEw6uXDYTIUopANk
         y4k4AXEQLzjIQiIs5DOzYt56aR6q6mj/4jRyvBOimJZXxkXGs4H19m+PQ4hVGxvBW3en
         xqRVjMgqn6djxnm6aRIUF1u/tx4lOYDWDvPZFH8JXj1Hf68RalcQY7wApJ/NqCutpxrM
         FRA86p/2iqMIvRBjQ1eJgOcAeEFKSfAiggAMKQwzBFoYru68H/hqNvz+5rdy9zRAYa1k
         IvSVSrXkQJrF6ep7RWkEX+4uCNFSi28NA8espCR2yxUw9eJMS8OM9AU6tOhlAzQKk8Zq
         THtw==
X-Gm-Message-State: AOJu0YyMzEF3iewgoQuv3Vo1Q+brQbprCq2jBnmeLzVtrDp0OC2SfKHv
	kH3lBwl8kRRQnIUh9fW3Cjy9crvcJ+27BqNSavQ9AnSbm8PMHUjPLAXDQrAawg4=
X-Google-Smtp-Source: AGHT+IE12TytICRdsL2F3gNVkV6eKllHYKHvuShfvBQQdBABSqGov6rYd2Qc6dcxo5JCUzXwAptJzA==
X-Received: by 2002:a05:6512:344e:b0:511:2988:cf93 with SMTP id j14-20020a056512344e00b005112988cf93mr388733lfr.54.1706705913005;
        Wed, 31 Jan 2024 04:58:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWB/0NZYSc+xrEkVzOogX/cM/IKKcg5EJTC6B2y9F48G5yRtsyfETvhOLVWvWV0Ew2K+08tvh36yYqHe+RT8HSPxUVhQsimG7cJcNpMGMcvBbzB+kL+gZH/SS3MJEBgwaAv3ECfWjMO9wnFCnL9H/E527oxJiRgGozE1GsgxCDOoeXdhG/oIw7qcMdPymV22P26BKiCps8HsQhixsI9mglEySod4PCumklL6cfR3ZrR5jufzPgdORpTz9usdPpnwJUBSY8eDAE493bvf5NbV63BWB2Tif+sSnJS/Sw0MAVVPIvhY5b4Ar2Fl5MCexEUySgE36todwO6cqxtz4Oi9hcgQjVYP8TfUzFkNfvvEKcnWKppIXgy/KnfuohWgzn/M/L8Rpg49ZNwIkmdPW+byAUywP8jy38dxcxjBkt24TkddNLJz3E0+yhRREgBQI2NmZSG3e5HFua1OMmNyZeTXkgasaNrL/mtlkDelRpipd5nDmPwY15yI1+Hvera4u21ewnqjq28uixNF6KLPZ1pDvmGNiUtJ+leOlc73Zolm0SFMY9Ewo8R1peycNLwQ964o2XUSivhMPk3AD9QV+xzQGA4UkgW03vQDXdRHYwyKZ8Cks7XG4CosUUGmzLQLSjJdYMferXoU4vY2ypR2JQWEYZ0pJWixfCYwrOz59Q+MIaA0/Dfs3GgCU+rzt/wbZ89I97sHMALt/1625k=
Received: from ?IPV6:2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f? ([2a10:bac0:b000:7588:aea0:a2ac:ddc1:371f])
        by smtp.gmail.com with ESMTPSA id bv16-20020a170906b1d000b00a35e3202d81sm2705223ejb.122.2024.01.31.04.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:58:32 -0800 (PST)
Message-ID: <5d91fc11-0b3b-40f0-872d-abdbb4038f76@suse.com>
Date: Wed, 31 Jan 2024 14:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <efe20a00-9a7c-4c03-8fcc-fce265cdbf0e@suse.com>
 <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZbpBbAkPxQZ6gHoE@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_045837_417556_5835C6E5 
X-CRM114-Status: GOOD (  15.58  )
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

CgpPbiAzMS4wMS4yNCDQsy4gMTQ6NDcg0YcuLCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9uIDAxLzMx
LzI0IGF0IDA5OjMxYW0sIE5pa29sYXkgQm9yaXNvdiB3cm90ZToKPj4KPj4KPj4gT24gMzAuMDEu
MjQg0LMuIDE1OjQzINGHLiwgUGFvbG8gQm9uemluaSB3cm90ZToKPj4+IE9uIDEvMjQvMjQgMTM6
NTUsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPj4+PiBUaGUgcGF0Y2hzZXQgYWRkcyBiaXRz
IGFuZCBwaWVjZXMgdG8gZ2V0IGtleGVjIChhbmQgY3Jhc2hrZXJuZWwpIHdvcmsgb24KPj4+PiBU
RFggZ3Vlc3QuCj4+Pj4KPj4+PiBUaGUgbGFzdCBwYXRjaCBpbXBsZW1lbnRzIENQVSBvZmZsaW5p
bmcgYWNjb3JkaW5nIHRvIHRoZSBhcHByb3ZlZCBBQ1BJCj4+Pj4gc3BlYyBjaGFuZ2UgcG9wb3Nh
bFsxXS4gSXQgdW5sb2NrcyBrZXhlYyB3aXRoIGFsbCBDUFVzIHZpc2libGUgaW4KPj4+PiB0aGUg
dGFyZ2V0Cj4+Pj4ga2VybmVsLiBJdCByZXF1aXJlcyBCSU9TLXNpZGUgZW5hYmxpbmcuIElmIGl0
IG1pc3Npbmcgd2UgZmFsbGJhY2sgdG8KPj4+PiBib290aW5nCj4+Pj4gMm5kIGtlcm5lbCB3aXRo
IHNpbmdsZSBDUFUuCj4+Pj4KPj4+PiBQbGVhc2UgcmV2aWV3LiBJIHdvdWxkIGJlIGdsYWQgZm9y
IGFueSBmZWVkYmFjay4KPj4+Cj4+PiBIaSBLaXJpbGwsCj4+Pgo+Pj4gSSBoYXZlIGEgdmVyeSBi
YXNpYyBxdWVzdGlvbjogaXMgdGhlcmUgYSByZWFzb24gd2h5IHRoaXMgc2VyaWVzIGRvZXMgbm90
Cj4+PiByZXZlcnQgY29tbWl0IGNiOGViMDZkNTBmYywgIng4Ni92aXJ0L3RkeDogRGlzYWJsZSBU
RFggaG9zdCBzdXBwb3J0IHdoZW4KPj4+IGtleGVjIGlzIGVuYWJsZWQiPwo+Pgo+PiBXaGlsZSBv
biB0aGUgdG9waWMsIFBhb2xvIGRvIHlvdSB0aGluayBpdCdzICBiZXR0ZXIgdG8gaGF2ZSBhIHJ1
bnRpbWUKPj4gZGlzYWJsZSBvZiBrZXhlYyByYXRoZXIgdGhhbiBhdCBjb21waWxlIHRpbWU6Cj4+
Cj4+IFtSRkMgUEFUQ0hdIHg4Ni92aXJ0L3RkeDogRGlzYWJsZSBLRVhFQyBpbiB0aGUgcHJlc2Vu
Y2Ugb2YgVERYCj4+Cj4+IDIwMjQwMTE4MTYwMTE4LjE4OTkyOTktMS1uaWsuYm9yaXNvdkBzdXNl
LmNvbQo+IAo+IFJ1bnRpbWUgZGlzYWJsaW5nIGtleGVjIGxvb2tzIGJldHRlciB0aGFuIGF0IGNt
cGlsZSB0aW1lLCBlc3AgZm9yCj4gZGlzdHJvcy4gV2hpbGUgZnJvbSBhYm92ZSBwYXRjaCwgbWFr
aW5nIHVzaW5nIG9mIGtleGVjX2xvYWRfZGlzYWJsZWQgdG8KPiBhY2hpdmUgdGhlIHJ1bnRpbWUg
ZGlzYWJsaW5nIG1heSBub3QgYmUgc28gZ29vZC4gQmVjYXVzZSB3ZSBoYXZlIGEgZnJvbnQKPiBk
b29yIHRvIGVuYWJsZSBpdCB0aHJvdWdoOgo+IAo+IC9wcm9jL3N5cy9rZXJuZWwva2V4ZWNfbG9h
ZF9kaXNhYmxlZAoKQUZBSVUgaXQgY2FuJ3QgYmUgZW5hYmxlZCB2aWEgdGhpcyBzeXNjdGwgYmVj
YXVzZSB0aGUgaGFuZGxlciBmb3IgaXQgCmV4cGVjdHMgb25seSAxIHRvIGJlIHdyaXR0ZW4gdG8g
aXQ6CgogICAgICAyICAgICAgICAgICAgICAgICAucHJvY19oYW5kbGVyICAgPSBwcm9jX2RvaW50
dmVjX21pbm1heCwgCgogICAgICAxICAgICAgICAgICAgICAgICAuZXh0cmExICAgICAgICAgPSBT
WVNDVExfT05FLCAKCiAgIDk5NCAgICAgICAgICAgICAgICAgIC5leHRyYTIgICAgICAgICA9IFNZ
U0NUTF9PTkUsCgo+IAo+IElmIHRoZXJlJ3MgYSBmbGFnIG9yIHN0YXR1cyB0byBjaGVjayBpZiBU
RFggaG9zdCBpcyBlbmFibGVkLCBhbmQgZG9lcwo+IHRoZSBjaGVja2luZyBpbiBrZXhlY19sb2Fk
X3Blcm1pdHRlZCgpLCB0aGF0IGNvdWxkIGJlIGJldHRlci4gQW55d2F5LCBJCj4gc2F3IEh1YW5n
LCBLYWkgaGFzIHBvc3RlZCB0aGUgdGR4IGhvc3Qgc3VwcG9ydCBwYXRjaHNldC4KPiAKPj4KPj4g
SSdtIHRyeWluZyB0byBnZXQgdHJhY3Rpb24gZm9yIHRoaXMgcGF0Y2guCj4+Cj4+Cj4+Pgo+Pj4g
VGhhbmtzLAo+Pj4KPj4+IFBhb2xvCj4+Pgo+Pj4KPj4KPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
