Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C93C43334
	for <kexec@archiver.kernel.org>; Mon,  6 Jun 2022 02:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QvNj8YSdIByxrsTZmuZQCWib0Kn8uJ/xScYX9KOLUSU=; b=JjC+6fAblv0Ms2
	IOC1MRpWDkeI5OuPdZ9g7uzVx8WLeMK4VfU1ckEyNZnB57/l/I5WJTWuOtPRGxWxwtM+N+c0KuYHi
	jy8mWFU1L0B6yDK/PHziG1v1HLMrEpWbZbcY1u6ztZ5hw5OAfPSlT3WhgNlogdXR3KODM3aKrrQ1W
	X/+PB+gyUjYiaTaeJTYeptFNkc8P+6m4qwyzPiAGoZsg+jcwZ1AZ4eVr1EItyMkUKIkmU7t6bdS54
	KfRCZJIkwORrGStiVqyGodBJNmT4+pd/1ufiyqfTsJdCSHqH3e5+28YV28SQcMopCBbZb/3bW+uz9
	gA03a4FikTZ5dhn7z24w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny2uy-00GYac-JK; Mon, 06 Jun 2022 02:56:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny2uv-00GYa2-Fj
	for kexec@lists.infradead.org; Mon, 06 Jun 2022 02:56:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654484192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEXtX0sGH9JESHp2vh7ZVWLUxp9Rfq4NGJnnAwZRSPw=;
	b=COIJRmhDLFEd44ylsP+Sa2CBWdWdCz5DUmhVcthHb5t6Fomu7zRmvJ+OPm5UPYXbsrYXQl
	h68VBDSRFJGvwqFilmnhutSlXYQwauHclxHyvodGg/0Q39EExofvmUA3Jrf1tWflAkqp+7
	Gk0+qh01HUKIi2buVAv/VzY2wRJW/F8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-_RCa0zPqOy6XrOVyXq6ZBA-1; Sun, 05 Jun 2022 22:56:31 -0400
X-MC-Unique: _RCa0zPqOy6XrOVyXq6ZBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DF6E801228;
	Mon,  6 Jun 2022 02:56:30 +0000 (UTC)
Received: from localhost (ovpn-12-209.pek2.redhat.com [10.72.12.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBCC1121314;
	Mon,  6 Jun 2022 02:56:28 +0000 (UTC)
Date: Mon, 6 Jun 2022 10:56:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, ebiederm@xmission.com, rburanyi@google.com,
	gthelen@google.com, viro@zeniv.linux.org.uk,
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
Message-ID: <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527025535.3953665-3-pasha.tatashin@soleen.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_195633_652772_C88F3729 
X-CRM114-Status: GOOD (  27.61  )
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

On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> In some case initrd can be large. For example, it could be a netboot
> image loaded by u-root, that is kexec'ing into it.
> 
> The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> not very obvious because it is hidden behind a generic INT_MAX macro.
> 
> Theoretically, we could make it LONG_MAX, but it is safer to keep it
> sane, and just increase it to 4G.

Do we need to care about 32bit system where initramfs could be larger
than 2G? On 32bit system, SSIZE_MAX is still 2G, right?

Another concern is if 2G is enough. If we can foresee it might need be
enlarged again in a near future, LONG_MAX certainly is not a good
value, but a little bigger multiple of 2G can be better?

> 
> Increase the size to 4G, and make it obvious by having a new macro
> that specifies the maximum file size supported by kexec_file_load()
> syscall: KEXEC_FILE_SIZE_MAX.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec_file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..f00cf70d82b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -31,6 +31,9 @@
>  
>  static int kexec_calculate_store_digests(struct kimage *image);
>  
> +/* Maximum size in bytes for kernel/initrd files. */
> +#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
> +
>  /*
>   * Currently this is the only default function that is exported as some
>   * architectures need it to do additional handlings.
> @@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			     const char __user *cmdline_ptr,
>  			     unsigned long cmdline_len, unsigned flags)
>  {
> -	int ret;
> +	ssize_t ret;
>  	void *ldata;
>  
>  	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
> -				       INT_MAX, NULL, READING_KEXEC_IMAGE);
> +				       KEXEC_FILE_SIZE_MAX, NULL,
> +				       READING_KEXEC_IMAGE);
>  	if (ret < 0)
>  		return ret;
>  	image->kernel_buf_len = ret;
> @@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
> -					       INT_MAX, NULL,
> +					       KEXEC_FILE_SIZE_MAX, NULL,
>  					       READING_KEXEC_INITRAMFS);
>  		if (ret < 0)
>  			goto out;
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
