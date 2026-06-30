Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A86C43602
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mg6vsp/jK24M0FEVqH+xkBLaeeIIgHOWsIxywI1KcqE=; b=ePrrENwkt3egWabiNOsLtZE7qi
	tvtOBXZpez58VLQA+C+CRUMjjbA+0ADbMatMfII1KwW1hel7BpCNvV0hp5sOhuMh9FxB+uOKV2D88
	Py+MZFDrR9CkAzWE1zTaKohVR8eAB0NSxLuAt346h8MxjQTdYZmw2dt9pwrwJeO77+ADrCA3v1G0q
	T2wLBrbcQX2SPwjChfKas9tXswWMb0N9ceFsw2f/zqpaUtQk9jRqQg6q7+SreTKeEk+3/94n0kwmt
	7kEpDrgfsY4TPSOEz8u4jRQmpyWtkZqTkcqvGXKAxv35vN6w81teMBz0LlWIUg/VwviT4wDpNcIL4
	gla1mamQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW07-0000000GhtX-2ZCJ;
	Tue, 30 Jun 2026 10:47:35 +0000
Received: from out-177.mta0.migadu.com ([2001:41d0:1004:224b::b1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW04-0000000GhsP-3c8K
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 10:47:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782816440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mg6vsp/jK24M0FEVqH+xkBLaeeIIgHOWsIxywI1KcqE=;
	b=bntUOZi7IarhgzlK1BZ1WsLScyGM3Ae7GIpkJSQ0DNCM47DRQj0T0zeuRqkrFL8hWLf1Yc
	6eamMcLRE3IL/ofX+gztk7Lkj9+HM/AKYSgtoqpLLSQ+TQ8Vo08WEKLhxaLmVXR48Ispxa
	0ZC00rOhiTr53qqNw/6DwXeRSFCyDLs=
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
Subject: Re: [PATCH v5 1/4] firmware: arm_sdei: add sdei_is_present()
Date: Tue, 30 Jun 2026 03:47:11 -0700
Message-ID: <20260630104713.3847805-1-usama.arif@linux.dev>
In-Reply-To: <dcf564152da8fc599cbfbe8b8d254fe837262ed3.1782744912.git.kas@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_034733_034643_8A529E01 
X-CRM114-Status: GOOD (  19.27  )
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

On Mon, 29 Jun 2026 16:07:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> invoke_sdei_fn() returns -EIO when no SDEI conduit was probed, and the
> core warns ("Failed to create event ...") on any registration that hits
> that. An optional consumer that registers an event from an unconditional
> initcall would therefore make every boot on a non-SDEI system emit that
> warning for what is simply absent firmware.
> 
> Expose whether SDEI firmware is present so such a consumer can skip
> registration -- and the warning -- when there is nothing to talk to.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Can this be merged in patch 3 where this function is actually used?

>  drivers/firmware/arm_sdei.c | 10 ++++++++++
>  include/linux/arm_sdei.h    |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index f39ed7ba3a38..c161cf263547 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -339,6 +339,16 @@ static void _ipi_unmask_cpu(void *ignored)
>  	sdei_unmask_local_cpu();
>  }
>  
> +/*
> + * Was SDEI firmware probed and is it usable?  Lets optional consumers skip
> + * registering an event -- and the warning a failed registration emits -- on
> + * systems with no SDEI.
> + */
> +bool sdei_is_present(void)
> +{
> +	return sdei_firmware_call;

sdei_firmware_call is a function pointer. The above is correct, but
can we make it sdei_firmware_call != NULL? I think that looks a lot better.

> +}
> +
>  static void _ipi_private_reset(void *ignored)
>  {
>  	int err;
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index f652a5028b59..b07113eeeff7 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -37,6 +37,9 @@ int sdei_event_unregister(u32 event_num);
>  int sdei_event_enable(u32 event_num);
>  int sdei_event_disable(u32 event_num);
>  
> +/* Was SDEI firmware probed and usable? */
> +bool sdei_is_present(void);
> +
>  /* GHES register/unregister helpers */
>  int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>  		       sdei_event_callback *critical_cb);
> -- 
> 2.54.0
> 
> 

