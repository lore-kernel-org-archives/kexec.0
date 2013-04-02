Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMtYf-0006tG-Pe
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 05:14:59 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 2 Apr 2013 15:06:04 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CD55E357804A
 for <kexec@lists.infradead.org>; Tue,  2 Apr 2013 16:14:43 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3250tXE58785958
 for <kexec@lists.infradead.org>; Tue, 2 Apr 2013 16:00:56 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r325ECFp018340
 for <kexec@lists.infradead.org>; Tue, 2 Apr 2013 16:14:12 +1100
Subject: [PATCH] makedumpfile: copy over the 'erase_ch' member while splitting
 filter info.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 02 Apr 2013 10:43:59 +0530
Message-ID: <20130402051243.24410.23935.stgit@mars.in.ibm.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Kexec-ml <kexec@lists.infradead.org>
Cc: Hemanth Siddarajaiah <hsiddara@in.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Recent eppic support in makedumpfile has introduced 'erase_ch' member in
filter_info structure. This member holds the erase character specified by the
user to poison the memory location in the dump file that require to be scrubbed
out. But, when the memory range to be scrubbed out is spanned across multiple
pages, only the memory that belongs to first page is poisoned with the
character set in 'erase_ch' member. The rest of the memory gets poisoned with
'null' character. This is because, the 'erase_ch' member is not copied over
while splitting filter info in split_filter_info() function.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
---
 erase_info.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index 61fe637..a1b08e0 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -1921,12 +1921,15 @@ split_filter_info(struct filter_info *prev, unsigned long long next_paddr,
 		ERRMSG("Can't allocate memory to split filter info\n");
 		return;
 	}
-	new->nullify        = prev->nullify;
-	new->erase_info_idx = prev->erase_info_idx;
-	new->size_idx       = prev->size_idx;
+	
+	/*
+	 * copy over existing data from prev node and only update fields
+	 * that differ. This approach will take care of copying over of any
+	 * future member addition to filter_info structure.
+	 */
+	*new = *prev;
 	new->paddr          = next_paddr;
 	new->size           = size;
-	new->next           = prev->next;
 	prev->next          = new;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
