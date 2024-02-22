Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A46C47DD9
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KyrzT35EGdBWvLIKH1kbHM1+x4Tk2Apf49A2uyrLpdQ=; b=kpJ2qHpemCnF27
	uuAJX3QPI+T8TNdYqz+j9QFPDqfv9xVIKseTpNJQUmBT1NyMZJxlzRjUliTlAHtn9MXL/hNJeekw1
	JF3Lji29rqB1HEn6v2D0b7rT/kkGXxCUZH1WNJkl3xqEYb3EbSuhpOKK606cjbLpNHhCLhUoSh2vL
	mKnz7aKScxllMz1rs5vy6THMecehzFGJ/CSAHO1RsoCHkCAnLtyyzwl1SdcBoCWlb+DGLLPXVPpvY
	JoPdpkVtbduBl7Twi2abaFC+NOpVnS2ynFLbmChARkVKrRRec9Ntii0+Hif6FyGrR8W1EF2aK+ol8
	wAg9PiMgHDNGKBmWevNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdGdf-00000006euH-3M9H;
	Thu, 22 Feb 2024 21:29:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdGdO-00000006esy-2wWu;
	Thu, 22 Feb 2024 21:29:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E9DCA606DC;
	Thu, 22 Feb 2024 21:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18839C433C7;
	Thu, 22 Feb 2024 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708637377;
	bh=t85/vLINNj4QjqTdLkHVSWfMx17aHlL+u2dxKq3yYy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hh5Zm4YvDfOKF5br8tkmh9sJvT791U5KssSAIS8LfOqGSzl3slitWdXs3E1Em8lxo
	 eW/hjzCE3XTpXQTswpeuaep38I7mm0zb4+bnWgNGgZIUZ8CEoNf8Y2On7Vgpn2ddNO
	 Q3Fn70VpnIcWdCXFtJ96SSNkluqeWjcO+vqu/Qw4=
Date: Thu, 22 Feb 2024 13:29:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, ebiederm@xmission.com,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up
 related config items
Message-Id: <20240222132936.e7dc50acbf5d1b653cb2e02c@linux-foundation.org>
In-Reply-To: <3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
	<Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
	<559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
	<20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
	<3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_132938_815192_7DAA34C2 
X-CRM114-Status: GOOD (  17.96  )
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

On Thu, 22 Feb 2024 10:47:29 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:

> 
> 
> On 22/02/24 2:27 am, Andrew Morton wrote:
> > On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> > 
> >> On 04/02/24 8:56 am, Baoquan He wrote:
> >>>>> Hope Hari and Pingfan can help have a look, see if
> >>>>> it's doable. Now, I make it either have both kexec and crash enabled, or
> >>>>> disable both of them altogether.
> >>>>
> >>>> Sure. I will take a closer look...
> >>> Thanks a lot. Please feel free to post patches to make that, or I can do
> >>> it with your support or suggestion.
> >>
> >> Tested your changes and on top of these changes, came up with the below
> >> changes to get it working for powerpc:
> >>
> >>   
> >> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> > 
> > So can we take it that you're OK with Baoquan's series as-is?
> 
> Hi Andrew,
> 
> If you mean
> 
> v3 (https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/)
> +
> follow-up from Baoquan 
> (https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/)
> 
> Yes.
> 

Can I add your Acked-by: and/or Tested-by: to the patches in this series?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
