Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QFDtW-0001MD-RD
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 23:11:44 +0000
Date: Thu, 28 Apr 2011 08:11:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2.0.2] use /proc/iomem for map with "add_efi_memmap"
	kernel option
Message-ID: <20110427231136.GB14272@verge.net.au>
References: <1303908969.20180.8.camel@ustr-romerbm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303908969.20180.8.camel@ustr-romerbm>
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
Cc: kexec <kexec@lists.infradead.org>

On Wed, Apr 27, 2011 at 08:56:09AM -0400, Ben Romer wrote:
> This patch changes the behavior of the kexec loader when the
> "add_efi_memmap" option is present on the currently running kernel's
> command line, to read the kernel memory map from /proc/iomem instead
> of /sys/firmware/memmap. 
> 
> On EFI systems, sometimes the e820 table is missing or incomplete.
> Systems like these use the "add_efi_memmap" option to add EFI's memory
> table entries to the kernel's memory table to build a complete picture
> of the system's memory; however, using the option does not add these
> entries to the table used to populate /sys/firmware/memmap, which is
> meant to be a pristine original copy. 
> 
> The kexec loader uses the pristine memory map by default, which causes
> problems when the loader doesn't have a complete picture of the system
> and incorrectly loads the kernel or ramdisk in places that aren't
> actually usable. This change makes the kexec loader check the running
> kernel's command line for the "add_efi_memmap" option and if it finds
> it, will use the modified map instead of the original map.
> 
> signed-off-by: Benjamin Romer <benjamin.romer@unisys.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
