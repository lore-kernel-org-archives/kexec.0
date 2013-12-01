Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from georges.telenet-ops.be ([195.130.137.68])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vn5F5-0002pz-W7
 for kexec@lists.infradead.org; Sun, 01 Dec 2013 11:31:17 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 0/2] kexec support for Linux/m68k (kernel part)
Date: Sun,  1 Dec 2013 12:30:33 +0100
Message-Id: <1385897435-18618-1-git-send-email-geert@linux-m68k.org>
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
To: linux-m68k@lists.linux-m68k.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This is a set of patches to add kexec support for m68k to the Linux kernel.

  - Kexec only, no kdump support yet (do you have enough RAM to keep a
    crashdump kernel in memory at all times? ;-)

  - Tested on ARAnyM, with emulated 68040 (Atari has identical virt/phys RAM
    mapping),
  - Tested on Amiga 4000/040, with real 68040 (Amiga has non-identical
    virt/phys RAM mapping).

  - Test results on machines with different CPUs would be welcome!

    You can download a kexec binary from
    http://users.telenet.be/geertu/Download/kexec-m68k-2013-10-15.tar.bz2

  - To have automatic "kexec -e" on reboot, copy /etc/rc6.d/S85kexec from
    another system, and fix it up for kexec living in /usr/local/sbin instead
    of /sbin.

  - Sample invocation:

        kexec -d -l vmlinux --reuse-cmdline
        reboot

Patches:
  - [PATCH 1/2] m68k: Add kexec support
      - v2:
          - KEXEC depends on M68KCLASSIC,
          - Fix handling of virtual and physical addresses, for machines where
            memory doesn't start at zero,
          - Support for other CPUs than 68040.
      - v3:
	  - Clear '040/'060 transparent translation registers on MMU disable

  - [PATCH 2/2] m68k: Add support to export bootinfo in procfs
       - v2:
          - No changes
       - v3:
	  - Rebased on top of current m68k tree

  - "m68k: Add System RAM to /proc/iomem" was dropped in v2.
  - "kexec: Add debug printing of kimage table entries" was dropped in v3.

Have fun!


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
