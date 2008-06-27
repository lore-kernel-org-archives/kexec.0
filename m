Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 27 Jun 2008 13:56:25 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080627205625.GA16609@kroah.com>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
	<1214565175-21512-2-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214565175-21512-2-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: gregkh@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, vgoyal@redhat.com

On Fri, Jun 27, 2008 at 01:12:54PM +0200, Bernhard Walle wrote:
> This patch adds /sys/firmware/memmap interface that represents the BIOS
> (or Firmware) provided memory map. The tree looks like:
> 
>     /sys/firmware/memmap/0/start   (hex number)
>                            end     (hex number)
>                            type    (string)
>     ...                 /1/start
>                            end
>                            type
> 
> With the following shell snippet one can print the memory map in the same form
> the kernel prints itself when booting on x86 (the E820 map).
> 
>   --------- 8< --------------------------
>     #!/bin/sh
>     cd /sys/firmware/memmap
>     for dir in * ; do
>         start=$(cat $dir/start)
>         end=$(cat $dir/end)
>         type=$(cat $dir/type)
>         printf "%016x-%016x (%s)\n" $start $[ $end +1] "$type"
>     done
>   --------- >8 --------------------------
> 
> That patch only provides the needed interface:
> 
>  1. The sysfs interface.
>  2. The structure and enumeration definition.
>  3. The function firmware_map_add() and firmware_map_add_early()
>     that should be called from architecture code (E820/EFI, for
>     example) to add the contents to the interface.
> 
> If the kernel is compiled without CONFIG_FIRMWARE_MEMMAP, the interface does
> nothing without cluttering the architecture-specific code with #ifdef's.
> 
> The purpose of the new interface is kexec: While /proc/iomem represents
> the *used* memory map (e.g. modified via kernel parameters like 'memmap'
> and 'mem'), the /sys/firmware/memmap tree represents the unmodified memory
> map provided via the firmware. So kexec can:
> 
>  - use the original memory map for rebooting,
>  - use the /proc/iomem for setting up the ELF core headers for kdump
>    case that should only represent the memory of the system.
> 
> The patch has been tested on i386 and x86_64.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

x86 developers, feel free to add this to your tree, it looks fine to me.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
