Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1EBCA0EE4
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgn81Tr+8hcjcnOTiZziRVmr22vaTnfczgkfFVMrPuA=; b=PwuKPmcn8WSOUuVREAlxNBYpIj
	zfO4cy2qgIDe5cSm1oGlKUL/Lu/rpAkSkLtChjYDuVG3gar/iIAWQphaNfuBV66TzqXMJgFgT3sTF
	CHVcoYIdpUIQGcZBViwfpn3cv0l3u1bofn+Ju4i9w/4s7HbtV/vAFKZNYm99vtuNXLi3e+wPDvcqu
	kAi3qzeJRoODA2oEUamF6Cx6FJ9uvfRhYGy4Iipv5uqI5x59jb8IQgDQ6ki0YcLnq39Y3SuslIsiM
	KR5jAnBdkpL1zKnsaJv8vQ+Bc8oWG7LHxRHYHfP2TN6qbBtHhkg+WoCxSqG/4s0/DqBvj1+pyvDkc
	SRXmb3bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYkv-0000000HCnx-2vR0;
	Thu, 14 Aug 2025 14:16:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV9i-0000000GaEL-1yNC
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 10:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755167156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgn81Tr+8hcjcnOTiZziRVmr22vaTnfczgkfFVMrPuA=;
	b=fgby6TzXFnIhsIkSds5pZ9KUPp6RKLb8FVz13+9jB2oJ0VF2xMIcCPSOoLvQQFXMP/yh3z
	Qu+iyR8L29C085jANB+lKjw7kTULiZEkn1HbUrbbGIloGp4MQWYw6YvHitXqrqiR/N4/jE
	YHnGuYS8lhmpfJ61hz1ML72BSon/Arg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-f8XJR9a3MA6XqxrxOu2w4w-1; Thu, 14 Aug 2025 06:25:53 -0400
X-MC-Unique: f8XJR9a3MA6XqxrxOu2w4w-1
X-Mimecast-MFC-AGG-ID: f8XJR9a3MA6XqxrxOu2w4w_1755167153
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109be41a1so32204591cf.2
        for <kexec@lists.infradead.org>; Thu, 14 Aug 2025 03:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167153; x=1755771953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgn81Tr+8hcjcnOTiZziRVmr22vaTnfczgkfFVMrPuA=;
        b=IC8IBoxhRaV5GUlbsjK3phC6JV7NB9vCU9ELIOdmnoPJ8lahuA8bYJfny7ny52feU+
         bwc3Zhv2NmhpIew4UxgkTWFR3p9mNkt5NquzmGLAa//pLlz5/sbCOgCBF2mKbb0CD/kk
         4ESavy75Fc/4KaePxvo+lLSLAzoKkU0Umofpl40SDwOX/uurMqFUGhlF7Nhc1jlXUjWm
         dh8C4nLPJs0hc6kAPPhjMpbUTOjHO1C9lPKQN+Ycx18w8F+XZiKFiIBLE3p5Lmo2dKon
         YvF2Ndva5SzU2s3sQK17RhSafxFjWAuyscN8kS4oAPoxcIjtQiZsslRUPu9/abLpWnpM
         h5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmagoKnCgBjIrbxuVrolBIzLjlHU5zmsX9EL11lkB5f6aKW85vaatmx70o8sBchXTAJCqceA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzH2bw+Zx/gQVPvzcSUPfapOh9T9OzLTHUG/EQPJE+typ4PIgVE
	L3xo7HehGKR4sZuAEyNq+Ften8QhF6VBPH4NYtRghEN4YaKso/VClfnI65Em6IQ5RvgkUbcPcg5
	9AwkRa+ig48LM3GkbcEfFvEZRq36XJGIsk6L71Hwu7+bQG5gYiZnSnrM4X1nOdp7JCugCEk7lon
	iPOks4nLJtWrxX6+CAajhJGyuTbQNwgvjx+n4U
X-Gm-Gg: ASbGncuBs0kEwDWFnanH0LS7X9pBLWZyTWYxqhhOyUbKRarUtRkPlIPiM9XuLHM9pz0
	IHtg5C5Dqhe2ACA5ufoyyeTHwX21s2XrtmBz4Hq9ft3+LbJ8vh2cz6ZYMjj0J90Nsxa0gz9qmYa
	ARo8izOkl7qdkB+30tTV3sKgaQIcXzLkS3jRkD4IxYdh6o+HGO4n/x
