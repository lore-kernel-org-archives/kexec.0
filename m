Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2ata-00075O-4F
 for kexec@lists.infradead.org; Mon, 03 Aug 2020 13:52:55 +0000
From: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCHv4 1/2] powerpc/pseries: group lmb operation and memblock's
References: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
Message-ID: <ee585548-aefc-ff3f-6a79-e616b9e04f12@linux.ibm.com>
Date: Mon, 3 Aug 2020 15:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org, Pingfan Liu <kernelfans@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>

> @@ -603,6 +606,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>         }
>
>         lmb_set_nid(lmb);
> +       lmb->flags |= DRCONF_MEM_ASSIGNED;
> +
>         block_sz = memory_block_size_bytes();
>
>         /* Add the memory */

Since the lmb->flags is now set earlier, you should unset it in the case the 
call to __add_memory() fails, something like:

@@ -614,6 +614,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
  	rc = __add_memory(lmb->nid, lmb->base_addr, block_sz);
  	if (rc) {
  		invalidate_lmb_associativity_index(lmb);
+		lmb->flags &= ~DRCONF_MEM_ASSIGNED;
  		return rc;
  	}

> @@ -614,11 +619,14 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>
>         rc = dlpar_online_lmb(lmb);
>         if (rc) {
> -               __remove_memory(lmb->nid, lmb->base_addr, block_sz);
> +               int nid = lmb->nid;
> +               phys_addr_t base_addr = lmb->base_addr;
> +
>                 invalidate_lmb_associativity_index(lmb);
>                 lmb_clear_nid(lmb);
> -       } else {
> -               lmb->flags |= DRCONF_MEM_ASSIGNED;
> +               lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> +
> +               __remove_memory(nid, base_addr, block_sz);
>         }
>
>         return rc;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
