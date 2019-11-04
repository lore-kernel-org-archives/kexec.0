Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRc2w-0001uW-Cm
 for kexec@lists.infradead.org; Mon, 04 Nov 2019 13:05:30 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA4Ct6tC046091
 for <kexec@lists.infradead.org>; Mon, 4 Nov 2019 08:05:22 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w2m00j0wt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 04 Nov 2019 08:05:21 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zaslonko@linux.ibm.com>;
 Mon, 4 Nov 2019 13:05:18 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH] makedumpfile: Fix off-by-one issue in exclude_nodata_pages()
Date: Mon,  4 Nov 2019 14:05:15 +0100
Message-Id: <20191104130515.26741-1-zaslonko@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: prudo@linux.ibm.com, dyoung@redhat.com

When building a dump bitmap (2nd bitmap) for the ELF dump, the last pfn
of the cycle is always ignored in exclude_nodata_pages() function due to
off-by-one error on cycle boundary check. Thus, the respective bit of
the bitmap is never cleared.
That can lead to the error when such a pfn should not be dumpable (e.g.
the last pfn of the ELF-load of zero filesize). Based on the bit in the
bitmap the page is treated as dumpable in write_elf_pages_cyclic() function
and the follow on error is triggered in write_elf_load_segment() function
due to the failing sanity check of paddr_to_offset2():

   $ makedumpfile -E dump.elf dump.elf.E
   Checking for memory holes                         : [100.0 %] |
   write_elf_load_segment: Can't convert physaddr(7ffff000) to an offset.
   makedumpfile Failed.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index de0973f..4a00011 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4740,7 +4740,7 @@ exclude_nodata_pages(struct cycle *cycle)
 		if (pfn < cycle->start_pfn)
 			pfn = cycle->start_pfn;
 		if (pfn_end >= cycle->end_pfn)
-			pfn_end = cycle->end_pfn - 1;
+			pfn_end = cycle->end_pfn;
 		while (pfn < pfn_end) {
 			clear_bit_on_2nd_bitmap(pfn, cycle);
 			++pfn;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
