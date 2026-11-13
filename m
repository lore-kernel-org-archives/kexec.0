Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659646084365
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XRQ4kvSc;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=an7qNshc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=z43uFM3Pjo7vfGW2mID+1SupLltnf5Xt8DNDDQTTcdI=; b=XRQ4kvSc8mYtiu
	FKScddFli80LEbODgVdq/C4rrneEMeSJlMA1HIwT7aFRJ5Gm12xryKPC+MA0d1voID/l5ksC0vaCt
	4TZ3TgfgkgTX9Oy97HcDwLQbcA2T72kc+wt/zkVGztUeqtzPwwHOVitq1QIUTPuCnc5ZHZdcBHVC5
	nu6CXHRLryUekvOdwLcuvfAaj7gsibVb8v48EtijA9pkmL8R7v3Z2Ev3q5IGANVQV2IvAldt4bPMz
	t6UUDcRPcNLDcX//5r8MvbzflKSGDTYc1faqNCTy5PYgSjD14VcewE1gz5ALZvNXHozm9kbNriynL
	dJe25tXSz1DAWrCk13oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuz1-0000000DjQh-3aeB;
	Fri, 13 Nov 2026 17:22:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuyy-0000000DjPp-265v
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 17:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z43uFM3Pjo7vfGW2mID+1SupLltnf5Xt8DNDDQTTcdI=;
	b=an7qNshcty32otm5qc6CSPxErGcMnyUYWXQa8X2t7Wm7rmmS2RBjZ9GNdTNRIwjpIF8iAb
	UlezVmtgYquLGDTsS8QBdBAOiVnfOwFYZepup5h9hTPFUvP5uKAcP4efq2CvLNy2InrgLl
	VZC3e6d68eeiNBko8aMNA31HguofSvw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-wUjNE_m6Ozuhp1pfPVLjKw-1; Fri, 13 Nov 2026 12:22:34 -0500
X-MC-Unique: wUjNE_m6Ozuhp1pfPVLjKw-1
X-Mimecast-MFC-AGG-ID: wUjNE_m6Ozuhp1pfPVLjKw_1794590553
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e8dd9b9743so16115595ad.1
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 09:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590553; x=1795195353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z43uFM3Pjo7vfGW2mID+1SupLltnf5Xt8DNDDQTTcdI=;
        b=GC+PkzhSwIAVcfWpgsGKff+Los2kYwFZ4kmFuVVEMyudgUKDOPzo0MLVWhbPWn4vOu
         ore0vJ9C1JIfSFNrL7ZZLYciYg/VhPNXpeOhbh/TD89OMa4H2D6zvXaWPMv97EPcJNaP
         ZOQ4niuOBwePd00utk/8v1el/NhuGCyC0jwsW+dXYO2DCeT989CebpOHJyekCjW6ZzQc
         DBb1tqrx1vcjYKqPeIabtPDOdtOSFWqdxer18BC29NQGAcs8B2nBZ20rApYHIOPr84cm
         10WaIhSeb0/G0jtOzuxpp8z0LorNawodmNTkFnIK4MhY+eVGsgjIiGNGLCYiluv2wMkm
         zkEA==
X-Forwarded-Encrypted: i=1; AL+hErFxwiDsQOQ/UPk2mKAgHUUIKzJ+Wf42lWJh4AZUVRiqsaAXzr8teqSoudZibBRT27plJvSiNg==@lists.infradead.org
X-Gm-Message-State: APuU4Z82LutUo7A8qA2kQkhiRdSCZqOvtJ9fL9R/rxmMC0Ny8djMxjxy
	//b3uNe5MGsybqcu3DbE9b+yS7A8ahxGoMylg9NfYHboHypljvSeycM0H2gzXEpL1r5lWsbluNz
	zihqj9N5hal8znM6M8le6WHBleT+m+2Ej1Cd3C7ZUraPaQW0nYJ5vu3GawYRHPQ==
