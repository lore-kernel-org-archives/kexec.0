Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XBlgi-0000Aq-51
 for kexec@lists.infradead.org; Mon, 28 Jul 2014 14:14:07 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 00:13:29 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7606C3578047
 for <kexec@lists.infradead.org>; Tue, 29 Jul 2014 00:13:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6SDoZxf10420626
 for <kexec@lists.infradead.org>; Mon, 28 Jul 2014 23:50:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6SEDX7i002230
 for <kexec@lists.infradead.org>; Tue, 29 Jul 2014 00:13:33 +1000
Subject: [PATCH v2 0/2] PPC64: Add virtual to physical address translation
 support for vmalloc region
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 28 Jul 2014 19:43:31 +0530
Message-ID: <20140728141253.3399.4397.stgit@localhost.localdomain>
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

Changes in v2:
1. Allocating memory to read page tables only when vmalloc address
   translation is requested.
2. Fixed coding style issues.

---

Hari Bathini (2):
      makedumpfile: Initialize for vmalloc address translation support in PPC64 arch
      makedumpfile: vtop address translation support for vmalloc region in PPC64 arch


 arch/ppc64.c   |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.c |    7 ++
 makedumpfile.h |   82 ++++++++++++++++++++++++++-
 3 files changed, 248 insertions(+), 13 deletions(-)

-- 
- Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
