Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hvo7m-0000dr-Ka
	for kexec@lists.infradead.org; Wed, 06 Jun 2007 06:32:04 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l565WhR1008860
	for <kexec@lists.infradead.org>; Wed, 6 Jun 2007 01:32:43 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l565VdOw531830
	for <kexec@lists.infradead.org>; Wed, 6 Jun 2007 01:31:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l565Vdux023416
	for <kexec@lists.infradead.org>; Wed, 6 Jun 2007 01:31:39 -0400
Date: Wed, 6 Jun 2007 11:01:35 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: root= cmdline modification in kexec (was Re: [PATCH] kexec ppc64:
	fix misaligned cmdline )
Message-ID: <20070606053135.GB4916@in.ibm.com>
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
	<26608.1180950136@neuling.org> <2773.1181031738@neuling.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2773.1181031738@neuling.org>
Reply-To: mohan@in.ibm.com
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
To: Michael Neuling <mikey@neuling.org>
Cc: horms@verge.net.au, kexec@lists.infradead.org, miltonm@bga.com

On Tue, Jun 05, 2007 at 06:22:18PM +1000, Michael Neuling wrote:
> OK Looks like we parse the new command line to see if there is a
> 'root=blah' parameter.  If yes, use that, otherwise we use what was on
> the last boot.

For PPC64, if the user does not pass the kernel parameter, it is taken
from the existing kernel parameter. In this case "crashkernel=X@Y"
parameter is removed. If user explicitly gives the parameter, it is
used.

> 
> Is this what other architectures are doing?  Is there any other special
> cases we need to look out for?

I am not sure about x86, I hope they expect that user has to _pass_ the
kernel parameter. They don't copy the kernel parameter from current
kernel.

> 
> Mikey
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
