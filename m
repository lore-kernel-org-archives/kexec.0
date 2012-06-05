Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SblsY-0004Cu-HV
 for kexec@lists.infradead.org; Tue, 05 Jun 2012 05:00:28 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5550Hk8002850
 for <kexec@lists.infradead.org>; Tue, 5 Jun 2012 14:00:17 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5550HO11610 for kexec@lists.infradead.org;
 Tue, 5 Jun 2012 14:00:17 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5550H7h019944
 for <kexec@lists.infradead.org>; Tue, 5 Jun 2012 14:00:17 +0900 (JST)
Date: Tue, 5 Jun 2012 13:57:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Message-Id: <20120605135740.d1e4c41f.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120531173307.0ab11595.nishimura@mxp.nes.nec.co.jp>
References: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120531173307.0ab11595.nishimura@mxp.nes.nec.co.jp>
Mime-Version: 1.0
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
To: nishimura@mxp.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Hello Nishimura-san,

On Thu, 31 May 2012 17:33:07 +0900
Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp> wrote:

> From the POV of adding partial bitmaps, I think it would be better to include
> following hunks in [3/4] into [2/4].

The functions below are just initializer for partial bitmaps, so it may be better
to include them in [2/4] as you said. Thank you for your advice.


Thanks
Atsushi Kumagai

> > @@ -3954,6 +4019,39 @@ prepare_bitmap_buffer(void)
> >  	return TRUE;
> >  }
> >  
> > +int
> > +prepare_bitmap_buffer_cyclic(void)
> > +{
> > +	unsigned long tmp;
> > +
> > +	/*
> > +	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
> > +	 * The crash utility requires both of them to be aligned to block_size
> > +	 * boundary.
> > +	 */
> > +	tmp = divideup(divideup(info->max_mapnr, BITPERBYTE), info->page_size);
> > +	info->len_bitmap = tmp*info->page_size*2;
> > +
> > +
> > +	/*
> > +	 * Prepare bitmap buffers for creating dump bitmap.
> > +	 */
> > +	if ((info->partial_bitmap1 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
> > +		ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
> > +		       strerror(errno));
> > +		return FALSE;
> > +	}
> > +	if ((info->partial_bitmap2 = (char *)malloc(BUFSIZE_CYCLIC)) == NULL) {
> > +		ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
> > +		       strerror(errno));
> > +		return FALSE;
> > +	}
> > +	initialize_bitmap_cyclic(info->partial_bitmap1);
> > +	initialize_bitmap_cyclic(info->partial_bitmap2);
> > +
> > +	return TRUE;
> > +}
> > +
> >  void
> >  free_bitmap_buffer(void)
> >  {
> > @@ -3974,14 +4072,17 @@ create_dump_bitmap(void)
> >  {
> >  	int ret = FALSE;
> >  
> > -	if (!prepare_bitmap_buffer())
> > -		goto out;
> > -
> > -	if (!create_1st_bitmap())
> > -		goto out;
> > -
> > -	if (!create_2nd_bitmap())
> > -		goto out;
> > +	if (info->flag_cyclic) {
> > +		if (!prepare_bitmap_buffer_cyclic())
> > +			goto out;
> > +	} else {
> > +		if (!prepare_bitmap_buffer())
> > +			goto out;
> > +		if (!create_1st_bitmap())
> > +			goto out;
> > +		if (!create_2nd_bitmap())
> > +			goto out;
> > +	}
> >  
> >  	ret = TRUE;
> >  out:
> ...
> > @@ -7242,6 +7364,10 @@ out:
> >  			free(info->splitting_info);
> >  		if (info->p2m_mfn_frame_list != NULL)
> >  			free(info->p2m_mfn_frame_list);
> > +		if (info->partial_bitmap1 != NULL)
> > +			free(info->partial_bitmap1);
> > +		if (info->partial_bitmap2 != NULL)
> > +			free(info->partial_bitmap2);
> >  		free(info);
> >  	}
> >  	free_elf_info();
> 
> Thanks,
> Daisuke Nishimura.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
