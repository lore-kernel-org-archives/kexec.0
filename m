Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kdl3p-0005td-RU
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 12:14:10 +0000
Date: Thu, 11 Sep 2008 14:14:03 +0200
Subject: [patch] [PATCH] Don't write undefined values to disk
Message-ID: <20080911121403.GA29229@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Because of structure member alignment, the simple structure

    struct kdump_sub_header {
            unsigned long   phys_base;
            int             dump_level;     
    };  

is 16 bytes large on x86_64. So if you fill the two members phys_base and
dump_level with values, you still have uninitialised memory if you write
sizeof(struct kdump_sub_header) to disk.

This patch initialises everything with zero first to get rid of that problem.
The patch fixes valgrind warning

    ==24152== Syscall param write(buf) points to uninitialised byte(s)
    ==24152==    at 0x4EEFFC0: write (in /lib64/libc-2.8.so)
    ==24152==    by 0x40A97D: (within /bin/makedumpfile)
    ==24152==    by 0x40ACEF: (within /bin/makedumpfile)
    ==24152==    by 0x41896C: (within /bin/makedumpfile)
    ==24152==    by 0x4191AA: (within /bin/makedumpfile)
    ==24152==    by 0x4E48435: (below main) (in /lib64/libc-2.8.so)
    ==24152==  Address 0x7fefffbfc is on thread 1's stack


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |    1 +
 1 file changed, 1 insertion(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4707,6 +4707,7 @@ write_kdump_header(void)
 	/*
 	 * Write sub header
 	 */
+	memset(&sub_dump_header, 0, sizeof(struct kdump_sub_header));
 	sub_dump_header.phys_base  = info->phys_base;
 	sub_dump_header.dump_level = info->dump_level;
 	size = sizeof(struct kdump_sub_header);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
