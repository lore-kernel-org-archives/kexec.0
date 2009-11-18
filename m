Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NAgmu-0006Lu-PY
	for kexec@lists.infradead.org; Wed, 18 Nov 2009 09:25:21 +0000
Message-ID: <4B03BD7A.9040500@kernel.org>
Date: Wed, 18 Nov 2009 18:25:14 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: Kdump issue with percpu_alloc=lpage
References: <4AE8B612.9080103@ccur.com>
In-Reply-To: <4AE8B612.9080103@ccur.com>
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
To: John Blackwood <john.blackwood@ccur.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

Hello,

10/29/2009 06:22 AM, John Blackwood wrote:
>> Thanks Tejun. percpu_to_phys() makes sense to me also. John, would you
>> like to post a patch for this.
> 
> Hi Vivek,
> 
> I'm probably not really NUMA/vm savy enough to attempt a patch
> for approval at LKML.
> 
> But maybe someone else more qualified can take up the cause.

Is this still necessary for the current upstream where lpage allocator
is gone (but vmalloc mapping is still there)?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
