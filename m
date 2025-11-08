Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC5CCF9F8
	for <kexec@archiver.kernel.org>; Sat,  8 Nov 2025 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-ID:Date:
	In-Reply-To:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6C2+7Qd60IlxMiJIyGrsOyGd11fRVYN8pScSxbzQ4U=; b=P0U4VnyFE2qZqSflW1XkBKRvU/
	/Ks52cnrpIIyuW+Yz/kFhhEWpc2NIdz8O3kNEDwmFznpTqvCC7mopaZrWOTS8svfoUju/EgYPzY1I
	p+0DWgDrAgSQtmS0oqOgX5ZRVYCXJ8pkcZNG+asXHaHvHnCNTtkunqseOribr+0dgvbfsSrqna/7t
	bc2uB2ev9daDwdHJIGdJtAIe1P9COEx7qAUQ7Enymvd3g/gG8zI6n1N5LU+BddsH4sho5U15+aWLW
	XMMUlF8m+eJfjKnK3RvBg+DUxHl8EUzsOjxwLqqq8+hhsbqhHVAmCauM4RUpgc271VJfxuJlBwYGI
	HD2jD02g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHZPX-00000002HE0-2P9u;
	Sat, 08 Nov 2025 03:14:43 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHZPT-00000002HDE-39y8
	for kexec@lists.infradead.org;
	Sat, 08 Nov 2025 03:14:41 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3418ad69672so904734a91.3
        for <kexec@lists.infradead.org>; Fri, 07 Nov 2025 19:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762571678; x=1763176478; darn=lists.infradead.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6C2+7Qd60IlxMiJIyGrsOyGd11fRVYN8pScSxbzQ4U=;
        b=QEP28DTR6Pxw84/XxnwtBehhKACsN8vJ0VEKsyaFw2FU0zIvYs45w2FpsxXZKyx1nk
         uhyphNmZVpYodfZ0PLCcuNtpiX7NrLurrNAdQL1taVw8ZtDsjvVg2Y5JpgqWXJxmgt8Q
         VEXRYmyeQSWoTg0SwekzLAHvVN8m0uNv17BqQVKm8J4zlFD6sAyxBEbo//hL8qTx+ck6
         1yzEKUhG7oJx6TyLvNBVrM6puoevt5gkKHbdaNe4Sh7FB+qafHrMt47DYZK1PyiCUuTb
         ydiEVBFRn9tHHE+lBUqjDbvM4I3ezktZHve5ltL4W6UMBB9cGvgK+10436assjnP53DE
         LAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762571678; x=1763176478;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6C2+7Qd60IlxMiJIyGrsOyGd11fRVYN8pScSxbzQ4U=;
        b=VjeKzp7QQMWK75gc3ucWn239fYlJG39i5UYSaCwd/u5+a9QPG8Hza5fRYPG50Zw2NJ
         bjL/OXf3HQIGFhkLvR8gxbiC5ahh47wx1bn4CGUtNn41c62DPprdeMRv/nn8I5xerdZh
         D4aJ/fvYe2Mn0kkDBwd6UlvLaQGYb35kTogoF2MgPHhD6kVmcSy1r2A/o+/O9YCtkT9C
         sq5Hm3dF1fy+kLskmRrdjRUDAZ3HGEwq0Humo3rVZUHQ+7mLFUTzbUgtqu+BIS12rl8g
         ykMM9rjmWvg7UySE5qA/imO7Upv6dUqZeI3R0vc8RHyJwSKfDms5nIU5FM/FR4ajI5TB
         cuwA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3mQ4Ly4z6b1lDMBd8wB0R1ZaVM0sw+IgOL4x1eiDMU0kvUAtaFzCZaeNGp6D9PB4yyW7pg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwL1kofDeYM5kHdeW1S2vHo4Bn4uMLWsWeoIzcMYfU3EIk3JHFx
	X2jQ1UPWXgTSl0K/Kcl5iXmDJE8Rl2VUNdH0Vunb4KdlafAdMBfN98o/4bkpn5Cw
