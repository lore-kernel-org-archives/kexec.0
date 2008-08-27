Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYLF8-0007Ey-LA
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 13:39:27 +0000
Date: Wed, 27 Aug 2008 09:39:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec -p loads
Message-ID: <20080827133915.GA3694@redhat.com>
References: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Aug 26, 2008 at 05:13:27PM -0500, Cliff Wickman wrote:
> 
> Hi Vivek,
> 
> I'm having trouble getting a system kernel to load a kdump kernel.
> 
> These are 2.6.26.2 kernels on an x86_64.
> The kdump kernel has no modules.
> The kdump kernel area is reserved as 64M@16M.
> 
> This is the way I try to load it:
> 
> /usr/local/sbin/kexec -p /boot/vmlinux-cpwcomm --args-linux --append="root=/dev/sda3 1 irqpoll maxcpus=1 reset_devices"
> 
> This works with -l.  But with -p the kernel objects to the 2 lowest
> segments, at 0x1000 and 0xa000 which I presume are the startup code
> and arguments.
> 

CCing to kexec mailing list.

Few questions.

- What version of kexec-tools are you using?
- Can you please provide output of /proc/iomem. (With crash kernel memory
  reserved).
- Looks like you have compiled your kernel for physical address 16MB?
  (CONFIG_PHYSICAL_START=0x1000000)
- Can you also try loading relocatable bzImage, instead of vmlinux and see
  what happens.
  

> I have this debugging output from my kexec:
> 
> cpw: elf_x86_64_load returning entry:0x1550
> cpw: after call to file_type[i].load: nr_segments:6 entry:0x1550
> kexec_load: entry = 0x1550 flags = 1
> nr_segments = 6
> segment[0].buf   = 0x5237a0
> segment[0].bufsz = 7100
> segment[0].mem   = 0x1000
> segment[0].memsz = 9000
> 
> segment[1].buf   = 0x52aaf0
> segment[1].bufsz = 1000
> segment[1].mem   = 0xa000
> segment[1].memsz = 1000
> 

I think above two segments are not being loaded at right place. Looks like
kexec-tools decided to load first one at physical address 0x1000 and other at
physical address 0xa000. For crash kernel this is not right. It should
come out of reserved memory area and that's why you are encountering the
error.


For crash kernels, kexec-tools sets the value of mem-min and mem-max in
such a manner that it is with-in reserved memory area so that any memory
allocation in locate_hole() is done with-in reserved area and not outside
it.

In your case looks like something went wrong. Either memory area was not
reserved properly or value of mem-min, mem-max was not set properly etc.

Can you please paste the output of /proc/iomem and also do some
kexec-tools debugging. Especially value of mem-max and mem-min inside
locate_hole() function.

Thanks
Vivek

 
> segment[2].buf   = 0x7f9bd8461010
> segment[2].bufsz = 224668
> segment[2].mem   = 0x1000000
> segment[2].memsz = 225000
> 
> segment[3].buf   = 0x7f9bd8686010
> segment[3].bufsz = 75508
> segment[3].mem   = 0x1225000
> segment[3].memsz = 76000
> 
> segment[4].buf   = 0x7f9bd8761010
> segment[4].bufsz = c08
> segment[4].mem   = 0x129b000
> segment[4].memsz = 1000
> 
> segment[5].buf   = 0x7f9bd87fd010
> segment[5].bufsz = 30004
> segment[5].mem   = 0x129c000
> segment[5].memsz = c2000
> kexec_load failed: Cannot assign requested address
> 
> 
> And I have some debugging in the system kernel:
> 
> cleopatra1:/tmp/cpw # dmesg | tail
> 
> cpw: -p, call kimage_crash_alloc
> cpw: kimage_crash_alloc bad entry point 0x1550:0x1000000 0x1550:0x4ffffff
> cpw: kimage_crash_alloc segment 0: 0x1000-0x9fff
> cpw: kimage_crash_alloc pta EADDRNOTAVAIL 0x1000:0x1000000  0x9fff:0x4ffffff
> cpw: kimage_crash_alloc segment 1: 0xa000-0xafff
> cpw: kimage_crash_alloc pta EADDRNOTAVAIL 0xa000:0x1000000  0xafff:0x4ffffff
> cpw: kimage_crash_alloc segment 2: 0x1000000-0x1224fff
> cpw: kimage_crash_alloc segment 3: 0x1225000-0x129afff
> cpw: kimage_crash_alloc segment 4: 0x129b000-0x129bfff
> cpw: kimage_crash_alloc segment 5: 0x129c000-0x135dfff
> 
> The code that insists that the entry point must be within 64M@16M, and
> that every segment must also be in that range, seems to be old code.
> 
> I don't understand.
> Is kexec generating bad segments?  Or am I mis-using something?
> Can you tell from the above?
> 
> Thanks.
> -Cliff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
