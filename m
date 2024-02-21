Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B4C48BEB
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zNDoqZjsnjuYKiapMttYJzc1ChDFjfSUs4h4zjRXYU8=; b=dK0/Ftv3WUp0cj
	54UTFADerQZfJbrlEAyd9wSGPzylgcIQb+HjuaeGe+NlX6gjuK6NHDnFjV0iU4LHf2SD/U2J/LD/s
	rcvLDZLP7ZI8kuMQ7SKMJXklXq8OrOEWTLLyytCCuehvvh1KZrTLa8E0E4DqEX/5n3PghFSeN5aqZ
	hw0LhMUHIQ0tp/2jZqA9xGTDft7WF6ov/CYtv1qZ9xh9hOT2gDWlARmI4ZHvQoIFeylocTrA5+BjJ
	CY9XBo+OAATPxqJh1hbC6hBKEgJaEwLXaul61XBg5KwiEs2/84134lVHm6RK3S80AXUQrwoNMf6L1
	6vdJALYe3UY5VTlywUfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rctfC-00000002XxE-0uz2;
	Wed, 21 Feb 2024 20:57:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rctf9-00000002XwU-31tp;
	Wed, 21 Feb 2024 20:57:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F135BCE1DC3;
	Wed, 21 Feb 2024 20:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CEFC433F1;
	Wed, 21 Feb 2024 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708549073;
	bh=cQNUlLy8aiGRIYPC4jZV2h79/t7uLaYDp/ZsuaE++9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bbd9ALrcftdB4hiAFAbv+r3I0ERbgznFbhuh6MxPmx8jG8xGLzeq23eo9RRwwfYK+
	 iZCi2iMyB0NelsBsnf7/OypvyrQWmMazP7HA7Jbw0rZNQMouPMIBGFEDM881CMWNgk
	 2e1ZuX9I7suwwEUiqPo2BxD0oszsroHPkKn6qHbQ=
Date: Wed, 21 Feb 2024 12:57:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-s390@vger.kernel.org,
 piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, ebiederm@xmission.com,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up
 related config items
Message-Id: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
In-Reply-To: <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
	<Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
	<559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_125755_952355_7E520B07 
X-CRM114-Status: GOOD (  15.94  )
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

On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:

> On 04/02/24 8:56 am, Baoquan He wrote:
> >>> Hope Hari and Pingfan can help have a look, see if
> >>> it's doable. Now, I make it either have both kexec and crash enabled, or
> >>> disable both of them altogether.
> >>
> >> Sure. I will take a closer look...
> > Thanks a lot. Please feel free to post patches to make that, or I can do
> > it with your support or suggestion.
> 
> Tested your changes and on top of these changes, came up with the below
> changes to get it working for powerpc:
> 
>  
> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/

So can we take it that you're OK with Baoquan's series as-is?

Baoquan, do you believe the patches in mm-unstable are ready for moving
into mm-stable in preparation for an upstream merge?




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
