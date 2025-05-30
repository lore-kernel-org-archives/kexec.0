Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33249C3ABB2
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 04:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BEb33DDg7DpFW9LjvXELe8JW6iZ+vyGYUAOVA6/mv7c=; b=Y+RbgzEUtDB/GuGTHzeoS6PxDZ
	4IbLqKUOTkU9MkGCB/Ps8wya2uc3ccskLtUCXKE/ndB1Cv10W1iOjENEKdSXLBUD3Jq2766lktoWO
	Wgn/u0I0avK9IBztkIYqPMw2aup7uySsSK27WlQvkNXoG/0woqIqhyB+K/0cShSSKuVG6pTRorLcm
	gKxI78EaPM/URtdxVFpH33s7fwi4ziBCP90/H9rShK2TvsdiJJw4HRYvPvijahz3puovZe5qMLjin
	YlYTxMQFlBnmCGCNwf4/B5pw8059da0iW4Mc+hUaYbNmqZ+OjXrmIK+9E6+ROJOSezErL1AAOE41K
	Y1P7friA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKr9O-0000000HBVn-1Njd;
	Fri, 30 May 2025 04:15:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKr9H-0000000HBUo-3spG
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 04:15:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748578513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEb33DDg7DpFW9LjvXELe8JW6iZ+vyGYUAOVA6/mv7c=;
	b=QQWJIUKPzSNr60dKTzULhk6vaSD8U3pQ7ZCrj3QwwsZmo7sPaXqznqtJykL+kZgcItwB/m
	0pGBYFBXl1ktcmGFprB58cXuMAHciFTD7Lda5qSCsOxWw7h4Z7Cr8/NbX4PY7eY/FxR8cC
	7PivWpSmJR5ucIvMf49bxy/ZCbvivRs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-CpygWPPWOl6hPp2Yj_Bkpg-1; Fri, 30 May 2025 00:15:09 -0400
X-MC-Unique: CpygWPPWOl6hPp2Yj_Bkpg-1
X-Mimecast-MFC-AGG-ID: CpygWPPWOl6hPp2Yj_Bkpg_1748578509
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1187197a12.2
        for <kexec@lists.infradead.org>; Thu, 29 May 2025 21:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748578509; x=1749183309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEb33DDg7DpFW9LjvXELe8JW6iZ+vyGYUAOVA6/mv7c=;
        b=I6q+/PPWmCIBv4OfyxWUqCLN+Wx6Jh8FBXWengTu0iaG55LbMm6Hx+zCqJAYKYH7ny
         O2L1dbuMNdCPfGcVQPyIo0a11Nd7ajIuPUUaNoh80bwQd7F+g6nRcyk37Ezrf/oi0eEf
         pbya01VnNsHhQA7yNOe3nDpELCcIshGjKEd83oHhM7AS0o52jJe95OocYzWZTc6PQMN2
         GYiT+Or380g2xftjNjJyGEZGrvx8dD/NXTJl4oMujujUkHWxBsY189X0+Mj6UOPH+uYV
         IYH0FLT6YSAZVwULjvZJ2e5cg6oVq/dSJfVJhG/FvexbdUwWIa60BwcBro27Jmg7aMYK
         B4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOz9HhaXVGV+8OpKyfFUj+X1OfZ2QO/l6BZJ7ZBTouaDzFYy+CieqUsnsCOUNmDM8aUDAF+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgP5IpkyVx1JBYopSq1zg0WrBSASnZtjCNpR40i3W6pKK09THd
	tvywywSQKknELV+IttuuKgM4Ig4DNxBv2DkQ/R41uPaepMN43aSKfBDsPJZ3DQbLgwMHAvUv/8X
	u2dIoZVsViT1X3JmquHEH3lMDi4fdxp4ODNuZhCNqcBByqJgB54zkXQTmlIV/N2wtuUqlmzakDR
	W46/O7MBqq49dXAqgJ94Gtxm+wzSV/lzi1ovw4
X-Gm-Gg: ASbGncuHZBO1TZKvYMouy4bGVdeh2wH5eLohJWeEc5idkU0tvO1lrs3HktlVVqt8eeB
	atl8Ok5AmkTNtJ+HxJ5tQPSJBOfxEghWZ1uzRK//TYUT9mcJGHMHE47iBWzc/M3iOmM3gvA==
