Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XFk9A-0004Ay-4o
 for kexec@lists.infradead.org; Fri, 08 Aug 2014 13:23:52 +0000
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 8 Aug 2014 23:23:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5E0A82CE802D
 for <kexec@lists.infradead.org>; Fri,  8 Aug 2014 23:23:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s78DNwKW9830546
 for <kexec@lists.infradead.org>; Fri, 8 Aug 2014 23:23:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s78DNLIP016851
 for <kexec@lists.infradead.org>; Fri, 8 Aug 2014 23:23:22 +1000
Subject: [PATCH v3 0/2] PPC64: Add virtual to physical address translation
 support for vmalloc region
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 08 Aug 2014 18:53:17 +0530
Message-ID: <20140808132231.11571.34725.stgit@localhost.localdomain>
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

Changes in v3:
Added the buffer to read page tables in DumpInfo structure and freeing it
before exiting the tool

---

Hari Bathini (2):
      makedumpfile: Initialize for vmalloc address translation support in PPC64 arch
      makedumpfile: vtop address translation support for vmalloc region in PPC64 arch


 arch/ppc64.c   |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.c |    9 +++
 makedumpfile.h |   83 +++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 13 deletions(-)

-- 
- Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
