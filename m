Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882D606A332
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GIPNbhcy;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Oa+RYcvU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fCYv0pUxgmAeB4rdFLxkyhkQaEAR/KeTjA5yN8eBLPw=; b=GIPNbhcyx6uTCd
	zK8yqcHcbAzyU1iQhjke3ytz5GLQs4bI3QmzVXhJ787mDp+HV+45T8XvyzL56xnDoanIWozas/iBg
	THVgb1f+G/qlmma712lk/aSuDcMbgERP1XMy98RCjr6e2kHgiWRRYFOmzOCiEMQCpwfkeldg7vvTL
	cw5e6ky68K9ORjN+S2EqvcjNkyJWPf8VoxV2yHLBDxk42/jzxKQSCnjZ71Vi+LS5lT0eZc8LFtXlg
	z/uCjZC+je1c9tIg5Tp4Xk0SSENdkIG3v6cby9L6W7qf5FrpoXPuNLa3iW9IccEzPRkAThxpveYAU
	WgrHJsDGSfi5dyvfDtVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKLW-0000000CUPh-0cdl;
	Fri, 06 Nov 2026 13:51:10 +0000
Received: from out-56.mta1.migadu.com ([2001:41d0:203:375::38] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKLN-0000000CUN3-3N5A
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 13:51:08 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=aSjJokHbfeqfaOpdHS6iuJx1acJZQq2O8WuSPhMF0YI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793973059; v=1; x=1794577859;
 b=Oa+RYcvUBR5PfQFFNyEECSKE8IZFUE0qtcC3TqqrH8gbPiNFoniV3V3wuatfAQl0gXy12YzC
 H8NAGpfZTqXU/gE2k1uaedWlmbuWsfz2rNEktpesnIBFVsUREBprL/vUo4+xz1fZ94VCGsMRe3R
 OPIImH5D+vmH4STXi7jisnI4=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 821439f0cfeaeec5;
	Fri, 06 Nov 2026 13:50:59 +0000
X-Mizu-Trace-ID: 821439f0cfeaeec5
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jiri Bohac <jbohac@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Give crashkernel CMA areas unique names
Date: Fri,  6 Nov 2026 05:50:55 -0800
Message-ID: <20261106135056.790448-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106104309.3669583-1-zaslonko@linux.ibm.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_055103_092429_EAAD0363 
X-CRM114-Status: GOOD (  19.61  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri,  6 Nov 2026 11:43:09 +0100 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:

> reserve_crashkernel_cma() names every CMA area it reserves
> "crashkernel". If the requested size can't be reserved in one piece,
> it falls back to several smaller areas, all with the same name.
> With CONFIG_CMA_SYSFS, cma_sysfs_init() then fails to create the second
> directory:
> 
>   sysfs: cannot create duplicate filename '/kernel/mm/cma/crashkernel'
> 
> and the error path removes the sysfs entries of all CMA areas.
> 
> With CONFIG_CMA_DEBUGFS, debugfs refuses the duplicate directories as
> well:
> 
>   debugfs: 'crashkernel' already exists in 'cma'
> 
> so only the first area shows up in debugfs.
> 
> Keep the name of the first area and add the index to the others:
> crashkernel, crashkernel1, crashkernel2, ...
> 
> Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
> Found while adding crashkernel CMA support for s390.
> 
>  kernel/crash_reserve.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Thanks for the fix and pointing me to it in [1]!

Acked-by: Usama Arif <usama.arif@linux.dev>

[1] https://lore.kernel.org/all/20261106104309.3669583-1-zaslonko@linux.ibm.com/

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index eee37a11380c..e58318b1e092 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -483,10 +483,16 @@ void __init reserve_crashkernel_cma(unsigned long long cma_size)
>  	while (cma_size > reserved_size &&
>  	       crashk_cma_cnt < CRASHKERNEL_CMA_RANGES_MAX) {
>  
> +		char name[CMA_MAX_NAME];
>  		struct cma *res;
>  
> +		/* CMA area names show up in sysfs and debugfs, keep them unique */
> +		if (crashk_cma_cnt)
> +			snprintf(name, sizeof(name), "crashkernel%d", crashk_cma_cnt);
> +		else
> +			strscpy(name, "crashkernel");
>  		if (cma_declare_contiguous(0, request_size, 0, 0, 0, false,
> -				       "crashkernel", &res)) {
> +				       name, &res)) {
>  			/* reservation failed, try half-sized blocks */
>  			if (request_size <= PAGE_SIZE)
>  				break;
> 
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
> -- 
> 2.55.0
> 
> 

