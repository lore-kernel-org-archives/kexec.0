Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C7606A32D
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LlH/7PzT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS2U9cG5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b67nSDSKlbaduyToerD8/iZoRWrb26B2Xt6ysm6DMx8=; b=LlH/7PzTAobRuWk7VeVc7xtZXE
	1g4ma1r8iy0BHy/VRoN5KkOLo+wRmB1ZZILVQu+dWyd3vG+uHRUcThME6uAj+MK4veB3IBgdQSdS/
	omAxuh93AS7aU/IcPDhTfCvTlg8dH+/1HH1rUk3vUDWZkO9w0f56iSceHcSCEIb9/bLkbNk4PMZl4
	WBiv4o2/Qds/z1rJklkVOMexzDTIZWn2APv+hDdzxu8AxwoFe8xSNqlIcH8habI5PMo7+cd7GWTcq
	HI65uXH5PnVqxps1pxUQXdVCpYlQ4iwJ2a8F3cWEUikkwd6nXq/GxrY8TQ2y79tnynE8C6drDfaur
	bu2KBJSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs0n-00000006ppt-3elC;
	Tue, 24 Nov 2026 15:00:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs0n-00000006ppn-0V1D
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 15:00:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1E9D40BEF;
	Tue, 24 Nov 2026 15:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C011F000C6;
	Tue, 24 Nov 2026 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532448;
	bh=b67nSDSKlbaduyToerD8/iZoRWrb26B2Xt6ysm6DMx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kS2U9cG5k3BNOeM1o/Yw8hJGE4Ji6v4sydxvExS7m9RLqCcI+DPL31/kMICv4OPKV
	 vT6X/Ojuj4/KkoVQe8jcYVfNoTAVTh9kzW/ZHIfxij2EjaVjkstoeTjJ1vJ/7Byj6H
	 yBLe/IthXY52U3iCM7C+3lx8RJSOjU5X6E7XjPTPNIzWzB1wQspciUisUpVJvuYuPp
	 bl3gy2gLxsc9Sz7KjRuViLZqHHCiZ6Y4dIq3512Ho7+NK8XI6KIVe9EX60TRMjbi/V
	 4S8e9Qa4TowZySUM/kgljM4hQKMHkrgmNlb+xWbNjcUW5XXqslgi+4ezi23RvsYDVH
	 ZJOzpag+LIKeg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Add missing files to KEXEC and KHO
 subsystems
In-Reply-To: <20261124-fix-kexec-kdump-maintainers-v1-1-79c6a6144de4@csail.mit.edu>
	(Srivatsa S. Bhat's message of "Tue, 24 Nov 2026 01:37:53 +0530")
References: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
	<20261124-fix-kexec-kdump-maintainers-v1-1-79c6a6144de4@csail.mit.edu>
Date: Tue, 24 Nov 2026 15:00:44 +0000
Message-ID: <2vxzfqwqz337.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24 2026, Srivatsa S. Bhat (Microsoft) wrote:

> Several files related to kexec and Kexec HandOver are missing from their
> subsystem entries in MAINTAINERS. Hence, scripts/get_maintainers.pl does
> not currently recommend the kexec maintainers or the mailing list for
> changes to OF helpers, IRQ shutdown helper, purgatory header and kexec
> selftests.
>
> Fix it by adding these files under the appropriate KEXEC or KHO entries
> while preserving the existing Device Tree, IRQ, selftest and live-update
> coverage for these files.
>
> Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 012a21e4afcc..bb4d9c20db06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14775,10 +14775,14 @@ M:	Pratyush Yadav <pratyush@kernel.org>
>  L:	kexec@lists.infradead.org
>  W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> +F:	drivers/of/kexec.c
>  F:	include/linux/kexec.h
> +F:	include/linux/purgatory.h
>  F:	include/uapi/linux/kexec.h
>  F:	kernel/Kconfig.kexec
> +F:	kernel/irq/kexec.c
>  F:	kernel/kexec*
> +F:	tools/testing/selftests/kexec/
>  
>  KEXEC HANDOVER (KHO)
>  M:	Mike Rapoport <rppt@kernel.org>
> @@ -14791,11 +14795,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>  F:	Documentation/admin-guide/mm/kho.rst
>  F:	Documentation/core-api/kho/*
> +F:	drivers/of/kexec.c

Only a small part of that is KHO code, but adding it here is still fine I
think. Thanks for fixing this up!

Acked-by: Pratyush Yadav <pratyush@kernel.org>

>  F:	include/asm-generic/kexec_handover.h
>  F:	include/linux/kexec_handover.h
>  F:	include/linux/kho/
>  F:	include/linux/kho_block.h
> +F:	include/linux/kho_radix_tree.h
>  F:	kernel/liveupdate/kexec_handover*
> +F:	kernel/liveupdate/kho_block.c
>  F:	lib/test_kho.c
>  F:	tools/testing/selftests/kho/

-- 
Regards,
Pratyush Yadav

