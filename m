Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADA6CCF9E3
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 03:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VhEMZ0Jtb0EKH5oYWlO6UeXbTt7H19J688oVkjT6urY=; b=lBXtSWhndOT6RzxOPHD1oemqur
	9tJSCaqlUp2cV6QKk2ccPolk4S+JrugBBK+fuiIh/24iC7spMNf/NY4G2Hf1aC5U8ANWB5Eo8dhNR
	dsxLkOnCMy2WWzzGP01UzVA6dO3Berjsdr2aKuBY7zrhV1T2LnLhgn/bg6xuOnEdL7O5mxZcuJlpD
	oBI8P2qRLS3cHrrIr6lQ05jzxZrdzQzNPlVk6Dv2N6Qm5GwNBFEfD99+uG2GfSjEaFSmEgi9muJnc
	aq4A5fOG1O6uBnwtiZ3m4TD1lhhWJZXLsayNepgA2olRicU5oja1xP9f/5BiRJvofbjLneUoJ6zCi
	Xhve58mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTqX-0000000CwEl-1g7z;
	Wed, 05 Nov 2025 03:06:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTqS-0000000CwEH-0qi4
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 03:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762311959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhEMZ0Jtb0EKH5oYWlO6UeXbTt7H19J688oVkjT6urY=;
	b=fKz61Ts2v+NqkuIPu6RJXub1XfyiPGCdha6bjS4a/3Li+Ajal8k3FkhS6WXLodXb7p9ogz
	aSWZAFsKQoP3kIUczpyVU2amdvgkggMmbg6sCmDTPHPRC/liHSy/mZWFXQ/YD4GaRe6AIW
	lSiRONMcTchXVJSQdhrbjnSG0ml71mk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-r8hCIRS2MHu6lJasDsMnvw-1; Tue,
 04 Nov 2025 22:05:57 -0500
X-MC-Unique: r8hCIRS2MHu6lJasDsMnvw-1
X-Mimecast-MFC-AGG-ID: r8hCIRS2MHu6lJasDsMnvw_1762311956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A34180060D;
	Wed,  5 Nov 2025 03:05:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5550180035A;
	Wed,  5 Nov 2025 03:05:53 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:05:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between
 loop variable types
Message-ID: <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103063440.1681657-5-maqianga@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_190600_317313_A01F6C13 
X-CRM114-Status: GOOD (  17.62  )
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

On 11/03/25 at 02:34pm, Qiang Ma wrote:
> The type of the struct kimage member variable nr_segments is unsigned long.
> Correct the loop variable i and the print format specifier type.

I can't see what's meaningful with this change. nr_segments is unsigned
long, but it's the range 'i' will loop. If so, we need change all for
loop of the int iterator.

> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  kernel/kexec_file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 4a24aadbad02..7afdaa0efc50 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>  			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>  	struct kimage **dest_image, *image;
> -	int ret = 0, i;
> +	int ret = 0;
> +	unsigned long i;
>  
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!kexec_load_permitted(image_type))
> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>  			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>  			      ksegment->memsz);
>  
> -- 
> 2.20.1
> 


