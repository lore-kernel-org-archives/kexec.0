Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L4xKP-0006Z4-UG
	for kexec@lists.infradead.org; Tue, 25 Nov 2008 12:47:42 +0000
Date: Tue, 25 Nov 2008 13:47:38 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: kexec does not load
Message-ID: <20081125134738.7075a13a@hale.suse.de>
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
To: Huang Ying <ying.huang@intel.com>
Cc: kexec@lists.infradead.org

Hi Huang,

your patch:

    commit ceb04ae1223ba5cdd40df744aa73a32b2cc7d879
    Author: Huang Ying <ying.huang@intel.com>
    Date:   Wed Oct 29 11:24:25 2008 +0800

    kexec jump support for kexec-tools
    
    To support memory backup/restore an option named
    --load-preserve-context is added to kexec. When it is specified
    toggether with --mem-max, most segments for crash dump support are
    loaded, and the memory range between mem_min to mem_max which has no
    segments loaded are loaded as backup segments. To support jump back
    from kexeced, options named --load-jump-back-helper and --entry are
    added to load a helper image with specified entry to jump back.
    
    Signed-off-by: Huang Ying <ying.huang@intel.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

broke kexec on my system (x86-64) with Xen. With the patch:

   Symbol: cmdline_end not found cannot set

Without the patch it does work. The command line was:

    /sbin/kexec -p /boot/vmlinuz-2.6.27.5-2-default \
         --append="root=/dev/disk/by-id/scsi-3500000e0159c2510-part6 \
                   console=tty0 console=ttyS0,57600 \
                   sysrq_always_enabled panic=100 \
                   resume=/dev/disk/by-id/scsi-3500000e0159c2510-part2 \
                   xencons=ttyS vga=normal console=ttyS0,57600 \
                   elevator=deadline sysrq=1 reset_devices irqpoll \
                   maxcpus=1 kernelversion=2.6.27.7-3-xen " \
         --initrd=/boot/initrd-2.6.27.5-2-default-kdump

I don't know the cause. Can you analyse? I can help with testing
patches, of course, but I have no time to analyse the problem now. :-(


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
