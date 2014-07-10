Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X594u-0001jd-8N
 for kexec@lists.infradead.org; Thu, 10 Jul 2014 07:47:40 +0000
Date: Thu, 10 Jul 2014 15:47:13 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: Can't load bzImage crashkernel on xen system with 32 bit kernel
Message-ID: <20140710074713.GA23099@dhcp-17-89.nay.redhat.com>
References: <53BBC94B.8060905@overnetdata.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BBC94B.8060905@overnetdata.com>
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
To: Anthony Wright <anthony@overnetdata.com>
Cc: kexec@lists.infradead.org

Hi, Anthony

On 07/08/14 at 11:34am, Anthony Wright wrote:
> After successfully modifying kexec-tools to get it to load a crashkernel
> on a standard 32 bit linux 3.10.17 kernel, I tried to get it to load the
> same crashkernel on the same 32 bit linux kernel running under xen
> 4.4.0, but get the error "Cannot load <kernel-path>".
> 
> I've patched the code to include some diagnostics, and the problem is
> caused by add_memmap() reporting that it's been called with overlapping
> memory.
> 
> It's called twice, the first time it's called with:
> 	address: 0x00000000
> 	size:    0x0009f800
> 	type:    0
> 
> This comes from info->backup_src_*
> 
> The second time it is passed
> 	address: 0x00000000
> 	size:    0x00000000
> 	type:    0
> 
> This is derived from the crash_reserved_mem[] array, which has one
> element with the values:
> 	start: 0x0000000000000000 (16 0's)
> 	end:   0xffffffffffffffff (16 f's)

Why it looks like that? crashkernel memory region shouldn't be that
extreme.

Maybe there's something wrong when it retrieves crashkernel reserved
region. How you does your /proc/iomem look like?

Turn on debug option (-d) would be helpful too.

> 
> The problem isn't caused by the zero size because the maths in
> add_memmap, uses size to calculate end which overflows back again, and
> (partially) cancels out the error. The problem is caused by the two
> memory blocks being based at 0x0, causing the blocks to overlap.

The overflow issue should be easy to fix once we figure out why the
crash_reserved_mem[] has a element like that.

Thanks
WANG Chao

> 
> I'm not sure what the correct functionality should be.
> 
> Thanks,
> 
> Anthony.
> 
> 
> -- 
> Founder, Overnet Data Ltd
> +44-1604-807545
> www.overnetdata.com
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
