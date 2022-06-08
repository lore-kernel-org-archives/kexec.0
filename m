Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC828C433EF
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 00:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yhDMZTTivlfneXePLPOm7LwA/RMaotoH4e1aUnjaU30=; b=yAn7xB+he7lpvM
	YdlW8NjNmbBhVzSbMfT5PAeAUHxCawDmfTBSGfDwH86FI2xCjeBUuz3O1jEVSUlsQ8noCtgODqk9W
	Hoxwwxnd6g3h1jY3y7LBpF0JrlLacOo87MkKbsxGIRhJJsVGDd7NYTVcWkipnDT/zx+5qxc1B/cJy
	3gJyNJjyq/hZNFhDX2KB+21Eb5utoKqmDRl3QHq1JGcTvq9iWF0dYjD5CeUwRDbtm61zs/odzXYA7
	8ybHXMYzz981IYVzPIktbYEIO6YRG8PiJCS72z2tZilKWtmnQglt6JC85c1OptmtVh0F1dcJkQzu0
	ZlDY2aZLnkVGaG/3dO5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyk2P-00ABVG-3w; Wed, 08 Jun 2022 00:59:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyk2M-00ABUe-2M
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 00:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654649945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYVGlTfcixWRpDZ+Xnrns02OLERH2O9N67sLNCT2XaM=;
	b=EGUwmO7PudW/6vQUhpJ/Fs0waHL9ZNkJSCRkmNgBcs/nD8e5v5Gu3WJGv0YZd80LHr5Un4
	QeQEtH5NC5i1NyYD2NYpHM1bcIDTDVlqfZjPuJg+9fuF64UC4W4QcaxfTkmeIG6hQAoU0G
	ZCJ0gPXmkTf6ReTnG6ZiTOET01OeyJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-H_xe-6JtPiCty6iROnStrQ-1; Tue, 07 Jun 2022 20:58:59 -0400
X-MC-Unique: H_xe-6JtPiCty6iROnStrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D12800124;
	Wed,  8 Jun 2022 00:58:59 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 783F6492C3B;
	Wed,  8 Jun 2022 00:58:58 +0000 (UTC)
Date: Wed, 8 Jun 2022 08:58:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, ebiederm@xmission.com, rburanyi@google.com,
	akpm@linux-foundation.org, gthelen@google.com,
	viro@zeniv.linux.org.uk, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to
 ssize_t
Message-ID: <Yp/0TjxQGJJtjqAu@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527025535.3953665-2-pasha.tatashin@soleen.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_175906_229043_686674AD 
X-CRM114-Status: GOOD (  21.76  )
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
> Currently, the maximum file size that is supported is 2G. This may be
> too small in some cases. For example, kexec_file_load() system call
> loads initramfs. In some netboot cases initramfs can be rather large.
> 
> Allow to use up-to ssize_t bytes. The callers still can limit the
> maximum file size via buf_size.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
>  include/linux/kernel_read_file.h | 32 +++++++++++++--------------
>  include/linux/limits.h           |  1 +
>  3 files changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 1b07550485b9..5d826274570c 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -29,15 +29,15 @@
>   * change between calls to kernel_read_file().
>   *
>   * Returns number of bytes read (no single read will be bigger
> - * than INT_MAX), or negative on error.
> + * than SSIZE_MAX), or negative on error.
>   *
>   */
> -int kernel_read_file(struct file *file, loff_t offset, void **buf,
> -		     size_t buf_size, size_t *file_size,
> -		     enum kernel_read_file_id id)
> +ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> +			 size_t buf_size, size_t *file_size,
> +			 enum kernel_read_file_id id)
>  {
>  	loff_t i_size, pos;
> -	size_t copied;
> +	ssize_t copied;
>  	void *allocated = NULL;
>  	bool whole_file;
>  	int ret;
> @@ -58,7 +58,7 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
>  		goto out;
>  	}
>  	/* The file is too big for sane activities. */
> -	if (i_size > INT_MAX) {
> +	if (i_size > SSIZE_MAX) {
>  		ret = -EFBIG;
>  		goto out;
>  	}
> @@ -124,12 +124,12 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
>  
> -int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> -			       size_t buf_size, size_t *file_size,
> -			       enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> +				   size_t buf_size, size_t *file_size,
> +				   enum kernel_read_file_id id)
>  {
>  	struct file *file;
> -	int ret;
> +	ssize_t ret;
>  
>  	if (!path || !*path)
>  		return -EINVAL;
> @@ -144,14 +144,14 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>  
> -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> -				      void **buf, size_t buf_size,
> -				      size_t *file_size,
> -				      enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> +					  void **buf, size_t buf_size,
> +					  size_t *file_size,
> +					  enum kernel_read_file_id id)
>  {
>  	struct file *file;
>  	struct path root;
> -	int ret;
> +	ssize_t ret;
>  
>  	if (!path || !*path)
>  		return -EINVAL;
> @@ -171,12 +171,12 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>  
> -int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> -			     size_t buf_size, size_t *file_size,
> -			     enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> +				 size_t buf_size, size_t *file_size,
> +				 enum kernel_read_file_id id)
>  {
>  	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> +	ssize_t ret = -EBADF;
>  
>  	if (!f.file || !(f.file->f_mode & FMODE_READ))
>  		goto out;
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 575ffa1031d3..90451e2e12bd 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -35,21 +35,21 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>  	return kernel_read_file_str[id];
>  }
>  
> -int kernel_read_file(struct file *file, loff_t offset,
> -		     void **buf, size_t buf_size,
> -		     size_t *file_size,
> -		     enum kernel_read_file_id id);
> -int kernel_read_file_from_path(const char *path, loff_t offset,
> -			       void **buf, size_t buf_size,
> -			       size_t *file_size,
> -			       enum kernel_read_file_id id);
> -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> -				      void **buf, size_t buf_size,
> -				      size_t *file_size,
> -				      enum kernel_read_file_id id);
> -int kernel_read_file_from_fd(int fd, loff_t offset,
> -			     void **buf, size_t buf_size,
> -			     size_t *file_size,
> -			     enum kernel_read_file_id id);
> +ssize_t kernel_read_file(struct file *file, loff_t offset,
> +			 void **buf, size_t buf_size,
> +			 size_t *file_size,
> +			 enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_path(const char *path, loff_t offset,
> +				   void **buf, size_t buf_size,
> +				   size_t *file_size,
> +				   enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> +					  void **buf, size_t buf_size,
> +					  size_t *file_size,
> +					  enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
> +				 void **buf, size_t buf_size,
> +				 size_t *file_size,
> +				 enum kernel_read_file_id id);
>  
>  #endif /* _LINUX_KERNEL_READ_FILE_H */
> diff --git a/include/linux/limits.h b/include/linux/limits.h
> index b568b9c30bbf..f6bcc9369010 100644
> --- a/include/linux/limits.h
> +++ b/include/linux/limits.h
> @@ -7,6 +7,7 @@
>  #include <vdso/limits.h>
>  
>  #define SIZE_MAX	(~(size_t)0)
> +#define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
>  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
>  
>  #define U8_MAX		((u8)~0U)
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
