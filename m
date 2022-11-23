Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34479C433FE
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOiJv+ofJthuj9U3kB7Gsv2e0Bd+o1ejTgMps3x71+k=; b=efUu4XA9oz5SUy
	lPIikAf+TXnOxxOCi7BHp99n4daJ3lFifrq7KNwdaA4f887TY+t5WKG8thPXrfy29+scdfMwIuvSc
	ZvC/6IeBgKSSb13asm956AxMq86PPdtykqpR2FfrEqu0l3CqlvkFAFrAaw/lesY9j6XNkAmukizPy
	xvmcvHrGQqI6G0oVdVmvQFPeGQqQjwzJrL3TcxQd1fTgCvWZTn5XkQJxXVORMqHi3+lxSZHdxBtrd
	tKYBNCf3A2GrlgMO055wuXO0x0Hd2FF5xshEQgx7kk64PDkf+EbJYmHSJVUoDS2ss9h/J6pKqVKJF
	j9CDoGSBrMWn5gHKiNHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxq8g-00HMhS-4H; Wed, 23 Nov 2022 13:50:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxq8d-00HMfJ-6s
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 13:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669211406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6zewKWTDgfvIFJXOy081wvDhtOx6ntJm4J8sIpATHc=;
	b=RgYAdVQa3HPNFyPAYqsbL9/cZqevJMz9/IJ97kj5g0rYWWQMlQDr+Po0gpiCTGj4fnjXMR
	UV+kyeVKcgaJ2sMGzNcSEgR46NI8edtHBpXmZ/Zttt5x8P42HglU12ZRvW+NBeC5eKre/B
	lTjHnO7t5l5T7idOo59TmTtTp/4D+H0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-CousNDlQNeqUYBc6rAHqyw-1; Wed, 23 Nov 2022 08:50:02 -0500
X-MC-Unique: CousNDlQNeqUYBc6rAHqyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC9943C0ED4D;
	Wed, 23 Nov 2022 13:50:01 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0646E2024CC8;
	Wed, 23 Nov 2022 13:49:59 +0000 (UTC)
Date: Wed, 23 Nov 2022 21:49:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <Y335zmhd0us0e7tD@MiWiFi-R3L-srv>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_055007_350620_D21BCF90 
X-CRM114-Status: GOOD (  27.17  )
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

On 11/14/22 at 02:18pm, Ricardo Ribalda wrote:
> Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
               ~ toggle
> attack surface to a system.
> 
> Without this toogle, an attacker can only reboot into a different kernel
  ~~s/without/with/
> if they can create a panic().

The log just tells what it's doing, but miss the most important why this
has to be needed, the motivation.

I roughly read the talking between you and Philipp, wondering why do you
believe panicked kernel, if you worry about the untrusted kernel kexec
rebooted into. People can change scripts in initramfs, e.g drop into
emergency shell and switch into rootfs, there are a lot of things people
can do in there too.

> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 97394bd9d065..25d019682d33 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -462,6 +462,17 @@ altered.
>  Generally used together with the `modules_disabled`_ sysctl.
>  
>  
> +kexec_reboot_disabled
> +=====================
> +
> +A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
> +This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
> +but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
> +Once true, kexec can no longer be used for reboot and the toggle
> +cannot be set back to false.
> +This toggle does not affect the use of kexec during a crash.
> +
> +
>  kptr_restrict
>  =============
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 41a686996aaa..15c3fad8918b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
>  extern int kexec_load_disabled;
> +extern int kexec_reboot_disabled;
>  
>  #ifndef kexec_flush_icache_page
>  #define kexec_flush_icache_page(page)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index cb8e6e6f983c..43063f803d81 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Check if the system admin has disabled kexec reboot. */
> +	if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
> +		return -EPERM;
> +
>  	/* Permit LSMs and IMA to fail the kexec */
>  	result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
>  	if (result < 0)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ca2743f9c634..fe82e2525705 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
>  int kexec_load_disabled;
> +int kexec_reboot_disabled;
>  #ifdef CONFIG_SYSCTL
>  static struct ctl_table kexec_core_sysctls[] = {
>  	{
> @@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "kexec_reboot_disabled",
> +		.data		= &kexec_reboot_disabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  	{ }
>  };
>  
> @@ -1138,7 +1149,7 @@ int kernel_kexec(void)
>  
>  	if (!kexec_trylock())
>  		return -EBUSY;
> -	if (!kexec_image) {
> +	if (!kexec_image || kexec_reboot_disabled) {
>  		error = -EINVAL;
>  		goto Unlock;
>  	}
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 45637511e0de..583fba6de5cb 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Check if the system admin has disabled kexec reboot. */
> +	if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
> +	    && kexec_reboot_disabled)
> +		return -EPERM;
> +
>  	/* Make sure we have a legal set of flags */
>  	if (flags != (flags & KEXEC_FILE_FLAGS))
>  		return -EINVAL;
> 
> -- 
> b4 0.11.0-dev-d93f8
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
