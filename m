Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uq29h-0004BA-MW
 for kexec@lists.infradead.org; Fri, 21 Jun 2013 14:17:38 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay3.corp.sgi.com (Postfix) with ESMTP id 4B56EAC008
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 07:17:15 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id 03C3D700341F
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 09:17:15 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1Uq29K-0004kW-Vd
 for kexec@lists.infradead.org; Fri, 21 Jun 2013 09:17:15 -0500
Subject: 32TB kdump
Message-Id: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Fri, 21 Jun 2013 09:17:14 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


I have been testing recent kernel and kexec-tools for doing kdump of large
memories, and found good results.

--------------------------------
UV2000  memory: 32TB  crashkernel=2G@4G
command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
   --map-size 4096 -x /boot/vmlinux-3.10.0-rc5-linus-cpw+ /proc/vmcore \
   /tmp/cpw/dumpfile

page scanning  570 sec.
copying data  5795 sec. (72G)
(The data copy ran out of disk space at 23%, so the time and size above are
 extrapolated.)

--------------------------------
UV1000  memory: 8.85TB  crashkernel=1G@5G
command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
   --map-size 4096 -x /boot/vmlinux-3.9.6-cpw-medusa /proc/vmcore \
   /tmp/cpw/dumpfile

page scanning  175 sec.
copying data  2085 sec. (15G)
(The data copy ran out of disk space at 60%, so the time and size above are
 extrapolated.)

Notes/observations:
- These systems were idle, so this is the capture of basically system
  memory only.
- Both stable 3.9.6 and 3.10.0-rc5 worked.
- Use of crashkernel=1G,high was usually problematic.  I assume some problem
  with a conflict with something else using high memory.  I always use
  the form like 1G@5G, finding memory by examining /proc/iomem.
- Time for copying data is dominated by data compression.  Writing 15G of
  compressed data to /dev/null takes about 35min.  Writing the same data
  but uncompressed (140G) to /dev/null takes about 6min.
  So a good workaround for a very large system might be to dump uncompressed
  to an SSD.
  The multi-threading of the crash kernel would produce a big gain.
- Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
  to 3 minutes.  It also increased data copying speed (unexpectedly) from
  38min. to 35min.
  So I think it is worthwhile to push Hatayama's 9-patch set into the kernel.
- I applied a 5-patch set from Takao Indoh to fix reset_devices handling of
  PCI devices.
  And I applied 3 kernel hacks of my own:
    - making a "Crash kernel low" section in /proc/iomem
    - make crashkernel avoid some things in pci_swiotlb_detect_override(),
      pci_swiotlb_detect_4gb() and register_mem_sect_under_node()
    - doing a crashkernel return from cpu_up()
  I don't understand why these should be necessary for my kernels but are
  not reported as problems elsewhere. I'm still investigating and will discuss
  those patches separately.
- my makedumpfile is an mmap-using version, with about 10 patches applied. I'll
  check which of those are not in the common version and discuss separately.
- my kexec is version 2.0.4 with 3 patches applied. I'll check which of those
  are not in the common version and discuss separately.

-Cliff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
