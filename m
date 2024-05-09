Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670CBC10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 06:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akU92prjjCHN8AXZwLwIIZsCf9ECpOIAyrA4T4QVwCQ=; b=x1Y4NkrOIFeqJI
	3SfDYw1mr7R7feymr1UExxu+ME16z7z9KRo1Vw+DTkppRvSBdxMeDUkac6+BigmK+aD41XKCkvzUR
	s7DlcY5kV2VERJEENuEcCiwB/sySm2RN4q58b0jF4E/S8ry2iu6yHY/H5scxV1bgqF4PrBGpltMqE
	4CYl9kMGqlFXQENOzi108g7EVSVwktxlHi1HXY4n3lOcnlvSNxmUAR+AIt5FB78hiSbXSzgFwLy5N
	nlspEM77Hzd7IzmrE/rgpnt4V07LF0Qt9QudI7fIhpHVWZld106mUoQcBWzz04RUYg57AOxIYN3pT
	8Mj/KWHM7/9iQcMTvVDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4xKB-00000000Zrs-20x3;
	Thu, 09 May 2024 06:32:15 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4xK8-00000000ZqZ-0rSh
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 06:32:14 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 954C91C3C9C;
	Thu,  9 May 2024 08:32:06 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715236326; bh=efG3zK0vKcyGk9qTSSHOK3oDZCuzuyL7s8iDujt9W14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fsiaFvaeIO1yoIVjC02r2h5+4oCgd528m2/Elrx/HYZ37kkBOwxe0mkftqoNlyOaT
	 lsdmomHOLQHvZPX0gS+mlnbBqBcOMAkgplAa0ZpF9fymben+E8wq8i8XAKuWf/NVtm
	 iyPftgTGY4b1FGSCb78qp+lgSjFUXL5fb2VyL/iJrSVDG1GUB1DAIhIWCVVgwvTC14
	 BbYekJIBPMIxBQod5+lcYEk7HH0rbp4UOQuXYKJx9QNAIwC81r+2ktNqLRWD0XO9Ow
	 9uLheolhMl40dFK2v6KrpGhtsvE71/9tSHuNIMVL3oiQL36ISC9mbwaAFbbKJqaIjI
	 Gjysq3ffjrYPg==
Date: Thu, 9 May 2024 08:32:05 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: Re: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <20240509083205.17d53ccb@meshulam.tesarici.cz>
In-Reply-To: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	<20240214153827.1087657-6-tusharsu@linux.microsoft.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_233212_590745_02C00533 
X-CRM114-Status: GOOD (  22.84  )
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

On Wed, 14 Feb 2024 07:38:24 -0800
Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:

> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs
> to be called during kexec 'execute'.
> 
> This patch includes the following changes:
>  - Call kimage_file_post_load() from kexec_file_load() syscall only for
>    kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>    map the IMA segment, and register reboot notifier for the function
>    ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>    reboot.
>  - Make kexec_segment_size variable local static to the file, for it to be
>    accessible both during kexec 'load' and 'execute'.
>  - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>    to ima_update_kexec_buffer().
>  - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>    that the buffer is being copied at kexec 'execute', and resetting the
>    file at kexec 'load' will corrupt the buffer.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  kernel/kexec_file.c                |  3 ++
>  security/integrity/ima/ima_kexec.c | 45 +++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index fe59cb7c179d..2d5df320c34f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);
> +
>  	ret = machine_kexec_post_load(image);
>  	if (ret)
>  		goto out;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 1d4d6c122d82..98fc9b9782a2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_IMA_KEXEC
>  static struct seq_file ima_kexec_file;
>  static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>  static bool ima_kexec_update_registered;
>  
>  static void ima_reset_kexec_file(struct seq_file *sf)
> @@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>  	int ret;
>  
>  	/*
> @@ -154,14 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> -		       __func__, ret);
> -		return;
> -	}
> -

After removing these lines...

>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
                     ^^^^^^^^^^^^^^^^^

... kexec_buffer_size is uninitialized here.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
