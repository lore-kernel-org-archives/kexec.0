Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail28.messagelabs.com ([216.82.249.131])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QF3uX-000352-9U
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 12:32:06 +0000
Subject: Re: kexec-tools support for add_efi_memmap
From: Ben Romer <benjamin.romer@unisys.com>
In-Reply-To: <20110427061630.GF14497@verge.net.au>
References: <1303842290.20829.57.camel@ustr-romerbm>
	<20110427061630.GF14497@verge.net.au>
Date: Wed, 27 Apr 2011 08:32:47 -0400
Message-ID: <1303907567.20829.60.camel@ustr-romerbm>
MIME-Version: 1.0
Reply-To: benjamin.romer@unisys.com
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Will do! Thanks! :)

On Wed, 2011-04-27 at 01:16 -0500, Simon Horman wrote:
> On Tue, Apr 26, 2011 at 02:24:50PM -0400, Ben Romer wrote:
> > Hi Simon! 
> > 
> > I'm working on supporting linux on a Unisys virtualization platform
> > called s-Par, and I've put together a patch for kexec-tools that I'd
> > like to submit. s-Par is an EFI-based virtualization system that splits
> > up a machine in a way similar to the way Xen does, using a hypervisor,
> > and we have a virtual EFI environment that runs for each guest
> > partition. This is a "pure" EFI environment, so it doesn't have a
> > fully-defined e820 table. To boot linux on our platform, we have to use
> > the "add_efi_memmap" parameter to fill out the kernel's memory map with
> > the additional entries from EFI.
> > 
> > This causes problems when we try to kexec, because the kexec loader is
> > using the /sys/firmware information which is incomplete. It ends up
> > causing the kernel and initrd to overlap in memory, which of course
> > doesn't work. 
> > 
> > I found some discussion of a similar problem on the LKML - a patch from
> > Mike Travis, specifically, in a thread called "[Patch 1/1] x86 efi:
> > insert add_efi_memmap entries into both e820 maps" from May 12, 2010 -
> > the end of which said that the loader needed work rather than the kernel
> > being modified. 
> > 
> > The patch below checks for the add_efi_memmap option in the kernel
> > command line, and switches to using /proc/iomem instead of /sys/memmap
> > when the option is found. I think this might fix the general case and I
> > know it will allow linux to successfully kexec on our platform.
> > 
> > Would you mind taking a look and letting me know what you think? Thanks
> > in advance. :) If this looks okay to you I'll type up and send a formal
> > patch email. Sometimes our email system eats patches so if this doesn't
> > come through cleanly I'll try again with a different account.
> 
> Hi Ben,
> 
> this looks good to me. Could you please make it a formal submission
> by supplying a Signed-off-by line?
> 

-- 
Ben Romer | Software Engineer |
Virtual Systems Development
Unisys Corporation |  2476
Swedesford Rd |  Malvern, PA 19355
|  610-648-7140 

THIS COMMUNICATION MAY CONTAIN
CONFIDENTIAL AND/OR OTHERWISE
PROPRIETARY MATERIAL and is thus for
use only by the intended recipient.
If you received this in error,
please contact the sender and delete
the e-mail and its attachments from
all computers. 








_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
