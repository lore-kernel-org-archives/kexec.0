Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABD606A32E
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HYoYBn7H;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkqpfmLb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9akG+nDtIvJDcRYJ/oAtRMDaGCKBlqt1RbnUpTcKFrU=; b=HYoYBn7Hrj4YvA
	7ohYD/+mv0MHHmqDLWILys8GLFgX6PT73KXmf9m2zsrPC9Y35e/f5vno9NWX95XqUvpjIRS604i9V
	GMiq73Tpzmnt498GZ5s+BIKG2bVNWalGxpbW82RIBQl665TAwwY4cwrhxw6IcvIuWwtJr5T8FGLOZ
	CIuU8wIRmCTfhRBW8WUas5X2vYAeSZI8qLPvmfpbusfMHohs0ZhflF3N5OJuYZl4KdBA6NGgN9BWC
	pcKf+SFbRC+5lG+WtG/zbD4oxy26UhgFx0oAj8ljywCRi/LQTrXs1xUwpb9q0b5rKVfyCL5RSmQYz
	c7deyYGwDHEygo6YFNbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPB5X-0000000BC7E-2rqh;
	Fri, 06 Nov 2026 03:58:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPB5V-0000000BC6i-0fyl
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 03:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793937480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9akG+nDtIvJDcRYJ/oAtRMDaGCKBlqt1RbnUpTcKFrU=;
	b=WkqpfmLb86STo6pkTZCgVlyjM8fHpT4OE0FMuHzSKSBdgnoyMuf/GlITl9h+0PL8XRmwCl
	Eb2NHC2uh7SqpC2sgeeWcgniXsv1SKxYVksWUdcMt/aB+uXuxzVGLsCcI4hk5fRpOISp/V
	YQvL4NZY/YsHTBmHvkHMXHxylitcO1Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-LKm-F8FsN6Gyb7JPIdHlgQ-1; Thu, 05 Nov 2026 22:57:59 -0500
X-MC-Unique: LKm-F8FsN6Gyb7JPIdHlgQ-1
X-Mimecast-MFC-AGG-ID: LKm-F8FsN6Gyb7JPIdHlgQ_1793937478
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed00709df0so2443415ad.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 19:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937478; x=1794542278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9akG+nDtIvJDcRYJ/oAtRMDaGCKBlqt1RbnUpTcKFrU=;
        b=1zeeC9rj81ogEg5jMolars23Yl+mm38jwQVzMXRph6UmJDD99GgHoMb8MUunZfn3pu
         3OuYEfhvOMhjn3rw7jGqDwBtnP+MadyPaD0fjRsy9gkTZoHy3uc8VFxaPaYpj3aRtP+y
         x1laK7Gc1JuKQhg6d02kX1IZEF8cAnn0nTMPhnGY++5/lxC/BVxPOJLvMftWCa8BiKS9
         r3rFsl2VYwPTKjXgZRCvFOqaN6GhO+VDCeC1wtdf6Zveh6HUxCkTVO6FdIn+0UOGVGbq
         pDco77SxwwRL0sVkRx9MOkxHEdBCexNScLwzpXIf63ZHSRtxiCJqMvhAZb0Mf7Lh/UcA
         nx7Q==
X-Forwarded-Encrypted: i=1; AL+hErEd3Vg+QqqTiDQIvg06qmLMHq0dGSTCtQt2bCqwZGqdIYw4MTSahJdhn2slb4SY6ZXOr2ZPfg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8BNLvmgPpQ1hUUtifLvyCQW9IrJiRprlP4mK2nr8EJzrGTNq6a
	cAX7pvuKij2I6B1lIR9/pazGHsk/5LD9lkKpDHtj0HSy2aE04p1eT9WtrcPMtYntd5Kn5ykBzSt
	x84/mIyHVTyq8Eh4XSyscIQyjyIfXdsOs2wJijZcqNV3E1Cgxtuv7QmFjSC29pQ==
X-Gm-Gg: AYBFou1PR4pUcV5b7YKgVZknIzQfCxiZx1XpdVkdfFChi4p2YV+ZnSLIObzAG6aOsTA
	BPPYEdcqSZtCQ1vA7vVKpPom8uLaqKjYGy0QZCFLMR5eftzVVvvB7PsdNjIY79RRHh5FTLyVXZ7
	iOrnAWnznQGUwUEqBuAyQYaMQIfZXaFgmIMGN58OgQR7qEHX/dlTGrq8vKXOO8HOsLZLmJL5Kd2
	Dy8aL/VREur1RPB1acTN6L7ucHk+1ybrHTN3q0iO7Ze7rBCiBioJcASXMHptpE6lkzEemetOWKn
	5zCCOQv4QZILxO7M5FpvvFU0TfMJtlSGz9a67+N9/MWgZ4D3xPoH7teRLx5t2wLMY65FF3rkKF5
	HeBAuRNB4zN/rKpBgsAzemSVfIV7Az/WvyDcL4gDE4fTLDPUTJ5xxrliXbiV1Z7uHAEG3Moj9MI
	4KvZYGwb4G6A7M592jmU4sGzYUKfqEceZVHpHxHg==
