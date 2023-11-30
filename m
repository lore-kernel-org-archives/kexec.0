Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B304C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2U10ZFTdUhxIKNPcTcAJdIARA4/tFcsG2aOYRNDICXw=; b=r5+MzAesFGbbzw
	kAjv0agdDM32IShYOXinmeZzlvmm4oBYw8jFlJvN2nTgHGdBquqgpVn33pFNSr4hK5LPsw5y26Cav
	QPNxlCfA9sbWErucmFyr8zBnyGAjBym4J1SSrslLB0ItLlqs0bWJWEunm8kYS3py68LvuhU1KPXGq
	2kfV91MCAJs0OBUDCIute+8fupzI+zycWC/AT0faiH4c0OR2Yng7suEt/7cuLBZjoQXy1U7zv6QH5
	+wvhCv3DKI+JIZGAiGsKEcd81uWxxzvR/3fndTYvF1QRNJd3TaRAXy88LMdVch1+ZHrrvf7bNcvMy
	GSSIyAny/TrZ8T8QPlfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8kLV-00BR02-3A;
	Thu, 30 Nov 2023 16:57:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8kLT-00BQys-21;
	Thu, 30 Nov 2023 16:57:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0FA6C61E45;
	Thu, 30 Nov 2023 16:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C48C433C9;
	Thu, 30 Nov 2023 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701363418;
	bh=jNTamNThZ0rAs2o+KORaTzGsMmcQ2kdIW/zV+pisW9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ep5mfn6/d/046KNhMrPxYSVs2b/H1SbZQJJM57P3hzC8hmlHC+aL7jEbzQHe/bzLV
	 ZDl9UEr14ekcpfCJk6RDza5apPq9i/1g5VSUREK4wQ/5Ib8LBFZY5NsHmgDKwcsJd5
	 raSV/4nqny+fZeQRHQXL35saZ9wB+AO2cAuRD2YA=
Date: Thu, 30 Nov 2023 08:56:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Vivek Goyal <vgoyal@redhat.com>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-Id: <20231130085657.6f7f500cc17b663747e4ee76@linux-foundation.org>
In-Reply-To: <ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
	<ZTe8NOgAjvKDA6z0@MiWiFi-R3L-srv>
	<b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
	<ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_085659_706543_2FB0BD10 
X-CRM114-Status: GOOD (  18.81  )
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

On Thu, 2 Nov 2023 16:03:18 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > CONFIG_KEXEC_FILE, but still get purgatory code built in which is
> > > totally useless.
> > >
> > > Not sure if I think too much over this.
> > 
> > I see your point here, and I would suggest changing the
> > CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY symbol to just indicate
> > the availability of the purgatory code for the arch, rather
> > than actually controlling the code itself. I already mentioned
> > this for s390, but riscv would need the same thing on top.
> > 
> > I think the change below should address your concern.
> 
> Since no new comment, do you mind spinning v2 to wrap all these up?

This patchset remains in mm-hotfixes-unstable from the previous -rc
cycle.  Eric, do you have any comments?  Arnd, do you plan on a v2?  If
not, should I merge v1?  If so, should I now add cc:stable?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
