Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K9iyP-0001bm-06
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 15:56:25 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: Introduce userspace interface for Firmware-provided memory map
Date: Fri, 20 Jun 2008 17:56:57 +0200
Message-Id: <1213977420-1555-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch (as request for comments) introduces a new userspace interface
/proc/firmware_mem that provides the unfiltered view of the BIOS on
memory configuration. That's usable for two reasons:

 1) Debugging (yes, the E820 memory is printed in kernel ring buffer, but that's
    not the case for all platforms, on IA64 you have to enable some magic define
    to print the EFI memory map, for example),
 
 2) Kexec. When the user or the system uses a special command line to modify the
    memory configuration, kexec still needs a method to get the original memory
    map.  While the filtered view is useful for generating ELF core headers for
    crashdumps, the unfiltered view is necessary to boot the next kernel without
    the "limitations" the original kernel has.

We had the discussion to add iomem_used on kexec mailing list. However, I think
it's better to let /proc/iomem represent the *filtered* (i.e. "used") view of
the I/O resources and introduce a new interface for the *unfiltered* view.
There are two reasons:

 1) On i386 (the oldest architectures), /proc/iomem always represented the
    *filtered* view (i.e. "mem" parameter was also visible in /proc/iomem).
    I think we should not change the semantics of an interface without a reason.
 
 2) /proc/iomem_used would it make necessary to duplicate all registration between
    /proc/iomem and /proc/iomem_used. Because currently the resource root
    is exported and used everywhere in the kernel source, that would make
    changes of the whole resource infrastructure necessary if code duplication
    should be avoided.

Maybe you think that /proc/firmware_mem is not the right place to export that.
I don't know, I also don't care that much about the naming or the way to export
that. So, please advise me if you agree that it's ok for kexec to export an
unfiltered view of the memory map.

The patch has been tested on i386 and x86_64.



Signed-off-by: Bernhard Walle <bwalle@suse.de>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
