Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE5D29DFE
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v41BmWMTW4tZcwktDmX8avT8k5SvIiig6VFNmXgetXc=; b=gX3Xzj1PPWxs3uac2eaGiCAiKQ
	ArVEXwQ1X1U87MvzGtIcJy7XBAZ30oz5z6V+Alw1uSzdmcCB6TfXYlL4HjGi7q1EflvJK6Ve5RtkL
	5YrT2YUwuE4EZKZImmUkVd4qgMipCsvvc3hkm28IvSMdHApmsA7UVjQs2ZR+9CbYU15jtatJxr5jc
	scFeaXgY+krCNmpdLxMfR6+Zhs+eJF6SnAGJGTyx+triWLjHLIVGrmMHaPlob4mKWv3oI32E6+r1F
	LLxNtV7Lhuq21v3qW1n8FWNas6gRkGvGBHMrOTl4sfOrYNF0o5NGxH08H/bjFJdEqH/HO2j31e78p
	XeCpGdgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfbRS-00000006t6c-0s3H;
	Tue, 13 Jan 2026 10:16:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfbRP-00000006t5w-3KPV
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 10:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768299357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v41BmWMTW4tZcwktDmX8avT8k5SvIiig6VFNmXgetXc=;
	b=PW6puOxYAF7FAQJNNtrXogLPS7pIoMONS9OesIjaJePSTof8jAZtCl8sgJ5kgH/oHBO+lG
	UB9VJaiw4yW8HVDMBK0L4XN9Pvbzf3sw3llQxnZ/TMRNWqDryeiY0lRF9lgptBznpVTOpf
	wEkyqgxhvh3S7UiXlJ7Fnlo6TGphzsw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-u-laz5eyPeS7U86NLQmQWQ-1; Tue, 13 Jan 2026 05:15:55 -0500
X-MC-Unique: u-laz5eyPeS7U86NLQmQWQ-1
X-Mimecast-MFC-AGG-ID: u-laz5eyPeS7U86NLQmQWQ_1768299355
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5659f40515so6472993a12.2
        for <kexec@lists.infradead.org>; Tue, 13 Jan 2026 02:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299354; x=1768904154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v41BmWMTW4tZcwktDmX8avT8k5SvIiig6VFNmXgetXc=;
        b=A6+nynSF6SLkF8uO2PmI7fVxSakGzVnP2NfYbANtANmfHnmxFQ05ZbAxKPWHw9N8yr
         5FVWbbwMel/afnENcPGPbbqtugwGHbsX6DKUF4D+Ji1g/59aJA4ziF0Fksu94K5XZDbk
         hBvQVfRSH2HQWP6FlEFypSFBPknHq9QjQHriM92mukcZF2wvq598K8DztOGmVb8oNnxJ
         6tTuA55a7A2lj1PtKbU6oVy57LHGkVY65ToqvRPixNlQ8WP85+3X5dJ4cEnlL74gaCuh
         E+oyz6Iwf6Vtxj+sZR5qFGFgxkZhlXhSoCJ5OhVBS1G8FGlZVdAP8OqVxOvxp84P5ml2
         chJw==
X-Gm-Message-State: AOJu0YzK2mVsHB+GEj1F+buMNqyu+KVlBp/RwpVPOQ8pS0ZV8chWZ5mt
	VC3F7FWHhhWvc5i1Xikg9n68lhg8Nn6q+SGN7dsbeRhx06siRgb+NGVO2ahs8Krgw/HMRPHA+3y
	e5x8rXdiYtTI3mvCwqHvTlkR2B6/QMRPTy0lOjL7dnbsChbAkYIh+wV0mg8WlkQ==
X-Gm-Gg: AY/fxX6TiFFQU+omh+C6r5ykYm+KyFFaTc55XR9ag+LZFNtLzE2+tY7o2spoT/z9+BI
	eem0MJqvc87OdoSivTlxikxQgdAopQo3Qvv1OOj+ZiVnnZe64XBADmKoTP9NCstNZbB4S24GLWv
	DgNHcMVsN3pkrkTAg9qTUqfVv9xhpv00NXIBvgve6Uom2gfZShL0g7zzxoP7haQVQ8yZwC4PMp+
	StrmGxA7zk1DCYcX1MCDV0jFxtXvZLsQsPEYBaeNzeFdqNpxJtyhPGm1qkQpGqS+ESsxKcOE69Q
	UHxYXp4iS1UNg1+T0HwoauSnDNAT0k5JO+Upd02QePcSAjr14fB2sKglL9Fxy44Jpl5UtPX5bPf
	w
X-Received: by 2002:a05:6a20:1590:b0:350:8f99:367c with SMTP id adf61e73a8af0-3898f9c749amr19677841637.58.1768299354383;
        Tue, 13 Jan 2026 02:15:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD8bVnhUW9rLwnM9mhHYysQ2ifqzdkq+BFmkuSXqdWfOtq4JZykE3GdXdZeED+1VsDF8ut7A==
