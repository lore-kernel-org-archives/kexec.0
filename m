Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llnhK-00BvNN-7U
 for kexec@lists.infradead.org; Wed, 26 May 2021 07:11:24 +0000
Date: Wed, 26 May 2021 15:11:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Documentation: kdump: update kdump guide
Message-ID: <20210526071108.GB2872@MiWiFi-R3L-srv>
References: <20210520103729.13696-1-bhe@redhat.com>
 <YKzidlzM6UCdzpA9@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKzidlzM6UCdzpA9@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>

On 05/25/21 at 07:41pm, Dave Young wrote:
> Hi Baoquan,
> > @@ -180,7 +191,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
> >  
> >  	CONFIG_SMP=n
> >  
> > -   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
> > +   (If CONFIG_SMP=y, then specify nr_cpus=1 on the kernel command line
> >     when loading the dump-capture kernel, see section "Load the Dump-capture
> >     Kernel".)
> 
> This part should be obsolete?  Since for X86_64 we can enable smp boot
> with disable_cpu_apicid=X set (see the Notes on loading the dump-capture
> kernel part)  So I think no need to disable CONFIG_SMP at all.  The
> current RHEL use of nr_cpus=1 is just to save 2nd kernel memory use.

Keeping them because they are not wrong. Talking about default config,
currently we only care about x86_64 mostly, not sure if we should remove
i386 part too. Anyway, I am fine to remove them and the below
relocatable thing.

> 
> Ditto for the text for other arches, not sure if they need update
> though, see if other maintainers can provide inputs..
> 
> 
> Otherwise for the CONFIG_RELOCATABLE related part,  it may be better to
> update as well? 
> ''' quote:
> 3) If one wants to build and use a relocatable kernel,
>    Enable "Build a relocatable kernel" support under "Processor type and
>    features"::
> 
>         CONFIG_RELOCATABLE=y
> 
> 4) Use a suitable value for "Physical address where the kernel is
>    loaded" (under "Processor type and features"). This only appears when
>    "kernel crash dumps" is enabled. A suitable value depends upon
>    whether kernel is relocatable or not.
> 
>    If you are using a relocatable kernel use CONFIG_PHYSICAL_START=0x100000
>    This will compile the kernel for physical address 1MB, but given the fact
>    kernel is relocatable, it can be run from any physical address hence
>    kexec boot loader will load it in memory region reserved for dump-capture
>    kernel.
> 
>    Otherwise it should be the start of memory region reserved for
>    second kernel using boot parameter "crashkernel=Y@X". Here X is
>    start of memory region reserved for dump-capture kernel.
>    Generally X is 16MB (0x1000000). So you can set
>    CONFIG_PHYSICAL_START=0x1000000
> ''' end quote
> 
> Since relocatable kernel is used by default now so we may just not describe it as "If one
> want to build with it =y", I feel it should be a corner case instead of
> the default use case.   Maybe HPA, Vivek, Eric can provide more opinions since
> they may know more about the background.  
> 
> >  
...  
> > -Boot into System Kernel
> > -=======================
> > +       crashkernel=512M-2G:64M,2G-:128M
> >  
> > +   This would mean:
> > +
> > +       1) if the RAM is smaller than 512M, then don't reserve anything
> > +          (this is the "rescue" case)
> > +       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> > +       3) if the RAM size is larger than 2G, then reserve 128M
> > +
> > +3) crashkernel=size,high and crashkernel=size,low
> > +
> > +   If memory above 4G is preferred, crashkernel=size,high can be used to
> > +   fulfill that. With it, physical memory is allowed to allocate from top,
> > +   so could be above 4G if system has more than 4G RAM installed. Otherwise,
> > +   memory region will be allocated below 4G if available.
> > +
> > +   When crashkernel=X,high is passed, kernel could allocate physical memory
> > +   region above 4G, low memory under 4G is needed in this case. There are
> > +   three ways to get low memory:
> > +
> > +      1) Kernel will allocate at least 256M memory below 4G automatically
> > +         if crashkernel=Y,low is not specified.
> > +      2) Let user specify low memory size instread.
> > +      3) Specified value 0 will disable low memory allocation::
> > +
> > +            crashkernel=0,low
> > +
> > +Boot into System Kernel
> > +-----------------------
> >  1) Update the boot loader (such as grub, yaboot, or lilo) configuration
> >     files as necessary.
> >  
> > -2) Boot the system kernel with the boot parameter "crashkernel=Y@X",
> > -   where Y specifies how much memory to reserve for the dump-capture kernel
> > -   and X specifies the beginning of this reserved memory. For example,
> > -   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
> > -   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
> > +2) Boot the system kernel with the boot parameter "crashkernel=Y@X".
> >  
> >     On x86 and x86_64, use "crashkernel=64M@16M".
> 
> For the recommendation of crashkernel it would be better to drop the
> @16M since most people do not need it?

It's only an example? Change it as "crashkernel=128M" instead to make it
more helpful?

> 
> >  
> > @@ -392,7 +432,7 @@ loading dump-capture kernel.
> >  
> >  For i386, x86_64 and ia64:
> >  
> > -	"1 irqpoll maxcpus=1 reset_devices"
> > +	"1 irqpoll nr_cpus=1 reset_devices"
> >  
> >  For ppc64:
> >  
> > @@ -400,7 +440,7 @@ For ppc64:
> >  
> >  For s390x:
> >  
> > -	"1 maxcpus=1 cgroup_disable=memory"
> > +	"1 nr_cpus=1 cgroup_disable=memory"
> >  
> >  For arm:
> >  
> > @@ -408,7 +448,7 @@ For arm:
> >  
> >  For arm64:
> >  
> > -	"1 maxcpus=1 reset_devices"
> > +	"1 nr_cpus=1 reset_devices"
> >  
> >  Notes on loading the dump-capture kernel:
> >  
> > @@ -487,7 +527,12 @@ After the dump-capture kernel is booted, write out the dump file with
> >  the following command::
> >  
> >     cp /proc/vmcore <dump-file>
> > +   scp /proc/vmcore to <user@server>:<path>/%HOST-%DATE/
> > +
> > +You can also use makedumpfile utility to write out the dump file
> > +with specified options to filter out unwanted contents, e.g::
> >  
> > +   core_collector makedumpfile -l --message-level 1 -d 31
> 
> Looks like scp and core_collector usage are based on Fedora/RHEL, but
> since this doc is for generic upstream, it might be better to describe
> it in generic way, eg.  (maybe just drop scp)
>   makedumpfile -l --message-level 1 -d 31 /proc/vmcore <dump-file>
>   scp /proc/vmcore <user@server>:<path>/<dump-file>

Right, forgot removing core_collector. While scp is also a generic tool?

Thanks for reviewing.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
