Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5kB3-0003he-NK
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 16:25:02 +0000
Date: Mon, 9 Jun 2008 18:25:37 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080609182537.06847134@halley.suse.de>
In-Reply-To: <87bq2bmvro.fsf@saeurebad.de>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<87bq2bmvro.fsf@saeurebad.de>
Mime-Version: 1.0
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
To: Johannes Weiner <hannes@saeurebad.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

* Johannes Weiner [2008-06-09 00:01]:
>
> >  		/*
> > @@ -811,11 +812,11 @@ void __init reserve_bootmem_generic(unsi
> >  		 * firmware tables:
> >  		 */
> >  		if (pfn < max_pfn_mapped)
> > -			return;
> > +			return -EFAULT;
> 
> This seemed to be `just do nothing' behaviour.  Wouldn't 0 be more
> correct here?  Or something else so there is a difference between the
> path that does not print a warning (the one below) and the path that
> does?

Well, I don't think that we should return success when memory
allocation fails. For kdump, I think if the memory has not been
reserved, then the function should failed, for whatever reason it
failed. Because we cannot load the crashkernel.

So IMO the code should look like

[...]
	int ret;

	if (pfn >= end_pfn)
		return -EFAULT;

	/* Should check here against the e820 map to avoid double free */
#ifdef CONFIG_NUMA
	nid = phys_to_nid(phys);
[...]


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
