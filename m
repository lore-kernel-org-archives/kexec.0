Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qh206-0005EL-R4
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 16:09:27 +0000
Date: Wed, 13 Jul 2011 12:02:39 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110713160239.GE4426@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110711175626.121dcc58@mschwide>
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Mon, Jul 11, 2011 at 05:56:26PM +0200, Martin Schwidefsky wrote:

[..]
> > kexec-tools purgatory code already has the checksum logic. So you don't
> > have to redo that in stand alone tools. I think you probably need to
> > s390 specic purgatory and jump to IPLing stand alone kernel if kdump
> > kernel is corrupted instead of rebooting back or spinning infinitely
> > in the loop/
> 
> I can not quite follow you here. The purgatory code is part of the kdump kernel,
> no? When we trigger a dump with the stand-alone tools we will start executing
> code in the assembler function of that stand-alone tools. We can not trust
> the kdump kernel yet, not without doing the checksums first.

Purgatory is another piece of binary code which is loaded along with kdump
kernel in reserved memory area. So yes, there is a chance that this code
itself get corrupted.

So in case of stand alone dump, you save the calculated checksum of
kdump kernel at disk and not in memory? And then calculate the checksum
of memory image of kdump kernel and decide whether kdump kenrel is 
corrupted or not?

If yes, this sounds more reliable as checksum of kernel is stored on
some disk/tape.

[..]
> > Ok. So again why not reuse the checksump capability of kexec-tools and
> > instead of infinite looping you can jump to stand alone tools + IPL etc.
> > I understand this will require a tighter integration with kexec-tools
> > and using ELF header mechanism and will not cover the early kernel
> > crashes.
> 
> Imho the checksum of kexec-tools is in the wrong place.

Because you think that stored checksum can get corrupted?

[..]
> > To me we seem to be diverging a lot from existing kdump+kexec-tools
> > mechanism just to solve the case of early crash dumping. If we break
> > down the problem in two parts and do thing kexec-tools way (with a
> > backup path of booting stand alone kernel if kdump kenrel is corrupted),
> > things might be better.
> 
> The "backup path of booting stand alone kernel" would result in passing
> the control twice, once from the stand-alone dumper to the kexec purgatory
> (after the purgatory checksum has been verified), then doing more checks 
> in the kdump kernel, only to return to the stand-alone dumper if some check
> fails. Does not really sound enticing to me.

What I am suggesting is that stand alone dumper gets control only if
kdump kernel is corrupted.

So following sequence.

Kernel Crash ---> purgatory --> either kdump kenrel/IPL stand alone tools

Here only drawback seems to be that we assume that purgatory code and
pre-calculated checksum has not been corrupted. The big advantage is
that s390 kdump support looks very similar to other arches and
understaning and supporting kdump across architectures becomes easy.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
