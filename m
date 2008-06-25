Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBTh4-0003Om-HC
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 12:01:47 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 1/3] e820_update_range(): Strip size of original region
Date: Wed, 25 Jun 2008 14:02:20 +0200
Message-Id: <1214395342-20375-2-git-send-email-bwalle@suse.de>
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

This patch fixes a bug in e820_update_range(): Previously, if a region was
partially covered, then e820_update_range() only added a new E820 range but
didn't update the end/size of the previous range. That lead to duplicate
covering of a region.

Patch tested on i386 and x86-64 with patch that uses e820_update_range()
to limit the E820 map when "mem" parameter is specified on the command line.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e285ea3..e466073 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -422,6 +422,7 @@ u64 __init e820_update_range(u64 start, u64 size, unsigned old_type,
 		final_end = min(start + size, ei->addr + ei->size);
 		if (final_start >= final_end)
 			continue;
+		ei->size -= final_end - final_start;
 		e820_add_region(final_start, final_end - final_start,
 					 new_type);
 		real_updated_size += final_end - final_start;
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
