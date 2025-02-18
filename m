Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3563C02198
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSEtCsZpxMOMKNdaR1yK/nbBKLsfJHzA8/Mqc8jeEh8=; b=4OP8k4vPlOFeXAMizsaHXHLYGV
	0IUSMftratecVdlFvfYdDxExfMhTW23/5WH4kQ4UW6ccVoA0SyuY1HFUxzcJ4brAj/nzjQeqdNoX+
	zGRh/gVTqL4tN9ruy/lSVxRqzK3bYeSGWPd5bQrS3on++IP+IIXXkRPazHQn/5uSjGAy/B+vWuR1c
	gdGYwvJdvXKIQF/cUWxTLEnebvs+gL2Yz51w1XkZ092j+6MOA8W16XpkMgi1Bv71jKzUnLfIC4/8D
	zLwUqpuLZC0c2lGI6+rkWLRPubmdA8pTsjamLaXEQoMFdbKBpSHwG1/1//20SkuAB3Us7PgrkdZoP
	8hHi4WlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkJK5-00000007Mhg-1K4F;
	Tue, 18 Feb 2025 08:51:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkJH7-00000007M7x-1RRB
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 08:48:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSEtCsZpxMOMKNdaR1yK/nbBKLsfJHzA8/Mqc8jeEh8=;
	b=MWTpoqyP9iRqdpmy0/ET2f/okBW5MUWEWvq+R5NfzWfFbZtm1IXwKNUIGUlYnldUimrGfB
	xLeUgfSXmNdcaJpaqL6+VNsl2yblzPr3MSsHbOCNV6kOKvDWSyHPt5SFJ3BwMMTiqKeqDc
	zrBGeKdZyi65cz/XHYYj1+KjwY0ovPM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686--5IY1APwOJyBAS8GToCrvg-1; Tue, 18 Feb 2025 03:48:14 -0500
X-MC-Unique: -5IY1APwOJyBAS8GToCrvg-1
X-Mimecast-MFC-AGG-ID: -5IY1APwOJyBAS8GToCrvg_1739868493
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d190ae831fso94115615ab.3
        for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 00:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868493; x=1740473293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSEtCsZpxMOMKNdaR1yK/nbBKLsfJHzA8/Mqc8jeEh8=;
        b=QvWegRhfTeK9BpGod5IY8MIVZDN/b+Oqldg9N3KBYsw1bCimCdOYWJROTL0DuuRsIA
         VVSINvH7JSI16ZBiGmdh/ODGFAY2zjq9RmBZNZuyp+fuPOGMOp5utQa1vFGvR5d32vwx
         KvDEofc/2+ctCziDvUAGZuYeK2A4OprRLkoUoN18NWF6rczmdTUojhWpH2v1deFCmzEL
         HNLJlfyzS8M4xHt6ShcyPRhRdXUmRnn7qVD5ijWGQ1Vftpm0Uop//Et916cVt+YM+Jbq
         XY8yoK6fnl+BfVZYit/4hJNiuLPVZbaJSzNPhH02g1nOZc3bg48hJLLCVhVBKFkV6czA
         P2qA==
X-Gm-Message-State: AOJu0Ywwl9VQ6jLr1tkdQIO3wU9ExgJ23zC2zhtW84zNKQb6Cn9m0f3n
	Zv+5Ygxms9tXwE7MtxaH/iiwwJGfyd5tUjvv03RM0t27bgVa5b2Bmg1bLAGfHj6hkW81HdqYD0u
	+gyDy3qHoucT6LGplWTDguBlGlQNEnc3WuPWnQDHpZ49D2QwNFumtstqARmz/vHR9da5D89+y5g
	jFCVxNlidF2miYmNQkPT6NSkJWauToaCp/
X-Gm-Gg: ASbGncuFGvSODniqE+Yjme6Dm7CR4hfaHHUrgkQmEsPoZUJP7xDZJcI/EzjIzQU19M3
	pkU06snDf/tUaFf3lfVlSIWValraH24p7lUJmoK/eGm1NPGSqRwehfcj0vEIp6tU=
X-Received: by 2002:a05:6e02:1c28:b0:3d0:237e:c29c with SMTP id e9e14a558f8ab-3d2807c57ccmr97275135ab.12.1739868493292;
        Tue, 18 Feb 2025 00:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGktrtPDzks6L/C8mtjftG/kq6YmQXl/QwzctIlUY2VqLenJ6KDJ6XoLOTWsTTsGNetuQcwU69oktcpVCuxpJ8=
X-Received: by 2002:a05:6e02:1c28:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d2807c57ccmr97274935ab.12.1739868493003; Tue, 18 Feb 2025
 00:48:13 -0800 (PST)
MIME-Version: 1.0
References: <4ccd4d81-2efd-4369-a759-552dbb9a007f@ti.com> <a69a8eaf-9fc0-468b-b39a-1486e6054878@ti.com>
In-Reply-To: <a69a8eaf-9fc0-468b-b39a-1486e6054878@ti.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 18 Feb 2025 16:48:26 +0800
X-Gm-Features: AWEUYZkFeiGJPsvWA7G5huEYD9zm02zPem0JeORmrZGf_4NxJjjfHEGAZ734C74
Message-ID: <CALu+AoRDtPRgZS6t57xXpQvQ9bXv7hTyebAVfPLXH69Op2qRzA@mail.gmail.com>
Subject: Re: VMCORE and kdump.conf file not found LINUX 6.12 KERNEL
To: Gokul Praveen <g-praveen@ti.com>
Cc: kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pKU7v5JGCR6PlbUB_iuGLNFOERSqfcOLQnYwcGL0VzA_1739868493
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_004817_454287_89421A00 
X-CRM114-Status: GOOD (  13.74  )
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

On Tue, 18 Feb 2025 at 14:07, Gokul Praveen <g-praveen@ti.com> wrote:
>
> Hi Team,
>
> Just a reminder.
> It would be really great if you could help me with the following.
>
> Regards
> Gokul
>
> On 05/02/25 17:50, Gokul Praveen wrote:
> > Hi Team,
> >
> > It would be really great,if you could help me with a couple of questions
> > regarding kexec and kdump.
> >
> > I tried kdump on my SOC and it is rebooting fine . However,the VMCORE
> > file and /etc/kdump.conf file is not found.
> >
> > VERSION:
> > kexec-tools 2.0.30.
> > kernel 6.12v
> >
> > STEPS FOLLOWED:
> >
> > 1)git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >
> > 2)
> >     HOST PC:
> >      >cd $KEXEC_TOOLS_DIR
> >      >./bootstrap LDFLAGS=-static ./configure --prefix=/usr/local
> > --host=aarch64-linux-gnu --target=aarch64-linux-gnu
> >      >make
> >      >cp $KEXEC_TOOLS_DIR/build/sbin/kexec /media/$USER/rootfs/usr/sbin
> > (To copy the kexec binary to the rootfs filesystem of the target board)
> >
> >     TARGET BOARD:
> >      >Booted upto linux
> >      >cmdline="crashkernel=128M console=ttyS2,115200n8
> > root=/dev/mmcblk0p2 rw rootfste=ext4 rootwait" (/dev/mmcblk0p2 refers to
> > EMMC)
> >      > /kexec -p /Image --command-line="$cmdline"
> > --dtb=/k3-j721e-common-proc-board.dtb
> >      > echo c > /proc/sysrq-trigger

Hi,

This looks more like a distribution related issue, I suggest you ask
distribution developers to help.

Thanks
Dave


