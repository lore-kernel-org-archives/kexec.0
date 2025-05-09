Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABB5C3ABC3
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 04:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J+SYrIQbnbnk5O/f1zspa8NoKFzZ95VWEpF6PHlNOTo=; b=0tlXSFEV011oQLuI8lOWa4S7ia
	pzU5gNAkRwwdyiKjEB4i/LOm/Xa+knYHK8VXM/7OvJGw15KBOKH4o6eqat+bdC2bnZy2NP4b3j7s7
	FZeva9SjABrP9Nfvpsrs9rYWi9oeTDY3up71+LfZDDtmckGz7d3kXnie/6lPHJy9x0widIr6uCKfw
	PS5gg0NoOp7364F5oBVlVFiyG6eCzgCtlL577CudXpl28hdxcaANVucFZsfX6Brp648mMMZsSdWp7
	DHnqAdKNnQzqZgQMUW4/744rlwRlQXxnA8b8fELiHHF/FT7pcupmA1iBm5iKKty9FGtFOaJWU3OZC
	NiteH4vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDEzT-00000002QCX-0nvI;
	Fri, 09 May 2025 04:05:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDEzM-00000002QCA-2B8D
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 04:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746763531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+SYrIQbnbnk5O/f1zspa8NoKFzZ95VWEpF6PHlNOTo=;
	b=dZUMEKFENZaaSwenXLb9MGRLqHYTLfh5U0lVc+NgxmD7+a5AlNsTz0dA8OjMROFBnl93Gh
	mBUj00OWbR59YRRYgoq3Dg23HE/6atuITZZnI3wy3SxICdPZvQ6kfyJKLjvhbriBkVOXwB
	5TiX+xo02SmiWlL/hETeRvcESjOMfg0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-BzG_mhKYN8myh9h1rCaPEA-1; Fri, 09 May 2025 00:05:29 -0400
X-MC-Unique: BzG_mhKYN8myh9h1rCaPEA-1
X-Mimecast-MFC-AGG-ID: BzG_mhKYN8myh9h1rCaPEA_1746763528
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7398d70abbfso2493433b3a.2
        for <kexec@lists.infradead.org>; Thu, 08 May 2025 21:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746763528; x=1747368328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+SYrIQbnbnk5O/f1zspa8NoKFzZ95VWEpF6PHlNOTo=;
        b=Da2TnXspvRMCXm0KA2zF044S8pBBBc+Yg+fARkxXxGBoZXI/QFf/RWZvgZIpc+sjwM
         af4Yi+M3gpUa+RNfN9IkAUYpGfaxWioZg/yxzYLkp6hG4ckI6OL9mnDVmUdTa52tyrsJ
         b3x4Z9KYesB2J0v0klFxAJIUd6b9GjIlkytYGNLOswjvz9Zc2HEYIAvYtIZ5VzQMVUS9
         Clgkd5sGtk/evpFcfJyJiEisEjIs6rlRa3Qw4Pjyb97cmLuluwbyqQrf6ZpC35PWRLlC
         14qLA/6glFyM8C+TaT+kg8ri4oOIe0yAnuJVeEVCFTbIKoBertwt5YXJaihymasChvgm
         KFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWpIGpsC45UaLzD0M7MCFvzFkf3lOevQo0P3aIdoc+DLIsWJgMT7tCG4t/roI6cZ5wkUFeV2w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/QJ5GlVLhata/iHUFtRbhgc1nLJZQ4JspDgeIGybIKE2dZ2l0
	wxEbK96J8zVNojrzq/o9OC03snQG32QbtYU0WmUqlLqxtaWhvPaubpkuS5HrRGscuGpB74LHSfD
	OQD/rVjhA+uX8AUfHoEXtVEvMXdMFZYHh6rjsfwxvFPEDwLtgtsrDt8EGlQ==
X-Gm-Gg: ASbGncv6gpH4URWCH4g1BFRpyWR8oCf7yYLhuoUbJA+xqDeHA+/+k/glrz8gMChvA2v
	knySGqpy56f0veAEZw9yqb8MoVz0KZp4BPql85UZJpS5GOUbBSC3DYB7vjxIxa90vZiuFdBRdKR
	4XEwQ6IWPE6IrxW6F8mu2Fve4qkj46HBz5eXAbPRQ1DsGi8ueaGEiGOuZw19kWqpz3HudttnvsZ
	ttbisTkKJSQ68/HCWgnfG+Vi1tU8dQdSxWgdsJ6kAlEfNUk/uwYMeJCY51uVWf9roGGTZ5LEpFw
	wHQ=
X-Received: by 2002:a05:6a00:2e24:b0:73e:30dc:bb9b with SMTP id d2e1a72fcca58-7423ba88b38mr2682907b3a.2.1746763528165;
        Thu, 08 May 2025 21:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE77As/UwDFJ+dP/ELWVq0LFZcNGkVTWSBLh/OwCUft42xY+m4lFdYftfZTKsV2tbDZ8ZSfVg==
