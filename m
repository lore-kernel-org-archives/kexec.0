Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4265C982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4eH9hr+yvfFnvbbCrIYejYZnIdTOc3jXJLWRBe+BYc=; b=UoDZwvmUibSUMKbPHKlf35N7zX
	cJZ+vPbVRl3FmKXuYxpaoQxC2tiBLMGjWEZi64iZPSZGCchVEnyDtudjqCarQEE4Xms4GV6lAqB2f
	HZ2YtrH+kajAGBCQIMvJGkon3SKNlbY5o1Q6lu3jtwhqH9yJE0D8k2PR44iiuV+ItOXQHyN0eXyu0
	tcLSgMFEId8Pa3OHkXkCIjtJdtBuSRBTYtIXI53a7/JqK45CEuCN5uWwzLBGWi3BQ1ws98wD2WG/d
	gvSrY3bdTS7wrdrhSfjmrIB129a9k0CfDlyjK0wtglnje4oI1s1Yqz+AnJLa6PKK6siJjBlabaHfW
	VFC3m9nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zus-00000005MCM-2nh9;
	Tue, 22 Sep 2026 12:48:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zuq-00000005MBv-3kBs
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 12:48:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DC23411B5;
	Tue, 22 Sep 2026 12:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC61F000FF;
	Tue, 22 Sep 2026 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081288;
	bh=r4eH9hr+yvfFnvbbCrIYejYZnIdTOc3jXJLWRBe+BYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AxRcrfCKj4TeX6ZLNGmys0EohkLSWdZA4WpCoVu2s2m54mvKPCy6liQKcGrQ8XbgI
	 SQupz29e6y7f+7JP+FdhlC3s1z2X8i7JkPdbM3Y976b8njRgJrKLRElYxFR9JEM0BM
	 8TCcoyrcCXV565sfkLcc6LcmZjQmjecePjY6QHJrrJkVK8K8VbGFL91PeILG+FoFl9
	 1THEXtqQfFgXse9S65S+IyHqHuKjKQQgT8FUJXtwclVIR9dTtE3pMYo8uBe0eAvsYc
	 VeRU/FuqXgJPqY0qchNGgBdyeHHurNFz2kQGrv3nsl9hWhSY6PVrVOyB3nSxSAKtfk
	 9k3gXyOmIuBAg==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org,  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  chenhuacai@kernel.org,  ardb@kernel.org,  shuah@kernel.org,
  ilias.apalodimas@linaro.org,  akpm@linux-foundation.org,
  baoquan.he@linux.dev,  ruirui.yang@linux.dev,  guodongtai@kylinos.cn,
  kernel@xen0n.name,  graf@amazon.com,  liukexin@kylinos.cn,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 2/5] liveupdate: synchronize EFI KHO channel at
 execution
In-Reply-To: <20260904100852.26006-3-dongtai.guo@linux.dev> (George Guo's
	message of "Fri, 4 Sep 2026 18:08:49 +0800")
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
	<20260904100852.26006-3-dongtai.guo@linux.dev>
Date: Tue, 22 Sep 2026 14:48:03 +0200
Message-ID: <2vxz1pal5u64.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Sep 04 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> The EFI KHO configuration table is a global channel. Updating it while
> a candidate kexec image is still being loaded can leave the channel
> pointing at the failed candidate even though the previous image remains
> installed. Synchronize it instead from the image selected for execution.

Huh? Sorry, I don't understand this is supposed to mean at all. What
failed candidate?

>
> Use the actual scratch payload size rather than its page-aligned segment
> size, and propagate update failures before live-update serialization.
> Keep clearing the channel for cold and crash images best-effort.

Huh? This is word soup and I don't understand what any of this is
supposed to mean.

If you are using a LLM to generate this, please _read_ what the output
is and see if it even is readable to someone else.

And if you are writing this by hand, then take a step back, and consider
if patch reviews can even understand what you are saying.

