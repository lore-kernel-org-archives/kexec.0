Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d2-0001Y8-KD
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:13 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1591756Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/7] kdump: Xen fixes
Date: Mon, 10 Sep 2012 13:57:44 +0200
Message-Id: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

Here I am sending Xen kdump fixes.

Daniel

Daniel Kiper (7):
      kexec: Define some constants and structures conditionally
      xen: Rename e820_to_kexec_type() to xen_e820_to_kexec_type() and export it
      kexec: Move crash kernel area placement and size detection to is_crashkernel_mem_reserved()
      kexec: Add segregate_lowmem_region()
      kexec: Get backup area start address and size directly from mem_range
      kexec: Move crash memory ranges logging
      xen: Fix Xen kdump support

 include/x86/x86-linux.h            |    7 +-
 kexec/arch/i386/crashdump-x86.c    |  322 +++++++++++++++++++++++++++--------
 kexec/arch/i386/kexec-x86-common.c |    6 +-
 kexec/arch/i386/kexec-x86.h        |    2 +
 4 files changed, 259 insertions(+), 78 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
