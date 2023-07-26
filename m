Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ADEC001B0
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mmtrpIhiwaONRGIjRaOesKc+GQmkBXoIsoxtZoqCclI=; b=bYOg89TI/YzZul
	vYK6ITT8mQNQT7Eg1nseC0/TzpIG3MlOb6amVDRjkKmCxpeEl9zcLzSdNouXlgsV+XxyON42DYZid
	kzW0Y1AHFFbNc4WtCap3rqIOCg5Va2M1i3lvIs5XxLGI5fpMl4e9P3gdlKBtAQqjjlvAEgqT5Zw1s
	598zzU9IfZVBNoig43yjkT+ccyQqGpikFgUnhE0+91gM59eVB0AxG/oo5HD8MQw/r0HQ6VGfD/rJy
	ZkS2sUSiiT4ShQkq4EhCEKqBxD1r134VZ9BAdWeJs8tPXxryFRwEBfyQmG+Oe7rCzoNAOFtj7qC+R
	kikTKcN0rn1i9giq1xrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qObhy-009tAe-0a;
	Wed, 26 Jul 2023 10:25:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qObhw-009tA4-14
	for kexec@lists.infradead.org;
	Wed, 26 Jul 2023 10:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690367127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6NrkSvDdE4cdjpoTJxD+Lnito5LDpS0282P7ZLa36EE=;
	b=VFe6OlcjwWPGehyfVBCdhk1wjquIwWgnLcHRZzRSndvi8ptBsze7G5JOG/cX5LZSEKLbHN
	d5OnNfmZ209FebZkpFRJkmR47q44pdBLblTrw56MxypqA1rOSJi2f6bvt+tzkGHonaAEUZ
	Ug2cRWgI3pVPvccV67Qo0Cqogzpxr08=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-jrcLmOGXMXWtWFE-eZtxUw-1; Wed, 26 Jul 2023 06:25:24 -0400
X-MC-Unique: jrcLmOGXMXWtWFE-eZtxUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E81B1C31C49;
	Wed, 26 Jul 2023 10:25:23 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E202646A3A7;
	Wed, 26 Jul 2023 10:25:22 +0000 (UTC)
Date: Wed, 26 Jul 2023 18:25:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v9 2/2] docs: kdump: Update the crashkernel
 description for riscv
Message-ID: <ZMD0jxzH0jmFLTd8@MiWiFi-R3L-srv>
References: <20230726175000.2536220-1-chenjiahao16@huawei.com>
 <20230726175000.2536220-3-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230726175000.2536220-3-chenjiahao16@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_032528_434844_253812D3 
X-CRM114-Status: GOOD (  24.35  )
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

On 07/26/23 at 05:50pm, Chen Jiahao wrote:
> Now "crashkernel=" parameter on riscv has been updated to support
> crashkernel=X,[high,low]. Through which we can reserve memory region
> above/within 32bit addressible DMA zone.
> 
> Here update the parameter description accordingly.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41..bd519749968f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -862,7 +862,7 @@
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
>  			is selected automatically.
> -			[KNL, X86-64, ARM64] Select a region under 4G first, and
> +			[KNL, X86-64, ARM64, RISCV] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> @@ -875,14 +875,14 @@
>  			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
>  	crashkernel=size[KMG],high
> -			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
> -			to allocate physical memory region from top, so could
> -			be above 4G if system have more than 4G ram installed.
> -			Otherwise memory region will be allocated below 4G, if
> -			available.
> +			[KNL, X86-64, ARM64, RISCV] range could be above 4G.
> +			Allow kernel to allocate physical memory region from top,
> +			so could be above 4G if system have more than 4G ram
> +			installed. Otherwise memory region will be allocated
> +			below 4G, if available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64, RISCV] range under 4G. When crashkernel=X,high
>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -893,6 +893,7 @@
>  			size is	platform dependent.
>  			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
>  			  --> arm64: 128MiB
> +			  --> riscv: 128MiB
>  			This one lets the user specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
