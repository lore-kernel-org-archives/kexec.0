Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cai7E-0001Xk-Sn
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 12:09:55 +0000
Received: by mail-pg0-f41.google.com with SMTP id v184so28291572pgv.3
 for <kexec@lists.infradead.org>; Mon, 06 Feb 2017 04:09:32 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch 4/6] elf_info: kcore: check for invalid physical
 address
Date: Mon,  6 Feb 2017 17:31:49 +0530
Message-Id: <d01fb1346891c0e48b3d17008e904386e648e5bd.1486381806.git.panand@redhat.com>
In-Reply-To: <cover.1486381805.git.panand@redhat.com>
References: <cover.1486381805.git.panand@redhat.com>
In-Reply-To: <cover.1486381805.git.panand@redhat.com>
References: <cover.1486381805.git.panand@redhat.com>
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

After a recent kernel changes [0], kcore passes correct phys_start for
direct mapped region and an invalid value (-1) for all other regions.
arch specific function is_phys_addr() accepts only virt_start.
Therefore, check for valid phys_start in get_kcore_dump_loads().

[0] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?h=next-20170206&id=c9d4e5d7b7fd6c74e134ca44df8a5386efbc561c

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
