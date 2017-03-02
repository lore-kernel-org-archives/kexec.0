Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMEx-00011f-RR
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:37 +0000
Received: by mail-pf0-f171.google.com with SMTP id x66so20143262pfb.3
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:14 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 4/7] elf_info: kcore: check for invalid
 physical address
Date: Thu,  2 Mar 2017 14:06:49 +0530
Message-Id: <5647c5e3caa1e469b625f4adb7277493e9795fb3.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

kcore passes correct phys_start for direct mapped region and an invalid
value (-1) for all other regions after the kernel commit
464920104bf7(/proc/kcore: update physical address for kcore ram and
text). arch specific function is_phys_addr() accepts only virt_start.
Therefore, check for valid phys_start in get_kcore_dump_loads().

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 elf_info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 65ff333cf33a..c5743b3cab28 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -881,7 +881,8 @@ int get_kcore_dump_loads(void)
 
 	for (i = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
-		if (!is_phys_addr(p->virt_start))
+		if (p->phys_start == NOT_PADDR
+				|| !is_phys_addr(p->virt_start))
 			continue;
 		loads++;
 	}
@@ -901,7 +902,8 @@ int get_kcore_dump_loads(void)
 
 	for (i = 0, j = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
-		if (!is_phys_addr(p->virt_start))
+		if (p->phys_start == NOT_PADDR
+				|| !is_phys_addr(p->virt_start))
 			continue;
 		if (j >= loads)
 			return FALSE;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
