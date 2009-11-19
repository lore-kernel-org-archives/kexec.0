Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NB85Z-00089D-3H
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 14:34:30 +0000
Date: Thu, 19 Nov 2009 09:33:43 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump issue with percpu_alloc=lpage
Message-ID: <20091119143343.GB8741@redhat.com>
References: <4AE8B612.9080103@ccur.com> <4B03BD7A.9040500@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B03BD7A.9040500@kernel.org>
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
To: Tejun Heo <tj@kernel.org>
Cc: John Blackwood <john.blackwood@ccur.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Nov 18, 2009 at 06:25:14PM +0900, Tejun Heo wrote:
> Hello,
> 
> 10/29/2009 06:22 AM, John Blackwood wrote:
> >> Thanks Tejun. percpu_to_phys() makes sense to me also. John, would you
> >> like to post a patch for this.
> > 
> > Hi Vivek,
> > 
> > I'm probably not really NUMA/vm savy enough to attempt a patch
> > for approval at LKML.
> > 
> > But maybe someone else more qualified can take up the cause.
> 
> Is this still necessary for the current upstream where lpage allocator
> is gone (but vmalloc mapping is still there)?
> 

Hi Tejun,

I did load a kdump kernel on 32-rc7 and it worked fine. But I guess in
this case memory might have come from linearly mapped region.

If the default per cpu allocator can get memory from vmalloc region also, then
I think we will need this function which can map virtual address to
physical address.

Are there multiple allocators now? If yes, what are the command line
options and I can try to use some other allocator and see if I can force
the condition where memory comes from vmalloc region and I observe the
crash.

Once I can reproduce it, I can also send you the fix you suggested.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
