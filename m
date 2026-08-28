Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C4AC61DC4
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 02:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6Y2t7t3pTyS1TsGaO5sZiclBGn4Af0w47UGH/u7Uw0=; b=FkEXR3Nz53lIQJOs/k4LXgRJsc
	0OtSNXJ2sxRP0kq1xEelPDQyn/2OVBuBlT39mUtQ/X6SbwU8pK36vLeh/lT3jz4fv9eZEtKnagHqi
	oRTPrjjdo3yVCg6XzSk3582Sm3g7QpkhTHKojdEvOaW9BqWnzL/EojB8i5b01ciGf+jvRqxySEqtQ
	ZMvSxheENCKTUnCIRwUrIPT0HScvtOpJTcgYI2o2kzIbs1MhcwKCqaJSWSUDSGMZDMrAZL7reYw6M
	gilvKbGu68aDZFxYk3CGZNHBt588Jz31NvxnKTaCrLjKjdbkM1dQegTP7Bof5zcgtAP9eN60VsAMD
	iUP5//8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzm3R-00000005119-0arb;
	Fri, 28 Aug 2026 02:10:53 +0000
Received: from out-58.mta1.migadu.com ([2001:41d0:203:375::3a] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzm3O-00000005108-0bm0
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 02:10:52 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=306qViCsI/fL3kh7CVfETFHgjEHNsKAvkMgPEdvlycI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787883044; v=1; x=1788487844;
 b=O/BI380/Nz/18+bn+FrTdCV90NZYvfYF3ijOMc92x4P2UWYpM2DtvorSkFWyx1MkRONPs1WS
 apOEvdOGROG4esnaVwm0YCYFALFbwe3wqyOzBqEu9eJ0x5heTjtW6UoJo3QnFtnhmAcmgLwPwwZ
 vCvB2JzxKUo+cnOzWSK6Q+4w=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 0947378481690cdb;
	Fri, 28 Aug 2026 02:10:44 +0000
X-Mizu-Trace-ID: 0947378481690cdb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:10:35 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Paul Walmsley <pjw@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: remove unused arch_kexec_locate_mem_hole hook
Message-ID: <apDuG6mgDNyJL9rh@MiWiFi-R3L-srv>
References: <20260827144452.508328-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827144452.508328-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_191051_180841_D53B1C90 
X-CRM114-Status: GOOD (  17.77  )
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

On 08/27/26 at 08:14pm, Sourabh Jain wrote:
> No architecture provides an implementation of
> arch_kexec_locate_mem_hole(). Use kexec_locate_mem_hole() directly
> and remove the unused fallback wrapper from the kexec header.

Since below commit, the last user was gone:
commit 6e5250eaa665f ("powerpc/crash: use generic APIs to locate memory hole for kdump")

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> This simplifies the kexec memory allocation path without changing
> its behavior.
> 
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/riscv/kernel/kexec_elf.c |  2 +-
>  include/linux/kexec.h         | 15 ---------------
>  kernel/kexec_file.c           |  2 +-
>  3 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
> index 3e9a32acb8f2..ca5abbad59e5 100644
> --- a/arch/riscv/kernel/kexec_elf.c
> +++ b/arch/riscv/kernel/kexec_elf.c
> @@ -91,7 +91,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
>  	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
>  	kbuf.cma = NULL;
>  	kbuf.top_down = false;
> -	ret = arch_kexec_locate_mem_hole(&kbuf);
> +	ret = kexec_locate_mem_hole(&kbuf);
>  	if (!ret) {
>  		*old_pbase = lowest_paddr;
>  		*new_pbase = kbuf.mem;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0af8ae4fdd08..e5f1cfc11fef 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -259,21 +259,6 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> -#ifndef arch_kexec_locate_mem_hole
> -/**
> - * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> - * @kbuf:                       Parameters for the memory search.
> - *
> - * On success, kbuf->mem will have the start address of the memory region found.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> -{
> -	return kexec_locate_mem_hole(kbuf);
> -}
> -#endif
> -
>  #ifndef arch_kexec_apply_relocations_add
>  /*
>   * arch_kexec_apply_relocations_add - apply relocations of type RELA
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d8..9a981359addd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -784,7 +784,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->cma = NULL;
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = arch_kexec_locate_mem_hole(kbuf);
> +	ret = kexec_locate_mem_hole(kbuf);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.55.0
> 

