Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYe8c-0007c6-1Y
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 04:45:30 -0400
Subject: Re: [linux-pm] [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200709211043.38266.stefan@loplof.de>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>
	<200709211043.38266.stefan@loplof.de>
Date: Fri, 21 Sep 2007 16:47:11 +0800
Message-Id: <1190364431.21818.186.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Stefan Rompf <stefan@loplof.de>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Fri, 2007-09-21 at 10:43 +0200, Stefan Rompf wrote:
> Am Donnerstag, 20. September 2007 07:34 schrieb Huang, Ying:
> 
> > The hibernation procedure with the patch set is as follow:
> >
> > 1. Boot a kernel A
> >
> > 2. Work under kernel A
> >
> > 3. Kexec another kernel B (crash dump enabled) in kernel A.
> 
> From a short glance over current Linus' arch/i386/kernel/machine_kexec.c, 
> memory for the crash dump kernel B still needs to be reserved statically when 
> booting A.
> 
> This is one of the biggest issues with kexec based hibernation. For the 
> typical notebook user, it is totally unacceptable to reserve 16 megabytes of 
> memory just to be able to suspend to disk. And given the fact that current 
> distribution kernels are quite modular and require early module loading, even 
> more memory might be needed.
> 
> IMHO, a plan how to fix this must exist or the concept of kexec based 
> hibernation is a waste of time.

This issue has been resolved. The implementation method details in
another mail with title as follow:

[RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