X-Received: by 2002:a05:6a20:1590:b0:350:8f99:367c with SMTP id adf61e73a8af0-3898f9c749amr19677814637.58.1768299353782;
        Tue, 13 Jan 2026 02:15:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc9e7e824sm19776837a12.30.2026.01.13.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:15:53 -0800 (PST)
Date: Tue, 13 Jan 2026 18:14:38 +0800
From: Coiby Xu <coxu@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: kexec@lists.infradead.org, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/crash: Use set_memory_p instead of
 __set_memory_prot
Message-ID: <aWYWm4gLwFmvM730@Rk>
References: <20260106095100.656292-1-coxu@redhat.com>
 <20260109201142.GFaWFg_kR8eW48CpUp@fat_crate.local>
MIME-Version: 1.0
In-Reply-To: <20260109201142.GFaWFg_kR8eW48CpUp@fat_crate.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yp0LS8NUPhJRx_GiIo_MibrmQsZhz4lbw8Td1clK8Zw_1768299355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_021559_904642_94105458 
X-CRM114-Status: GOOD (  22.47  )
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

On Fri, Jan 09, 2026 at 09:11:42PM +0100, Borislav Petkov wrote:
>On Tue, Jan 06, 2026 at 05:50:58PM +0800, Coiby Xu wrote:
>> set_memory_p has been introduced since commit 030ad7af9437 ("x86/mm:
>> Regularize set_memory_p() parameters and make non-static"). There is no
>> need to use __set_memory_prot.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>
>Why aren't those a single patch?

Hi Borislav,

I thought smaller patches are easier to review. But seems it's
unnecessary for this case.

Thanks for squashing the two commits and also updating the commit
message! I notice you also added a Link tag. Does it mean there is no
need for me to re-send your new patch as v2?

>
>---
>From: Coiby Xu <coxu@redhat.com>
>Date: Tue, 6 Jan 2026 17:50:58 +0800
>Subject: [PATCH] x86/crash: Use set_memory_p() instead of __set_memory_prot()
>
>set_memory_p() is available to use outside of its compilation unit since:
>
>  030ad7af9437 ("x86/mm: Regularize set_memory_p() parameters and make non-static").
>
>There is no use for __set_memory_prot() anymore so drop it too.
>
>  [ bp: Massage commit message. ]
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>Link: https://patch.msgid.link/20260106095100.656292-1-coxu@redhat.com
>---
> arch/x86/include/asm/set_memory.h  |  1 -
> arch/x86/kernel/machine_kexec_64.c |  5 +----
> arch/x86/mm/pat/set_memory.c       | 13 -------------
> 3 files changed, 1 insertion(+), 18 deletions(-)
>
>diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
>index 61f56cdaccb5..4362c26aa992 100644
>--- a/arch/x86/include/asm/set_memory.h
>+++ b/arch/x86/include/asm/set_memory.h
>@@ -38,7 +38,6 @@ int set_memory_rox(unsigned long addr, int numpages);
>  * The caller is required to take care of these.
>  */
>
>-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
> int _set_memory_uc(unsigned long addr, int numpages);
> int _set_memory_wc(unsigned long addr, int numpages);
> int _set_memory_wt(unsigned long addr, int numpages);
>diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>index 201137b98fb8..0590d399d4f1 100644
>--- a/arch/x86/kernel/machine_kexec_64.c
>+++ b/arch/x86/kernel/machine_kexec_64.c
>@@ -673,10 +673,7 @@ static void kexec_mark_dm_crypt_keys(bool protect)
> 		if (protect)
> 			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
> 		else
>-			__set_memory_prot(
>-				(unsigned long)phys_to_virt(start_paddr),
>-				nr_pages,
>-				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
>+			set_memory_p((unsigned long)phys_to_virt(start_paddr), nr_pages);
> 	}
> }
>
>diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>index 6c6eb486f7a6..40581a720fe8 100644
>--- a/arch/x86/mm/pat/set_memory.c
>+++ b/arch/x86/mm/pat/set_memory.c
>@@ -2145,19 +2145,6 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
> 		CPA_PAGES_ARRAY, pages);
> }
>
>-/*
>- * __set_memory_prot is an internal helper for callers that have been passed
>- * a pgprot_t value from upper layers and a reservation has already been taken.
>- * If you want to set the pgprot to a specific page protocol, use the
>- * set_memory_xx() functions.
>- */
>-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
>-{
>-	return change_page_attr_set_clr(&addr, numpages, prot,
>-					__pgprot(~pgprot_val(prot)), 0, 0,
>-					NULL);
>-}
>-
> int _set_memory_uc(unsigned long addr, int numpages)
> {
> 	/*
>-- 
>2.51.0
>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette
>

-- 
Best regards,
Coiby


