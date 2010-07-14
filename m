Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OYu5n-0003RL-7z
	for kexec@lists.infradead.org; Wed, 14 Jul 2010 05:01:11 +0000
Date: Wed, 14 Jul 2010 14:01:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec -l could not find a free area of memory locate_hole failed
Message-ID: <20100714050103.GA29498@verge.net.au>
References: <BAY157-w54278284B21FED4E234976D4B80@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BAY157-w54278284B21FED4E234976D4B80@phx.gbl>
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
To: Brian Cockrell <bjcockrell@hotmail.com>
Cc: kexec@lists.infradead.org

On Mon, Jul 12, 2010 at 11:31:50PM +0000, Brian Cockrell wrote:
> 
> I received the message "Could not find a free area of memory of 21b1a000 bytes...Locate_hole failed" while attempting to perform a kexec-l on an image file of approximately 550mb.  Hardware is x86 with 4GB memory.  Kernel is 2.6.34 and booted via Livecd.  free is showing 3047324kb free memory available.  Dmesg is showing nothing.  I am able to boot a 400mb image. Suggested debug steps?

Hi Brian,

I would guess that the problem is that the code can't find
a (continuous) range of physical memory to place the image.

I'm a bit rust on this portion of the code, but as I understand
it kexec works out the memory segments that it needs
and tries to place each of them in a valid "System RAM" region.

The code that is failing would be a good place to start,
kexec/kexec.c:locate_hole() of kexec-tools.

The memory regions are set up by inspecting /sys/firmware,
or if that fails, using /proc/iomem. See
kexec/arch/i386/kexec-x86-common.c:get_memory_ranges_sysfs().

550Mb, is a rather large image. I'm curious to know why.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
