Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz4R6-0002uZ-Sz
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 12:32:59 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 0/7] makedumpfile: Xen fixes and minor cleanups
Date: Tue, 16 Jul 2013 14:32:02 +0200
Message-Id: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

This patch series contains following makedumpfile Xen fixes and minor cleanups:
  - xen: Improve calculation of beginning of virtual address space,
  - elf: Properly check buf size in get_pt_note_info(),
  - xen: Take into account new frame table address since Xen 4.3,
  - xen: Enforce page size only when xen-syms file is used,
  - Do not break progress messages,
  - Mute some compiler warnings,
  - Use elf_getshdrstrndx() instead of elf_getshstrndx().

All patches were tested with Xen versions up to 4.3.

Please apply.

Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
