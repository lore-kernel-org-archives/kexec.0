Return-path: <kexec-bounces@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IgB2p-0002d0-5D
	for kexec@lists.infradead.org; Fri, 12 Oct 2007 04:18:38 +0100
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200710111217.58473.rjw@sisk.pl>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<200710111217.58473.rjw@sisk.pl>
Date: Fri, 12 Oct 2007 11:19:32 +0800
Message-Id: <1192159172.17539.26.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thu, 2007-10-11 at 12:17 +0200, Rafael J. Wysocki wrote:
> On Thursday, 11 October 2007 04:13, Huang, Ying wrote:
> > Kexec base hibernation has some potential advantages over uswsusp and
> > TuxOnIce (suspend2). Some most obvious advantages are:
> 
> Well, I have some doubts as far as the obviousness is concerned.

OK, I will remove the "obvious".

> > 1. The hibernation image size can exceed half of memory size easily.
> 
> This is also possible with TuxOnIce.

I will add detail description about this. It is possible with TuxOnIce,
and hard with u/swsusp.

> 
> > 2. The hibernation image can be written to and read from almost
> >    anywhere, such as USB disk, NFS.
> 
> This is possible with uswsusp, at least in theory, probably with TuxOnIce too.

I will remove this.

> > 3. It is possible to eliminate freezer from kexec based hibernation
> >    implementation.
> 
> This isn't true as long as we have not changed the handling of devices
> (which is in the works, but will take time).

I know it has not been implemented yet. I just say that it is possible
for khibernation and it is almost impossible for u/swsusp and TuxOnIce.

> > 4. Based on kexec/kdump implementation, the kernel code needed is
> >    less.
> 
> Well, maybe.
> 

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
