Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBTh4-0003OZ-NR
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 12:01:47 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 2/3] e820_update_range(): Allow specifying ULLONG_MAX
Date: Wed, 25 Jun 2008 14:02:21 +0200
Message-Id: <1214395342-20375-3-git-send-email-bwalle@suse.de>
In-Reply-To: <1214395342-20375-1-git-send-email-bwalle@suse.de>
References: <1214395342-20375-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yhlu.kernel@gmail.com

Allow the specifying of ULLONG_MAX to limit the whole E820 map from the
specified start to the end. Without the patch, there would be integer
overflows.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e466073..7d1109b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -397,6 +397,9 @@ int __init copy_e820_map(struct e820entry *biosmap, int nr_map)
 	return __copy_e820_map(biosmap, nr_map);
 }
 
+/*
+ * Pass size == ULLONG_MAX to update until the end.
+ */
 u64 __init e820_update_range(u64 start, u64 size, unsigned old_type,
 				unsigned new_type)
 {
@@ -412,14 +415,18 @@ u64 __init e820_update_range(u64 start, u64 size, unsigned old_type,
 			continue;
 		/* totally covered? */
 		if (ei->addr >= start &&
-		    (ei->addr + ei->size) <= (start + size)) {
+		    (((ei->addr + ei->size) <= (start + size)) ||
+			    (size == ULLONG_MAX))) {
 			ei->type = new_type;
 			real_updated_size += ei->size;
 			continue;
 		}
 		/* partially covered */
 		final_start = max(start, ei->addr);
-		final_end = min(start + size, ei->addr + ei->size);
+		if (size == ULLONG_MAX)
+			final_end = ei->addr + ei->size;
+		else
+			final_end = min(start + size, ei->addr + ei->size);
 		if (final_start >= final_end)
 			continue;
 		ei->size -= final_end - final_start;
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
