Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYMyk-00080F-20
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 15:30:38 +0000
Date: Wed, 27 Aug 2008 17:30:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec -p loads
Message-ID: <20080827173035.71358a1f@halley.suse.de>
In-Reply-To: <20080827152815.GC3694@redhat.com>
References: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
	<20080827133915.GA3694@redhat.com>
	<20080827154333.2298e414@halley.suse.de>
	<20080827152815.GC3694@redhat.com>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

* Vivek Goyal [2008-08-27 11:28]:
> > > 
> > > > I have this debugging output from my kexec:
> > > > 
> > > > cpw: elf_x86_64_load returning entry:0x1550
> > > > cpw: after call to file_type[i].load: nr_segments:6 entry:0x1550
> > > > kexec_load: entry = 0x1550 flags = 1
> > > > nr_segments = 6
> > > > segment[0].buf   = 0x5237a0
> > > > segment[0].bufsz = 7100
> > > > segment[0].mem   = 0x1000
> > > > segment[0].memsz = 9000
> > > > 
> > > > segment[1].buf   = 0x52aaf0
> > > > segment[1].bufsz = 1000
> > > > segment[1].mem   = 0xa000
> > > > segment[1].memsz = 1000
> > > > 
> > > 
> > > I think above two segments are not being loaded at right place. Looks like
> > > kexec-tools decided to load first one at physical address 0x1000 and other at
> > > physical address 0xa000. For crash kernel this is not right. It should
> > > come out of reserved memory area and that's why you are encountering the
> > > error.
> > 
> > Relocatability in ELF image never worked on x86_64 because of GDB but
> > (so the binary was marked as ET_EXEC instead of ET_DYN).
> > 
> > You have to use bzImage for kdump in any case.
> 
> True that vmlinux is not relocatable. But one can always compile the
> vmlinux for a fixed physical address (Address in reserved region) and then
> use it?  In this case his vmlinux seems to have been compiled for physical
> address 16MB. Which should be usable if there is a reserved memory region
> at 16MB.

Of course, that's true. I just thought when Cliff uses the same kernel
for "kexec -l" and "kexec -p", then it's the "normal" kernel. But I
didn't calculate the numbers.



Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
