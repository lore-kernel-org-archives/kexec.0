Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SFyoz-0003xm-NK
 for kexec@lists.infradead.org; Fri, 06 Apr 2012 02:22:42 +0000
Date: Fri, 6 Apr 2012 11:22:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Add generic debug option
Message-ID: <20120406022237.GD27120@verge.net.au>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
 <20120313002116.GB24671@verge.net.au> <4F5EB7E0.8040701@gmail.com>
 <20120315064818.GC3449@verge.net.au> <4F68864D.9060008@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F68864D.9060008@gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 20, 2012 at 09:29:49PM +0800, Cong Wang wrote:
> On 03/15/2012 02:48 PM, Simon Horman wrote:
> >On Tue, Mar 13, 2012 at 10:58:40AM +0800, Cong Wang wrote:
> >>On 03/13/2012 08:21 AM, Simon Horman wrote:
> >>>On Thu, Mar 08, 2012 at 02:39:38PM +0800, Cong Wang wrote:
> >>>>Currently the debugging code is under #ifdef DEBUG, which
> >>>>means when we want to debug, we have to re-compile the source
> >>>>code with -DDEBUG. This is not convenient, we want to have
> >>>>a generic --debug option so that we can enable debugging code
> >>>>without re-compiling.
> >>>>
> >>>>This patch moves the arch-specific --debug to generic place
> >>>>and moves code under #ifdef DEBUG to --debug on x86.
> >>>>
> >>>>BTW, the size of kexec binary increases very little after this patch.
> >>>
> >>>Hi Cong,
> >>>
> >>>In general I am happy with making kexec easier to use.  However, it would
> >>>be nice not to make kexec-tools even bigger than it already is. Its size
> >>>already seems to be an issue for some people on ARM at least.  Do you
> >>>have some feeling for the change in binary size on architectures other than
> >>>i386?
> >>>
> >>
> >>Hi,
> >>
> >>I only tested the patches on x86 and ppc.
> >>
> >>Sorry I don't have a chance to test it on ARM, on ARM it just adds a
> >>small function dump_memory_ranges(), if this would be a problem,
> >>feel free to drop patch 3/5. :)
> >
> >Hi,
> >
> >As per my post to the ppc patch, it did not seem to compile for me.
> 
> I did compiling and run tests on ppc64 if you mean ppc32 by "ppc".
> 
> >I will push the remaining patches. For reference before and after
> >sizes for the non-ppc architectures are as follows.
> >
> 
> Ok, I will re-send the ppc patch soon. Thank you!

Sorry, I missed this. But yes, I think it was 32bit ppc where
I saw the problem.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
