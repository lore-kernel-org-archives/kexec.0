Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kf6vR-0003y2-Bi
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 05:47:06 +0000
Date: Mon, 15 Sep 2008 15:47:03 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] IA64: kexec allocates too few memory for kdump kernel
	itself
Message-ID: <20080915054702.GA3160@verge.net.au>
References: <48BEFB47.20004@sgi.com> <20080904000100.GD8974@verge.net.au>
	<48BF3BE8.2050806@sgi.com> <48C028D0.4050202@sgi.com>
	<20080912232710.GE3832@verge.net.au> <48CB0B71.2070308@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48CB0B71.2070308@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Fri, Sep 12, 2008 at 05:38:09PM -0700, Jay Lan wrote:
> Simon Horman wrote:
> >> Hi,
> >>
> >> It should be mem_phdr, got it from mem_ehdr->e_phdr.
> >>
> >>> i=0, p_paddr=3018000000, p_memsz=d04480, p_offset=10000, p_type=1
> >>> i=1, p_paddr=3018d20000, p_memsz=9620, p_offset=d20000, p_type=1
> >>> i=2, p_paddr=3018d30000, p_memsz=564490, p_offset=d30000, p_type=1
> >>> i=3, p_paddr=0, p_memsz=0, p_offset=0, p_type=4
> >> Does anyone understand how the array were created and why there
> >> was a gap between i=0 and i=1 entries? I think this is the problem
> >> but i do not know how to fix it, so tried to work around it.
> >>
> >> The statement my patch replaced was totally broken:
> >>  -			if (loaded_segments[loaded_segments_num].end !=
> >>  -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
> >>  -				break;
> >>  +			if (loaded_segments[loaded_segments_num].end <
> >>  +			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
> >>  +				loaded_segments[loaded_segments_num].end
> >>  +				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
> >>
> >> My debugging showed that when "loaded_segments[loaded_segments_num].end"
> >> != "phdr->p_paddr & ~(ELF_PAGE_SIZE-1)", they were treated as equal
> >> and continue to next statement.  However, if i assign both expression
> >> to local variables and do comparison, the 'break' statement is
> >> executed correctly when two values are not the same. Unfortunately,
> >> consequently the kdump kernel would _alawys_ hang.
> >>
> >> I believe the intent of the original statement is to ensure there is
> >> no gap between entries of mem_phdr array. But if there is a gap,
> >> kexec should simply exit with failure. The 'break' statement just
> >> created a loaded_segment[] array that broke the kernel memory segment
> >> into multiple entries and resulted in the kdump kernel hang in
> >> find_memory(). The IA64 (at least 2.6.27-rc4) kdump kernel works in
> >> some cases today are simply out of luck.
> >>
> >> I believe the real fix is to fix the contents of the mem_phdr array.
> >> Since i do not know how to fix it, my patch would close up the
> >> gap where there is the a gap between entries of the mem_phdr array.
> >>
> >> Does it make more sense to you now, Simon?
> > 
> > Hi Jay,
> > 
> > yes that does make sense. I'd like to poke around and see
> > if mem_phdr can be fixed.
> 
> I think the whole ehdr is read from the kernel binary in
> slurp_decompress_file.
> 
> Bernhard reported a kdump kernel boot problem caused by a patch
> regarding per-cpu variables access in early boot code:
> http://article.gmane.org/gmane.linux.ports.ia64/19380
> 
> I backed out the offending patch and i was no longer able to
> reproduce this problem.
> 
> So, it is safe to say the problem was due to how we process
> data from the vmlinuz.
> 
> The code i tried to change:
> -             if (loaded_segments[loaded_segments_num].end !=
> -                     phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
> -                     break;
> has two problems:
> 1) '!=' operation takes precedence over '&'. If the code is to
>    do what it intends to do, the statement should be:
>               if (loaded_segments[loaded_segments_num].end !=
>                      (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
>                      break;

Good point. That is definately a problem.

> 2) When the 'break' is really executed, you breaks the kernel
>    segment into multiple segments.

I also agree that is a problem. I just wonder what is the
best thing to do about it.

> The code needs fix even if the problem i saw was a result of
> a bug in the kernel.

Agreed.

For now can you make a patch that just fixes precedence logic bug?
Lets merge that and then tackle the more complex broken segment issue.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
