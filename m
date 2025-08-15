Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0933ECA0EE4
	for <kexec@archiver.kernel.org>; Fri, 15 Aug 2025 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=; b=hGyqOkHPhzwRtHiuMDJJXnIPmu
	wvaHUQcoqtZaX2IbmTdcfEMb1zUTqdqQutVFZmZLYUR/ps48yeIZ7obQXy05nIEn0VoA4hrb6IWiE
	A8rXuohBiBClKkBQmStKwjLOKYu6wNX1PIwMQoSj/5RID4XFaJc8d18YC7IP4bD2ZWlzP8QkqAKRR
	7cpN/lx/JB3b/DLGn7Q7lqp7Pf1fzAQ3XBWYE4dMxuGqZ4/gnll12eCRKMRKIZ2D+6SqcoYhBFlty
	JcqVPjpDKPbTpF16HOBUM4K3pWuJGZd8FQTHBPlri90jBIhQxkU741o4miGyvhwqkpjR5oNBgpHVV
	yHzwf6Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umvfD-00000002kuh-0Puw;
	Fri, 15 Aug 2025 14:44:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umtIc-00000002R6x-1R6f
	for kexec@lists.infradead.org;
	Fri, 15 Aug 2025 12:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755259964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
	b=dQfMBfhisKj3knLfJS7nlEInfOt0FMJIlr8aD/rLA8xQdkrX24SzK6VZ4vhKDhUqhj5uGx
	kXYs/UFGvlehQz95bTTdp2sW5EdqXoHh0mZBAV4a+f2qC8N2lQajK83gdSlYvE/sjP+Up9
	EXoEpRq8iqTfJjfrE9WdylD/XIMHQHo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-SPcslDqKOIm9GT8YznKqAA-1; Fri, 15 Aug 2025 08:12:43 -0400
X-MC-Unique: SPcslDqKOIm9GT8YznKqAA-1
X-Mimecast-MFC-AGG-ID: SPcslDqKOIm9GT8YznKqAA_1755259961
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c382aaso56099061cf.3
        for <kexec@lists.infradead.org>; Fri, 15 Aug 2025 05:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259961; x=1755864761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
        b=phelfkcmMLxkMfpNy2OL+WlYKdK2VtkqEXfxTwf+8ZhLKAlVK5bvZFMswPvkL++UfG
         7RGS/vh/nrXikXSkdr5w9ocbCxDYAQYAj1NlgSdmkj+jxotCyhDL+PbhhhxSIiAdoXs5
         xFt/18zxYJo7sOr9xLMVcUl2biM5d/z3erwT+CPUCYAhopXiOf7YJwRQd6eZJY/lBjzB
         1TpxMm+2rEyJ2YVvzGvp+FYChipLItWHH6P6uqD7+JoiRr3pF5Tbo8FXe5WQlnqg70Mp
         UYedgYDYGlHTZHCUz0WGTCuyXP5nMAsy28ImDGjXQlZxOTjPrFsFj2wVDNimiw6oNLOn
         FJpA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvAAXqT8rACVDxqESrfY/0bmpySh9TWd1bu3yvR4W5xxY+xmVopn+OweLezPKHabTN0w8zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwkyCfWmRLyL1TIRSVGf9NUG0sU8Ei1umUlOAuniPLFQRyWf/5
	7WQIO0wUdeNwPFuQZkx5YqUBEQ9tYYYy5P9ixAr8xfbU4LLRF922ZwNrDSp9l1sKAOT/R91xNPd
	b0rN3ot+PW3UGWWlpbpr9OjyQIdH4ceZRuc5G1r9E7/Myo7+EyRABFUCVhUA7r8wh0Io1oPUlg3
	TwboPsHPBH7o9I1ZUUIqjVlZAOftLeKWz7THft
X-Gm-Gg: ASbGncsZpyp/Ws3q44kM32ihm6x6vf3ROnYHdJhIu+OTi/QOE898UWzdTPopdLebWvp
	4sv8L0hsXnLy1D7ujEH+LzUDHtER8cPzy9/toluNNuEQQxeQKrDrrORiRkqQ8aeQTNUcz8Q+GYV
	fl5uLYAYoszIYCgKGtpg8Hl4NiJJZKHdlWgl+0zvCFgwFcOAQzfjgP
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id d75a77b69052e-4b11e27e336mr21594031cf.40.1755259961373;
        Fri, 15 Aug 2025 05:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnPnvMwLbNdtzAW+0roAeIZqivH1p27UtKqFsGOF6SNMkniTfnNu9dyNXw9EPSCCREzSVauEw0aVkW+ujZac=
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id
 d75a77b69052e-4b11e27e336mr21593341cf.40.1755259960870; Fri, 15 Aug 2025
 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250814103424.3287358-2-lichliu@redhat.com> <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
In-Reply-To: <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 15 Aug 2025 20:12:30 +0800
X-Gm-Features: Ac12FXz8u1gnW3sWaPY_5ktKOWU5Gtqqb7XQcSSDytiYY6c-gGJc-TBLcG6Iyzc
Message-ID: <CAPmSd0O=f24o0J6Q202qFv09YrvvAtVryLk68RbU9ncfMTS0Vw@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
To: Randy Dunlap <rdunlap@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rx0Nosxtm051wdAKiA6y4PYRPGgnVwNkKQWEurvBllo_1755259961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_051246_449301_51FB6369 
X-CRM114-Status: GOOD (  35.42  )
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

Thanks Randy,

I will send a v2 with documentation.

On Fri, Aug 15, 2025 at 12:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
> On 8/14/25 3:34 AM, Lichen Liu wrote:
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
> > Tested-by: Rob Landley <rob@landley.net>
> > ---
> > Hi VFS maintainers,
> >
> > Resending this patch as it did not get picked up.
> > This patch is intended for the VFS tree.
> >
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 8f1000f9f3df..e484c26d5e3f 100644
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
>
> Please document this option (alphabetically) in
> Documentation/admin-guide/kernel-parameters.txt.
>
> Thanks.
>
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
> >       struct mnt_namespace *ns;
> >       struct path root;
> >
> > -     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
> >       if (IS_ERR(mnt))
> >               panic("Can't create rootfs");
> >
>
> --
> ~Randy
>
>


