Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4V2Y-0006Kr-1o
 for kexec@lists.infradead.org; Mon, 24 Sep 2018 17:52:59 +0000
Date: Mon, 24 Sep 2018 12:52:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3 v3] resource: fix an error which walks through iomem
 resources
Message-ID: <20180924175241.GO224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
 <20180921073211.20097-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180921073211.20097-2-lijiang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lianbo Jiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

On Fri, Sep 21, 2018 at 03:32:09PM +0800, Lianbo Jiang wrote:
> When we walk through iomem resources by calling walk_iomem_res_desc(),
> the values of the function parameter may be modified in the while loop
> of __walk_iomem_res_desc(), which will cause us to not get the desired
> result in some cases.

If I understand correctly, the issue is caused by the interaction
between __walk_iomem_res_desc() and find_next_iomem_res() in this
path:

  __walk_iomem_res_desc
    find_next_iomem_res
      res->flags = p->flags;            # <-- problem

This path is used by the following interfaces, and I think your patch
would fix the issue for them:

  walk_iomem_res_desc()
  walk_system_ram_res()
  walk_mem_res()

However, find_next_iomem_res() is also used directly by
walk_system_ram_range().  I think that path has the same problem, and
your patch does not fix that path.

I have a few more comments related to the existing code that I'll post
soon.

> At present, it only restores the original value of res->end, but it
> doesn't restore the original value of res->flags in the while loop of
> __walk_iomem _res_desc(). Whenever the find_next_iomem_res() finds a
> resource and returns the result, the original values of this resource
> will be modified, which might lead to an error in the next loop. For
> example:
> 
> The original value of resource flags is:
>  res->flags=0x80000200(initial value)
> 
> p->flags   _ 0x81000200 _                _ 0x80000200 _
>           /              \              /              \
> |________|_______A________|____|_....._|______B_________|..........___|
> 0                                                            0xffffffff
>                 (memory address ranges)
> 
> Note: if ((p->flags & res->flags) != res->flags) continue;
> 
> When the resource A is found, the original value of this resource flags
> will be changed to 0x81000200(res->flags=0x81000200), and continue to
> look for the next resource, when the loop reaches resource B, it can not
> get the resource B any more(you can refer to the for loop of find_next
> _iomem_res()), because the value of conditional expression will become
> true and will also jump the resource B.
> 
> In fact, we should get the resource A and B when we walk through the
> whole tree, but it only gets the resource A, the resource B is missed.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kernel/resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..f5d9fc70a04c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -375,6 +375,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  				 int (*func)(struct resource *, void *))
>  {
>  	u64 orig_end = res->end;
> +	u64 orig_flags = res->flags;
>  	int ret = -1;
>  
>  	while ((res->start < res->end) &&
> @@ -385,6 +386,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  
>  		res->start = res->end + 1;
>  		res->end = orig_end;
> +		res->flags = orig_flags;
>  	}
>  
>  	return ret;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
