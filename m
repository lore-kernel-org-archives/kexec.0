Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=outbound1-sin-R.bigfish.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hlttq-0005rl-1y
	for kexec@lists.infradead.org; Wed, 09 May 2007 22:40:44 +0100
Message-ID: <46423FC4.605@am.sony.com>
Date: Wed, 09 May 2007 14:40:20 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 1/2] kexec remove last remaining dfprintf
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com> <20070508061204.GD8170@verge.net.au>
In-Reply-To: <20070508061204.GD8170@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Remove the last remaining dfprintf call and remove the dfprintf
definition.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/arch/ppc64/kexec-ppc64.c |    2 +-
 kexec/kexec.h                  |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

--- ps3-kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ ps3-kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
@@ -207,7 +207,7 @@ static int get_base_ranges(void)
 				((unsigned long long *)buf)[1];
 			base_memory_range[local_memory_ranges].type = RANGE_RAM;
 			local_memory_ranges++;
-			dfprintf(stderr, "%016llx-%016llx : %x\n",
+			dprintf("%016llx-%016llx : %x\n",
 				base_memory_range[local_memory_ranges-1].start,
 				base_memory_range[local_memory_ranges-1].end,
 				base_memory_range[local_memory_ranges-1].type);
--- ps3-kexec-tools.orig/kexec/kexec.h
+++ ps3-kexec-tools/kexec/kexec.h
@@ -217,12 +217,11 @@ int parse_iomem_single(char *str, uint64
 
 #define MAX_LINE	160
 
-#define dprintf(args...) dfprintf(stdout, args)
 #ifdef DEBUG
-#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
+#define dprintf(_args...) do {printf(_args);} while(0)
 #else
-static inline int __attribute__ ((format (printf, 2, 3)))
-	dfprintf(FILE *f, const char *fmt, ...) {return 0;}
+static inline int __attribute__ ((format (printf, 1, 2)))
+	dprintf(const char *fmt, ...) {return 0;}
 #endif
 
 #endif /* KEXEC_H */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
