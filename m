Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5pMq-0000I2-Kz
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 21:57:33 +0000
Date: Mon, 9 Jun 2008 23:57:29 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Implement support for mem command line parameter
Message-ID: <20080609235729.43e38e2f@kopernikus.site>
In-Reply-To: <20080603030440.GC32687@redhat.com>
References: <1212449384-22819-1-git-send-email-bwalle@suse.de>
	<20080603030440.GC32687@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

* Vivek Goyal <vgoyal@redhat.com> [2008-06-02 23:04]:
>
> On Tue, Jun 03, 2008 at 01:29:44AM +0200, Bernhard Walle wrote:
> > When the kernel is booted with the "mem" kernel command line (see
> > Documentation/kernel-parameters.txt of kernel source tree), the /proc/iomem
> > is not modified. Instead, it shows the whole memory space as "System RAM".
> > I consider that as correct because the file is named "iomem", and for I/O,
> > the behaviour makes sense.
> > 
> 
> IIUC, in the past the behavior of /proc/iomem was different for i386 and
> x86_64. One arch used to truncate it and other would not. I don't remember
> which one used to do what.

Right. I just checked with 2.6.22.5 (openSUSE 10.3 kernel), and

  - i386: /proc/iomem contains full memory
  - x86_64: /proc/iomem contains truncated memory

After the x86 merge, x86_64 now has the behaviour of i386.

> I had a quick look at the current code and looks like truncation of e820
> map is taking place before request_resource(). In that case we should
> see the truncated map. But I am not sure and will test it tomorrow...

2.6.25 shows the full /proc/iomem.

> We probably will not touch /proc/iomem. We need to create a new interface
> which will change based on user options. That should not break any 
> user space applications?

That would make sense. I will prepare a patch tomorrow, I hope such a
interface will be accepted. One might argue that "just don't use mem,
it's only for debugging" or something.

> >  - We should not add yet another interface between kernel and userspace for
> >    a feature 99 % of the people don't need and don't even know about.
> > 
> > The semantics of mem is different on different architectures. i386 and x86_64
> > (x86) treat the limit specified on the command line as physical address limit
> 
> You mean system RAM limit? Because PCI devices are still mapped at higher
> physical addresses. So it is not physical address limit?

In x86 the mem=3G means that the highest RAM memory address is
3*1024*1024*1024 bytes physical address space. Removing the hole
between 640K and 1M and 15M and 16M, that's not exactly 3G memory.

> > while IA64 count the real memory. That is because of different practises of
> > memory mapping on PC architecture vs. "new" architectures.

And IA64 really counts that memory, so 'free -m' will show 3*1024 in
that case.

> Hence I feel that we need to create two views. /proc/iomem can serve
> as unmodied io resource view as reported by BIOS, and /proc/iomem_used
> can serve as modified view as seen by kernel (due to user options.)

Right, that's the more *clean* solution, but it needs a new kernel
interface.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
