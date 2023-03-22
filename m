Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A47FC6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yppwBVaV2VGFGfoB1L4thbqrwwtxUBN+lO06cBhWHjU=; b=HjTv5s6J+kre30
	CUr+mLugycrCON4bFzuA3gSvwc5oNrxY1c1fBjZqh9YLCqvBOQndtBWKtIgK+jFK5NUjEGbAH3JHY
	USd42vQWdISWAXDy82/EI3hzwmrffg23JWpxHP77DSrHl2v0/Rg2jgufbQ3/cKQiMVGewOvyuCAl7
	8u/31zVo//jfJ2uWISj7GjlTd5dTwGKxENR5yDSEuW3LyBRnr9HrZ19hVCsWZ3O2lAGv1IDgVQa7+
	3pYvGz6vSxJ1qiwEihFfyRXQjvVj6cDYcybwDYYRpAtEZNSG5u0KPRD3jPhFe6Ij5LtCuQ/6JKOIL
	0Vl8MLDiE694ZJBp3XsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5Hv-00HNA5-2m;
	Wed, 22 Mar 2023 20:42:28 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5Hr-00HN9E-20
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 20:42:25 +0000
Received: by mail-il1-x132.google.com with SMTP id l15so9020246ilv.4
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679517742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeLzAkC8ofe4r03oiTnUMuqRyEUnaMbKdmxdI/cMXiM=;
        b=kqhsjOaIgYeqkmaxknXrou/E9CAWLLXCWtke8nsMd+V+dAl8Ga7iynfXqBHTcRVMLF
         zLiOHRlLUHVULCL+pKdRDQ2qoJnga+m+BrogLYKkZ7JpHIg4qOwtY8UQR4Fkg1i/Ct4O
         UlKS3TeJhDOTfy9v1vVyHjn05NVO6hmcPAj/WLe08+vavEqYhAdZ3frgHvAwvHzMa5C7
         ch1CE72tMkDsQOScDRmZyqj1JaTc1fjB1GyGwOE9Y3QRU0F8SCxgycpIiAgaQAKxPPug
         xjeGyOIuX8JcCMJ9dpeBdsU5+obmhYIz4If+Vdv4GY5+HmVG+hA3aUq3d03iul6mCcJU
         PjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679517742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeLzAkC8ofe4r03oiTnUMuqRyEUnaMbKdmxdI/cMXiM=;
        b=HnorUu+7a5aZpvi7Tjwr9LXt3MaoKXlGvgoMeA0z8zpt8CT5ErU8FDeKfaCu7WTZca
         /nIZZu6SJJxB8EKVWJmfEjaMnrlI92TLeLfpohlKWr5ymxd2huWA3pZJG7x9VGnYqvy/
         NN1uHaTUDCxsc5wkog3Wm8fSWRDmn/unuSn5px1unaFUgn3RbFvhawK3+jQ4OK/cQtRX
         zTMpVFeIhiwfn/GJB4WvX8reupFlIpasnGnpowaly2FwiNfZqemc7SQTuuM9qTx/5GRI
         JjdpyjZY7Uz8gcLfV8+UGYBFkNkufV9m+uu8S6N2OTppO5amibe2kP2HXqMjl4jyTrP6
         3VNw==
X-Gm-Message-State: AO0yUKUYmF7u0KUkf2qzlW/DXlxXPAg0qnILs8tuaC3O2+3c9xXgZMSP
	HCN9cpB/E3jt3oBOFIQ83GKibA==
X-Google-Smtp-Source: AK7set/06aJHdEyDBbceHYokSH5vndvb5S1yTg7EcEj+8vu430ajLvdUnVHF0SntvV7+l8P8X7HezQ==
X-Received: by 2002:a92:d102:0:b0:325:bc3f:f760 with SMTP id a2-20020a92d102000000b00325bc3ff760mr2290215ilb.0.1679517741531;
        Wed, 22 Mar 2023 13:42:21 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7419:4945:3325:dd1e])
        by smtp.gmail.com with ESMTPSA id y16-20020a027310000000b004061d6abcd1sm5274857jab.162.2023.03.22.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:42:21 -0700 (PDT)
Date: Wed, 22 Mar 2023 14:42:17 -0600
From: Ross Zwisler <zwisler@google.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322204217.GA3076000@google.com>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_134223_658358_0261C9BE 
X-CRM114-Status: GOOD (  30.04  )
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

On Wed, Mar 22, 2023 at 08:09:21PM +0100, Ricardo Ribalda wrote:
> Clang16 links the purgatory text in two sections:
> 
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>        00000000000011a1  0000000000000000  AX       0     0     16
>   [ 2] .rela.text        RELA             0000000000000000  00003498
>        0000000000000648  0000000000000018   I      24     1     8
>   ...
>   [17] .text.hot.        PROGBITS         0000000000000000  00003220
>        000000000000020b  0000000000000000  AX       0     0     1
>   [18] .rela.text.hot.   RELA             0000000000000000  00004428
>        0000000000000078  0000000000000018   I      24    17     8
> 
> And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> area pointed by `e_entry`.
> 
> This causes that image->start is calculated twice, once for .text and
> another time for .text.hot. The second calculation leaves image->start
> in a random location.
> 
> Because of this, the system crashes inmediatly after:
> 
> kexec_core: Starting new kernel
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>

> ---
> kexec: Fix kexec_file_load for llvm16
> 
> When upreving llvm I realised that kexec stopped working on my test
> platform. This patch fixes it.
> 
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v3:
> - Fix initial value. Thanks Ross!
> - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> 
> Changes in v2:
> - Fix if condition. Thanks Steven!.
> - Update Philipp email. Thanks Baoquan.
> - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> ---
>  kernel/kexec_file.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..25a37d8f113a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		}
>  
>  		offset = ALIGN(offset, align);
> +
> +		/*
> +		 * Check if the segment contains the entry point, if so,
> +		 * calculate the value of image->start based on it.
> +		 * If the compiler has produced more than one .text sections
> +		 * (Eg: .text.hot), they are generally after the main .text
> +		 * section, and they shall not be used to calculate
> +		 * image->start. So do not re-calculate image->start if it
> +		 * is not set to the initial value.
> +		 */
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start == pi->ehdr->e_entry) {
>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
