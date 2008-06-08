Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from saeurebad.de ([85.214.36.134])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5Sxf-0001o6-07
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 22:02:03 +0000
From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
Date: Mon, 09 Jun 2008 00:01:15 +0200
In-Reply-To: <20080608134629.743220278@halley.suse.de> (Bernhard Walle's
	message of "Sun, 08 Jun 2008 15:46:30 +0200")
Message-ID: <87bq2bmvro.fsf@saeurebad.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

Hi,

Bernhard Walle <bwalle@suse.de> writes:

> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -798,12 +798,13 @@ void free_initrd_mem(unsigned long start
>  }
>  #endif
>  
> -void __init reserve_bootmem_generic(unsigned long phys, unsigned len)
> +int __init reserve_bootmem_generic(unsigned long phys, unsigned len, int flags)
>  {
>  #ifdef CONFIG_NUMA
>  	int nid, next_nid;
>  #endif
>  	unsigned long pfn = phys >> PAGE_SHIFT;
> +	int ret;
>  
>  	if (pfn >= end_pfn) {
>  		/*
> @@ -811,11 +812,11 @@ void __init reserve_bootmem_generic(unsi
>  		 * firmware tables:
>  		 */
>  		if (pfn < max_pfn_mapped)
> -			return;
> +			return -EFAULT;

This seemed to be `just do nothing' behaviour.  Wouldn't 0 be more
correct here?  Or something else so there is a difference between the
path that does not print a warning (the one below) and the path that
does?

>  
>  		printk(KERN_ERR "reserve_bootmem: illegal reserve %lx %u\n",
>  				phys, len);
> -		return;
> +		return -EFAULT;
>  	}

	Hannes

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
