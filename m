Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0060.outbound.protection.outlook.com
 ([104.47.34.60] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2kd7-0002wx-DP
 for kexec@lists.infradead.org; Thu, 12 Oct 2017 21:02:58 +0000
From: David Daney <david.daney@cavium.com>
Subject: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Date: Thu, 12 Oct 2017 14:02:25 -0700
Message-Id: <20171012210228.7353-2-david.daney@cavium.com>
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

Some kernel versions running on MIPS split the System RAM memory
regions reported in /proc/iomem.  This may cause loading of the kexec
kernel to fail if it crosses one of the splits.

Fix by merging adjacent memory ranges that have the same type.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 2e5b700..415c2ed 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		} else {
 			continue;
 		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-		memory_ranges++;
+		if (memory_ranges > 0 &&
+		    memory_range[memory_ranges - 1].end == start &&
+		    memory_range[memory_ranges - 1].type == type) {
+			memory_range[memory_ranges - 1].end = end;
+		} else {
+			memory_range[memory_ranges].start = start;
+			memory_range[memory_ranges].end = end;
+			memory_range[memory_ranges].type = type;
+			memory_ranges++;
+		}
 	}
 	fclose(fp);
 	*range = memory_range;
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
