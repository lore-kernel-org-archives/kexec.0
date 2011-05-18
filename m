Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QMWgk-0005bc-7h
	for kexec@lists.infradead.org; Wed, 18 May 2011 02:40:43 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QMWgi-0001yP-DM
	for kexec@lists.infradead.org; Wed, 18 May 2011 04:40:40 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 04:40:40 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 04:40:40 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Kexec & Memory Zones question
Date: Wed, 18 May 2011 02:40:26 +0000 (UTC)
Message-ID: <iqvbiq$ctv$2@dough.gmane.org>
References: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
	<20110511150908.GG31633@redhat.com> <iqgb8m$ruq$1@dough.gmane.org>
	<BANLkTi=ds+qwHd5D3LiYQQf6-zqDOkZ_dw@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Tue, 17 May 2011 19:05:13 -0700, Sujit V wrote:

> We found the root cause for this issue in the bootmem allocator.
> 
> The 96GB NUMA system has two memory nodes each with 48GB. node 0 had
> zone dma, dma32 & normal
> node 1 had only zone normal.
> 
> During the early boot i.e kernel/setup.c The bootmem allocator uses the
> API find_free_area from the e820 map to allocate some of its data
> structures.[ i.e the bitmap ] (The bootmem bitmap is used to track free
> & used pages with 1bit for 4K page. The reserve_bootmem() API is used to
> reserve)
> 
> The amount of memory required to represent the bitmap for node 0 with
> 48GB is. (48GB / (4K * 8)) = 1.5MB
> 
> The start address of the free area of size 1.5 MB returned by e820 map
> was
>>> bitmap starts at  PA (0xf9b000) size 1.5MB
> 0xf9b000 + 1.5 MB = 17.13MB
> 
> The bootmem bitmap used the 1.13MB section from the supposed crashkernel
> reserved area.
> Later when boot param parsing looks at the crashkernel=128M@16M and
> reserves the area using the reserve_bootmem().
> 
> 
> Later when paging_init() is called the bootmem allocator is retired. At
> this point it free's the memory allocated to the bitmap & gives it to
> the system page allocator.
> i.e pages from 16MB to 17.13 MB are given to the system page allocator.
> (Even though the page is reserved by crashkernel.  ]
> 
> So pages in this memory range were given some system resources. When
> kexec loaded the kdump kernel in the 128M@16M range it corrupted that
> memory & we saw the system crash.
> 
> I fixed the boot mem allocator and then things worked correctly.


Yes, this is a bug of bootmem allocator. Before switching to memblock,
the old bootmem allocator marks the crashkernel as exclusive, which
means it should use any memory area used by others, thus in this case
crashkernel memory reservation should fail.

> 
> 
> Ours is a 2.6.23 kernel.
> The later versions of the kernel have some other mechanism for early
> memory reservation (like early_res & memblock)
> 

Right, I think that version of kernel is still using the old bootmem 
allocator, so you can change the crashkernel reservation to be 
exclusively.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
