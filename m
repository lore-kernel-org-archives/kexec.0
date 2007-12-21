Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J5dhh-0003KN-0c
	for kexec@lists.infradead.org; Fri, 21 Dec 2007 08:58:08 +0000
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <476B7ACF.8020602@nigel.suspend2.net>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<476B7ACF.8020602@nigel.suspend2.net>
Date: Fri, 21 Dec 2007 16:53:27 +0800
Message-Id: <1198227207.25346.11.camel@caritas-dev.intel.com>
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
To: nigel@nigel.suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Fri, 2007-12-21 at 19:35 +1100, Nigel Cunningham wrote:
> Hi.
> 
> Huang, Ying wrote:
> > This patchset provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used both by the original kernel and the
> >   kexeced kernel.
> 
> Why the kexeced kernel as well?

The memory range used by kexeced kernel is also the usable memory range
in original kernel. Maybe should be: backup/restore memory used by both
the original kernel and the kexeced kernel. My English is poor.

> [...]
> 
> > The features of this patchset can be used as follow:
> > 
> > - Kernel/system debug through making system snapshot. You can make
> >   system snapshot, jump back, do some thing and make another system
> >   snapshot.
> 
> Are you somehow recording all the filesystem changes after the first
> snapshot? If not, this is pointless (you'll end up with filesystem
> corruption).

This snapshot is not used for restore/resume. It is just used for
debugging. You can check the system state with these snapshots. So I
think it is useful even without recording filesystem changes.

> [...]
> 
> > - Cooperative multi-kernel/system. With kexec jump, you can switch
> >   between several kernels/systems quickly without boot process except
> >   the first time. This appears like swap a whole kernel/system out/in.
> 
> How is this useful to the end user?

I am not sure how useful is this. Maybe I can run a Redhat and a Debian
on my machine and switch between them.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
