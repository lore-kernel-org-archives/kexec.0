Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([147.243.1.48] helo=mgw-sa02.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PDv57-00039E-7f
	for kexec@lists.infradead.org; Thu, 04 Nov 2010 08:22:02 +0000
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 1/2] ARM: determine PAGE_OFFSET from _stext
Date: Thu,  4 Nov 2010 10:15:16 +0200
Message-Id: <eeee74fa4f26d7a83f13e71afe09b9f98c1a5ee0.1288788355.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
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
Cc: igawa@mxs.nes.nec.co.jp, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

It is normal that we can have different values for PAGE_OFFSET depending on
selected VM split. We avoid the hard-coded value and derive the value from the
_stext symbol instead.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arm.c          |    2 +-
 makedumpfile.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arm.c b/arm.c
index 3fc0599..3ea450a 100644
--- a/arm.c
+++ b/arm.c
@@ -81,7 +81,7 @@ get_machdep_info_arm(void)
 {
 	unsigned long vmlist, vmalloc_start;
 
-	info->page_offset = __PAGE_OFFSET;
+	info->page_offset = SYMBOL(_stext) & 0xffff0000UL;
 	info->max_physmem_bits = _MAX_PHYSMEM_BITS;
 	info->kernel_start = SYMBOL(_stext);
 	info->section_size_bits = _SECTION_SIZE_BITS;
diff --git a/makedumpfile.h b/makedumpfile.h
index 3f39a88..6d91d51 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -507,7 +507,6 @@ do { \
 #define VMEMMAP_END		(info->vmemmap_end)
 
 #ifdef __arm__
-#define __PAGE_OFFSET		(0xc0000000)
 #define KVBASE_MASK		(0xffff)
 #define KVBASE			(SYMBOL(_stext) & ~KVBASE_MASK)
 #define _SECTION_SIZE_BITS	(28)
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
