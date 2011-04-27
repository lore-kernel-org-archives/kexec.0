Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEy39-0008QY-8p
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 06:16:36 +0000
Date: Wed, 27 Apr 2011 15:16:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec-tools support for add_efi_memmap
Message-ID: <20110427061630.GF14497@verge.net.au>
References: <1303842290.20829.57.camel@ustr-romerbm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303842290.20829.57.camel@ustr-romerbm>
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
To: Ben Romer <benjamin.romer@unisys.com>
Cc: kexec@lists.infradead.org

On Tue, Apr 26, 2011 at 02:24:50PM -0400, Ben Romer wrote:
> Hi Simon! 
> 
> I'm working on supporting linux on a Unisys virtualization platform
> called s-Par, and I've put together a patch for kexec-tools that I'd
> like to submit. s-Par is an EFI-based virtualization system that splits
> up a machine in a way similar to the way Xen does, using a hypervisor,
> and we have a virtual EFI environment that runs for each guest
> partition. This is a "pure" EFI environment, so it doesn't have a
> fully-defined e820 table. To boot linux on our platform, we have to use
> the "add_efi_memmap" parameter to fill out the kernel's memory map with
> the additional entries from EFI.
> 
> This causes problems when we try to kexec, because the kexec loader is
> using the /sys/firmware information which is incomplete. It ends up
> causing the kernel and initrd to overlap in memory, which of course
> doesn't work. 
> 
> I found some discussion of a similar problem on the LKML - a patch from
> Mike Travis, specifically, in a thread called "[Patch 1/1] x86 efi:
> insert add_efi_memmap entries into both e820 maps" from May 12, 2010 -
> the end of which said that the loader needed work rather than the kernel
> being modified. 
> 
> The patch below checks for the add_efi_memmap option in the kernel
> command line, and switches to using /proc/iomem instead of /sys/memmap
> when the option is found. I think this might fix the general case and I
> know it will allow linux to successfully kexec on our platform.
> 
> Would you mind taking a look and letting me know what you think? Thanks
> in advance. :) If this looks okay to you I'll type up and send a formal
> patch email. Sometimes our email system eats patches so if this doesn't
> come through cleanly I'll try again with a different account.

Hi Ben,

this looks good to me. Could you please make it a formal submission
by supplying a Signed-off-by line?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
