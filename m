Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IN5pZ-0003Eq-J4
	for kexec@lists.infradead.org; Mon, 20 Aug 2007 07:54:03 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 84DA612367
	for <kexec@lists.infradead.org>; Mon, 20 Aug 2007 13:53:56 +0200 (CEST)
Date: Mon, 20 Aug 2007 13:53:59 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kdump for ARM (vmcore generation problem)
Message-ID: <20070820115359.GA21033@suse.de>
References: <46C1AA1A.6050907@samsung.com> <20070816030251.GA20860@in.ibm.com>
	<46C98029.2000800@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C98029.2000800@samsung.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Indraneel <indraneel.m@samsung.com> [2007-08-20 13:51]:
> Hi Vivek/Bernhard,
> 
> Vivek Goyal wrote:
> > On Tue, Aug 14, 2007 at 06:41:54PM +0530, Indraneel wrote:
> >> Hi,
> >> I'm trying to make Kdump work for ARM. Till now i've managed to get the 
> >> /dev/oldmem interface working for taking dumps. Now i want to get the 
> >> /proc/vmcore interface working.
> >> I'm unclear how to generate the elfcore headers required by routines in 
> >> vmcore.c.
> >>
> > 
> > Hi Indraneel,
> > 
> > kexec-tools in user space generates those headers. Have a loot at
> > kexec-tools code.
> 
> Thanks for the lead. I'm looking into kexec-tools and trying to do 
> changes for ARM. I'm unable to interpret one of the comments in 
> kexec/crashdump-elf.c which says,
> " The separate PT_LOAD program header is required either because the
>    kernel is mapped at a different location than the rest of the
>    physical memory or because we need to support relocatable kernels.
>    Or both as on x86_64. "
> 
> Can you please provide some more clarification for this so that i can 
> figure out whether a separate PT_LOAD header is required for ARM 
> architecture as well (esp. the "kernel mapped to diff. loc. part of the 
> comment").

Is the ARM kernel relocatable? If no, then you don't need this.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