X-Gm-Gg: ASbGncs29tm/+tT46wsVUh05XDeRsypmXva5Vtgy+/7Nxm8AH87fdnRwTosLFuU25qL
	Wmxd/82iRwsXDcGNeFnL1V7ySMndi4/uMrMYyDMKVaFil1mzPn0mvKU2vrIGgDxAxul/3TNkaTT
	5sTexpk4/0exHDzW3Mw6TlspxMdZ16eG3wObgGzm5HDG8GDZXixk8OjQ07vIyCWTQz2eo6kCOs1
	z+ieK4RSOWeDrRDC6LWRWHjJ41VV7f9EKrlBaMXJDYimklbjaH3XXsFlkXjjVqOSgBmDBLd69Fq
	qRKx96hb+FFQYqh61iGP4ROvBZl2I6tTymjvowbdgi1pKudTYTamg/uyeMq9M0WviPKutAXgvnn
	0kZrF5cJSz4qLMa7/4PliprZDUVNSGoOu/6bVc6fM7QBSsPy5Ob04GiXNpwWNHatSTckrgg==
X-Google-Smtp-Source: AGHT+IG9vhxF6McYx23s0+35XeyzF1JXNaUkhqmH82aBI1lNnROQAEm8GsscnfsHXOTjHEvjsYsCUg==
X-Received: by 2002:a17:90b:4a8f:b0:343:653d:31c with SMTP id 98e67ed59e1d1-3436cb0d08amr1498550a91.5.1762571678338;
        Fri, 07 Nov 2025 19:14:38 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed1e73sm6842743a12.12.2025.11.07.19.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:14:37 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v7] powerpc/kdump: Add support for crashkernel CMA reservation
In-Reply-To: <20251107080334.708028-1-sourabhjain@linux.ibm.com>
Date: Sat, 08 Nov 2025 08:14:51 +0530
Message-ID: <87a50x450c.ritesh.list@gmail.com>
References: <20251107080334.708028-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_191439_819064_85DD659B 
X-CRM114-Status: GOOD (  17.00  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
>
> Extend crashkernel CMA reservation support to powerpc.
>

Yup, would be nice to see this support landing in powerpc!

> The following changes are made to enable CMA reservation on powerpc:
>
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump
> - Include the CMA-reserved ranges in the usable memory ranges for the
>   kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore.
>
> With the introduction of the CMA crashkernel regions,
> crash_exclude_mem_range() needs to be called multiple times to exclude
> both crashk_res and crashk_cma_ranges from the crash memory ranges. To
> avoid repetitive logic for validating mem_ranges size and handling
> reallocation when required, this functionality is moved to a new wrapper
> function crash_exclude_mem_range_guarded().
>
> To ensure proper CMA reservation, reserve_crashkernel_cma() is called
> after pageblock_order is initialized.
>
> Update kernel-parameters.txt to document CMA support for crashkernel on
> powerpc architecture.
>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>
> v6 -> v7
> https://lore.kernel.org/all/20251104132818.1724562-1-sourabhjain@linux.ibm.com/
>  - declare crashk_cma_size static
>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  arch/powerpc/include/asm/kexec.h              |  2 +
>  arch/powerpc/kernel/setup-common.c            |  4 +-
>  arch/powerpc/kexec/core.c                     | 10 ++++-
>  arch/powerpc/kexec/ranges.c                   | 43 ++++++++++++++-----
>  5 files changed, 47 insertions(+), 14 deletions(-)

Although my reviewed by may not count much here since I am not deeply
familiar with arch/powerpc/kexec/** part.. 

But FWIW, the patch overall looks logical to me. 
Keeping cma reservation in setup_arch() is the right thing to do to
avoid issues like these in past [1]. The error handling logic and the
loop logic for handling CMA ranges also looks correct to me. 

So feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

[1]: https://lore.kernel.org/linuxppc-dev/3ae208e48c0d9cefe53d2dc4f593388067405b7d.1729146153.git.ritesh.list@gmail.com/

