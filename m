Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF4C4345F
	for <kexec@archiver.kernel.org>; Fri, 12 Apr 2024 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pN/EQBzI9tTsrgnwSGvwZsh5VKx43ZsmxL7XZMPF82k=; b=TcFWXeNiLveQD+
	2QaFoBxKkFFapi6ZdAJuLGYPdfYQifiZsscZM7K6dXiLeRSIfhxGKFZSvH3A3xiwPfy8oA7VZD4Pl
	dqtH5egTc9i2m1DHSJb1yAo8shPIbgk6t5OVYmCC6vaFgdxGzhnDtpWtjIFtFSHYdxC2htexw7Y9+
	jxDBIShxjjh2SvNuOS2QqJ/KsFvIGR2zoKFPtRSCfKFQ/74N8IJGo5+ai3RkfObIf0PpZU06f+O//
	QrrNQh80ONavu0AePmH8LtgID2+SNMlBJHfEXtqBo0GtA9U9UZii2lxy7x1d94BNzQ0pIe8T/jcYU
	k2VHZUuWxhm83xBD5zYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBLB-0000000FqTJ-1obi;
	Fri, 12 Apr 2024 07:28:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBL7-0000000FqQ5-01el
	for kexec@lists.infradead.org;
	Fri, 12 Apr 2024 07:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712906920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4v5L9yYqFT1nF+Gr2M5J9sdYztg1g6ZV5At3HsBWFs=;
	b=AKck9iXBR9QfA18Wx5IUx2EavJlQaiRJsPwf7sC+hCzRixJIliKHZCC/rglJftkoO8VkfM
	Kk1RLKdoO1etShEJrqN/cHpIZnouakU2/s+p2+EwZFjrlCI807yU52BU7VY9ZUuj0THF00
	D2QjymPiHfnQn7McbmMovzS1rVqLLgU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-CqIZsMnGO9eRk6PA7dYTlA-1; Fri, 12 Apr 2024 03:28:38 -0400
X-MC-Unique: CqIZsMnGO9eRk6PA7dYTlA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-366b2ee3b5bso756425ab.1
        for <kexec@lists.infradead.org>; Fri, 12 Apr 2024 00:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906918; x=1713511718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4v5L9yYqFT1nF+Gr2M5J9sdYztg1g6ZV5At3HsBWFs=;
        b=ltTgf8fokLHgGpBo48BoQQYmWWN+3ExgIuevDfFsA5UuMmushdZ0ObP9yLKGalSpzc
         tWGRsaV0G6V6tn5jqSaFG9wYCAz/pEydyiyS2rfpfgbjqsPY0LssMjgpi+aLwbPCLdKo
         18DaximvBx9ZvYFZP7jBaHaQrUepLSgrZKDawKYPjY/DCtU3hsUdLrkAnmT01DCc9Cmm
         gPCLdgjRmmKfWNid6PuVtMg53LWj1p4tOGPwH5lZfo7/4awNPUf5sEaA34dxLb2SsqWe
         Xh3z07eC9mlhJk4cFaH6UdxhJhrekwWiMP4jyf/liRk2Q462wwn+0aCEXjd6MYVg/Gfe
         MOSQ==
X-Gm-Message-State: AOJu0YzziUUrWQm5pChooxT/gptrVIqwGG/UBW9SGOlU+f/rruxOqUTn
	4YoxD2XIAWI0WfUlYjguUYjKoQ4xwxS9KOncY04NCQ+aUwE7DCiff+XBa7VpPWu0H62QtZr/WfI
	eRytF9rG/IUAb18flz5ugBayJGHeIrHud1GUdMtCXAoq6bwgEz5i+AXXlMV6ZgA9XWwocC/zzX5
	w9Yc+f5X9mbcErzc6qNhBD2MyLDMzfMeZb
X-Received: by 2002:a05:6e02:1fec:b0:36a:2d25:3d82 with SMTP id dt12-20020a056e021fec00b0036a2d253d82mr2093924ilb.0.1712906918156;
        Fri, 12 Apr 2024 00:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3mtFwkDAWvZL9WB+G3Djd0/EsxG1ujbtd6oa5q2SV7swKwH/GPa7ti3VumMBkbl/CHIdLMcmIEoUhu5lxNy8=
X-Received: by 2002:a05:6e02:1fec:b0:36a:2d25:3d82 with SMTP id
 dt12-20020a056e021fec00b0036a2d253d82mr2093917ilb.0.1712906917899; Fri, 12
 Apr 2024 00:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240409042238.1240462-1-bhe@redhat.com>
In-Reply-To: <20240409042238.1240462-1-bhe@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 12 Apr 2024 15:28:53 +0800
Message-ID: <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, jirislaby@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_002849_210270_0DC85EB9 
X-CRM114-Status: GOOD (  22.94  )
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

On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
>
> Jiri reported that the current kexec_dprintk() always prints out
> debugging message whenever kexec/kdmmp loading is triggered. That is
> not wanted. The debugging message is supposed to be printed out when
> 'kexec -s -d' is specified for kexec/kdump loading.
>
> After investigating, the reason is the current kexec_dprintk() takes
> printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> specified. However, distros usually have defaulg log level like below:
>
>  [~]# cat /proc/sys/kernel/printk
>  7       4      1       7
>
> So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> not.
>
> Fix it by changing to use pr_info() instead which are expected to work.

Could you also update the kernel/crash_core.c and
kernel/crash_reserve.c to include the filename prefix?
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Otherwise:
Reviewed-by: Dave Young <dyoung@redhat.com>

>
> Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> ---
> v1->v2:
> - Change to use pr_info() only when "kexec -s -d" is specified. With
>   this change, those debugging message for "kexec -c -d" of kexec_load
>   will be missed. We'll see if we need add them for kexec_load too, if
>   someone explicitly requests it.
>
>  include/linux/kexec.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 060835bb82d5..f31bd304df45 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>
>  extern bool kexec_file_dbg_print;
>
> -#define kexec_dprintk(fmt, ...)                                        \
> -       printk("%s" fmt,                                        \
> -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> -              ##__VA_ARGS__)
> +#define kexec_dprintk(fmt, arg...) \
> +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
> --
> 2.41.0
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
