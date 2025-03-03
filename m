Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D973CC19F32
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lAV0uCT+WsooVoz6S69qz2vMhclHH6xzQjRGhGLXYng=; b=Dm7tvmmxTwQ7lULn3GakCz452W
	aIWe0PhtEwgGtwcQkbGnifJ7L5dIIMRlwW8SG1ng9afdIWSkc9MW+g7RuPinr7JsdetYQhE0r+1o+
	80DMGqRdcg613uLPN+nLLE0AypmYy3++WdrDKQqVNwfi6/Yi+somXTTFRkG5fF3g0MWgogVKNbllw
	LNF6iWW8BQyXnceVj1mNPOGtI3wmSqVG/ClFH+nLk3Ane6a9qlNUc1JD2GuwR95k9WQBHGAqJS/N6
	s2l57xp6SBWk94Lvs13B9aN+6ivZkiWF0wso/CkA4dT75zj8esZxwkAG3MKf4NEol7L68wRkrMDMV
	26UUZCSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tov99-0000000GvzT-3nAY;
	Mon, 03 Mar 2025 02:03:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tov97-0000000Gvz3-2C5e
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 02:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740967384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAV0uCT+WsooVoz6S69qz2vMhclHH6xzQjRGhGLXYng=;
	b=QMRTyHQcRiGPa64heeUdtWL/7QMSPcZpgJwHSWIiqYQyaTavOpGv2k2mXvlix+lCJibHh6
	MYqWqXU9YA35lvL6jHSr8Y2FGr+pHaM5VHWl6JLj+wIJICx+HFmhZVhSYPwauuwhAY3cCp
	XtdwdTPGyESWqHbkbkgcynfQEU6bjJk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-Cg5-S6tIMv6V34vDypTwow-1; Sun,
 02 Mar 2025 21:02:46 -0500
X-MC-Unique: Cg5-S6tIMv6V34vDypTwow-1
X-Mimecast-MFC-AGG-ID: Cg5-S6tIMv6V34vDypTwow_1740967365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03B401800873;
	Mon,  3 Mar 2025 02:02:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4DD21801768;
	Mon,  3 Mar 2025 02:02:43 +0000 (UTC)
Date: Mon, 3 Mar 2025 10:02:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <Z8UNvvEF2Ow/qigk@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7demEmgm-D_fqi2@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7demEmgm-D_fqi2@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_180305_638574_FB526FCD 
X-CRM114-Status: GOOD (  28.48  )
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

On 02/20/25 at 05:55pm, Jiri Bohac wrote:
> When re-using the CMA area for kdump there is a risk of pending DMA into
> pinned user pages in the CMA area.
> 
> Pages that are pinned long-term are migrated away from CMA, so these are not a
> concern. Pages pinned without FOLL_LONGTERM remain in the CMA and may possibly
> be the source or destination of a pending DMA transfer.
> 
> Although there is no clear specification how long a page may be pinned without
> FOLL_LONGTERM, pinning without the flag shows an intent of the caller to
> only use the memory for short-lived DMA transfers, not a transfer initiated
> by a device asynchronously at a random time in the future.
> 
> Add a delay of CMA_DMA_TIMEOUT_MSEC milliseconds before starting the kdump
> kernel, giving such short-lived DMA transfers time to finish before the CMA
> memory is re-used by the kdump kernel.
> 
> Set CMA_DMA_TIMEOUT_MSEC to 1000 (one second) - chosen arbitrarily as both a
> huge margin for a DMA transfer, yet not increasing the kdump time
> significantly.
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> ---
>  include/linux/crash_core.h |  5 +++++
>  kernel/crash_core.c        | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 44305336314e..543e4a71f13c 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -56,6 +56,11 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> +/* Time to wait for possible DMA to finish before starting the kdump kernel
> + * when a CMA reservation is used
> + */
> +#define CMA_DMA_TIMEOUT_MSEC 1000
> +
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 078fe5bc5a74..543e509b7926 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -21,6 +21,7 @@
>  #include <linux/reboot.h>
>  #include <linux/btf.h>
>  #include <linux/objtool.h>
> +#include <linux/delay.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -97,6 +98,14 @@ int kexec_crash_loaded(void)
>  }
>  EXPORT_SYMBOL_GPL(kexec_crash_loaded);
>  
> +static void crash_cma_clear_pending_dma(void)
> +{
> +	if (!crashk_cma_cnt)
> +		return;
> +
> +	mdelay(CMA_DMA_TIMEOUT_MSEC);
> +}
> +
>  /*
>   * No panic_cpu check version of crash_kexec().  This function is called
>   * only when panic_cpu holds the current CPU number; this is the only CPU
> @@ -116,6 +125,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;
>  
> +			crash_cma_clear_pending_dma();

This could be too ideal, I am not sure if it's a good way. When crash
triggered, we need do the urgent and necessary thing as soon as
possible, then shutdown all CPU to avoid further damage. This one second
of waiting could give the strayed system too much time. My personal
opinion.

>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 


