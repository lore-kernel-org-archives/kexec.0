Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ABBD597C3
	for <kexec@archiver.kernel.org>; Wed, 13 Nov 2024 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VrivR523vm+ChvLCz2zoKm7qZge4OihtMXV2MR0/ows=; b=3jMV8z/Z/O/KmL
	bGiVVMlS9aJuAoFCHj9vvc29Q5UTCrvgHT16ca+Z1i+IJi7wL6Xb7AK0tyFqhq3ifSAwhaj3YPHbC
	oAiP6g47Yrk0yYdwEwLs5h/WYJHX6DQB+SVZb1g1eOol1wdQAIC5aOOxPPhERjG4ER6WqHdQf8a2h
	saHeqb6PAKuLLZv174HQFJuXmoCLSWcdkikZyhaYqHwzwBuxag3PuQF2f0a6HaVVKhQg9bVATRne7
	DUVZj/drBZ6CS1HnCA0X2pvADsqoXK75O+I4Df2Nv2bOTq+/aEO9kDJA4xxN4i0svqJWUsFq3ntd7
	avfaqMgTaM0VjMwZwsvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB1ny-00000005Tc3-0TN8;
	Wed, 13 Nov 2024 01:04:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB1nu-00000005TbJ-13yD
	for kexec@lists.infradead.org;
	Wed, 13 Nov 2024 01:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731459856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71kRV9QsWZSXh3DeItT/ZQQntIgYvFwGt1Icivu2FQU=;
	b=W/3QJif3EzC+DqiNuiM1JinKwu0JDI1aqlA7EFdt9r2cZdW2hzrTc80fprK2Abefdv4Ojn
	YCjGXef8m28K2Ij3/xln1C7t4R6/eK7f1jG0zsaZYFNnUz8UtrVUyvZ04wHQJUvfVYmTos
	4I73a7Czz4KZR1wAAYLQHEav1a7uozw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-11EtgfivOCK3-BmbgwnKPQ-1; Tue,
 12 Nov 2024 20:04:12 -0500
X-MC-Unique: 11EtgfivOCK3-BmbgwnKPQ-1
X-Mimecast-MFC-AGG-ID: 11EtgfivOCK3-BmbgwnKPQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2220919541A1;
	Wed, 13 Nov 2024 01:04:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B4830000DF;
	Wed, 13 Nov 2024 01:04:07 +0000 (UTC)
Date: Wed, 13 Nov 2024 09:04:03 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org, Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	ebiederm@xmission.com,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on
 PPC_BOOK3S_32
Message-ID: <ZzP7AzziB8a2jJGP@MiWiFi-R3L-srv>
References: <20240917163720.1644584-1-dave@vasilevsky.ca>
 <ZuvnhSvVMIGgAVNj@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZuvnhSvVMIGgAVNj@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_170418_385906_CB55FBA0 
X-CRM114-Status: GOOD (  17.19  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On 09/19/24 at 10:57am, Baoquan He wrote:
> On 09/17/24 at 12:37pm, Dave Vasilevsky wrote:
> > Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
> > Open Firmware. On these machines, the kernel refuses to boot
> > from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.
> > =

> > Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
> > default to off for them. Users booting via some other mechanism
> > can still turn it on explicitly.
> > =

> > Does not change the default on any other architectures for the
> > time being.
> > =

> > Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> > Reported-by: Reimar D=F6ffinger <Reimar.Doeffinger@gmx.de>
> > Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> > Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
> > ---
> >  arch/arm/Kconfig       | 3 +++
> >  arch/arm64/Kconfig     | 3 +++
> >  arch/loongarch/Kconfig | 3 +++
> >  arch/mips/Kconfig      | 3 +++
> >  arch/powerpc/Kconfig   | 4 ++++
> >  arch/riscv/Kconfig     | 3 +++
> >  arch/s390/Kconfig      | 3 +++
> >  arch/sh/Kconfig        | 3 +++
> >  arch/x86/Kconfig       | 3 +++
> >  kernel/Kconfig.kexec   | 2 +-
> >  10 files changed, 29 insertions(+), 1 deletion(-)
> =

> Thanks for the effort.
> =

> Acked-by: Baoquan He <bhe@redhat.com>

Could you help pick this one?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
