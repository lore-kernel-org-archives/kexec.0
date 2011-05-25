Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QP8q9-0007ls-Pe
	for kexec@lists.infradead.org; Wed, 25 May 2011 07:49:14 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4P7j0T0009232
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:45:00 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4P7nB8N987328
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:49:11 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4P7nAGx004730
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:49:11 +1000
Subject: [PATCH] makedumpfile: s390x: Fix dump refiltering for s390x.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 25 May 2011 13:19:08 +0530
Message-ID: <20110525074907.17025.26375.stgit@mars.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Tachibana-san <tachibana@mxn.nes.nec.co.jp>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On s390x, dump refiltering fails in get_machdep_info_s390x() function while
reading vmlist kernel symbol data. It fails in vaddr_to_paddr_s390x()
function while resolving vmlist kernel symbol address. Since the vmlist
kernel symbol address is not a vmalloc address, the function returns failure.

Fix the vaddr_to_paddr_s390x() function to translate non-vmalloc'ed
address into physical adddress.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 s390x.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/s390x.c b/s390x.c
index 128e5f0..49658d0 100644
--- a/s390x.c
+++ b/s390x.c
@@ -269,9 +269,7 @@ vaddr_to_paddr_s390x(unsigned long vaddr)
 		paddr = vtop_s390x(vaddr);
 	}
 	else {
-		ERRMSG("Can't convert a virtual address(%lx) to " \
-		    "physical address.\n", vaddr);
-		return NOT_PADDR;
+		paddr = vaddr - KVBASE;
 	}
 
 	return paddr;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
