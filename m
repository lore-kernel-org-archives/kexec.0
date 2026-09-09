Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD8BC79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQbDye0Ug6lK7AwcUFZhsBEDnI1W9xjGfK//bEWCpeM=; b=XL9IJwpDODqfSEcCzAbMTAAk57
	IdUvs24O3E6eSjhl3risNlnFmjCsdcOvJMchyMt4kmCCnA47sT16josb14KPZMzPOvoT5Bjg+GDIq
	WHOUJ7x54+ijAsLidgmRiQa5mVgjntvvmir5bY07lx7VgWdzgqYqjE6W3dVf6/tpJtcPDT9oPl0Ln
	EWvu8iZT5emJLw4GZZkuvxYXspfbBy7sWV34y/uBuYlBchJy5Ho2gvsHzOimSGcCfvQtNODXJZ9wa
	SUOPRvN5WcnJwhmIRGC2YvLy2F2Ul4ovl/id5OUx4jqKQEFTEyPIZ/Uq9WM2PvqC9ESSwZmYxuYd7
	dRrdc5jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ISU-0000000Bos4-3v9e;
	Wed, 09 Sep 2026 13:35:26 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ISQ-0000000BopP-2EnH
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:35:25 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d46e4cdccso10687857b3.1
        for <kexec@lists.infradead.org>; Wed, 09 Sep 2026 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960921; x=1789565721; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQbDye0Ug6lK7AwcUFZhsBEDnI1W9xjGfK//bEWCpeM=;
        b=Wfks5BZyjRTcJVBuY3t0+DXMu83C1Dw5lrK8dwoXfDx7LAFVaQbh1hnY+w0Z5dHYe/
         /jBaYQnpp3+uy/bx2bPbw7rtXpovH3+IEtgFQ98dzqJUU6d/eTt0d9q01w0O/K1vladw
         x4DUzm8EUdzYnwRyfkyDpNlCFmT96/LqG2BuchxApoLhqVdqACi1yVP/qFYxBsaUlPmr
         TQRjATklZbt4M2olHneTnPtLIqKnU0d8NfOw4eZRMJXNLRLHSrbHFEERonCHgGftxnjb
         01CTkHl1PzjFHr1eBLvjOlr2aVnA3QoojV8QwUW7VSWqoRhUpzcXkxJboAVRGnvzxxCG
         OJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960921; x=1789565721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQbDye0Ug6lK7AwcUFZhsBEDnI1W9xjGfK//bEWCpeM=;
        b=QLx8GXvCcmiUVRG4FAD5I+SOa6By1CM3ypA9IXpCSS7MCpYU1TSZJM2Yf6r2iIGJ3n
         ljNcVDMMwCLsCFLZKzvwO1AUkTszv6fI9O11SGWArLNMwbRx+lhF5i3mZ6s4opDLXc2I
         9Uvrji9ZsuNcujEbPxaV/agDb1wicukdCO6paHz7XCAg3cstigT9O1L5PNkPyqiz57IG
         vY3QySXjxZBrRndkFQVPuH3EH7GpoersP3XydwOh7rZaRQIJrXnTExRhn+22vDG4sIOo
         LmRtOXhVwVuTG65643/uBYq3HZ4SZx3prTITcEAWXqKnxHSqZEGPAd4ogZ8aansR4HBE
         L37Q==
X-Gm-Message-State: AFuF++nmDbW2L/WJzXTB7s/BOGxrg4gzLRFutK3TZIUvel8u5oAWc/O5
	Ig/1kle/DI0UftuWJpXPDMhgcth/ZHsnpEcuEKvl+mM/p/qOF33tHqWN
X-Gm-Gg: AYBFou1F6ZMiyymaPwiqCdyc6+MvZlLbE2rKcOpBupnqBckwdzMnTs/OkLQhq0Dn2sj
	CyZWbSkIFckm4WnMa5aCJX5HVgCC+HB7+tsCzhaWfl34kYNrbzb9/gkZYOE2QG57KXM7CzSkHC4
	w7YJWcjrbPB+tF20ZUDR2KWhjj1eTVk4wrUQcVPp1Sx7nXq6man3DJbczzeKVmbRmdcIvufKTG7
	/P7kxCe+ewOf6BKVAmT6kxGd+uMU2bsPpzH3XurTFXjj4pwnn+LeUI/s//VQp9Kmjs1w/megXvJ
	kXI96Nbfi1Nc8tKj4R0VXLtukvrXkBfBSgWeTJSBfxGgMk5KNMD1+QBDD5DEampFO+jOoXlywiV
	0Ef5prRt0+r5HeLeVAHAQwZCKKQRz98tjefWVlU+s6C9qeZQTqwqihnrKqysuGi7I/qZCbJeJU3
	PErQ6mnN1BrnVs7Zb/zvZJ0mcezq+KLUkcIx4AkrMOaGecf6Zyt7R2mRGhL8gQosc/Jw==
X-Received: by 2002:a05:690c:650c:b0:85b:35f6:bc5d with SMTP id 00721157ae682-87f23fe7a98mr29962947b3.13.1788960920937;
        Wed, 09 Sep 2026 06:35:20 -0700 (PDT)
Received: from localhost ([45.112.44.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714c0e5c6fsm111191177b3.48.2026.09.09.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:35:20 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 9 Sep 2026 21:34:58 +0800
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>, 
	Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] Documentation: kdump: Add arm64 and ppc64le to
 encrypted dump target support list
Message-ID: <aqFgNFBdwoS2okjR@Rk>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-10-coiby.xu@gmail.com>
 <83b9fd96-d0dc-4ced-97cd-287c82cdacbe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83b9fd96-d0dc-4ced-97cd-287c82cdacbe@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_063523_683979_43254C19 
X-CRM114-Status: GOOD (  15.55  )
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

On Tue, Sep 08, 2026 at 10:48:11PM -0700, Randy Dunlap wrote:
>
>
>On 9/8/26 5:36 PM, Coiby Xu wrote:
>> The encrypted dump target support is now extended to arm64 and ppc64le.
>>
>> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 0bf2eb100a05..36ad6125c670 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -572,8 +572,8 @@ Write the dump file to encrypted disk volume
>>  ============================================
>>
>>  CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
>> -encrypted disk volume (only x86_64 supported for now). User space can interact
>> -with /sys/kernel/config/crash_dm_crypt_keys for setup,
>> +encrypted disk volume (only x86_64, arm64, ppc64le supported for now). User
>> +space can interact with /sys/kernel/config/crash_dm_crypt_keys for setup,
>
>                                                                  for setup.

I'll apply the suggestion, thanks!

[...]

-- 
Best regards,
Coiby

