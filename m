Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9E1p-00022P-7N
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 11:44:21 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [RFC PATCH 1/4] Fix an overflow bug with address comparison
Date: Wed,  5 Sep 2012 12:44:00 +0100
Message-Id: <1346845443-32242-2-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew Leach <matthew.leach@arm.com>, will.deacon@arm.com

The variables mstart and mend are assigned the values of
mem_region[i].start and mem_region[i].end which are of the type
unsigned long long. Ensure that mstart and mend are of the same data
type to prevent address overflow.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 8928be0..c7b38e3 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -108,7 +108,7 @@ int valid_memory_range(struct kexec_info *info,
 		return 0;
 	}
 	for (i = 0; i < info->memory_ranges; i++) {
-		unsigned long mstart, mend;
+		unsigned long long mstart, mend;
 		/* Only consider memory ranges */
 		if (info->memory_range[i].type != RANGE_RAM)
 			continue;
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
