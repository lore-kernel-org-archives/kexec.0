Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MoCwI-0003Ja-9q
	for kexec@lists.infradead.org; Thu, 17 Sep 2009 09:06:11 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8H9178f019194
	for <kexec@lists.infradead.org>; Thu, 17 Sep 2009 14:31:07 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8H95xrv1257670
	for <kexec@lists.infradead.org>; Thu, 17 Sep 2009 14:35:59 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8H95x3S006486
	for <kexec@lists.infradead.org>; Thu, 17 Sep 2009 14:35:59 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [RFC] [PATCH] Write to HVC terminal from purgatory code
Date: Thu, 17 Sep 2009 14:36:02 +0530
References: <20090907051407.GA2990@in.ibm.com>
	<20090908230911.GE4075@verge.net.au>
In-Reply-To: <20090908230911.GE4075@verge.net.au>
MIME-Version: 1.0
Message-Id: <200909171436.02165.mohan@in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, miltonm@bga.com

> On Mon, Sep 07, 2009 at 10:44:07AM +0530, M. Mohan Kumar wrote:
> > Write to HVC terminal from purgatory code
> >
> > Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to
> > serial console/VGA while executing the purgatory code.  Implement this
> > feature for POWERPC pseries platform by using the H_PUT_TERM_CHAR
> > hypervisor call by printng to hvc console.
>
> This change seems reasonable to me, can any of the ppc people offer a
> review?
>

Sorry, I forgot to mention that this patch is tested on POWER5 (under 
hypervisor) and POWER4 Full System partition mode (under non-hypervisor)

Regards,
M. Mohan Kumar.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
