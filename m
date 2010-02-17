Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nhejo-0007Mn-MJ
	for kexec@lists.infradead.org; Wed, 17 Feb 2010 07:54:29 +0000
Date: Wed, 17 Feb 2010 18:54:20 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: powerpc32 support with device tree
Message-ID: <20100217075420.GC27742@verge.net.au>
References: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: kexec@lists.infradead.org, Kumar Gala <galak@kernel.crashing.org>

On Tue, Jan 19, 2010 at 11:59:40PM +0100, Sebastian Andrzej Siewior wrote:
> I've rebased my old patches on top of current kexec-tools tree and added
> support for the uImage target. There was no negative feedback the last I
> have posted as far I remember.
> 
> Now that there is uImage support, there is no need for a wrapper around
> the kernel:
>  kexec -l uImage --dtb=file.dtb
> 
> If the device tree does not contain the current memory size, clocks, mac
> address, ... the --reuse-node option can be used in order to set the value
> to the "current" value. This value is obtained from /proc/device-tree so
> it requires that the kernel exports the device tree.
> 
> I'm currently not sure if the --reuse-node option is very convenient to
> use. Another way to go would be to suck the complete device tree via /proc
> and only update the command line. Any comments on this?
> 
> There are two more things sitting on my todo list: SMP support & initrd. 
> 
> The patch series is also available in the git repository at:
> 
>   git://breakpoint.cc/bigeasy/kexec-tools ppc32

Hi Sebastian,

sorry for taking so long to respond to your email.
There are some minor problems with your patchset

1) The last patch breaks the build if zlib isn't installed.
   Please use HAVE_ZLIB or something similar to resolve this.

2) Patch 3 breaks the built although that is fixed by patch 4.
   I think I'll let this slip as you're importing code and then
   fixing it and that seems like a reasonable thing to do in this case.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
