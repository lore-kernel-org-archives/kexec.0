Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211])
	by pentafluge.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IjlIN-0003aF-JD
	for kexec@lists.infradead.org; Mon, 22 Oct 2007 01:37:31 +0100
From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 0/2] add new notifier function ,take2
Date: Sun, 21 Oct 2007 22:00:03 +1000
References: <471700F4.1080200@ah.jp.nec.com> <20071018080621.GB8779@in.ibm.com>
	<47171ED9.7010907@ah.jp.nec.com>
In-Reply-To: <47171ED9.7010907@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710212200.04361.nickpiggin@yahoo.com.au>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Thursday 18 October 2007 18:52, Takenori Nagano wrote:
> Vivek Goyal wrote:

> > > My stance is that _all_ the RAS tools (kdb, kgdb, nlkd, netdump, lkcd,
> > > crash, kdump etc.) should be using a common interface that safely puts
> > > the entire system in a stopped state and saves the state of each cpu.
> > > Then each tool can do what it likes, instead of every RAS tool doing
> > > its own thing and they all conflict with each other, which is why this
> > > thread started.
> > >
> > > It is not the kernel's job to decide which RAS tool runs first, second
> > > etc., it is the user's decision to set that policy. Different sites
> > > will want different orders, some will say "go straight to kdump", other
> > > sites will want to invoke a debugger first. Sites must be able to
> > > define that policy, but we hard code the policy into the kernel.
>
> I agreed with him and I made new notifier function that users can change
> the order. Priority value in notifier blocks are hardcoded. If users want
> to change list order, they have to rebuild kernel. I think it is very
> unhappy.

Is it possible to use a single bit of common code and a single
notifier for these things? Or is it too difficult?

One thing I'd suggest is not to use debugfs, if it is going to
be a useful end-user feature.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
