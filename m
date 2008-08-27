Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYQbs-0003Gn-4i
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 19:23:16 +0000
Date: Wed, 27 Aug 2008 14:23:17 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: kexec -p loads
Message-ID: <20080827192317.GA23699@sgi.com>
References: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
	<20080827133915.GA3694@redhat.com>
	<20080827154333.2298e414@halley.suse.de>
	<20080827152815.GC3694@redhat.com>
	<20080827173035.71358a1f@halley.suse.de>
	<20080827153622.GD3694@redhat.com> <20080827183413.GA22700@sgi.com>
	<20080827190157.GF3694@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080827190157.GF3694@redhat.com>
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
Cc: Bernhard Walle <bwalle@suse.de>, Kexec Mailing List <kexec@lists.infradead.org>

On Wed, Aug 27, 2008 at 03:01:57PM -0400, Vivek Goyal wrote:
> On Wed, Aug 27, 2008 at 01:34:13PM -0500, Cliff Wickman wrote:
> > 
> > On Wed, Aug 27, 2008 at 11:36:22AM -0400, Vivek Goyal wrote:
> > > On Wed, Aug 27, 2008 at 05:30:35PM +0200, Bernhard Walle wrote:
> > > > * Vivek Goyal [2008-08-27 11:28]:
> > > > > > > 
> > > > > > > > I have this debugging output from my kexec:
> > > > > > > > 
> > > > > > > > cpw: elf_x86_64_load returning entry:0x1550
> > > > > > > > cpw: after call to file_type[i].load: nr_segments:6 entry:0x1550
> > > > > > > > kexec_load: entry = 0x1550 flags = 1
> > > > > > > > nr_segments = 6
> > > > > > > > segment[0].buf   = 0x5237a0
> > > > > > > > segment[0].bufsz = 7100
> > > > > > > > segment[0].mem   = 0x1000
> > > > > > > > segment[0].memsz = 9000
> > > > > > > > 
> > > > > > > > segment[1].buf   = 0x52aaf0
> > > > > > > > segment[1].bufsz = 1000
> > > > > > > > segment[1].mem   = 0xa000
> > > > > > > > segment[1].memsz = 1000
> > > > > > > > 
> > > > > > > 
> > > > > > > I think above two segments are not being loaded at right place. Looks like
> > > > > > > kexec-tools decided to load first one at physical address 0x1000 and other at
> > > > > > > physical address 0xa000. For crash kernel this is not right. It should
> > > > > > > come out of reserved memory area and that's why you are encountering the
> > > > > > > error.
> > > > > > 
> > > > > > Relocatability in ELF image never worked on x86_64 because of GDB but
> > > > > > (so the binary was marked as ET_EXEC instead of ET_DYN).
> > > > > > 
> > > > > > You have to use bzImage for kdump in any case.
> > > > > 
> > > > > True that vmlinux is not relocatable. But one can always compile the
> > > > > vmlinux for a fixed physical address (Address in reserved region) and then
> > > > > use it?  In this case his vmlinux seems to have been compiled for physical
> > > > > address 16MB. Which should be usable if there is a reserved memory region
> > > > > at 16MB.
> > > > 
> > > > Of course, that's true. I just thought when Cliff uses the same kernel
> > > > for "kexec -l" and "kexec -p", then it's the "normal" kernel. But I
> > > > didn't calculate the numbers.
> > > > 
> > > > 
> > > 
> > > Its litle tricky. I think one can always do both "kexec -l" and "kexec -p"
> > > on a vmlinux which has been built for kdump (for reserved region).
> > > 
> > > But one can not do "kexec -p" on normal kernel vmlinux.
> > > 
> > > So I am assuming that Cliff is running into first case. But he can tell
> > > us more. 
> > > 
> > > Cliff, is it same vmlinux which you use for first kernel or a different
> > > vmlinux compiled for dump capture.
> > 
> > Sorry for the lag.  I was working on the problem and not watching my mail.
> > 
> > I'm using two different kernels.
> > The kdump vmlinux is compiled with
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x1000000
> > 
> > I'm using  kexec-tools-1.101
> 
> This is too old  a version. Can you try the version 2.0.0. from following
> link.
> 
> http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools.tar.bz2

Ahh.  That works.
I think I got 1.101 as the latest from sourceforge.  I should've looked
at the path in Documentation/kdump/kdump.txt

Thanks.
-Cliff
-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
