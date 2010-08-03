Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgCzZ-0008CI-50
	for kexec@lists.infradead.org; Tue, 03 Aug 2010 08:37:00 +0000
Date: Tue, 3 Aug 2010 17:36:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: set prstatus.pr_pid to cpu id when current->pid
	is  0
Message-ID: <20100803083647.GB15434@verge.net.au>
References: <AANLkTikuUi=i6Lk-ZpE65Gr0tWOeVnrnpWPe85T=J=Ph@mail.gmail.com>
	<m1zkx4w3hx.fsf@fess.ebiederm.org>
	<AANLkTi=-By6ZWjo9bW0s4MndFftHegROO7oa0jbpnCho@mail.gmail.com>
	<m1d3u0un7b.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1d3u0un7b.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: gdb@sourceware.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Hui Zhu <teawater@gmail.com>

On Tue, Aug 03, 2010 at 01:15:04AM -0700, Eric W. Biederman wrote:
> Hui Zhu <teawater@gmail.com> writes:
> 
> > On Tue, Aug 3, 2010 at 15:37, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Hui Zhu <teawater@gmail.com> writes:
> >>
> >
> > Equal 0 is not a bug, the trouble is a lot of core's pid is same.
> >
> > This is what gdb say:
> > /* Found an old thread with the same id.  It has to be dead,
> >        otherwise we wouldn't be adding a new thread with the same id.
> >        The OS is reusing this id --- delete it, and recreate a new
> >        one.  */
> 
> gdb bug compatibility is not a primary goal.  Having an extensible
> format and not inventing it totally out of the blue is the goal.
> 
> The goal was always that something could post process the output of
> the kernel crashdump and create something that is gdb compatible.  It
> looks to me like it would take just a moment to strip out all of the
> idle threads.
> 
> Claiming the pid is the cpu number when the pid is the idle pid gives
> you no insulation against duplication, and it looses information.

Agreed, there clearly an ambiguity brought in by this patch as the range
of valid values for pids and cpus is essentially the same.

Doing this in user-space is the right place, though I'm not really
convinced its even correct there.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