X-Received: by 2002:a05:6a00:2e24:b0:73e:30dc:bb9b with SMTP id d2e1a72fcca58-7423ba88b38mr2682870b3a.2.1746763527716;
        Thu, 08 May 2025 21:05:27 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237705123sm882603b3a.16.2025.05.08.21.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 21:05:27 -0700 (PDT)
Date: Fri, 9 May 2025 12:04:36 +0800
From: Coiby Xu <coxu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, fuqiang wang <fuqiang.wang@easystack.cn>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NbXuEWmBVJHyf2OQQtMW1np5E7mzaj_t-z5nyL-PkyQ_1746763528
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_210532_649316_AEF56257 
X-CRM114-Status: GOOD (  27.31  )
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

On Wed, May 07, 2025 at 10:59:59PM -0700, Andrew Morton wrote:
>On Thu, 8 May 2025 12:25:15 +0800 Coiby Xu <coxu@redhat.com> wrote:
>
>> >
>> >Acked-by: Baoquan He <bhe@redhat.com>
>>
>> Hi Andrew,
>>
>> It seems this patch was missed.
>
>January 2024.  Yes, it's fair to assume that it was missed ;)
>
>> Will you pick it up?
>
>Sure.

Thanks for quickly processing this patch! Sorry I didn't reply yesterday
as I was trying to reproduce the UBSAN warning and truly understand the
it.

>
>> Without this patch,
>> kdump kernel will fail to be loaded by the kexec_file_load,

As already pointed out by Baoquan, a manual test shows kexec_file_load
actually works despite the UBSAN warning. Sorry I misinterpreted the
UBSAN warning and the automated test result failure (somehow sysrq
wasn't be triggered and vmcore wasn't saved either).


>>
>>   [  139.736948] UBSAN: array-index-out-of-bounds in arch/x86/kernel/crash.c:350:25
>>   [  139.742360] index 0 is out of range for type 'range [*]'
[...]
>>
>
>Do we know why this has appeared at such a late date?  The reporter
>must be doing something rare.

The UBSAN warning happens because flexible array members annotated with
__counted_by are accessed without assigning an array element count i.e.
crash_mem->ranges[0] is accessed without setting max_nr_ranges after
vzalloc,

     // include/linux/crash_core.h
     struct crash_mem {
     	unsigned int max_nr_ranges;
     	unsigned int nr_ranges;
     	struct range ranges[] __counted_by(max_nr_ranges);
     };

The bad commit was introduced in 2021 but only recent gcc-15 supports
__counted_by. That's why we don't see this UBSAN warning until this
year. And although this UBSAN warning is scary enough, fortunately it
doesn't cause a real problem. 

>
>Baoquan, please re-review this?
>
>A -stable backport is clearly required.  A Fixes: would be nice, but I
>assume this goes back a long time so it isn't worth spending a lot of
>time working out when this was introduced.

So I believe the correct fix should be as follows,

--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -301,6 +301,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
         cmem = vzalloc(struct_size(cmem, ranges, 1));
         if (!cmem)
                 return -ENOMEM;
+       cmem->max_nr_ranges = 1;
  
         memset(&cmd, 0, sizeof(struct crash_memmap_data));
         cmd.params = params;


And a Fixes tag should be dedicated to commit
5849cdf8c120 ("x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access")
which forgot to set cmem->max_nr_ranges=1.

>
>The patch needed a bit of work to apply to current code.  I did the
>below.  It compiles.
>
>--- a/arch/x86/kernel/crash.c~x86-kexec-fix-potential-cmem-ranges-out-of-bounds
>+++ a/arch/x86/kernel/crash.c
>@@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_e
> 	/*
> 	 * Exclusion of crash region and/or crashk_low_res may cause
> 	 * another range split. So add extra two slots here.
>+	 *
>+	 * Exclusion of low 1M may not cause another range split, because the
>+	 * range of exclude is [0, 1M] and the condition for splitting a new
>+	 * region is that the start, end parameters are both in a certain
>+	 * existing region in cmem and cannot be equal to existing region's
>+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
>+	 * condition.
>+	 *
>+	 * But in order to lest the low 1M could be changed in the future,
>+	 * (e.g. [stare, 1M]), add a extra slot.
> 	 */
>-	nr_ranges += 2;
>+	nr_ranges += 3;
> 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> 	if (!cmem)
> 		return NULL;
>@@ -317,9 +327,16 @@ int crash_setup_memmap_entries(struct ki
> 	 * split. So use two slots here.
> 	 */
> 	nr_ranges = 2;
>-	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>+	/*
>+	 * In the current x86 architecture code, the elfheader is always
>+	 * allocated at crashk_res.start. But it depends on the allocation
>+	 * position of elfheader in crashk_res. To avoid potential out of
>+	 * bounds in future, add a extra slot.
>+	 */
>+	cmem = vzalloc(struct_size(cmem, ranges, 2));
> 	if (!cmem)
> 		return -ENOMEM;
>+	cmem->max_nr_ranges = 2;

Thanks for coming up with the above patch! I think the goal of this
patch is addressing a different issue but it also fixes the UBSAN
warning because cmem->max_nr_ranges is now set.

>
> 	cmem->max_nr_ranges = nr_ranges;
> 	cmem->nr_ranges = 0;
>_


-- 
Best regards,
Coiby


