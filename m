Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB51C87FD3
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 03:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsyp6Edg52gGxunzu47oK6lBp56ZTl6cz3Zk/uJfGaM=; b=YdOaIdD+ZNa+uX+tQvFdUTgvG4
	mZD2g3ZQftbqROdBglf6lrzjAjfDZGM9OY0rQukhpiJwMKYgCFc0a+CiTQmL/4X2PPy799s0qy1by
	8k4sh7L+HMO1I3EZk88khhpLnCvDk58adfqXDFG7x4C2+rDcalzhNOE3s9Z6Tp8skhg+F7lFZP21F
	YO4IrDQN6W2/i58GYRfKEnxzb4UMaR0m1vd5ZSYmMLT81uyFCeDUfGEP9JvrCpME9EMqST+zdDPzI
	teg7azcQepwCx0cKlxluKl2ylzil8MgmrEYet3bYmmSbdynpRv371coTSUUOKkOurnH13lLua0vcY
	DuiL44ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukDuf-00000001vdQ-0GzR;
	Fri, 08 Aug 2025 03:37:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukDub-00000001vcw-3Imd
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 03:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754624216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsyp6Edg52gGxunzu47oK6lBp56ZTl6cz3Zk/uJfGaM=;
	b=SKpLehK1rNMz50RC7Bj21vQU1Nud1E5dl9tpWJnVquBXAhd9xI/t7nn/VN95DfYfDDvHpB
	mVdNQBEsCcy0LEspnfACcrpkmdo2UR0qH2NxTg/ZAdCZpaOIdYfIuI2ymO3TVSOvGhBIcI
	olu9SejaEsSbvdbtvbW9H90q7Y/GD7g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-M_Z06jURPdu2znVgKJUYag-1; Thu, 07 Aug 2025 23:36:55 -0400
X-MC-Unique: M_Z06jURPdu2znVgKJUYag-1
X-Mimecast-MFC-AGG-ID: M_Z06jURPdu2znVgKJUYag_1754624214
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e6a5428a76so694552085a.1
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 20:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754624214; x=1755229014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsyp6Edg52gGxunzu47oK6lBp56ZTl6cz3Zk/uJfGaM=;
        b=Khlvi0ASQyH0d7CJYHcSVPSk3oykVQ3VUGNyO3mOmozU15KGSqmGPL7RvqgWJ3PcBc
         YwXNIF/ZocxLW3FnE5dxBeC3S2yfKrY9ZegXnoS3Ac7xEoMBITDnmwTivF15GPJK5z2y
         3vtJA3XXqevhOVHn0PHWbFi80FhrHq4czhS5P/rbQ1mYdVm/POqG3sIR9zLexLO8rSIR
         eHUobVfusjjT2e5feJldP071uosHAB7o8Y6i6nfUPzRbnNoBgf4I90Flb8IpJYIItrTi
         +N2M9UmE+urKX0MEhYfIEOoBraLAdJuQ8LKA31OVPpBugn3HA4S+R8c2R9LAChYFaVfY
         InhA==
X-Forwarded-Encrypted: i=1; AJvYcCXet5Ix3Dl4RjYWClQI3YfJiKsYDrKRwSjblbGIu6jWR+BWOINW7EjIbVd0ulK9GlijkirPEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxwZpdu85p+PQ1uc6R6d6dQdw3tyQPY4s2Xu/+tyYpTZCsnLNWX
	RMVYkKG2dHywrbrxZZcIukoStOIUYFOVVbybUVKfnCfA8EIBX4JG/eoY1+s0w1RsbuGYvfmP+TF
	Cc3iQnHuPE/zwY+0dTOxRAjag/PQWePw/KvOPoA5q3VzON8KkKVmZMW2o7sdJl9ir1SnW8jw+1l
	cG6gzlJavxfL6NIn5Zn5PleFJ3lHuJMJi9bJEG
X-Gm-Gg: ASbGnctCBcCUCJWkjAoNqCw95Tbc2il1odXsb5fv7eIMrl7c29F9S/v8cDdnOiMB/Ri
	zijRU9HJyr3vtqOOyBPm729mZbAK+/hoSspFEJaT2tIg+7zNIbirLZVeCx8qPxU3SHwmmq/sxfz
	YigMrw2vknL6Zah+XWuK+tGoit/PFseSGQU1aRB/28UXuNVceI60xN
X-Received: by 2002:ac8:5d04:0:b0:4b0:6a31:163a with SMTP id d75a77b69052e-4b0afd827f0mr18021911cf.4.1754624214263;
        Thu, 07 Aug 2025 20:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh1M25upIO8yP24fBcslf6iFMfxnENdkySk6wSIBZZPvvKaFt0DZ6Carbxl/kgYDKYoZ7WIqT4DSAxq/3ahpg=
