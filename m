Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB5ECA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=; b=F5m4PLAGasTSJntW0eCfhajLca
	xBWp3vjb4po5GYufHZbPsbFThZj51ymdFzZIKvLZt9oMLglcGyYGpfpYJZg73/3052vB2iG5Vy8M4
	ldrA+AQZ2NDaSL1BA0s5Wyjg61SiN4eYCP6VydrSD9fCD4jhwCAAQ83aG3uB1MsZgweg3Ix09BS3T
	UJ+F4GI95V8gp2aKntSlBl7U0orjlC6xGvnGqpJr4j8FdbQNqE+7i5mv+aavISCSC6vus+JTbyzsc
	EBoqSGQBCPmOedcAlG2epRL06tsQtFR5MGvP0MuxH1sYtfwdPNDwMb18vrvEZivsmPRC5Z5RkgL8K
	sZ+sa/mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uonvG-0000000EiNd-2lV2;
	Wed, 20 Aug 2025 18:52:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uokZE-0000000EDzA-1MaF
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 15:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755703054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
	b=XPnjKtZACGjNqU2LY+VCKreoDDF6wSndHvqXVaBNUco1cSqLuhAF44oScNKH6ehZ3UHI8f
	fDb0sKziN9t3UqSJsK4QWRYkzKnzqQpwmRafUTlE/ElSOgkVtgb0ie3QvMu1pHJBhWpbD7
	LymjE4/RftnBue+nAE/7iSPsOdWRr4g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ibedCRRSNzGyqZY3Ju9slg-1; Wed, 20 Aug 2025 11:17:32 -0400
X-MC-Unique: ibedCRRSNzGyqZY3Ju9slg-1
X-Mimecast-MFC-AGG-ID: ibedCRRSNzGyqZY3Ju9slg_1755703052
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2955f64b1so302751cf.1
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703052; x=1756307852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
        b=hL49kijQlIk2V63tYDiQpKvOT/o0lg229a6qgyUcWxv0LPfKJKpLIPcwo7E/e5SxA8
         hvLAbqWn140ajzB2J19j+uyaPu6rwmzthJUsJ9KWrmtGPD7JUxmBXT0NwZPcry6iNGOj
         Hy9NREMp6o/y4IpxIGzV2q3QkJnUno+MzKOatrnVlRJFvPDCbY1NAoBFgZgelKtNas1e
         6MryciF9JLr3ezNIpzuUTD2+Cc9g9SSXy+cO+mPkNajs89dID3lWPSbql5tjG+HsBeBz
         2cGdvMJpRRVqlwlfZS9VjITq1BtVydvsQtyQfXF7J4LcCIsAEMlNfUacoe1jvEbBfOI0
         2Uog==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ1KPYuMkIi1GX5YfV1/bHyBrD+71P9XbVwbKPyjlgZJrdfB9Fi/91acfAob77oigGtPWSw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyiNoHvHuSZ61PUnSbQ7joYPgLRq9Ez2FszR+X+HrlixxpU09wP
	CzEm0oiMSQO+2oS4xCgHUsE1K0g6sYBDeejU+bTnG+Lg/RFcstZpXi1bgduf8doX1N/O7w2aqwS
	c/fO7UtzI3XSD0PIBbfXSfMmj4NW2RYkRFuzgZ7F+2FQTDhvp8QkGKrYvrjo4H8iIqEKHgZ3POb
	yQNUw7YQhMyqPCprOm8LyPuuaG9LX58V+07ad/
X-Gm-Gg: ASbGncviGatvqf/bR/sPb9rtxuOmoWYFPa86FUfWbUW+Xp+/LzhM25A/UY6YOHN50dN
	XQAyBbjIczBi79F8OObPV6Y7JB5c5dmWXKgvG5nb4brHIS4BO+ShXBMJe96PlI2usl8e2rNOewU
	AoPFrsvc3BQDzLuBrfjWz5rcMeRaBZdOWuY99Cz2nAB7Ak5/v4uDeI
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id d75a77b69052e-4b291a45948mr38268781cf.3.1755703051777;
        Wed, 20 Aug 2025 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNNXQPsAlJCg5PdYpqbUQjKk2La90rXTiB/Xg+AFCp6PDdl0eXQ9VodkzneYLfMLO6npPB65IGBnQ/QO7tyQ=
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id
 d75a77b69052e-4b291a45948mr38268261cf.3.1755703051224; Wed, 20 Aug 2025
 08:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250815121459.3391223-1-lichliu@redhat.com>
In-Reply-To: <20250815121459.3391223-1-lichliu@redhat.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Wed, 20 Aug 2025 23:17:20 +0800
X-Gm-Features: Ac12FXz5J-qsSNe_dCy4Is9oFh6XR_1xsHJhV6_kkHN0LaUVbdz8uoGPSmN-wtU
Message-ID: <CAPmSd0OHB3orya=3V1icz4ZzOoAwHuWTqON_Dk+EaEcACtVtbg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aolDiLffAX_gvfc92oPlMIq0CGahdCa1OaMFgXo11ro_1755703052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_081736_439044_1957C8A8 
X-CRM114-Status: GOOD (  33.57  )
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

Hi all, do you have any comments for this v2 patch?

Thanks,
Lichen

On Fri, Aug 15, 2025 at 8:15=E2=80=AFPM Lichen Liu <lichliu@redhat.com> wro=
te:
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
> Also add documentation for the new kernel parameter "rootfsflags"
>
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-init=
ramfs.html#what-is-rootfs
>
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> Tested-by: Rob Landley <rob@landley.net>
> ---
> Changes in v2:
>   - Add documentation for the new kernel parameter.
>
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  fs/namespace.c                                  | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..0c00f651d431 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6220,6 +6220,9 @@
>
>         rootflags=3D      [KNL] Set root filesystem mount option string
>
> +       rootfsflags=3D    [KNL] Set initial root filesystem mount option =
string
> +                       (e.g. tmpfs for initramfs)
> +
>         rootfstype=3D     [KNL] Set root filesystem type
>
>         rootwait        [KNL] Wait (indefinitely) for root device to show=
 up.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8f1000f9f3df..e484c26d5e3f 100644
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
> +       return 1;
> +}
> +
> +__setup("rootfsflags=3D", rootfs_flags_setup);
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
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
> 2.47.0
>


