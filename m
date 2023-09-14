Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8459AEDE99E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5z2Ei7cKxIRozwnn1HsdDorkxxpEm5fpn4ui9tX8fNM=; b=NJS1SvhbY7ZpMX
	mYCCUtEWk26TH6QFFJK+93U3ar1Ib1i6wKPVLo4Bj8AJ9heXBC2oBxOJJbZn67VKcBfDCDOUwych7
	lixzS2LQYYs6rqXMCPiEtRE93wClTU+awM5dYG1ikdPnSfYB6QkHjhXVZMxRZKZ/iZXCCOqACd0ti
	cTSAWigoDY3VpieNl5xx40EyR7e7gz9e/5e0OrGcSNMMI21RbJWpXgs16odprrcHI5Z+qZrBd9Ha4
	2kH0vuEtdR3rr5oYlAECsPp1Ifha52b8Dbv1Dghim/BuRRlNVuQlbPD1rhDxMDq3e6HiYBhsjSkjp
	fp2j7sIvTtyqwr6WSWBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgj4j-007toc-1W;
	Thu, 14 Sep 2023 09:55:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgj4f-007tnv-1s
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 09:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694685348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbzCaHSCASDUnmuzOQPrtJXNKZm/xofYLYD9/QhZhaI=;
	b=J27z5Wxw7RDdQ0WehwrrNNth6nhUv2Sx11gHJBz+9lGxc1fOXide9whXfMEPIRxO4RT4ej
	uR1Q36tfvkbHGK/L5Tj6D6vFK3V70BSnl3dGPJPSUoRy9akISj7YCubB2nRVP0QsxMsIte
	tFxOv4KhPJ52ZiEOOine2aQtE8bz4mI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-xOEQw2EDNL2lenJG7tDtZQ-1; Thu, 14 Sep 2023 05:55:45 -0400
X-MC-Unique: xOEQw2EDNL2lenJG7tDtZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AE3688B7A1;
	Thu, 14 Sep 2023 09:55:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BFBBE9A;
	Thu, 14 Sep 2023 09:55:44 +0000 (UTC)
Date: Thu, 14 Sep 2023 17:55:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>,
	Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH v1 1/2] zboot: enable arm64 kexec_load for zboot image
Message-ID: <ZQLYnYkYHbiIYi9M@MiWiFi-R3L-srv>
References: <20230914085000.17982-1-dyoung@redhat.com>
 <20230914085000.17982-2-dyoung@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230914085000.17982-2-dyoung@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_025549_689200_BFC88B5E 
X-CRM114-Status: GOOD (  28.47  )
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

On 09/14/23 at 04:49pm, Dave Young wrote:
> kexec_file_load support of zboot kernel image decompressed the vmlinuz,
> so in kexec_load code just load the kernel with reading the decompressed
> kernel fd into a new buffer and use it directly.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  include/kexec-pe-zboot.h               |  3 ++-
>  kexec/arch/arm64/kexec-vmlinuz-arm64.c | 26 +++++++++++++++++++++++---
>  kexec/kexec-pe-zboot.c                 |  4 +++-
>  kexec/kexec.c                          |  2 +-
>  kexec/kexec.h                          |  1 +
>  5 files changed, 30 insertions(+), 6 deletions(-)

I got this problem too on arm64 machine, applied this patch to test, can
confirm it works to fix the load failure when kexec_load is taken.

Tested-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/kexec-pe-zboot.h b/include/kexec-pe-zboot.h
> index e2e0448a81f2..374916cbe883 100644
> --- a/include/kexec-pe-zboot.h
> +++ b/include/kexec-pe-zboot.h
> @@ -11,5 +11,6 @@ struct linux_pe_zboot_header {
>  	uint32_t compress_type;
>  };
>  
> -int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd);
> +int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
> +		off_t *kernel_size);
>  #endif
> diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
> index c0ee47c8f50a..e291a34c97ad 100644
> --- a/kexec/arch/arm64/kexec-vmlinuz-arm64.c
> +++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
> @@ -34,6 +34,7 @@
>  #include "arch/options.h"
>  
>  static int kernel_fd = -1;
> +static off_t decompressed_size;
>  
>  /* Returns:
>   * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
> @@ -72,7 +73,7 @@ int pez_arm64_probe(const char *kernel_buf, off_t kernel_size)
>  		return -1;
>  	}
>  
> -	ret = pez_prepare(buf, buf_sz, &kernel_fd);
> +	ret = pez_prepare(buf, buf_sz, &kernel_fd, &decompressed_size);
>  
>  	if (!ret) {
>  	    /* validate the arm64 specific header */
> @@ -98,8 +99,27 @@ bad_header:
>  int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
>  			struct kexec_info *info)
>  {
> -	info->kernel_fd = kernel_fd;
> -	return image_arm64_load(argc, argv, buf, len, info);
> +	if (kernel_fd > 0 && decompressed_size > 0) {
> +		char *kbuf;
> +		off_t nread;
> +		int fd;
> +
> +		info->kernel_fd = kernel_fd;
> +		fd = dup(kernel_fd);
> +		if (fd < 0) {
> +			dbgprintf("%s: dup fd failed.\n", __func__);
> +			return -1;
> +		}
> +		kbuf = slurp_fd(fd, NULL, decompressed_size, &nread);
> +		if (!kbuf || nread != decompressed_size) {
> +			dbgprintf("%s: slurp_fd failed.\n", __func__);
> +			return -1;
> +		}
> +		return image_arm64_load(argc, argv, kbuf, decompressed_size, info);
> +	}
> +
> +	dbgprintf("%s: wrong kernel file descriptor.\n", __func__);
> +	return -1;
>  }
>  
>  void pez_arm64_usage(void)
> diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
> index 2f2e052b76c5..3abd17d9fe59 100644
> --- a/kexec/kexec-pe-zboot.c
> +++ b/kexec/kexec-pe-zboot.c
> @@ -37,7 +37,8 @@
>   *
>   * crude_buf: the content, which is read from the kernel file without any processing
>   */
> -int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd)
> +int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
> +		off_t *kernel_size)
>  {
>  	int ret = -1;
>  	int fd = 0;
> @@ -110,6 +111,7 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd)
>  		goto fail_bad_header;
>  	}
>  
> +	*kernel_size = decompressed_size;
>  	dbgprintf("%s: done\n", __func__);
>  
>  	ret = 0;
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index c3b182e254e0..1edbd349c86d 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -489,7 +489,7 @@ static int add_backup_segments(struct kexec_info *info,
>  	return 0;
>  }
>  
> -static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
> +char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
>  {
>  	char *buf;
>  	off_t progress;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index ed3b499a80f2..093338969c57 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -267,6 +267,7 @@ extern void die(const char *fmt, ...)
>  	__attribute__ ((format (printf, 1, 2)));
>  extern void *xmalloc(size_t size);
>  extern void *xrealloc(void *ptr, size_t size);
> +extern char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread);
>  extern char *slurp_file(const char *filename, off_t *r_size);
>  extern char *slurp_file_mmap(const char *filename, off_t *r_size);
>  extern char *slurp_file_len(const char *filename, off_t size, off_t *nread);
> -- 
> 2.37.2
> 
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