X-Received: by 2002:ac8:5d04:0:b0:4b0:6a31:163a with SMTP id
 d75a77b69052e-4b0afd827f0mr18021761cf.4.1754624213751; Thu, 07 Aug 2025
 20:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
 <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
In-Reply-To: <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 8 Aug 2025 11:36:42 +0800
X-Gm-Features: Ac12FXwg4eabeUdRCinwQOjZemEW_hV9jM2hO2Z7nLNQw6zNDks5tnGEToJNyYA
Message-ID: <CAPmSd0OQfSHBqDSpFLNAddk-f_aDcjzKt_VBzLWjNqvMAXgzkQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Dave Young <dyoung@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rob@landley.net, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N9ZvYcmtZpwtdw0VDf24RLlfu8bscWvYT22m-aNScMw_1754624214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_203657_904199_EE5C0250 
X-CRM114-Status: GOOD (  41.18  )
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

On Fri, Aug 8, 2025 at 10:46=E2=80=AFAM Dave Young <dyoung@redhat.com> wrot=
e:
>
> On Fri, 8 Aug 2025 at 10:30, Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi Lichen,
> >
> > On Fri, 8 Aug 2025 at 09:55, Lichen Liu <lichliu@redhat.com> wrote:
> > >
> > > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > > By default, a tmpfs mount is limited to using 50% of the available RA=
M
> > > for its content. This can be problematic in memory-constrained
> > > environments, particularly during a kdump capture.
> > >
> > > In a kdump scenario, the capture kernel boots with a limited amount o=
f
> > > memory specified by the 'crashkernel' parameter. If the initramfs is
> > > large, it may fail to unpack into the tmpfs rootfs due to insufficien=
t
> > > space. This is because to get X MB of usable space in tmpfs, 2*X MB o=
f
> > > memory must be available for the mount. This leads to an OOM failure
> > > during the early boot process, preventing a successful crash dump.
> > >
> > > This patch introduces a new kernel command-line parameter, rootfsflag=
s,
> > > which allows passing specific mount options directly to the rootfs wh=
en
> > > it is first mounted. This gives users control over the rootfs behavio=
r.
> > >
> > > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow=
 the
> > > tmpfs to use up to 75% of the available memory. This can significantl=
y
> > > reduce the memory pressure for kdump.
> > >
> > > Consider a practical example:
> > >
> > > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. Wit=
h
> > > the default 50% limit, this requires a memory pool of 96MB to be
> > > available for the tmpfs mount. The total memory requirement is theref=
ore
> > > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpac=
ked
> > > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> > >
> > > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 4=
8MB
> > > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memo=
ry
> > > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with=
 a
> > > smaller crashkernel size, such as 192MB.
> > >
> > > An alternative approach of reusing the existing rootflags parameter w=
as
> > > considered. However, a new, dedicated rootfsflags parameter was chose=
n
> > > to avoid altering the current behavior of rootflags (which applies to
> > > the final root filesystem) and to prevent any potential regressions.
> > >
> > > This approach is inspired by prior discussions and patches on the top=
ic.
> > > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > > Ref: https://landley.net/notes-2015.html#01-01-2015
> > > Ref: https://lkml.org/lkml/2021/6/29/783
> > > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-=
initramfs.html#what-is-rootfs
> > >
> > > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > > ---
> > >  fs/namespace.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index ddfd4457d338..a450db31613e 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> > >  }
> > >  __setup("mphash_entries=3D", set_mphash_entries);
> > >
> > > +static char * __initdata rootfs_flags;
> > > +static int __init rootfs_flags_setup(char *str)
> > > +{
> > > +       rootfs_flags =3D str;
> >
> > I do see there are a few similar usages in init/do_mounts.c, probably
> > it is old stuff and it just works.  But I think making rootfs_flags as
> > an array and copying str into it is the right way.
Hi Dave, thanks for your comments!

I will check how to make it better.

>
> Another question, may need fs people to clarify.  If the mount is
> tmpfs and it is also rootfs,  could it use 100% of the memory by
> default, and then no need for an extra param?    I feel that there is
> no point to reserve memory if it is a fully memory based file system.
>

I think rootfstype=3Dramfs will use 100% of the memory.
For kdump only, there might not be much difference between using ramfs
and tmpfs size=3D100%. But I think it might provide more flexibility
since rootfstype=3D and rootflags=3D can be used with root=3D.

https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

> >
> > > +       return 1;
> > > +}
> > > +
> > > +__setup("rootfsflags=3D", rootfs_flags_setup);
> > > +
> > >  static u64 event;
> > >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> > >  static DEFINE_IDA(mnt_group_ida);
> > > @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
> > >         struct mnt_namespace *ns;
> > >         struct path root;
> > >
> > > -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > > +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_f=
lags);
> > >         if (IS_ERR(mnt))
> > >                 panic("Can't create rootfs");
> > >
> > > --
> > > 2.50.1
> > >
> > >
> > Thanks
> > Dave
>


