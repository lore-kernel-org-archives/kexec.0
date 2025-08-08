Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30FFC87FCA
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 02:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmALfAD79Sc2v/slqMGPnz9hxOoyvuPzjTOCA6rHq8s=; b=dW9qe00VkwHXzYTd3pgmISiKEA
	uygtMCaDmyQoIviZNKIhXIPNH5TVSYocV/T7f+3LrCYblQxyewHaHc+NBQDiH0k7jmGJCtOoFyQYp
	Dwgn1UTUMKGByZNtpLJ8fdx9liJ5cXYIB0q2USv7LHX5B69d9o3k+kWlYZIVem1FDjI15M6JzjAj4
	cFb+Wlyo67BX6gQiu6L4kps/K7iSiBzgMmqXhVncPyMhM2PX9Id29MYwm6w9xc/RFWvdTx1fYu7bA
	woSv0vtFae6jVOXe01UWRI8UuAOtLBJ2bIgW5d0RdBY7s13c1Uov5YIr2O3VsvdLu3fHFgv5sESPI
	UkyK8mYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukD7v-00000001sEs-1wfI;
	Fri, 08 Aug 2025 02:46:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukD7s-00000001sEP-0q9o
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 02:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754621195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmALfAD79Sc2v/slqMGPnz9hxOoyvuPzjTOCA6rHq8s=;
	b=U6va1lrQ8k1jv/i2cjlh79w8/sBR2pELmeagpK1buEE8i7whJqZGrEbNUI9rqdOVyLy8bQ
	Rn+ZjZAwkVogUoZWfCoW8UYMs60yr+7NrdZI42Vz6HSaAhNFS1wBGtILFhGGIAEbWgPPVJ
	NCr84QqZKKPMjaQ2qFPSoo40gEAa/fQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-lSiWamB-OzqfLHviuapndg-1; Thu, 07 Aug 2025 22:46:31 -0400
X-MC-Unique: lSiWamB-OzqfLHviuapndg-1
X-Mimecast-MFC-AGG-ID: lSiWamB-OzqfLHviuapndg_1754621190
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55b80e7e672so917063e87.2
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 19:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754621190; x=1755225990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmALfAD79Sc2v/slqMGPnz9hxOoyvuPzjTOCA6rHq8s=;
        b=hkVxqX8gkRD5Tacmc9ZIZkKdklzwQf3HcdtFBOHWVkP+CIb7klDGBAw7h4DnnI2n+F
         afomKwSEScxLk4sS/70w8DPP/zo+dsNpwhVf+94rkCQvJzu+0enEswSlkgu1VqxctrV2
         ZTO89I2fnJ2KKaKBfA4wNcV/wnbdkKBjFW6BEVIgVy1+D9eOfw0HD8PdxY9p/XxaoEop
         oDEXK53sP01EDwKRB9Zi4/yNEfmX4SQE5kQE/AVwOkXFg3qD53DvC+VbnWZ9grzXyRDd
         M0b6p8KTlhT81ZHqWJrTN9FQZajqNDTsTXdCe4lVDYp4m42SBA7yTLYQA3iOdyqP5zZo
         pfNw==
X-Forwarded-Encrypted: i=1; AJvYcCVsZFr07rwxhp281Et54AtA1tOp/b4j62GlNQFVIxDL4RAdN1siLjaIK3yo28SiGasnwfShQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzCmrwIp/DdSh5scIYIel2B0ovgKrhknRYUMh0Y8nsYMw4PFyp
	jPsqj7fk+yzIlwbkExTuKgaU1wpOSX44ECARGZ/qEX3kE+LuCGnFmStvjm7g6LODXyAyVSQASV0
	vBEVphaDzhVuL8cn0a5M9w2bnCx+sSyExQwip/7MVPKzv7KzG6AfiDBNTvCp7gVPkLTnrVn4ySH
	5f/YLAw+vlZ3LHxCyu5HhI3ViQGuW4LBxa8J+J
X-Gm-Gg: ASbGncvhQTgmhq7WFWmzM83xtcz/POaRNiumHIUST9o/PM4WOHSruKC/K6YxDfeFqhG
	TX10W4/5RRYYL+YYTFF5iHW0z61nzh4XjmsjSQmozpa2Tz0ClhnuuTtkFSMe2CKRRPpU6AbcDWT
	D/tvBKS+wRVpoRJtmeuhsMMw==
X-Received: by 2002:a05:6512:3996:b0:55b:7e31:c13f with SMTP id 2adb3069b0e04-55cc00b7471mr216425e87.19.1754621189643;
        Thu, 07 Aug 2025 19:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPl9MPWvi4vw2YfJW296tcWJT8TkRErAZcJZQzg9MhhbuF/GdVGhnXuvrRQn6Mbz1APgoTDbYgXvUw4Gf6gGU=
X-Received: by 2002:a05:6512:3996:b0:55b:7e31:c13f with SMTP id
 2adb3069b0e04-55cc00b7471mr216410e87.19.1754621189089; Thu, 07 Aug 2025
 19:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
In-Reply-To: <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 8 Aug 2025 10:47:09 +0800
X-Gm-Features: Ac12FXwMHdYPLNUSBIVRDOIQo0wLGhwEoVcSzCO_3Te7legG5opEYpuIRQTyYUM
Message-ID: <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pkDXOwgPhYNXA8Yyv0d1yCCxugpjPAJH6SLwz7PX-Cs_1754621190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_194636_314639_EA8BAA37 
X-CRM114-Status: GOOD (  37.14  )
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

On Fri, 8 Aug 2025 at 10:30, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Lichen,
>
> On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
> >
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
> > +       rootfs_flags =3D str;
>
> I do see there are a few similar usages in init/do_mounts.c, probably
> it is old stuff and it just works.  But I think making rootfs_flags as
> an array and copying str into it is the right way.

Another question, may need fs people to clarify.  If the mount is
tmpfs and it is also rootfs,  could it use 100% of the memory by
default, and then no need for an extra param?    I feel that there is
no point to reserve memory if it is a fully memory based file system.

>
> > +       return 1;
> > +}
> > +
> > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> >         struct mnt_namespace *ns;
> >         struct path root;
> >
> > -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_fla=
gs);
> >         if (IS_ERR(mnt))
> >                 panic("Can't create rootfs");
> >
> > --
> > 2.50.1
> >
> >
> Thanks
> Dave


