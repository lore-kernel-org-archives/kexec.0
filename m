Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SIcsh-0005w4-8p
 for kexec@lists.infradead.org; Fri, 13 Apr 2012 09:33:27 +0000
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hanpt@linux.vnet.ibm.com>;
 Fri, 13 Apr 2012 05:33:20 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4E6A36E804B
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2012 05:32:45 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3D9Wi7W3002516
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2012 05:32:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3D9WiRh004711
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2012 05:32:44 -0400
Date: Fri, 13 Apr 2012 17:32:42 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Subject: [PATCH] Add more debug infos when usable memory range changing
Message-ID: <20120413093242.GA17904@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

In the past, we did neglected some usable memory range
changing infos. With those deubg code added, we can now
catch them.
---
 kexec/arch/ppc64/crashdump-ppc64.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index d52b438..b5ec2c8 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -465,12 +465,24 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 			if (base < ustart && end > uend) {
 				usablemem_rgns.ranges[i].start = base;
 				usablemem_rgns.ranges[i].end = end;
+#ifdef DEBUG
+				fprintf(stderr, "usable memory rgn %u: new base:%llx new size:%llx\n",
+					i, base, size);
+#endif
 				return;
 			} else if (base < ustart) {
 				usablemem_rgns.ranges[i].start = base;
+#ifdef DEBUG
+				fprintf(stderr, "usable memory rgn %u: new base:%llx new size:%llx",
+					i, base, usablemem_rgns.ranges[i].end - base);
+#endif
 				return;
 			} else if (end > uend){
 				usablemem_rgns.ranges[i].end = end;
+#ifdef DEBUG
+				fprintf(stderr, "usable memory rgn %u: new end:%llx, new size:%llx",
+					i, end, end - usablemem_rgns.ranges[i].start);
+#endif
 				return;
 			}
 		}
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
