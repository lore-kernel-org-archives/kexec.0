Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pkl3E-0003IB-2v
	for kexec@lists.infradead.org; Wed, 02 Feb 2011 22:19:49 +0000
Date: Wed, 2 Feb 2011 22:19:37 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: kexec: selective MMU identity mapping
Message-ID: <20110202221937.GI31043@n2100.arm.linux.org.uk>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
	<20110202210925.GD31043@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102021704580.8212@xanadu.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102021704580.8212@xanadu.home>
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
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Per Fransson <per.xx.fransson@stericsson.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 02, 2011 at 05:10:37PM -0500, Nicolas Pitre wrote:
> On Wed, 2 Feb 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, Feb 02, 2011 at 03:43:29PM +0100, Per Fransson wrote:
> > > When restarting using the kernel kexec functionality the MMU
> > > needs to be turned off. Any code which does this needs to use
> > > identity mapped addresses to get reliable results. In the ARM
> > > kexec case this identity mapping is done:
> > > 
> > > - using the page table of the current task
> > > 
> > > - for all addresses normally used by user space,
> > >   i.e. 0x00000000-PAGE_OFFSET
> > > 
> > > If kexec is used at a kernel crash to collect a core dump this
> > > means that we lose important information.
> > > 
> > > This is what this patches does:
> > > 
> > > * Actually turns off the MMU, which has been omitted by mistake
> > > 
> > > * Sets up a more selective identity mapping
> > > 
> > > * Restores the old mapping once the MMU is off
> > > 
> > > Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> > > ---
> > > v2 changes:
> > > 
> > > * now uses (modified versions of) the identity mapping functions in idmap.c
> > >   as they look in 2.6.38-rc1. Some pud-level code has been added there in
> > >   linux-next.
> > 
> > Thanks.  As this been tested with ARMv4/v5 CPUs as well?
> 
> I have doubts about the effectiveness of setup_mm_for_reboot() on any 
> machine where physical RAM starts at 0xc0000000 or above, such as on 
> SA1100.

It's known to work on Assabet.  It works on SA1100 because the kernel
mapping is already a 1:1 mapping.

What setup_mm_for_reboot() is doing on Assabet though is making the
flash available for cpu_reset(0) to be able to call, not making the
kernel code for cpu_reset() available for calling.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
