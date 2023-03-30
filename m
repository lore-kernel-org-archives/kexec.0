Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2834FC761AF
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+IRN/utuLBiTK2DE3i8vsb7qK+HQDPOhl9Hgeqe75Ek=; b=bAAFTJPOVnvM6P
	Y59PCAva9mOF9T2GNvYC9s3Yn9wr7sFJWbGs1lpNUHLRLh1udbNCZICCSfJdzj/bBPcO5l+SM82eJ
	BWe/OKg3tLSY9vasr419DJKMkmIEzop3NnaomIY76m6iwDnypkCkkM220qF2YGzzwz5SMKXwvH1DI
	Ep4theZmqpuHImsJ2uT2roFz26BFqDv84Jqx4yXgFvDG7DQOnSxxsQI5L+SLVhr0KNouMO6IldCGF
	rccYHAOzl3shrUPkYGNeyOaH7SS7e225FClzSDem3Gua7rQECzt605y81gINTdsIKkK2Q2AmnqVWQ
	ZHmUa7E7OccieA14xjZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phn21-002yMn-0f;
	Thu, 30 Mar 2023 07:49:13 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phn1x-002yLO-2S
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 07:49:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id A5C06CE278B;
	Thu, 30 Mar 2023 07:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BB2C4339E;
	Thu, 30 Mar 2023 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680162545;
	bh=euhxm4vC64BtVaPf8+4nBzNG5RrVIhtI/ZRKJNYJ4sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C98FLKJvzntj7hCOAMFU+R4Ws2Cbw7uabZMxqiC0wdz2w1IHHq2XM5KMoXNVKmYPv
	 PFaLDQCHLKa+8UAx3GZqxoe9eZJRy9Uku8aMFAmWIqaLogFSIZ7DV6LsVDSWN35/FN
	 2gevljv7PWHZsMiWFJbJ3D5dZTip61hCMQ5AJ5u9HtwySBMKK9Vgrd3qFCBojDY8Hb
	 0NAD1DiNzfME7co1LNBc+yoRlyXGeCdIaOPfMGDd1Cj/nhktZ5YokOKmSsmSbJeZI4
	 OllKSBfeUUcqQh8pOQBROp4Y6+Tzk+FlwdAiejZ+82VKOIjEpUxHNoqdDRFXm1xQrE
	 FJGJgOsHM/wIQ==
Date: Thu, 30 Mar 2023 09:48:59 +0200
From: Simon Horman <horms@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, stable@vger.kernel.org,
	Ross Zwisler <zwisler@google.com>, Philipp Rudo <prudo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v4 1/2] kexec: Support purgatories with .text.hot sections
Message-ID: <ZCU+63H7GzPlL6QJ@kernel.org>
References: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
 <20230321-kexec_clang16-v4-1-1340518f98e9@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230321-kexec_clang16-v4-1-1340518f98e9@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_004910_144947_80C3CB11 
X-CRM114-Status: GOOD (  28.90  )
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

On Mon, Mar 27, 2023 at 05:06:53PM +0200, Ricardo Ribalda wrote:
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

s/inmediatly/immediately/

> 
> kexec_core: Starting new kernel
> 
> Cc: stable@vger.kernel.org

Maybe a fixes tag is warranted here.

> Reviewed-by: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
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

nit: s/sections/section/

> +		 * (Eg: .text.hot), they are generally after the main .text

If this is the general case, then are there cases where this doesn't hold?

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
> -- 
> 2.40.0.348.gf938b09366-goog-b4-0.11.0-dev-696ae
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
