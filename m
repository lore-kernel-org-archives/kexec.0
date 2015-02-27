Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YRJoR-0005x5-CY
 for kexec@lists.infradead.org; Fri, 27 Feb 2015 12:14:36 +0000
Date: Fri, 27 Feb 2015 13:14:09 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150227131409.33dd14a4@hananiah.suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec mailing list <kexec@lists.infradead.org>

Hi all,

update_mmap_range() expects a file offset as its first argument, but
initialize_mmap() passes a physical address. Since the first segment
usually starts at physical addr 0 on S/390, but there is no segment 
at file offset 0, update_mmap_range() fails, and makedumpfile falls
back to read().

@Michael: I wonder how you actually tested the kernel mmap patches;
this bug has prevented mmap on all my s390 systems...

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -347,7 +347,7 @@ initialize_mmap(void) {
 	info->mmap_buf = MAP_FAILED;
 
 	get_pt_load(0, &phys_start, NULL, NULL, NULL);
-	if (!update_mmap_range(phys_start, 1))
+	if (!update_mmap_range(paddr_to_offset(phys_start), 1))
 		return FALSE;
 
 	return TRUE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
