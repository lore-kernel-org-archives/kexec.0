Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecV7m-0006nS-5Z
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 11:46:23 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [makedumpfile PATCH 2/2] Fix physical-to-virtual conversion in
 exclude_segment()
Date: Fri, 19 Jan 2018 12:45:24 +0100
Message-Id: <2dbb8bb361a6de5d558fa66aa9790f28fac97891.1516354241.git.ptesarik@suse.com>
In-Reply-To: <cover.1516354241.git.ptesarik@suse.com>
References: <cover.1516354241.git.ptesarik@suse.com>
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
To: kexec@lists.infradead.org, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.com>

With kaslr enabled, PAGE_OFFSET may no longer be aligned to allow
calculation using bitwise OR. My fix follows the same idea as
Baoquan's commit 4c53423b995463067fbbd394e724b4d1d6ea3d62 for
set_kcore_vmcoreinfo, i.e. use arithmetic addition instead.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 elf_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 1eaddd9..711601a 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -810,8 +810,8 @@ static int exclude_segment(struct pt_load_segment **pt_loads,
 	int i, j, tidx = -1;
 	unsigned long long	vstart, vend, kvstart, kvend;
 	struct pt_load_segment temp_seg = {0};
-	kvstart = (ulong)start | PAGE_OFFSET;
-	kvend = (ulong)end | PAGE_OFFSET;
+	kvstart = (ulong)start + PAGE_OFFSET;
+	kvend = (ulong)end + PAGE_OFFSET;
 	unsigned long size;
 
 	for (i = 0; i < (*num_pt_loads); i++) {
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
