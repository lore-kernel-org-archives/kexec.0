Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD99C001DB
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YOkXhNfpiXHxL+o2RZzRVyXwH0RosKlgkmm96GHQcLo=; b=OVNaPAfzwM+MAz
	gTgRStk3hoa8gMvBCGVwC5NCSLZuk/l/JlynFc5Dn63BfWWNFZYOvjDnJusg6cMvIS0+Vtb+vPHkt
	8Dxx8dis8JQKa0OQGqlGUk9znGWvnXVP+tGFqJ6F4LkogdxRaD/nQxt4qpL3/iSkix+M1O9sSG1uX
	7tnFyYzhAK0wpuOdV+5HWFjZCr98mEI7TDcYJMvPCktRLNKz9gDIC62x8LqLLYNPZTHYW4VbDz41L
	sD5a9Lt6Dr4pkvO738xVphuhW/ri0Xbj+AZEaO1zHKjeM03sa3NEqaOGx0cyAO8ebvkl00vtqi9TW
	zi/XDHm605O6WCTnHUrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0DO-00HMhz-34;
	Mon, 07 Aug 2023 13:24:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0CO-00HLgA-07
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 13:23:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D53FD61AFE;
	Mon,  7 Aug 2023 13:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B0C433C8;
	Mon,  7 Aug 2023 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691414582;
	bh=UFq1cZWfdWBvDeWJ/9Ea9DY8wSheJDVAZbLLTr8zzOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZvnkmv0Vh65wmbUFQIsA1Sl+hkk8opbNl9lXfCIXXsPZV8LcM75LEGNaXvSum3oU
	 +yMq4BaBnywq6lvV6xBaGdXOj6fKeY/prQqRkQ1GHtWUzYbxKA4NS48x9HmOmOSeRW
	 p4p4e4kbu192qt9bb+6d+VW+EMYznmyM1rR/fFuBHXMHEGthzN88fOUs0YePOgL7Ml
	 nFQ36e/arAYRHRkr1U6XVLD3eqfPqA0HB1DFsdJYboeOsbWXIPAV/j0cpTTP6SgCUT
	 e8U2sVg8SZymBCR54gzxo1eCX1aiyyDMhwUZI8MCzdcsX13FOeXJIB+SblCQrVCrET
	 NEo9llaD+QTOg==
Date: Mon, 7 Aug 2023 15:22:59 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	ardb@kernel.org
Subject: Re: [PATCHv7 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZNDwM0YfAHT7PDef@vergenet.net>
References: <20230803024152.11663-1-piliu@redhat.com>
 <20230803024152.11663-4-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230803024152.11663-4-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_062304_168129_C1FB160C 
X-CRM114-Status: GOOD (  19.62  )
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

On Thu, Aug 03, 2023 at 10:41:50AM +0800, Pingfan Liu wrote:
> From: Jeremy Linton <jeremy.linton@arm.com>
> 
> The linux kernel CONFIG_ZBOOT option creates
> self decompressing PE kernel images. So this means
> that kexec should have a generic understanding of
> the format which may be used by multiple arches.
> 
> So lets add an arch independent validation
> and decompression routine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> [Modified by Pingfan to export kernel fd]
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> To: kexec@lists.infradead.org
> Cc: horms@verge.net.au
> Cc: ardb@kernel.org
> Cc: jeremy.linton@arm.com
> ---
>  include/Makefile         |   1 +
>  include/kexec-pe-zboot.h |  15 +++++
>  kexec/Makefile           |   1 +
>  kexec/kexec-pe-zboot.c   | 131 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 include/kexec-pe-zboot.h
>  create mode 100644 kexec/kexec-pe-zboot.c
> 
> diff --git a/include/Makefile b/include/Makefile
> index 621ce9f..cd88a26 100644
> --- a/include/Makefile
> +++ b/include/Makefile
> @@ -1,6 +1,7 @@
>  dist += include/Makefile		\
>  	include/config.h		\
>  	include/config.h.in		\
> +	include/kexec-pe-zboot.h	\
>  	include/kexec-uImage.h		\
>  	include/x86/x86-linux.h		\
>  	include/x86/mb_info.h		\
> diff --git a/include/kexec-pe-zboot.h b/include/kexec-pe-zboot.h
> new file mode 100644
> index 0000000..c588ca2
> --- /dev/null
> +++ b/include/kexec-pe-zboot.h
> @@ -0,0 +1,15 @@
> +#ifndef __KEXEC_PE_ZBOOT_H__
> +#define __KEXEC_PE_ZBOOT_H__
> +
> +/* see drivers/firmware/efi/libstub/zboot-header.S */
> +struct linux_pe_zboot_header {
> +	uint32_t mz_magic;
> +        uint32_t image_type;
> +        uint32_t payload_offset;
> +        uint32_t payload_size;
> +        uint32_t reserved[2];
> +        uint32_t compress_type;
> +};

nit: the above should consistently use tabs for indentation.
     I can try and fix this when applying if there is no v8.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
