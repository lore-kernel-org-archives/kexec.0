Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TW5oJ-0002Z1-MK
 for kexec@lists.infradead.org; Wed, 07 Nov 2012 13:36:53 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 7 Nov 2012 23:32:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA7DQNZp45154306
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 00:26:23 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA7DacOh028373
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 00:36:38 +1100
Subject: [PATCH] ppc/uImage: Find new kernel load_addr if the default addr
 is not available
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 07 Nov 2012 19:06:35 +0530
Message-ID: <20121107133242.3676.23885.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

If the kernel cannot be loaded at the default load_addr, provided
by the image, we should try finding a free area using locate_hole().
This is usually applicable for the CRASH case, where the memory should
be located in the reserved region.

Without this patch, sometime the kernel fails to load for uImage formatted
relocatable kernel images.


Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index b5579f0..e55bf94 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -130,13 +130,22 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	 * allocated from memtop down towards zero so we should never get too
 	 * close to the bss :)
 	 */
-	ret = valid_memory_range(info, load_addr, load_addr + (len + (1 * 1024 * 1024)));
-	if (!ret) {
-		printf("Can't add kernel to addr 0x%08x len %ld\n",
-				load_addr, len + (1 * 1024 * 1024));
-		return -1;
+#define _1MiB	(1 * 1024 * 1024)
+
+	/*
+	 * If the provided load_addr cannot be allocated, find a new
+	 * area.
+	 */
+	if (!valid_memory_range(info, load_addr, load_addr + (len + _1MiB))) {
+		load_addr = locate_hole(info, len + _1MiB, 0, 0, max_addr, 1);
+		if (load_addr == ULONG_MAX) {
+			printf("Can't allocate memory for kernel of len %ld\n",
+					len + _1MiB);
+			return -1;
+		}
 	}
-	add_segment(info, buf, len, load_addr, len + (1 * 1024 * 1024));
+
+	add_segment(info, buf, len, load_addr, len + _1MiB);
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
                 crash_cmdline = xmalloc(COMMAND_LINE_SIZE);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
