Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KHGVq-0000v0-4t
	for kexec@lists.infradead.org; Fri, 11 Jul 2008 11:10:18 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6BB9Th2001771
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2008 16:39:29 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6BB96Tg1216706
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2008 16:39:06 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6BB9S0X006389
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2008 16:39:28 +0530
From: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	=?iso-8859-1?q?=09dynamic-reconfiguration-memory_for?= kexec/kdump
Date: Fri, 11 Jul 2008 16:39:21 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<48768CE9.2080802@austin.ibm.com>
In-Reply-To: <48768CE9.2080802@austin.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807111639.22032.chandru@in.ibm.com>
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
To: Nathan Fontenot <nfont@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

On Friday 11 July 2008 03:57:53 Nathan Fontenot wrote:
> Hello Chandru,
>
> >  static int __init early_init_dt_scan_drconf_memory(unsigned long node)
> >  {
> > -	cell_t *dm, *ls;
> > +	cell_t *dm, *ls, *endp, *usm;
> >  	unsigned long l, n, flags;
> >  	u64 base, size, lmb_size;
> > +	char buf[32], t[8];
> >
> >  	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
> >  	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
> > @@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
> >  			if ((base + size) > 0x80000000ul)
> >  				size = 0x80000000ul - base;
> >  		}
> > -		lmb_add(base, size);
> > +		strcpy(buf, "linux,usable-memory");
> > +		sprintf(t, "%d", (int)n);
> > +		strcat(buf, t);
> > +		usm = (cell_t *)of_get_flat_dt_prop(node,
> > +						 (const char *)buf, &l);
> > +		if (usm != NULL) {
> > +			endp = usm + (l / sizeof(cell_t));
> > +			while ((endp - usm) >= (dt_root_addr_cells +
> > +						 dt_root_size_cells)) {
> > +				base = dt_mem_next_cell(dt_root_addr_cells,
> > +								 &usm);
> > +				size = dt_mem_next_cell(dt_root_size_cells,
> > +								 &usm);
> > +				if (size == 0)
> > +					continue;
> > +				if (iommu_is_off) {
> > +					if ((base + size) > 0x80000000ul)
> > +						size = 0x80000000ul - base;
> > +				}
> > +				lmb_add(base, size);
> > +			}
> > +
> > +			/* Continue with next lmb entry */
> > +			continue;
> > +		} else {
> > +			lmb_add(base, size);
> > +		}
> >  	}
>
> I am still digging through the kexec tools but I don't think you want
> the processing of the linux,usable-memory property inside of the
> for (; n!= 0; --n) loop.  This should be moved up so that it looks for
> the linux,usable-memory property and parses it, then if it is not found
> look for the ibm,dynamic-reconfiguration-memory property and parse it.
>
> There is no need to look for the linux-usable-memory property every time
> a piece of the ibm,dynamic-reconfiguration-memory property is parsed.
>
> -Nathan

Hello Nathan,

Thanks for the review. kexec-tools adds a 'linux,usable-memory' property for 
each memory range listed in the device tree.  If the regions are not 
crashkernel or rtas or tce regions, then it sets base and size to zero but 
still adds them as linux,usable-memory property.  If we look at the code 
above, in a kdump kernel we don't add an lmb through lmb_add() if the regions 
are not one of the mentioned above.  We check for (size == 0) and continue 
with next lmb if it is so.  We still have the complete device tree which 
kexec-tools passes in as the buffer that we are scanning here and 
linux,usable-memory  properties aid in making kdump kernel to see only those 
memory regions that it is suppose to use.  I just worked on another version 
of this patch based on comments from Michael Neuling and Stephen Rothwell. I 
will post it shortly.


Thanks,
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
