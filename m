Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4iFb-0001Mg-6A
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 23:23:03 +0000
Date: Wed, 30 Mar 2011 08:22:59 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] kexec, x86: fix kexec when
	boot_params.hardware_subarch != 0
Message-ID: <20110329232259.GC27905@verge.net.au>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
	<20110328215011.30400.91252.stgit@localhost6.localdomain6>
	<ims7bl$ik5$1@dough.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ims7bl$ik5$1@dough.gmane.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 29, 2011 at 09:04:53AM +0000, WANG Cong wrote:
> On Mon, 28 Mar 2011 14:50:11 -0700, Chris Leech wrote:
> 
> > kexec needs to keep the subarch setting the same as the running kernel
> > in the boot parameters, or the kernel will die in early setup.  I ran
> > into this with X86_SUBARCH_MRST, but it should apply to CE4100 and any
> > future subarch that uses non-default early setup code.
> > 
> > This patch requires debugfs mounted at /sys/kernel/debug, as that's the
> > only way I know of to get at the running kernels boot_params. Without
> > debugfs mounted it falls back to the current behavior of assuming
> > subarch 0.
> > 
> ...
> >  
> > +#define BOOT_PARAMS_DBGFS	"/sys/kernel/debug/boot_params/data"
> 
> A minor issue here is that you are using a hard-coded debugfs path,
> debugfs can be also mounted to /debug too, so it is better that if we can 
> search the path dynamically here.

Do you think it would be better for the code to loop through
a few common alternatives for the path?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
