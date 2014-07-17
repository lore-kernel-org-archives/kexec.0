Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7mWy-0003FT-Qh
 for kexec@lists.infradead.org; Thu, 17 Jul 2014 14:19:33 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 18 Jul 2014 00:19:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F3EAE2CE8052
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HEIkGj11469156
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:18:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HEJ1OX026021
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:01 +1000
Subject: [PATCH 0/2] PPC64: Add virtual to physical address translation
 support for vmalloc region
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2014 19:48:59 +0530
Message-ID: <20140717141827.8955.95825.stgit@localhost.localdomain>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec-ml <kexec@lists.infradead.org>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Ken'ichi <oomichi@mxs.nes.nec.co.jp>

In makedumpfile tool, currently there is no support for virtual to physical
address translation of vmalloc region  on PPC64 architecture. These patches
add this support.  The patches have been tested by  erasing data in vmalloc
region, verfying for eraseinfo in the resultant ELF dump and verifiying the
resultant ELF dump for sanity using crash utility. Also, tested the patches
successfully with eppic scripts.

---

Hari Bathini (2):
      makedumpfile: Initialize for vmalloc address translation support in PPC64 arch
      makedumpfile: vtop address translation support for vmalloc region in PPC64 arch


 arch/ppc64.c   |  156 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.c |    7 +++
 makedumpfile.h |   83 +++++++++++++++++++++++++++++-
 3 files changed, 233 insertions(+), 13 deletions(-)

-- 
- Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
