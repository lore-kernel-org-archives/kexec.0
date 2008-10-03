Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KldSl-0006KN-06
	for kexec@lists.infradead.org; Fri, 03 Oct 2008 05:44:27 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m935iPTB012710
	for <kexec@lists.infradead.org>; Fri, 3 Oct 2008 01:44:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m935iPla234272
	for <kexec@lists.infradead.org>; Fri, 3 Oct 2008 01:44:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m935iPxa018395
	for <kexec@lists.infradead.org>; Fri, 3 Oct 2008 01:44:25 -0400
Message-ID: <48E5B134.6050506@in.ibm.com>
Date: Fri, 03 Oct 2008 11:14:20 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<7AB33E84-B8C2-4B32-B1F8-7FA213198FE4@kernel.crashing.org>
	<48E47D38.3040508@linutronix.de>
	<20081002100553.GA5886@verge.net.au>
In-Reply-To: <20081002100553.GA5886@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Kumar Gala <galak@kernel.crashing.org>

Simon Horman wrote:
> On Thu, Oct 02, 2008 at 09:50:16AM +0200, Sebastian Siewior wrote:

> 
> I'm not speaking on behalf of Kumar Gala, just on behalf of myself.
>

Hi Horms,

> I would like to get some review of this patch by if possible.
> Also, I'm a little unclear of how it will interact with the
> patches that Mohan Kumar sent this week. But at this point
> I don't see any particular need to break the patch up into
> smaller pieices.
> 

My patches are meant for PPC64 only. The patch implements support for 
relocatable kdump kernel on PPC64 platform.

So I don't think Sebastian's patches need to support this relocation 
support in the kexec-tools as of now.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
