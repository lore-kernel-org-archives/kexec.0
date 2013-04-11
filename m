Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQGbV-00085q-Fc
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 12:27:51 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/5] kexec: X86: Show e820 table which gets passed in debug
 mode
Date: Thu, 11 Apr 2013 14:26:43 +0200
Message-Id: <1365683207-42425-2-git-send-email-trenn@suse.de>
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

CC: Simon Horman <horms@verge.net.au>
CC: kexec@lists.infradead.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/x86-linux-setup.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 454fad6..c538897 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -518,7 +518,10 @@ void setup_linux_system_parameters(struct kexec_info *info,
 		ranges = E820MAX;
 	}
 	real_mode->e820_map_nr = ranges;
+	dbgprintf("E820 map:\n");
 	for(i = 0; i < ranges; i++) {
+		dbgprintf("%016Lx-%016Lx (%d)\n", range[i].start,
+			  range[i].end, range[i].type);
 		real_mode->e820_map[i].addr = range[i].start;
 		real_mode->e820_map[i].size = range[i].end - range[i].start;
 		switch (range[i].type) {
@@ -550,7 +553,6 @@ void setup_linux_system_parameters(struct kexec_info *info,
 			}
 		}
 	}
-
 	/* fill the EDD information */
 	setup_edd_info(real_mode);
 }
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
