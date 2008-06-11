Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6SPk-0003xl-5N
	for kexec@lists.infradead.org; Wed, 11 Jun 2008 15:39:08 +0000
Date: Wed, 11 Jun 2008 11:39:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Limit E820 map and /proc/iomem for mem parameter on x86-64
Message-ID: <20080611153901.GD6450@redhat.com>
References: <20080610215325.GA20673@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080610215325.GA20673@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bernhard Walle <bwalle@suse.de>

On Tue, Jun 10, 2008 at 11:53:25PM +0200, Bernhard Walle wrote:
> This patch tries to unify the behaviour of i386 and x86-64 when parsing
> the memory (mem/memmap) parameter of the kernel command line:
> 
> On i386, the view was limited (i.e. the actual view was presented).
> On x86-64, the view was full (i.e. the BIOS view was presented).
> 
> This patch moves the limit_regions() function and the print_memory_map()
> function to a new file e820.c, shared between the two x86 flavours. Then
> it adds calls to limit_regions() in 64 bit code.
> 
> I gave the patch a bit testing. However, it's not for merging, it's just
> to get early feedback to see if that goes into the right direction.
> 
> 

I would like to have consistent behavior of /proc/iomem across i386
and x86_64, so this sounds like right direction to me.

Also I would like to have another interface (say /proc/iomem_kernel)which
actually gets modified based on the user specified options. So effectively we
can have both the views. BIOS view and user defined view.

As discussed on kexec mailing list, it helps kexec and kdump operation. 
In the case of kexec, we want to know the actual resources present in 
the system so that new kernel can see it (Irrespective of the fact
what first kernel was actually using).

In case of kdump, we want to see truncated view so that we don't end
up capturing the contents of memory not being used by kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
