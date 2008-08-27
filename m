Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYMwS-0007RV-Bj
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 15:28:16 +0000
Date: Wed, 27 Aug 2008 11:28:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec -p loads
Message-ID: <20080827152815.GC3694@redhat.com>
References: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
	<20080827133915.GA3694@redhat.com>
	<20080827154333.2298e414@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080827154333.2298e414@halley.suse.de>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

On Wed, Aug 27, 2008 at 03:43:33PM +0200, Bernhard Walle wrote:
> * Vivek Goyal [2008-08-27 09:39]:
> >
> > On Tue, Aug 26, 2008 at 05:13:27PM -0500, Cliff Wickman wrote:
> > > 
> > > Hi Vivek,
> > > 
> > > I'm having trouble getting a system kernel to load a kdump kernel.
> > > 
> > > These are 2.6.26.2 kernels on an x86_64.
> > > The kdump kernel has no modules.
> > > The kdump kernel area is reserved as 64M@16M.
> > > 
> > > This is the way I try to load it:
> > > 
> > > /usr/local/sbin/kexec -p /boot/vmlinux-cpwcomm --args-linux --append="root=/dev/sda3 1 irqpoll maxcpus=1 reset_devices"
> > > 
> > > This works with -l.  But with -p the kernel objects to the 2 lowest
> > > segments, at 0x1000 and 0xa000 which I presume are the startup code
> > > and arguments.
> > > 
> > 
> > CCing to kexec mailing list.
> > 
> > Few questions.
> > 
> > - What version of kexec-tools are you using?
> > - Can you please provide output of /proc/iomem. (With crash kernel memory
> >   reserved).
> > - Looks like you have compiled your kernel for physical address 16MB?
> >   (CONFIG_PHYSICAL_START=0x1000000)
> > - Can you also try loading relocatable bzImage, instead of vmlinux and see
> >   what happens.
> >   
> > 
> > > I have this debugging output from my kexec:
> > > 
> > > cpw: elf_x86_64_load returning entry:0x1550
> > > cpw: after call to file_type[i].load: nr_segments:6 entry:0x1550
> > > kexec_load: entry = 0x1550 flags = 1
> > > nr_segments = 6
> > > segment[0].buf   = 0x5237a0
> > > segment[0].bufsz = 7100
> > > segment[0].mem   = 0x1000
> > > segment[0].memsz = 9000
> > > 
> > > segment[1].buf   = 0x52aaf0
> > > segment[1].bufsz = 1000
> > > segment[1].mem   = 0xa000
> > > segment[1].memsz = 1000
> > > 
> > 
> > I think above two segments are not being loaded at right place. Looks like
> > kexec-tools decided to load first one at physical address 0x1000 and other at
> > physical address 0xa000. For crash kernel this is not right. It should
> > come out of reserved memory area and that's why you are encountering the
> > error.
> 
> Relocatability in ELF image never worked on x86_64 because of GDB but
> (so the binary was marked as ET_EXEC instead of ET_DYN).
> 
> You have to use bzImage for kdump in any case.
> 

True that vmlinux is not relocatable. But one can always compile the
vmlinux for a fixed physical address (Address in reserved region) and then
use it?  In this case his vmlinux seems to have been compiled for physical
address 16MB. Which should be usable if there is a reserved memory region
at 16MB.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
