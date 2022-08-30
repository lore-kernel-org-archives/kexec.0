Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B49ECAAD8
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=weyU76IMOu/2QthERPgncyVByL+R3getREv17nj9LBU=; b=GtBT8huJF+7I/O
	kDH7a0nXyQBrF7gN18w3HxyR+u08IxxQENOwxpkS+oAp1G74r8ToVV925Fcy11LJuyWa4pMlo/wEC
	BGGBgAGH9cpCr2ag934iFhRurDyKoXt4arKp/rMEkUslevxyfDglySqBMoIifcs4i4vu/JBPOpmUf
	UhF8eHkdTAq+85rHpWFHHzsJwlKeYnHAwjMAxgeTjKUXNolFQXl/8Oar2qCkEGVI/L6cp2GnIYIo3
	QV/Sycy91Rrldk4FjiZ4ZqIfjwsVDY5WQeGanC3TjnVXGTDZ7wLLKWa8Dcfp1438lu+wCD41dwmw8
	G10Wdrz5KlmiB/ClHYJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvou-00Eon5-DW; Tue, 30 Aug 2022 07:38:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvo7-00EoR2-5t
	for kexec@lists.infradead.org; Tue, 30 Aug 2022 07:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661845030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3NkIhLQKy7eVJi/82pOIjWmNoom7j0EFy9fhBJw9/E=;
	b=Roya8zx70vPkBsb1Zvq+qSKlmhfqtZjIa6axvY596iluh8/pw5SHUSk8AywZ/tCyv+RJ4y
	dky+Ws/maRK071TBpbsM31qVFLaDEIa8c4hOwm+6Mu90uCVPCToZ9KX2/Pg9LFyLebYZAv
	46Y5t3QP+cxoDLLV6NcfMyNHRMMA438=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-cTciaf-dNbaNxSJAY5f-0Q-1; Tue, 30 Aug 2022 03:37:07 -0400
X-MC-Unique: cTciaf-dNbaNxSJAY5f-0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 403DB1019C88;
	Tue, 30 Aug 2022 07:37:07 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8383A492C3B;
	Tue, 30 Aug 2022 07:37:06 +0000 (UTC)
Date: Tue, 30 Aug 2022 15:37:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com,
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH-RESEND] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
References: <20220803151217.75962-1-ppbuk5246@gmail.com>
 <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_003717_637583_66099473 
X-CRM114-Status: GOOD (  16.65  )
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

On 08/30/22 at 01:28pm, Yun Levi wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> Add one extra crash_mem range when crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c
> b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..378aee04e7d4 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -51,6 +51,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>         for_each_mem_range(i, &start, &end)
>                 nr_ranges++;
> 
> +       if (crashk_low_res.end)
> +               nr_ranges++; /**< for exclusion of
> crashkernel=size,low region */
> +

Right, excluding crashkernel region may cause memory region splitting,
so we need extra slot for that.

Meanwhile, can you fix above code comment mess? Otherwise, this looks
good to me. 

Or we can add extra 2 slots like we do in x86, it just add another 16
bytes temporarily.


>         cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
>         if (!cmem)
>                 return -ENOMEM;
> --
> 2.35.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
