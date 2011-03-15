Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzXkQ-0003OC-CQ
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 17:09:31 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id p2FGEdBP025475
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 21:44:39 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2FH9PBf3383522
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 22:39:25 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2FH9OgI007511
	for <kexec@lists.infradead.org>; Wed, 16 Mar 2011 04:09:24 +1100
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: s390x: Fix KVBASE to correct value for s390x
	arcitecture.
Date: Tue, 15 Mar 2011 22:39:23 +0530
Message-ID: <20110315170902.32471.52757.stgit@mars.in.ibm.com>
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
To: kexec-ml <kexec@lists.infradead.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

While excluding free pages from s390x dumps taken on LPAR, makedumpfile
fails to convert page address to pfn. The reason is, the memory for
mem_section structure is allocated below '_stext' and since KVBASE is
set to SYMBOL(_stext), the function is_kvaddr() fails and return NULL
address.

Set KVBASE to KENRELBASE(0) for s390x architecture to fix this issue.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 makedumpfile.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 11e1a93..4ec77b7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -615,7 +615,7 @@ do { \
 #ifdef __s390x__
 #define __PAGE_OFFSET		(info->page_size - 1)
 #define KERNELBASE		(0)
-#define KVBASE			(SYMBOL(_stext))
+#define KVBASE			KERNELBASE
 #define _SECTION_SIZE_BITS	(28)
 #define _MAX_PHYSMEM_BITS	(42)
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
