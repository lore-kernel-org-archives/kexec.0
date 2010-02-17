Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NhkHl-00081y-7W
	for kexec@lists.infradead.org; Wed, 17 Feb 2010 13:49:54 +0000
Date: Wed, 17 Feb 2010 08:49:46 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <976749693.1787721266414586815.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <571350993.1786101266414411140.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: FYI: x86_64 bug when using gdb with vmcore
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org


----- "Simon Horman" <horms@verge.net.au> wrote:

> On Fri, Feb 05, 2010 at 11:53:18AM -0500, Dave Anderson wrote:
> > 
> > The kexec/arch/x86_64/crashdump-x86_64.h file contains a
> > stale PAGE_OFFSET value.  In 2.6.27 it was changed from
> > 0xffff810000000000UL to 0xffff880000000000UL.  This is
> > only a problem when using gdb with the vmlinux/vmcore
> > pair, because gdb relies upon the PT_LOAD segment's p_vaddr
> > values in the ELF header to be correct.
> > 
> > Anyway, in the RHEL6 kexec-tools, this simple patch 
> > was made:
> > 
> > -#define PAGE_OFFSET            0xffff810000000000UL
> > +#define PAGE_OFFSET            0xffff880000000000UL
> > 
> > which is OK since the RHEL6 version of kexec-tools
> > will only be used with RHEL6 kernels.  
> > 
> > But for backwards compatibility, the better way to do 
> > it would be to check the utsname of the running kernel, 
> > and use the right value.
> > 
> > But again, this is only required for gdb usage.  The 
> > crash utility (and makedumpfile) make kernel version checks 
> > to determine which x86_64 PAGE_OFFSET value is applicable,
> > and don't rely on the ELF header p_vaddr values for
> > the unity-mapped regions.  
> 
> Hi Dave,
> 
> Something like this?

Looks good to me -- all except for the second "if" statement/typo below:  

> +int arch_init(void)
> +{
> +	int kv;
> +
> +	kv = kernel_version();
> +	if (kv < 0)
> +		return -1;
> +
> +	if (kv < KERNEL_VERSION(2, 4, 27))
> +		page_offset = PAGE_OFFSET_PRE_2_6_27;
> +	else
> +		page_offset = PAGE_OFFSET;
> +
> +	return 0;
> +}

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
