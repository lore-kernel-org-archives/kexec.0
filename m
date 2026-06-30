Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5089C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9n7ZDpIccfmSH+LPnECjmP2B4EEr/9E/8XqHFTUfhY=; b=Mu/r4+zV0xEMAdgJBMJseTKQj5
	ul2H0DJ+2spEiiKnrQpjkQ9o3huA/y8lvXT7XRInuCCJXxMtd3N9zIxQjZz5ItdCnmfmfdK01QDuH
	SbAz2rW5PqmlpPWRQ01fZtbCvuE4lHaEJG0NGCbsNnSDWqsKyJ5sgJ9LMicgWOnh6TgrTOAQYyEgp
	HgicnaDxwbQq/B8GrqCEPs2NxTIRqJHAL5CpGWImeslGIeaC8PxKMmabFE3hKDdTvOhVOJNwL00Lg
	3DU3zC8zWLy5F0pkDl7l6N1BeG69OHNuzteEwYN2KwteLiMXoZyVIGPqN2+aCYkcvR+hx4he0Ee/B
	i/DFXjDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW42-0000000GiRe-2PJz;
	Tue, 30 Jun 2026 10:51:38 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW3z-0000000GiQQ-1osN
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 10:51:37 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782816692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9n7ZDpIccfmSH+LPnECjmP2B4EEr/9E/8XqHFTUfhY=;
	b=tLKtQvIHPPZ3b4rEERovDRJqgbHmYlhXaOm/EjNtjomCDmMj6tjE2wn/lOcMdKOiEY14Jj
	zL6gUZijwI6higGOLymEzIvrbMCPe0Jp4XrWn2dW7Y89drmKG/QUJg/hUUL7FrFUXMlFpc
	8Mkflnqg2HFcRyKSPVmvqsJPelqBkBw=
From: Usama Arif <usama.arif@linux.dev>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Usama Arif <usama.arif@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v5 2/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Date: Tue, 30 Jun 2026 03:51:24 -0700
Message-ID: <20260630105125.4006859-1-usama.arif@linux.dev>
In-Reply-To: <def2f1a87ea36a5c3817ca5fbed8a01b7422e4c7.1782744912.git.kas@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_035135_656263_BA1620BD 
X-CRM114-Status: GOOD (  19.53  )
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

On Mon, 29 Jun 2026 16:07:16 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Add sdei_event_signal(), a thin wrapper over the SDEI_EVENT_SIGNAL call
> (DEN0054) that makes the software-signalled event (event 0) pending on a
> target PE -- delivered NMI-like even when that PE has interrupts masked.
> It takes no locks, so it is safe to call from NMI / crash context.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/firmware/arm_sdei.c   | 12 ++++++++++++
>  include/linux/arm_sdei.h      |  6 ++++++
>  include/uapi/linux/arm_sdei.h |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index c161cf263547..e8dd2f0f3919 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -339,6 +339,18 @@ static void _ipi_unmask_cpu(void *ignored)
>  	sdei_unmask_local_cpu();
>  }
>  
> +/*
> + * Signal the software-signalled event (event 0) to @mpidr. Does nothing
> + * but the SMC -- no locks, no event lookup -- so it is safe from NMI /
> + * crash context (e.g. the cross-CPU NMI service).
> + */
> +int sdei_event_signal(u32 event_num, u64 mpidr)
> +{
> +	return invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_SIGNAL, event_num,
> +			      mpidr, 0, 0, 0, NULL);
> +}
> +NOKPROBE_SYMBOL(sdei_event_signal);
> +

Same as patch 1, can this be merged in patch 3? Its good to keep functions
where they are used.

>  /*
>   * Was SDEI firmware probed and is it usable?  Lets optional consumers skip
>   * registering an event -- and the warning a failed registration emits -- on
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index b07113eeeff7..b9dc21c241be 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -37,6 +37,12 @@ int sdei_event_unregister(u32 event_num);
>  int sdei_event_enable(u32 event_num);
>  int sdei_event_disable(u32 event_num);
>  
> +/*
> + * Signal the software-signalled event (event 0) to another PE, NMI-like.
> + * @mpidr is the target's MPIDR affinity.
> + */
> +int sdei_event_signal(u32 event_num, u64 mpidr);
> +
>  /* Was SDEI firmware probed and usable? */
>  bool sdei_is_present(void);
>  
> diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
> index af0630ba5437..22eb61612673 100644
> --- a/include/uapi/linux/arm_sdei.h
> +++ b/include/uapi/linux/arm_sdei.h
> @@ -22,6 +22,7 @@
>  #define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
>  #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
>  #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
> +#define SDEI_1_0_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
>  #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
>  #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
>  
> -- 
> 2.54.0
> 
> 

