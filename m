Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMaga-0001TF-02
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 04:15:30 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0D4E6Pw009866
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:14:06 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0D4FPs7189344
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:15:25 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0D4FOr9004695
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:15:24 -0500
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH 0/5 + 2] kexec updates
Date: Tue, 13 Jan 2009 09:45:20 +0530
References: <kexec-29-1.miltonm@bga.com> <20090112062359.GK7337@verge.net.au>
In-Reply-To: <20090112062359.GK7337@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200901130945.20596.mohan@in.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>

> On Fri, Jan 02, 2009 at 02:42:38PM -0600, Milton Miller wrote:
> > Follwing this mail are 5 patches for kexec userspace and two for the
> > kernel.  The first fixes an array overflow and the second updates
> > userspace to the merged 2.6.28 kdump support.  The remaining are
> > cleanups and warning fixes, including one for the common code.
> > 
> > The two patchs for the kernel are independent.
> 
> Hi all,
> 
> sorry to be a bit slow in responding, this email landed just
> as I was leaving for a weeks holiday.
> 
> The kexec-tools patches seem reasonable to me and I'm happy to merge what I
> think are the latest versions - thanks Michael for your review.

Hi,

I tested both kernel and kexec-tools patches and kdump works fine. Tested on a 
POWER5 machine.

Regards,
Mohan.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
