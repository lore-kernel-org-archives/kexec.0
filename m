Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFdPW-0002bi-5z
	for kexec@lists.infradead.org; Sun, 06 Jul 2008 23:12:50 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 2/5] Fix compiler warning in kexec-x86.c
Date: Mon,  7 Jul 2008 01:13:25 +0200
Message-Id: <1215386008-16271-3-git-send-email-bwalle@suse.de>
In-Reply-To: <1215386008-16271-1-git-send-email-bwalle@suse.de>
References: <1215386008-16271-1-git-send-email-bwalle@suse.de>
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
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, Bernhard Walle <bernhard.walle@gmx.de>, vgoyal@redhat.com

From: Bernhard Walle <bernhard.walle@gmx.de>

This patch fixes following compiler warning:

    kexec/arch/i386/kexec-x86.c:234: \
        warning: missing initializer
    kexec/arch/i386/kexec-x86.c:234: \
        warning: (near initialization for 'arches[5].arch')


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/kexec-x86.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 31e4752..8c8ba7f 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -226,12 +226,12 @@ const struct arch_map_entry arches[] = {
 	/* For compatibility with older patches
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_386 here.
 	 */
-	{ "i386", KEXEC_ARCH_DEFAULT },
-	{ "i486", KEXEC_ARCH_DEFAULT },
-	{ "i586", KEXEC_ARCH_DEFAULT },
-	{ "i686", KEXEC_ARCH_DEFAULT },
-	{ "x86_64", KEXEC_ARCH_X86_64 },
-	{ 0 },
+	{ "i386",   KEXEC_ARCH_DEFAULT },
+	{ "i486",   KEXEC_ARCH_DEFAULT },
+	{ "i586",   KEXEC_ARCH_DEFAULT },
+	{ "i686",   KEXEC_ARCH_DEFAULT },
+	{ "x86_64", KEXEC_ARCH_X86_64  },
+	{ 0,        0  		       },
 };
 
 int arch_compat_trampoline(struct kexec_info *info)
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
