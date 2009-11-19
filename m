Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NB8Eu-0002lh-2R
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 14:44:04 +0000
Message-ID: <4B055A05.2010205@kernel.org>
Date: Thu, 19 Nov 2009 23:45:25 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: Kdump issue with percpu_alloc=lpage
References: <4AE8B612.9080103@ccur.com> <4B03BD7A.9040500@kernel.org>
	<20091119143343.GB8741@redhat.com>
In-Reply-To: <20091119143343.GB8741@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: John Blackwood <john.blackwood@ccur.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

11/19/2009 11:33 PM, Vivek Goyal wrote:
> I did load a kdump kernel on 32-rc7 and it worked fine. But I guess in
> this case memory might have come from linearly mapped region.
> 
> If the default per cpu allocator can get memory from vmalloc region
> also, then I think we will need this function which can map virtual
> address to physical address.

I see.

> Are there multiple allocators now? If yes, what are the command line
> options and I can try to use some other allocator and see if I can force
> the condition where memory comes from vmalloc region and I observe the
> crash.
> 
> Once I can reproduce it, I can also send you the fix you suggested.

Now there are two allocators - embed (default) and page.  You can
choose using percpu_alloc= parameter.  Embed allocator will put the
first chunk in linear mapping area while page will put the first chunk
in vmalloc area too but regardless of the allocator from the second
chunk it will always be in the vmalloc area.  So, either using
percpu_alloc=page or allocating some amount of percpu memory using
__alloc_percpu() - a thousand 4k blocks will always be enough - should
do it.

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
