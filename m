Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R49sX-0000jx-BS
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 11:13:14 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [RFC] sh: Take into account the base of physical memory in
	virt_to_phys()
Date: Thu, 15 Sep 2011 20:12:59 +0900
Message-Id: <1316085179-4207-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Previously virt_to_phys() assumed that physical memory always started
at address 0. This is not always the case.

Tested on an sh7757lcr (32bit system) whose only System RAM region is
40000000-4effffff

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 4b21ee8..b0381bb 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -188,10 +188,18 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
+	unsigned long long start, end;
+	int ret;
+
+	/* Assume there is only one "System RAM" region */
+	ret = parse_iomem_single("System RAM\n", &start, &end);
+	if (ret)
+		die("Could not parse System RAM region in /proc/iomem\n");
+
 	if (seg != 0x80000000 && seg != 0xc0000000)
 		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
 
-	return addr - seg;
+	return addr - seg + start;
 }
 
 /*
-- 
1.7.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