>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/crash_core.c                |  7 +++++++
>  kernel/kexec_core.c                |  5 +++++
>  kernel/kexec_internal.h            |  3 +++
>  kernel/liveupdate/kexec_handover.c | 33 ++++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade0..6166ce4203d3 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -138,6 +138,13 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;
>  
> +			/*
> +			 * A crash image carries no KHO state: clear the
> +			 * transport so the crash kernel boots cold instead
> +			 * of reviving from stale state.
> +			 */
> +			(void)kho_sync_channel(kexec_crash_image);
> +
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d05..147f5b5b23d4 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1146,6 +1146,11 @@ int kernel_kexec(void)
>  		goto Unlock;
>  	}
>  
> +	/* Synchronize the handover transport with the image being executed. */
> +	error = kho_sync_channel(kexec_image);
> +	if (error)
> +		goto Unlock;
> +

Why are you setting this at kexec time? Why not set it at load time like
every other architecture?

Also what's this "sync channel"? Use simpler words that _actually
describe_ what they do.

>  	if (!kexec_image->preserve_context) {
>  		error = liveupdate_reboot();
>  		if (error)
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 228bb88c018b..4d4c2290e85c 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -46,6 +46,7 @@ struct kexec_buf;
>  int kho_locate_mem_hole(struct kexec_buf *kbuf,
>  			int (*func)(struct resource *, void *));
>  int kho_fill_kimage(struct kimage *image);
> +int kho_sync_channel(struct kimage *image);
>  #else
>  static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
>  				      int (*func)(struct resource *, void *))
> @@ -54,5 +55,7 @@ static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
>  }
>  
>  static inline int kho_fill_kimage(struct kimage *image) { return 0; }
> +
> +static inline int kho_sync_channel(struct kimage *image) { return 0; }
>  #endif /* CONFIG_KEXEC_HANDOVER */
>  #endif /* LINUX_KEXEC_INTERNAL_H */
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 39f489a258d9..3aa5c66dfc6d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -14,6 +14,7 @@
>  #include <linux/cma.h>
>  #include <linux/kmemleak.h>
>  #include <linux/count_zeros.h>
> +#include <linux/efi.h>
>  #include <linux/kasan.h>
>  #include <linux/kexec.h>
>  #include <linux/kexec_handover.h>
> @@ -2074,6 +2075,38 @@ int kho_fill_kimage(struct kimage *image)
>  	return 0;
>  }
>  
> +/*
> + * Synchronize the handover transport with the image that is about to be
> + * executed.  The EFI config table channel is global, while kexec keeps
> + * separate images for a normal reboot and for crash.  Write the state of the
> + * selected image immediately before it is executed, rather than while a
> + * candidate image is being loaded, so a failed replacement cannot leave the
> + * channel pointing at that failed image.
> + *
> + * An image loaded through the legacy kexec_load() syscall, a crash image, or
> + * an image loaded while KHO is disabled carries no handover state.  Clear the
> + * channel for those images so the next kernel boots cold instead of reviving
> + * from stale state.  Clearing is best-effort because an absent channel cannot
> + * affect a cold boot.
> + */
> +int kho_sync_channel(struct kimage *image)
> +{
> +	int err;
> +
> +	if (!image->kho.fdt || !image->kho.scratch) {
> +		efi_kho_update(0, 0, 0, 0);
> +		return 0;
> +	}
> +
> +	err = efi_kho_update(image->kho.fdt, PAGE_SIZE,
> +			     image->kho.scratch->mem,
> +			     image->kho.scratch->bufsz);
> +	if (err)
> +		pr_warn("failed to update EFI config table: %d\n", err);
> +
> +	return err;
> +}
> +
>  static int kho_walk_scratch(struct kexec_buf *kbuf,
>  			    int (*func)(struct resource *, void *))
>  {

-- 
Regards,
Pratyush Yadav