X-Received: by 2002:a17:90b:58eb:b0:311:f99e:7f4e with SMTP id 98e67ed59e1d1-3124152f29fmr3271296a91.16.1748578508610;
        Thu, 29 May 2025 21:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdNkL/QOg0pgwhpFjclJbxX9yS+kdBsgXT9/3xp4M+RVHKQ3aStcTn4xx15LUWcuWRLmKhhRfllSzauASBpmg=
X-Received: by 2002:a17:90b:58eb:b0:311:f99e:7f4e with SMTP id
 98e67ed59e1d1-3124152f29fmr3271262a91.16.1748578508205; Thu, 29 May 2025
 21:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250515233953.14685-1-bhe@redhat.com> <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv> <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
 <aC86NSypHlER2C3L@MiWiFi-R3L-srv> <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
 <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com> <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
In-Reply-To: <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 30 May 2025 12:14:57 +0800
X-Gm-Features: AX0GCFu-M8N1d-FrbfO4Ax_Xw2IAE_iVpqDIOOmbg0VDp3GzgJjExVn2UQM-Mb0
Message-ID: <CAF+s44TOjC60hfTU2JKQrfiogUin5E=O7XvePb86Lv7jjobJ1Q@mail.gmail.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com, 
	chenste@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DTMHDTwpg3Bta1PynmbIJBAZbUSc7H4PY1AotgWuBT4_1748578509
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_211516_438974_BB1DBEA7 
X-CRM114-Status: GOOD (  36.95  )
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

On Thu, May 29, 2025 at 10:32=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Thu, 2025-05-29 at 12:13 +0800, Pingfan Liu wrote:
> > On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >
> > > On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
> > > > > >
> > > > > >
> > > > > > We're trying to close integrity gaps, not add new ones.  Verify=
ing the
> > > > > > UKI's
> > > > > > signature addresses the integrity of the initramfs.  What about=
 the
> > > > > > integrity of
> > > > > > the kdump initramfs (or for that matter the kexec initramfs)?  =
If the
> > > > > > kdump
> > > > > > initramfs was signed, IMA would be able to verify it before the=
 kexec.
> > > >
> > > > IMHO, from the higher level, if there is a requirement on the integ=
rity of
> > > > the
> > > > initramfs, it should take a similar approach as UKI. And the system=
 admin
> > > > can
> > > > choose whether to disable the unsafe format loader or not.
> > >
> > > Yes, that is a possibility, probably a good aim, but in the case of
> > > kexec/kdump
> > > that isn't really necessary.  As filesystem(s) support xattrs, IMA po=
licies
> > > could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to includ=
e the
> > > initramfs.
> > >
> >
> > Just aware that we have such a cool feature. Thanks!
>
> > I checked the code. IIUC, the relevant code has already been in the
> > kernel. And the thing left to do is to install an IMA policy, right?
>
> Correct.  The problem up to now has been that the initramfs was created o=
n the
> fly on the target system, so it was impossible to remotely sign it by the
> distro.
>
> >
> > But there are still two things to be considered.
> > -1.The UEFI partition is FAT format, which can not support xattr
>
> The normal kexec/kdump kernel image and initramfs are stored in /boot, no=
t the
> UEFI partition.  Is that changing?
>
I think that is the case if grub is used as a bootloader.

But officially, only FAT32 is supported in the UEFI specification. So
if a UEFI application (let's say systemd-boot) tries to load kernel
and initramfs, then boots into kernel, it can only expect to read
these files from FAT32 partition.

> e.g. kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`una=
me -
> r`.img --reuse-cmdline
>
> > -2. Just like in the UKI case, the kernel fd content is not necessary
> > for the kernel image itself. The initramfs fd can be used to pass some
> > extra data if we use a temp file as a package. So checking the
> > signatures at the initramfs level will block this usage
>
> Sorry I lost you here.  What exactly is included in the UKI signature?  W=
hat is
> this initramfs fd extra data?  Is it included in the UKI signature?  Can =
you
> point me to some documentation?
>

Sorry for the awkward expression, let me clarify it.

It is a pity that these things are on the fly and there are no documents ye=
t.

With the advent of UKI, which encapsulates the kernel, initramfs, and
cmdline into a single PE file, the original kexec_file_load syscall
schema no longer aligns with this design.

SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
                unsigned long, cmdline_len, const char __user *, cmdline_pt=
r,
                unsigned long, flags)

In particular, the kernel_fd parameter no longer refers to just the
kernel image alone.
And the same thing may happen to initrd_fd.

In essence, it means the redesign or re-explaining of the
kexec_file_load() interface, but for the time being, these things are
on the fly.

Thanks,

Pingfan


