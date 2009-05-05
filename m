Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M1LyP-0008M4-Ca
	for kexec@lists.infradead.org; Tue, 05 May 2009 14:50:28 +0000
Date: Tue, 5 May 2009 10:49:37 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] sysrq: Simplify sysrq-c handler
Message-ID: <20090505144937.GD11817@hmsreliant.think-freely.org>
References: <20090505134547.GA11780@hmsreliant.think-freely.org>
	<20090505142359.GB9909@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090505142359.GB9909@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, ebiederm@xmission.com

On Tue, May 05, 2009 at 10:23:59AM -0400, Vivek Goyal wrote:
> On Tue, May 05, 2009 at 09:45:47AM -0400, Neil Horman wrote:
> > Currently the sysrq-c handler is bit over-engineered.  Its behavior is dependent
> > on a few compile time and run time factors that alter its behavior which is
> > really unnecessecary.  If CONFIG_KEXEC is not configured, sysrq-c, crashes the
> > system with a NULL pointer dereference.  If CONFIG_KEXEC is configured, it calls
> > crash_kexec directly, which implies that the kexec kernel will either be booted
> > (if its been previously loaded), or it will simply do nothing (the no kexec
> > kernel has been loaded).  It would be much easier to just simplify the whole
> > thing to dereference a NULL pointer all the time regardless of configuration.
> > That way, it will always try to crash the system, and if a kexec kernel has been
> > loaded into reserved space, it will still boot from the page fault trap handler
> > (assuming panic_on_oops is set appropriately).
> > 
> 
> Neil,
> 
> Would it make sense to call panic() directly so that we are not dependent
> on panic_on_oops being set?
> 
> Thanks
> Vivek
> 
I think a good argument could be made for doing that, but I kind of like
traversing the entire page fault path, specifically to make sure that an oops
works the way they expect it too.  If nothing else, going through the entire
oops path like I do below will (hopefully) prevent people from complaining that
sysrq-c works, but when their custom module gets an OOPS, then never get a
vmcore :).

I'll defer to an opposing consensus of course, but I think going through the
entire oops path is a better solution.
Regards
Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
