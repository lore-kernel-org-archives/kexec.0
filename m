Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQGbV-00085m-Fv
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 12:27:50 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/5] kexec: X86: Enhance crash range debug output
Date: Thu, 11 Apr 2013 14:26:44 +0200
Message-Id: <1365683207-42425-3-git-send-email-trenn@suse.de>
In-Reply-To: <1365683207-42425-1-git-send-email-trenn@suse.de>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Thomas Renninger <trenn@suse.de>

Add the type as done at other places where ranges are shown.

CC: Simon Horman <horms@verge.net.au>
CC: kexec@lists.infradead.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 9ab648b..3f8593d 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -984,7 +984,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	dbgprintf("CRASH MEMORY RANGES\n");
 
 	for(i = 0; i < nr_ranges; ++i)
-		dbgprintf("%016Lx-%016Lx\n", mem_range[i].start, mem_range[i].end);
+		dbgprintf("%016Lx-%016Lx (%d)\n", mem_range[i].start,
+			  mem_range[i].end, mem_range[i].type);
 
 	/*
 	 * if the core type has not been set on command line, set it here
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
