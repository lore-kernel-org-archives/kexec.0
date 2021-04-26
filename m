Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb1JH-00FzDX-IK
 for kexec@lists.infradead.org; Mon, 26 Apr 2021 13:30:00 +0000
Date: Mon, 26 Apr 2021 15:29:51 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] kexec-tools: Remove duplicate definition of ramdisk
Message-ID: <20210426152815.556fb945@ezekiel.suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

The ramdisk variable is defined in kexec/arch/ppc/kexec-ppc.c. This
other definition is not needed and breaks build with -fno-common.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -33,7 +33,6 @@
 static const int probe_debug = 0;
 
 unsigned char reuse_initrd;
-const char *ramdisk;
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
 			char *);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
