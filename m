Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B81CA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjEfQ8K0k/MG2FrlywYZFAm1b1OQE1BGLhy0qHVcnUc=; b=pzdPs50zpi9wXA6C4thmuGc6cE
	g/rNolMqXoKPzwnKXiDLBYvvPv7PfGg5bDkKZqRnM78x/ecTyZwGRkVhgl372PxpfaXeDuG/JPjd2
	Q/K9aFzcBahWOR4j6S7l1x2w815RQXtPlBvy/UKwvPXX+vD0LOYik+f6MKa4bkLQ0xuGKK5NnX0H/
	fvB2THCHho4ai8l0uasarO8lloucHQR/GT9rAqmio8r7KSqSswKlzphbW3QWPk47a1tXp7BmZvXBO
	/5ZN6TAmCux4JVZrb3SD5VUuApGKNeCMGLVV1IBqfgtKq+CcSm3QRTpO7PRlTc8Qt1zoHkHvMGOrg
	izwediuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEitm-00000003nOd-1CX6;
	Thu, 08 Oct 2026 07:50:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEitl-00000003nOT-0IKO
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 07:50:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84E9E40239;
	Thu,  8 Oct 2026 07:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC21F0089A;
	Thu,  8 Oct 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791445840;
	bh=RjEfQ8K0k/MG2FrlywYZFAm1b1OQE1BGLhy0qHVcnUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IyYqNrIgnpzzFIJm9VUcTtkTa/krazKwEPDJeihSX4TjZ5OOGBpyYwUlIPuD9VI+7
	 gt8vqVLzPaEghj/4b0MzpHynDxYWhC1VIZVySweXqqAfXuiMsy3AgYcQ6UPXwMJ3BX
	 raudmfsPGitA+aKfIVXQ/VuF6BoCayOg6VimigLs8RKNfSuVWa4ymDVuc2Gg4DUlL0
	 8CwN+kn9fuiNIgA3V2lJiOpM2kqPREEMzfkoVJszNR1OD7tzg84PbR9oGrikrx6skE
	 IhTnuCnQRZR9qv/bytscnWbigqBHaWNn3esyk9f7W3mHvF5iSTdF2iLDLc65qFSTI3
	 2ZubRZZ27uv3Q==
Date: Thu, 8 Oct 2026 09:50:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kexec: Add helper to report an active kexec reboot
Message-ID: <asdLS9lRSL30eD34@kernel.org>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <20261001132147.1703600-1-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001132147.1703600-1-shradhagupta@linux.microsoft.com>
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

On Thu, Oct 01, 2026 at 06:21:44AM -0700, Shradha Gupta wrote:
> A shutdown callback in a loadable module may need to distinguish a
> kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
> VMBus driver needs this distinction when moving its kexec cleanup into
> a common syscore shutdown callback.
> 
> Add kexec_is_in_progress() and export it to GPL modules so the callback
> can remain guarded when VMBus is built as a module. Provide a false
> inline implementation when CONFIG_KEXEC_CORE is disabled.
> 
> The helper reports only the normal kexec reboot path. Crash kexec and
> preserve-context kexec do not set this state.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec.h | 2 ++
>  kernel/kexec_core.c   | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8a22bc9b8c6c..827a5311d97a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -468,6 +468,7 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;
> +bool kexec_is_in_progress(void);
>  
>  #ifndef page_to_boot_pfn
>  static inline unsigned long page_to_boot_pfn(struct page *page)
> @@ -544,6 +545,7 @@ static inline void *kimage_map_segment(struct kimage *image, int idx)
>  { return NULL; }
>  static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
> +static inline bool kexec_is_in_progress(void) { return false; }
>  #endif /* CONFIG_KEXEC_CORE */
>  
>  #ifdef CONFIG_KEXEC_SIG
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d05..282c7b3c6c35 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
> +#include <linux/export.h>
>  #include <linux/utsname.h>
>  #include <linux/numa.h>
>  #include <linux/suspend.h>
> @@ -54,6 +55,12 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> +bool kexec_is_in_progress(void)
> +{
> +	return kexec_in_progress;
> +}
> +EXPORT_SYMBOL_GPL(kexec_is_in_progress);
> +
>  bool kexec_file_dbg_print;
>  
>  /*
> -- 
> 2.43.0

-- 
Sincerely yours,
Mike.