X-Received: by 2002:a17:903:3d10:b0:2ed:69b:9e76 with SMTP id d9443c01a7336-2ed40c59069mr18818695ad.28.1793937477814;
        Thu, 05 Nov 2026 19:57:57 -0800 (PST)
X-Received: by 2002:a17:903:3d10:b0:2ed:69b:9e76 with SMTP id d9443c01a7336-2ed40c59069mr18818435ad.28.1793937477119;
        Thu, 05 Nov 2026 19:57:57 -0800 (PST)
Received: from ?IPV6:2401:4900:1f28:63e0:a033:fd4:21a3:8f1? ([2401:4900:1f28:63e0:a033:fd4:21a3:8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a941csm1173495ad.18.2026.11.05.19.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 19:57:56 -0800 (PST)
Message-ID: <d928099c-4e43-4af8-a929-b510819967ce@redhat.com>
Date: Fri, 6 Nov 2026 09:27:50 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memblock: don't allocate new reserve_mem regions on a
 KHO boot
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>,
 Alexander Graf <graf@amazon.com>
Cc: Tony Luck <tony.luck@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>
References: <20261105213153.9572-1-azpijr@gmail.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261105213153.9572-1-azpijr@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UoO2EpAzIMTd_KTGjZRKEA98_SBb0-m_rqL2NfzJT_g_1793937478
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_195801_291651_B63744F1 
X-CRM114-Status: GOOD (  29.59  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jose, Thanks for the patch!

On 06/11/26 3:01 am, Jose A. Perez de Azpillaga wrote:
> On a KHO boot, a reserve_mem region that can't be revived is allocated
> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
> then fails:
> 
>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
>   failed to prepare memblock FDT for KHO: -22
> 
> Without it, the next kernel puts its memmap on top of the region and
> the ramoops records in it are lost.
> 
> There is no use case for adding regions across a live update, so fail
> instead of allocating, and drop the TODO.
> 
> Add an is_kho_boot() stub so the memblock tests still build.
> 
> Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
> Changes in v3:
> - add an is_kho_boot() stub to the memblock tests (Mike).
> - add Pasha's Reviewed-by.
> 
> Changes in v2:
> - fail on a KHO boot instead of allocating outside bootmem, as agreed
>   with Pratyush [1]. this drops v1's patch 1.
> - not an RFC anymore.
> - based on v7.4-rc1.
> 
> v2: https://lore.kernel.org/all/20261104204235.9066-1-azpijr@gmail.com/
> v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/
> 
> [1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/
> 
>  mm/memblock.c                     | 11 ++++++++++-
>  tools/testing/memblock/internal.h |  5 +++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a450092a80fb..e325e0542c9a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
>  	if (reserve_mem_kho_revive(name, size, align))
>  		return 1;
>  
> -	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
> +	/*
> +	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
> +	 * which includes the bootmem the next kernel boots out of. Only regions
> +	 * handed over by the previous kernel are supported.
> +	 */
> +	if (is_kho_boot()) {
> +		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
> +		return -EOPNOTSUPP;
> +	}
I think this over-restricts when KHO is explicitly disabled. kho= is an
early_param parsed before reserve_mem=, but kho_populate records the
incoming FDT without checking kho_enable. So a KHO payload booted with
kho=off ends up with is_kho_boot() == true and kho_is_enabled() ==false.

In that config nothing can be handed over again; reserve_mem_init
returns early on !kho_is_enabled(), and kho_fill_kimage bails on
!kho_enable. Allocating the region from KHO_NOPRSRV is therefore
harmless, and the documented best-effort reserve_mem= behaviour is
preserved.
That said, a new reserve_mem= line is rejected and its ramoops/ftrace
boot-instance consumers lose their region.

So, Would

	if (kho_is_enabled() && is_kho_boot())

be better here? If so, the memblock tests will also need a
kho_is_enabled() stub, since
tools/testing/memblock/linux/kexec_handover.h is empty and reserve_mem()
sits outside the CONFIG_KEXEC_HANDOVER ifdef.

Otherwise, the patch looks good to me.
> +
>  	start = memblock_phys_alloc(size, align);
>  	if (!start) {
>  		pr_err("reserve_mem: memblock allocation failed\n");
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index ba4d1c02fde5..84f22a964510 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -51,4 +51,9 @@ static inline bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>  	return false;
>  }
>  
> +static inline bool is_kho_boot(void)
> +{
> +	return false;
> +}
> +
>  #endif
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

-- 
Regards,
Mukesh Pilaniya


