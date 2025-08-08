Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C29EC87FCA
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 02:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWO28gwYTWogzlWdvgUUvwXPL9Mg4aE3AHHmYyG+EaY=; b=i1m6e3gFj9vwS91ZuIxUB/ewZu
	j/knZ0fb+hcblwKIEp9ceVjbd+yg+lvYyHt3C3drQH6OJ8Yyj+mwmPq9VMOW285cM+neXOPyz46Ql
	Xs00xe0LyuDkUa/xk9nElzVlPv+lmF9ngVq1DmLq62xgesmM/zFmM2cYj6AKhPDi3DGd5l40WVpcY
	Kv6MTXA3OBZubbkoOeC8Qo/cYs+qdE/nHOuvjbvWlS6boy0EqSWC0c5zwF/1Nz+PasFcYoF4jUKvs
	flQ//o1+tS2V8JckC4figX1Rx3oiXey4fjH/Je+Ot5erIZEkz/LhoL2p1G0zXwdTVUEK6vB2m9auT
	pQBtm81A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukCrO-00000001rRU-1T1n;
	Fri, 08 Aug 2025 02:29:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukCrL-00000001rR2-33cV
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 02:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754620169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWO28gwYTWogzlWdvgUUvwXPL9Mg4aE3AHHmYyG+EaY=;
	b=TNzr7ZYCcJUsDquH8QGZTXs2U/zUkQAKOLjgpnWWMPo/dnfzs+DUgj2oCN1Mt6DK0IJjtN
	syD4VUykhlSQfpTMtG2Mbg1PsJ+axEirfBNg13+ejiI/StzOQg0nbO3+kpkJdhCtlaQYqI
	qHVe/n4p3+Cap6Ii1IySSgxvdP2z3nY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-BRputKKhMhuGtQljkksb-Q-1; Thu, 07 Aug 2025 22:29:27 -0400
X-MC-Unique: BRputKKhMhuGtQljkksb-Q-1
X-Mimecast-MFC-AGG-ID: BRputKKhMhuGtQljkksb-Q_1754620166
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55ba198c6f6so1465435e87.2
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 19:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754620165; x=1755224965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWO28gwYTWogzlWdvgUUvwXPL9Mg4aE3AHHmYyG+EaY=;
        b=wW7OEhaU3+jpg9Aof76w7vGczFX2ScIROrtelJloXFB/peIAsrtupjYg//Zb4aTtkp
         c/c6LY3J1kTLHaCxBERfqsmeTq+2ki+3k3qV84nSlXS0ZM1QfvhFOlmXSVZ67v228VfC
         AumgCbJFM9SRCPH09QqhexjpQw7usush8cm4iFuIISrsgv9G9Svv0Ys4aFPnF/A59o26
         SF99XF24uZCLJsrxk4iwUflWghxHk4xIsf/veCmj/lp8pgOR35A464Tkh6dG0ZlTZJEP
         d1lVJu+wboSlgDrLPKxjtJhW4pDiO9K0tNvnr82q8j//MRjsnkV7nFqnxj5NHGEGSuzG
         uuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyxms+ZMcTiK1HKf7iCnbajsBZx+BKLq6fyA4gjBLzgwEJaqMV2Tqj6/re0MFcnB/27JuTVQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyrsb0yS/YgHu27Q5sXLJHgSCJi9rqSA2aEJWmapm/dyTn7L5oo
	IdSoubkLVCp5l7Ab9bT31V67bgKlfaDj5qZZgRauHhC2o8RlUwT0gc+AXLTlMPQxByE6PRIWRJf
	IeQpADdVZn3mZURNdLqi9GyqUpJBSc85wtxljlEMQQH4cqBafnu4e4baWXMYFCBok84yheqzMjD
	x8t4ylvwvrk0YnzEW2PlAXEL6tXX7r+dWCi53h1syL92Gff90=
X-Gm-Gg: ASbGncvntJDhrnNIiQvMPswR3p5TjJZAuZEbwHtR6mpERmjDmGia/kvSCBzwDXgZKGw
	jdvqgglYvLP26BVGPUbP6R0pTjmdAM8j5t5fYfqkTU6eey+TcsqE84ecEIgLP97Rjj/JBL7k9oe
	d4Ob8PnbZqpoprzgfRIP8YLw==
X-Received: by 2002:a05:6512:4006:b0:55b:760d:c2e6 with SMTP id 2adb3069b0e04-55cc00adef4mr235697e87.2.1754620164780;
        Thu, 07 Aug 2025 19:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4XzQf169HOvBGe6tunaXtqLl6ZIzU+U8mV7ZNhc0nlOI9xBKSORZ4O8H7NJfMJv+z5oSK4BFm1Hcr0DNYFA8=
X-Received: by 2002:a05:6512:4006:b0:55b:760d:c2e6 with SMTP id
 2adb3069b0e04-55cc00adef4mr235680e87.2.1754620164280; Thu, 07 Aug 2025
 19:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com>
In-Reply-To: <20250808015134.2875430-2-lichliu@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 8 Aug 2025 10:30:04 +0800
X-Gm-Features: Ac12FXzXPcQuckbFIXVF4do131vQN15Llc9s99Q_ea3julL0PWC3EGzx9j_wJRQ
Message-ID: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zmjeZNOM81eI6HfCyRtTm0xjgfLAFxbI9P5H3kX1N5E_1754620166
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_192931_844487_6E439AE6 
X-CRM114-Status: GOOD (  31.48  )
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

Hi Lichen,

On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
>
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
>
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
>
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.
>
> For example, a user can now specify rootfsflags=3Dsize=3D75% to allow the
> tmpfs to use up to 75% of the available memory. This can significantly
> reduce the memory pressure for kdump.
>
> Consider a practical example:
>
> To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> the default 50% limit, this requires a memory pool of 96MB to be
> available for the tmpfs mount. The total memory requirement is therefore
> approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
> kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
>
> By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48MB
> tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> smaller crashkernel size, such as 192MB.
>
> An alternative approach of reusing the existing rootflags parameter was
> considered. However, a new, dedicated rootfsflags parameter was chosen
> to avoid altering the current behavior of rootflags (which applies to
> the final root filesystem) and to prevent any potential regressions.
>
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-init=
ramfs.html#what-is-rootfs
>
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> ---
>  fs/namespace.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..a450db31613e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
>  }
>  __setup("mphash_entries=3D", set_mphash_entries);
>
> +static char * __initdata rootfs_flags;
> +static int __init rootfs_flags_setup(char *str)
> +{
> +       rootfs_flags =3D str;

I do see there are a few similar usages in init/do_mounts.c, probably
it is old stuff and it just works.  But I think making rootfs_flags as
an array and copying str into it is the right way.

> +       return 1;
> +}
> +
> +__setup("rootfsflags=3D", rootfs_flags_setup);
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
>         struct mnt_namespace *ns;
>         struct path root;
>
> -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
>         if (IS_ERR(mnt))
>                 panic("Can't create rootfs");
>
> --
> 2.50.1
>
>
Thanks
Dave


