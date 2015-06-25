Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z813q-0007Iw-KU
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 06:54:59 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5P6qsa5011628
 for <kexec@lists.infradead.org>; Thu, 25 Jun 2015 14:52:54 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] makedumpfile: Fix a bug
Date: Thu, 25 Jun 2015 14:51:02 +0800
Message-ID: <1435215062-31333-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1435215062-31333-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1435215062-31333-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

In cyclic mode, when generating vmcore in elf format, info->bitmap2
is used but not prepared.

Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7f2949c..88e3389 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6026,6 +6026,11 @@ get_loads_dumpfile_cyclic(void)
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
 
+	if (info->flag_cyclic) {
+		if (!prepare_bitmap2_buffer())
+			return FALSE;
+	}
+
 	for (i = 0; i < phnum; i++) {
 		if (!get_phdr_memory(i, &load))
 			return FALSE;
@@ -6069,6 +6074,11 @@ get_loads_dumpfile_cyclic(void)
 		}
 
 	}
+
+	if (info->flag_cyclic) {
+		free_bitmap2_buffer();
+	}
+
 	return num_new_load;
 }
 
@@ -6108,6 +6118,11 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
 
+        if (info->flag_cyclic) {
+                if (!prepare_bitmap2_buffer())
+                        return FALSE;
+        }
+
 	gettimeofday(&tv_start, NULL);
 
 	for (i = 0; i < phnum; i++) {
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