X-Received: by 2002:ac8:7e81:0:b0:4b1:dd3:e3a0 with SMTP id d75a77b69052e-4b10dd3eecfmr23734361cf.63.1755167152785;
        Thu, 14 Aug 2025 03:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj6Fqf8ZwqtpABxCnBRRgWEUtTuRorTGk78D6BUIRWpQRL0vtIDMWjft+v/pu6kMmSX/QebZM7wdmGQ8Fxz5E=
X-Received: by 2002:ac8:7e81:0:b0:4b1:dd3:e3a0 with SMTP id
 d75a77b69052e-4b10dd3eecfmr23733991cf.63.1755167152330; Thu, 14 Aug 2025
 03:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <20250814081339.3007358-1-safinaskar@zohomail.com>
In-Reply-To: <20250814081339.3007358-1-safinaskar@zohomail.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Thu, 14 Aug 2025 18:25:41 +0800
X-Gm-Features: Ac12FXxDAq6OF9fc6qDx2bbELbCoeU3NGz_x-43ufP_dIt47GGsYNY84NXPWPG0
Message-ID: <CAPmSd0OpjE7-kKtW08LthJXsdMi4YNEfdrKiLjmHYtHuQ+CCkg@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Askar Safin <safinaskar@zohomail.com>
Cc: brauner@kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, rob@landley.net, viro@zeniv.linux.org.uk, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, initramfs@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ufV5CnEnaOPx_tixIT4i9K3CeKrf7SiLEpBHYaP6lpc_1755167153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_032558_624760_51595BB4 
X-CRM114-Status: GOOD (  37.09  )
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

On Thu, Aug 14, 2025 at 4:15=E2=80=AFPM Askar Safin <safinaskar@zohomail.co=
m> wrote:
>
> Lichen Liu <lichliu@redhat.com>:
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > This patch introduces a new kernel command-line parameter, rootfsflags,
> > which allows passing specific mount options directly to the rootfs when
> > it is first mounted. This gives users control over the rootfs behavior.
> >
> > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow t=
he
> > tmpfs to use up to 75% of the available memory. This can significantly
> > reduce the memory pressure for kdump.
> >
> > Consider a practical example:
> >
> > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> > the default 50% limit, this requires a memory pool of 96MB to be
> > available for the tmpfs mount. The total memory requirement is therefor=
e
> > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacke=
d
> > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> >
> > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48M=
B
> > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> > smaller crashkernel size, such as 192MB.
> >
> > An alternative approach of reusing the existing rootflags parameter was
> > considered. However, a new, dedicated rootfsflags parameter was chosen
> > to avoid altering the current behavior of rootflags (which applies to
> > the final root filesystem) and to prevent any potential regressions.
> >
> > This approach is inspired by prior discussions and patches on the topic=
.
> > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > Ref: https://landley.net/notes-2015.html#01-01-2015
> > Ref: https://lkml.org/lkml/2021/6/29/783
> > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-in=
itramfs.html#what-is-rootfs
> >
> > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > ---
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index ddfd4457d338..a450db31613e 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> >  }
> >  __setup("mphash_entries=3D", set_mphash_entries);
> >
> > +static char * __initdata rootfs_flags;
> > +static int __init rootfs_flags_setup(char *str)
> > +{
> > +     rootfs_flags =3D str;
> > +     return 1;
> > +}
> > +
> > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> >       struct mnt_namespace *ns;
> >       struct path root;
> >
> > -     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
> >       if (IS_ERR(mnt))
> >               panic("Can't create rootfs");
> >
> > --
> > 2.50.1
>
> Thank you for this patch!
>
> I suggest periodically check linux-next to see whether the patch got ther=
e.
>
> If it was not applied in resonable time, then resend it.
> But this time, please, clearly specify tree, which should accept it.
> I think the most apropriate tree is VFS tree here.
> So, when resending please add linux-fsdevel@vger.kernel.org to CC and say=
 in first paragraph
> in your mail that the patch is for VFS tree.
Thank You!

I checked the linux-next and it was not applied now. I will resend
this patch and CC linux-fsdevel@vger.kernel.org.

>
> --
> Askar Safin
>


