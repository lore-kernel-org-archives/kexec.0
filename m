Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E76C77B7C
	for <kexec@archiver.kernel.org>; Wed, 24 May 2023 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZqvHTuv7C0gQIj4UXwRlU3cJA4XeZ9M9XqdZh1cubBE=; b=lEu7oD854uX78i
	mG1GV/QThcKHf8ccL79DNIX+FhzcKJONBm3kX6pmMX5Rve5AwTjQOnlNou0t/qVjbdGBUQ4FqmEBH
	DWcXinn47nqVHin1WdbCY9Kyt7/XPGxBKedYb/k2ao5Kh+qGLksxMk+QVyDnTKReiIAC14jRaS/D/
	1X4NlNZsSsxH0rkvQAtMJXiUN39vPH/cWmFJI+eRD0xPDOfr56TVpITULolBECQBkKoPAYu9yc0UE
	UYGg4Q6PELkh/Lp3CFtFRlW+CJHNW0xiFEEDGy5SpGPYE3DRZnOHdS7sfCEscXFbPohtp04V8aZIE
	EWyWBSiS41qSEwVKaUYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xPD-00Es3a-2G;
	Wed, 24 May 2023 22:56:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xPA-00Es31-2H
	for kexec@lists.infradead.org;
	Wed, 24 May 2023 22:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684968986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
	b=YK+qnrCTP8ByBFJjvr6gI48dutejVK7ZpLhAb2iwEcqMLQB1NPA6OY39gDHe8CZcc7dcW4
	PTpJnPlW/Skhsn7+A8ILvHzsyvbu71uynHkJl9+Kzwt6IZLwxtkuTMxib8ZF55FVoHLjDI
	0pvY95F6wjl3e9K1B66M1rajjsRM9NE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-GomZECSHNNOFFhjTqqEEcg-1; Wed, 24 May 2023 18:56:25 -0400
X-MC-Unique: GomZECSHNNOFFhjTqqEEcg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f6a856ae6aso6647571cf.0
        for <kexec@lists.infradead.org>; Wed, 24 May 2023 15:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968984; x=1687560984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
        b=HGLwynY0ezdx2sAVBV2uMeHLX7zFFwpPY4Ic4jxZ1CR+9ATUfPnBXlhR+yLMlELCOO
         vy73ggqWTShimKZysIpZXTfYyMWaf78ov+TRD7iWBg5hiaz55TjElWW+coyjhPaSRxc/
         948wZaksxzr2pucZC3nYBN+TuZeqZCkfALOJDa/lazdxHeGN/Pmpipn3eYrtEPewpXAt
         KPvOqzocgsITUU8zU/jSk2tEp5scd3TGDIWTCAR12dk0keUss0qXmPydQILI3wNjnD9k
         yMzlAh47TZ5M+8E6rlmj+UfcDeXL3xENOulumZhf/cmzUNNCrrywcClziCgboK4svsq+
         PxVA==
X-Gm-Message-State: AC+VfDxmJW18q+jQ0d+fPoJMwJwe1rtd0+8N1d4tquKuWKLOp2b4z6Xt
	zWPJ/jbiyOj6+9IWzoF0TQURLX6CeMyDxT2hzYYttcb9o6okOmDKhk3ydiSjFJcWa1WDqg5lTH3
	pdSh4qCnJRl78Op0gxI/URjtOyGc0
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325810qtv.64.1684968984359;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YIOLa22uHsyvn/hEoIII2YehPLAhvw1u1EoIWqYO1cyYh5aCnNjvQkCcKdtrNBcB8QhnYhA==
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325796qtv.64.1684968984135;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a010700b003f6a8379fa4sm3555602qtw.70.2023.05.24.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:56:23 -0700 (PDT)
Date: Wed, 24 May 2023 15:56:21 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au, 
	Palmer Dabbelt <palmer@rivosinc.com>, Rob Herring <robh@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v9 1/4] drivers: of: kexec ima: Support 32-bit platforms
Message-ID: <a2dx66ug4gnbokit35in5c2qjsq2fcewtw35bwknnsav4pw2ee@c3s4wsbszeyb>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230418134409.177485-2-stefanb@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_155628_818086_1A544615 
X-CRM114-Status: GOOD (  16.17  )
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

On Tue, Apr 18, 2023 at 09:44:06AM -0400, Stefan Berger wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> RISC-V recently added kexec_file() support, which uses enables kexec
> IMA.  We're the first 32-bit platform to support this, so we found a
> build bug.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/of/kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..1373d7e0a9b3 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -250,8 +250,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> -		 image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> +		 &image->ima_buffer_addr, image->ima_buffer_size);
>  
>  	return 0;
>  }
> -- 
> 2.38.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
