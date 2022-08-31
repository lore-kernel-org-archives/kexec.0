Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D27ECAAD4
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=axFZiTO/BMdc+EAr7DTLjkxt+1sLqh9c1gqoAzFK5cY=; b=R4CCl0MmoEB44e
	aWL2bp9+si2Vwe4cFejgF9V7UhvoVPwlHwTczkF1LQhWigWoBlcQGoPkVqnADucpJRhVSWLZklZ0+
	wSaGHjPQtMRqaWEHWxvvBkqT63+O92EkcyQu0SfTQ7Mq7cN79+cysup3tROxsBKRpu1gmIXeViCfL
	uDPYJlf099BBcC2IekJ6DxHaLBECMalx2V4zR3TQuOzP1op7maOcNCCtaAhyCXgPm6poYSAVgyulN
	P7xmQDGkusBcx96rwUGx/BUedTHi4TWpYZWpR2YTHd0Sk7hhQVhCAu4reYs2GXGmrLLUHb5RwF8+j
	SblcIC4p3Dk007PIFjPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTKvv-005fHd-8J; Wed, 31 Aug 2022 10:26:55 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTKvs-005fH1-O9; Wed, 31 Aug 2022 10:26:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 895C6B81DB7;
	Wed, 31 Aug 2022 10:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A33BC433D6;
	Wed, 31 Aug 2022 10:26:47 +0000 (UTC)
Date: Wed, 31 Aug 2022 11:26:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, will@kernel.org,
	nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw83WQOgQf2yICaM@arm.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
 <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
 <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
 <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_032652_954812_59855FCE 
X-CRM114-Status: GOOD (  17.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Aug 31, 2022 at 10:49:30AM +0900, Yun Levi wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem slot in case of crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> Cc: stable@vger.kernel.org

To be even more precise, it should be:

Cc: <stable@vger.kernel.org> # 5.19.x

> Acked-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c
> b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..a11a6e14ba89 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   u64 i;
>   phys_addr_t start, end;
> 
> - nr_ranges = 1; /* for exclusion of crashkernel region */
> + nr_ranges = 2; /* for exclusion of crashkernel region */
>   for_each_mem_range(i, &start, &end)
>   nr_ranges++;

Something happened to the whitespace here, so the patch can't be
applied.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
