Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A29C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yT6AXtl3rcDOrA8CHC13zOchRPUX94+zGeSqbRBwczI=; b=LSw55+6rA24+0q45pUU3ouIbv4
	9TbZ5mc8dEuu7Q7jvPNUKCg5Kkq4NCEI2ud7oxdexgn4pPg0Gi0+eHHtLL1B6dkSX6JAKY4AabC3d
	FZTk0bwriOAiWAH+YeZYMHB/1leSd0AbRq5LwrwShhWeSNZ13qndysN4+Gc7THxDDKq/lEINHVUJ7
	5vTwM9M4NMrdaFobHAFBmvTzhuALyUjyXGCCSSEvhHxlDrdHh3/xK38Zp8c3W22QKp0tcr9DE24e4
	ZQ+O6642NvYFp0GonzLH2Cn+0qjNIAQeKrfZ+a7mS2rBPDwX86Ih0imEnxkyrepPeEjRkvJvn3fbc
	OsvFsqog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPD5-0000000DOJq-0mOX;
	Fri, 21 Aug 2026 13:23:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPD1-0000000DOHw-0n2D
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 13:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787318578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yT6AXtl3rcDOrA8CHC13zOchRPUX94+zGeSqbRBwczI=;
	b=A7ZxBiPXU8b7JfZ/+WzXxFWkjq59SjpR50h/kErr8a5fxRlr52r4VpF50EKQBL4wxfEOKK
	zIspyYGCMdJvfNVkGHH9KqNcKmDTLnElI5KKxvs9o0IImTY8lnd79ccj5kF7L3w5T26YVf
	xlJAL7xQO4seb5Q7FTW6X24bGUaiplg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-HcrUr7hkOlWhAI7zjd8Prw-1; Fri, 21 Aug 2026 09:22:55 -0400
X-MC-Unique: HcrUr7hkOlWhAI7zjd8Prw-1
X-Mimecast-MFC-AGG-ID: HcrUr7hkOlWhAI7zjd8Prw_1787318574
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84870e7f498so989533b3a.3
        for <kexec@lists.infradead.org>; Fri, 21 Aug 2026 06:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318574; x=1787923374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yT6AXtl3rcDOrA8CHC13zOchRPUX94+zGeSqbRBwczI=;
        b=VA8IJOjOkRpnhPwhyFeFP5UAlYzsTt5S73n1fQO0Zgl+v2BAsGjxd12PZ8eemrksjg
         zbjqYfmc8YUD9o1FmdlIW8f4bMYRRswN4Ojvfwya6FQOraWdKmN+Q2WzELwvF0fNxwMu
         a0YPkdcE+YKo/HP+/c8t4TfpITLET+9uyYK14ySOWQm8J8lWYTsd37gZ3d1M58HfSoCP
         X+wkQ/HnGmcLWMT2XvKGMZMA1NiF2Tx/mMStCM76SEAAM7c161sNXacM04A6bmUGiphm
         dXVvIxaLi9C6LR/P/DoUdGck8z3vou07iMuYiKfmagGm4vodDxFeMDqJUghptNw9F4aN
         SEBg==
X-Forwarded-Encrypted: i=1; AHgh+RpAl4w8ESDY5nM20IoHKbvVl4jr/+sdhBheZGiS/HKC6MWLyE+bf64rdHGNZpInoMs8Q7ttGQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mULHa0t7JlPm274nBNNCTdDyxwj/W1uvb1PUjthYZ8rMR6ybpb
	mB+e/U46/eWT6abRG1puwLglpCefeMpkAV8odJb80H4ElrmynirK6+eUBC77ig0u/nCrU81WlcP
	aXbkrrIAfWdlPG+WsTPR3+8l+GIyHfrAdDhUzd6HeLw+lxPSiXzToHvibwdo/9g==
