Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F735FCE07F
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eWwAMPVsNlYzbt9jqcCV9wZlXvhXXjV0haFsXZmtXA=; b=xkjCzjR5ve16Ta/qrVZfvZLjmX
	d5CaAIkhVXwrjsRjuos+T9OqM/UnnhUYF9/eR125Od+0Y1FcnbGVAfAf6xxJnLigjir7SesdWhyXj
	m/h0z89vG/0uc+QX4fJYHVgtGgvfPemtLOovgSHo+GCKRGoc0rXmh9+40420asSNEhwiBkcPTGoOX
	z1dX9Au2FPX9OV7z0TYlZNdWDaw/CfKYrerWCCoXR8uVJDksDpUI4JJ+fBXC5XcKyIxN2ePUq8UR2
	vofRX6Mn968ZDWrm+4Bj5BsZh2P8SVDK9fpRCfNeM7PWrIe2fa8/YNOJF4be+zGtncqSmpjbHKGi+
	z9CAe1pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbaS-00000006EeP-2YEO;
	Thu, 26 Feb 2026 13:39:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbaQ-00000006Edp-0jY1
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 13:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772113165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eWwAMPVsNlYzbt9jqcCV9wZlXvhXXjV0haFsXZmtXA=;
	b=WQTYGuwBEkPuEHU6OzfNLgjz4DXqaVHld2sEEFd11B9DfBtOJtW2/euOSOkLIRzeXNYnV/
	qOraOaIRaquRlww+ptrtrbgY94PQJ9vs6DeGPFFC2AwegVsqScX5FlCSjTLqe7fMtE7Z2n
	NU3Sg/xPEQyV8o6UvYCSG8WGn+NKMjU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-RoFitFaWPbaCQG9nJCx8ug-1; Thu,
 26 Feb 2026 08:37:43 -0500
X-MC-Unique: RoFitFaWPbaCQG9nJCx8ug-1
X-Mimecast-MFC-AGG-ID: RoFitFaWPbaCQG9nJCx8ug_1772113061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F09F21956048;
	Thu, 26 Feb 2026 13:37:24 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD3811800666;
	Thu, 26 Feb 2026 13:37:15 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:37:10 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
Message-ID: <20260226143710.42ba1843@rotkaeppchen>
In-Reply-To: <20260119032424.10781-3-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
	<20260119032424.10781-3-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MraaX_a3iDG3uoUy1C7dEeWNrQOlGsTPIHIg_tudeS0_1772113061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_053926_287378_33D2D95C 
X-CRM114-Status: GOOD (  21.46  )
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

Hi Pingfan,

On Mon, 19 Jan 2026 11:24:13 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> Move the signature validation at the head of the function, so the image
> can be unfold and handled later.

besides what the bpf-bot already mentioned.

What do you want to achieve by moving signature verification in front
of probing the image? Do you want to avoid calling
arch_kexec_kernel_image_probe twice? It would be great if you could add
the reasoning why the change is needed to the commit message in the
future. Not only to make review easier but also to document it for the
future.

Thanks
Philipp

> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a97942428..0222d17072d40 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
>  		      image->kernel_buf, image->kernel_buf_len);
>  
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
>  #ifdef CONFIG_KEXEC_SIG
>  	ret = kimage_validate_signature(image);
>  
>  	if (ret)
>  		goto out;
>  #endif
> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,


