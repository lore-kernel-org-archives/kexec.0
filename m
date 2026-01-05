Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6529BC98335
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+aO3Ebr2jGnru13EE9csHxWpIIPD1Zup/NJRG9MgAX8=; b=vcChELzy8gyXMl5K7AOa/IT1Qq
	T3noRsBeTbCw7SiZvmTuxcSOL46FedFKaBaaFn3Z04TXGw/1zeDKTxpPmKqGZMpUq2zxisRm7avp5
	Vega/hExI3jfnxG448cmRj5obZAbQIJAWDzhkm0lgnpz5HrMHZVvu5YoJuOd0dfy5zVD1Jz/ACB11
	h/Np8juvhDiPM0odQaSKcg3wYwEZWOfUs6BVMKAYO9KMLEmQ7e67i15MaCvrlYWUarUhuLbnXtBrp
	DTeMEXSFLPtbD7AvDnWRuhYgvN1MkD7lYqJBiUHpYnHibohjHZ/R/6/CbzJdKY0iR0i9U5qj+isaR
	oYiVyOBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcrOt-0000000C4Cg-3XTG;
	Mon, 05 Jan 2026 20:42:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcrOr-0000000C4C6-0ehj;
	Mon, 05 Jan 2026 20:42:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D031340B04;
	Mon,  5 Jan 2026 20:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C9CC116D0;
	Mon,  5 Jan 2026 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767645720;
	bh=adEcWXAy0LZcvoVkWmyVj5xf/ztM+dJW91uYUT/32rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhE8zMi6wocrFARofw/nNpROVtJ0tI4m1LHQxXbIHpXCi84Uwsv0EkpEvRXk49Zsb
	 FBILt6PqviIqbH2CgHt2ICHGXICt18aznepv1UpweHgda2RJz2F2kIg5dqBZIH8j0k
	 WGI+nztJc4lCYjks1iMyYaPf7o8MebOiNR9iXQkjt9si32LwrKSGpZG1KCAHy+ZBSZ
	 U7mizZ/ojJadjRsgett9JaCHRBK6jVDstGjA/Rs06rYteZe03ukMw8Z36GfCrSx6wl
	 DL6XmDfhYn6R0j8U7NGyKyR95B1MM3KbdQzchBFmOY/CloJ24Xw5OIqUD6/Hwx1DdP
	 QtSotSjrrET4w==
Date: Mon, 5 Jan 2026 20:41:55 +0000
From: Will Deacon <will@kernel.org>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, catalin.marinas@arm.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: kexec: Adjust the debug print of
 kexec_image_info
Message-ID: <aVwiE-eeD-rCrO54@willie-the-truck>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
 <20251219093134.2268620-5-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219093134.2268620-5-maqianga@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_124201_507724_34AB023B 
X-CRM114-Status: GOOD (  13.19  )
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

On Fri, Dec 19, 2025 at 05:31:34PM +0800, Qiang Ma wrote:
> In the previous patch, we move start/head of kimage to the
> generic code, so, we remove them to avoid duplicate printing.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  arch/arm64/kernel/machine_kexec.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 239c16e3d02f..0896e3e6a811 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -34,8 +34,6 @@ static void _kexec_image_info(const char *func, int line,
>  {
>  	kexec_dprintk("%s:%d:\n", func, line);
>  	kexec_dprintk("  kexec kimage info:\n");
> -	kexec_dprintk("    type:        %d\n", kimage->type);
> -	kexec_dprintk("    head:        %lx\n", kimage->head);
>  	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
>  	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
>  }
> -- 
> 2.20.1

Acked-by: Will Deacon <will@kernel.org>

Will

