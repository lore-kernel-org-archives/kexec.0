Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UlxaI-0003rt-Kb
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 08:36:15 +0000
Date: Mon, 10 Jun 2013 17:35:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] kexec-tools: Remove saved_max_mem
Message-ID: <20130610083551.GC1563@verge.net.au>
References: <51A183B0.7000607@gmail.com>
 <87obbu7mxg.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87obbu7mxg.fsf@xmission.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Tue, May 28, 2013 at 03:35:23PM -0700, Eric W. Biederman wrote:
> Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:
> 
> > When loading the dump-capture kernel, in some architectures(mips/ppc/ppc64),
> > we should add the parameter "savemaxmem=" in the dump-capture kernel
> > commandline to tell the new kernel the amount of memory that the previous
> > kernel used.
> >
> > Then in the dump-capture kernel, we parse this parameter and assign the
> > value to saved_max_pfn. In these architectures, the only user of
> > saved_max_pfn is the read interface read_oldmem for /dev/oldmem.
> >
> > But, no one actually uses the /dev/oldmem interface. And we have decided
> > to remove the /dev/oldmem interface. A kernel side patch to remove this
> > interface have been sent. See https://lkml.org/lkml/2013/5/24/451.
> >
> > So in kexec-tools, we don't need to pass this parameter anymore. This
> > patchset aims to remove the related variables and funtions in
> > kexec-tools.
> 
> To this series.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> No one cares unless they are actually using /dev/oldmem, and so far
> it appears no one actually uses /dev/oldmem so this change looks very
> safe.

Thanks, all four patches applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