X-Gm-Gg: AYBFou1FecbbTmurIZZsSU/xoYIQ7iH1kqP0YH1ldbdXDGcaFed6lG+fLQOUz7W6cHt
	bsX+er9NIn9zfuZkN0zLJ6KTxMh5Gjok+EAkuC3imvX2ze/rnefea4EhoYxRvjHZLzOiDXfuclj
	zexsNHiWIyg7G1j2hqFQRFqeZ9tuh0ZHHdiHgKJOzXId7r3zMBskC0aJAIIeu/kZUVO8VcQxdk9
	SPBNNHApn7ZBMVxayB9xRlIq2wi+q3MG6o2sEQQhopQMkdlUX66dO/Vy8hWgaznOaOAnecpMktS
	n63DzDYd/EoLDFdkxDZ3uKjYKqiEWPrqe51QSyjWJXTS9gmmFFrsDIJJqtZJ/EKS3MDHS41uGGx
	n1WID0Qq5h7A3l7a8YhCOkv4S+2GD4tbLjYJstCTIdHwprPumWeNw1nxPEdgNuSChyXvkM8c=
X-Received: by 2002:a17:902:d550:b0:2e9:6f2c:71b9 with SMTP id d9443c01a7336-2ee0d6654a8mr33241535ad.1.1794590552873;
        Fri, 13 Nov 2026 09:22:32 -0800 (PST)
X-Received: by 2002:a17:902:d550:b0:2e9:6f2c:71b9 with SMTP id d9443c01a7336-2ee0d6654a8mr33241305ad.1.1794590552278;
        Fri, 13 Nov 2026 09:22:32 -0800 (PST)
Received: from [192.168.1.102] ([117.245.168.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f809867sm14050805ad.41.2026.11.13.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:22:31 -0800 (PST)
Message-ID: <9eac28b2-1931-434a-ad06-ceddf34869f1@redhat.com>
Date: Fri, 13 Nov 2026 22:52:24 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] kho: docs: update description of bootmem regions
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ne7S3MmXmDtWYzFjR7z95P77RzQlF9PLTwPqbFLx3XM_1794590553
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_092236_775114_5D111D02 
X-CRM114-Status: GOOD (  24.95  )
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



On 12/11/26 4:08 pm, Mike Rapoport (Microsoft) wrote:
> The description of the boot memory regions does not mention the low
> memory region and claims there is always a region per node plus a global
> region, while the low memory and the global regions are not allocated
> when they would be empty.
> 
> List all types of the boot memory regions and describe when they are not
> allocated.
> 
> While on it, fix grammar and split the description of the regions size
> and of the CMA usage into separate paragraphs.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  Documentation/core-api/kho/index.rst | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> index e78a2bbe2be1d..ce2bf9cf66514 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -52,17 +52,26 @@ allocations before during boot up to the initialization of the page allocator.
>  
>  We guarantee that we always have such regions through the boot memory regions:
>  On first boot KHO allocates several physically contiguous memory regions. Since
> -after kexec these regions will be used by early memory allocations, there is a
> -boot memory region per NUMA node plus a boot memory region to satisfy
> -allocations requests that do not require particular NUMA node assignment. By
> -default, size of the boot memory region is calculated based on amount of memory
> -allocated during boot. The ``kho_bootmem`` kernel command line option may be
> -used to explicitly define size of the boot memory regions. The boot memory
> -regions are declared as CMA when page allocator is initialized so that their
> -memory can be used during system lifetime. CMA gives us the guarantee that no
> -handover pages land in that region, because handover pages must be at a static
> -physical memory location and CMA enforces that only movable pages can be located
> -inside.
> +after kexec these regions will be used by early memory allocations, there are
> +several types of such regions to ensure that all boot-time allocations work:
> +
> +* a low memory region for allocations below ``ARCH_LOW_ADDRESS_LIMIT``
> +* a region per NUMA node
> +* a global region for allocations that do not require a particular NUMA node
> +
> +Regions that would be empty are not allocated. For example, there is no low
> +memory region when ``ARCH_LOW_ADDRESS_LIMIT`` covers all memory, and there is
> +no global region when ``CONFIG_NUMA`` is disabled.
> +
> +By default, the size of the boot memory regions is calculated based on the
> +amount of memory allocated during boot. The ``kho_bootmem`` kernel command line
> +option may be used to explicitly define the size of the boot memory regions.
> +
> +The boot memory regions are declared as CMA when the page allocator is
> +initialized so that their memory can be used during system lifetime. CMA gives
> +us the guarantee that no handover pages land in that region, because handover
> +pages must be at a static physical memory location and CMA enforces that only
> +movable pages can be located inside.
>  
>  After KHO kexec, we ignore the ``kho_bootmem`` kernel command line option and
>  instead reuse the exact same region that was originally allocated. This allows
> 
Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

-- 
Regards,
Mukesh Pilaniya


