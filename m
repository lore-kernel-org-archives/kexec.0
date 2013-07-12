Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uxdim-000123-MV
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 13:49:19 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/7] Xen fixes and minor cleanups
Date: Fri, 12 Jul 2013 15:48:08 +0200
Message-Id: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

This patch series contains following Xen fixes and cleanups:
  - xen: Improve calculation of beginning of virtual address space,
  - elf: Increase buf size in get_pt_note_info(),
  - xen: Take into account new frame table address since Xen 4.3,
  - xen: Enforce page size only when xen-syms file is used,
  - Mute some compiler warnings,
  - Use elf_getshdrstrndx() instead of elf_getshstrndx(),
  - Do not break progress messages.

All patches were tested with Xen versions up to 4.3.

Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
