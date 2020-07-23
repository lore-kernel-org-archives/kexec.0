Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jycPK-0000Di-Fx
 for kexec@lists.infradead.org; Thu, 23 Jul 2020 14:41:15 +0000
From: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCHv3 1/2] powerpc/pseries: group lmb operation and memblock's
In-Reply-To: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
Date: Thu, 23 Jul 2020 09:41:06 -0500
Message-ID: <87ft9i1egt.fsf@linux.ibm.com>
MIME-Version: 1.0
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Hari Bathini <hbathini@linux.ibm.com>

Pingfan Liu <kernelfans@gmail.com> writes:
> This patch prepares for the incoming patch which swaps the order of KOBJ_
> uevent and dt's updating.
>
> It has no functional effect, just groups lmb operation and memblock's in
> order to insert dt updating operation easily, and makes it easier to
> review.

...

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 5d545b7..1a3ac3b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -355,7 +355,8 @@ static int dlpar_add_lmb(struct drmem_lmb *);
>  static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  {
>  	unsigned long block_sz;
> -	int rc;
> +	phys_addr_t base_addr;
> +	int rc, nid;
>  
>  	if (!lmb_is_removable(lmb))
>  		return -EINVAL;
> @@ -364,17 +365,19 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  	if (rc)
>  		return rc;
>  
> +	base_addr = lmb->base_addr;
> +	nid = lmb->nid;
>  	block_sz = pseries_memory_block_size();
>  
> -	__remove_memory(lmb->nid, lmb->base_addr, block_sz);
> -
> -	/* Update memory regions for memory remove */
> -	memblock_remove(lmb->base_addr, block_sz);
> -
>  	invalidate_lmb_associativity_index(lmb);
>  	lmb_clear_nid(lmb);
>  	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
>  
> +	__remove_memory(nid, base_addr, block_sz);
> +
> +	/* Update memory regions for memory remove */
> +	memblock_remove(base_addr, block_sz);
> +
>  	return 0;
>  }

I don't understand; the commit message should not claim this has no
functional effect when it changes the order of operations like
this. Maybe this is an improvement over the current behavior, but it's
not explained why it would be.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
