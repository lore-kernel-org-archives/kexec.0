Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coW8j-0007Aa-Dq
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 14:12:31 +0000
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: [PATCH][kexec-tools] ppc: Fix format warning with die()
Date: Thu, 16 Mar 2017 16:11:18 +0200
Message-Id: <20170316141118.22286-1-jussi.kukkonen@intel.com>
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
Cc: Jussi Kukkonen <jussi.kukkonen@intel.com>

Enable compiling kexec-tools for ppc with -Werror=format-security.

Signed-off-by: Jussi Kukkonen <jussi.kukkonen@intel.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c    | 2 +-
 kexec/arch/ppc/kexec-uImage-ppc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 291f06d..ad43ad1 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -453,7 +453,7 @@ out:
 	if (!tmp_cmdline)
 		free(command_line);
 	if (error_msg)
-		die(error_msg);
+		die("%s", error_msg);
 
 	return result;
 }
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 5eec6e4..e8f7adc 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -306,7 +306,7 @@ out:
 	if (!tmp_cmdline)
 		free(command_line);
 	if (error_msg)
-		die(error_msg);
+		die("%s", error_msg);
 	return ret;
 }
 
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