X-Gm-Gg: AR+sD126ZgYy9PK+HVd8ygndZdkIlQYIRSCtnrB4LERyB02xFzoJavdMwd1yWjCqJn5
	2Y7icqDWJl4ldVG/fI2yhzXbDa3QdMiZhpoB02uHQM/B+KweYa0IPEZUkE2GxyVQyhl1pAuRGMB
	6Fn7YGGOcSf9YYZYKGstk+wuDJ0OstxaePvKQb5cHjLxdCfGUJVBoytojCny2dIk3Z9ca4875t6
	V63z9sNMLhqk6gUIF00bDo+PZuMCaOBRlUoL5QKp8v0kF4dAxnKXNh2JLSfPifMgF/GdDrVNDtq
	q0ptABmo0Dm69ajpul9wFfg//jgPt0jpErVFV5zmi3bveU4NBBYRSOHdGHyopFQxtc8gfD2o79E
	Ai0sdclYXwGhnojE+nA==
X-Received: by 2002:a05:6a00:1c86:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-851f9cc6dfemr11345719b3a.3.1787318574005;
        Fri, 21 Aug 2026 06:22:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c86:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-851f9cc6dfemr11345592b3a.3.1787318573542;
        Fri, 21 Aug 2026 06:22:53 -0700 (PDT)
Received: from [192.168.1.3] ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3389a37sm2905604b3a.15.2026.08.21.06.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:22:53 -0700 (PDT)
Message-ID: <62cb1c7d-aa17-4d6d-b780-97cc40b7ff91@redhat.com>
Date: Fri, 21 Aug 2026 18:52:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Philipp Rudo <prudo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Tao Liu <ltao@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
 <20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
 <20260820142114.0a36ac78@rotkaeppchen> <2vxzik54zmpp.fsf@kernel.org>
 <713ab0a0-235d-47cf-a0c2-73249fbc8f74@redhat.com>
 <aogHeKQ8UnudNAMu@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <aogHeKQ8UnudNAMu@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eGBKfJrC6wMq9LY4d8wU73QslAJ-IFFt8WewmamOBLc_1787318574
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_062259_378602_A0C6414C 
X-CRM114-Status: GOOD (  16.43  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Mike, thanks for review.

On 21/08/26 1:38 pm, Mike Rapoport wrote:
> On Fri, Aug 21, 2026 at 12:48:15PM +0530, Mukesh Pilaniya wrote:
>> Hi Philipp,
>>
>> On 20/08/26 11:41 pm, Pratyush Yadav wrote:
>>> On Thu, Aug 20 2026, Philipp Rudo wrote:
>>>
>>>> Hi Mukesh,
>>>> Hi Pratyush,
>>>>
>>>> having this patch makes sense. Personally I'd go with having a
>>>> switch-case rather than individual if-blocks. E.g.
>>>>
>>>> 	switch (ret) {
>>>> 		case 0:
>>>> 			image->fops = *fops;
>>>> 			return 0;
>>>> 		case -ENOEXEC:
>>>> 			continue;
>>>> 		default:
>>>> 			return ret;
>>>> 	}
>>>>
>>>> IMHO that is better readable and easier to extend in case other error
>>>> codes need special handling as well. But that is only my personal
>>>> opinion.
>>>
>>> Well, IMO both look roughly the same so I unless Mukesh prefers your
>>> version more, we can keep it as-is.
>>>
>> Thanks for the review. I agree the switch-case reads nicely, but since
>> the current version is functionally equivalent and already
>> reviewed, I'll keep it as-is to avoid re-spinning for a style change.
>> Happy to switch if you or Pratyush feel strongly about it.
> 
> I'd like to request another style change :)
> 
> In newer code we often use 'err' rather than 'ret', so it's more obvious
> what this variable about.
> 
> I don't feel strong about if or switch, but if you go with if, please don't
> compare to 0, use !err.
>

Makes sense, will rename ret to err and use !err in v3.

-- 
Regards,
Mukesh Pilaniya


