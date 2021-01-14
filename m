Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzxwU-0006wp-7K
 for kexec@lists.infradead.org; Thu, 14 Jan 2021 08:25:19 +0000
Received: by mail-pl1-x630.google.com with SMTP id v3so2524254plz.13
 for <kexec@lists.infradead.org>; Thu, 14 Jan 2021 00:25:17 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [RFC PATCH 1/4] Use ELF vmcoreinfo note for --mem-usage option
Date: Thu, 14 Jan 2021 17:25:06 +0900
Message-Id: <1610612709-18887-2-git-send-email-kazuhito.hagio@gmail.com>
In-Reply-To: <1610612709-18887-1-git-send-email-kazuhito.hagio@gmail.com>
References: <1610612709-18887-1-git-send-email-kazuhito.hagio@gmail.com>
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
To: bhsharma@redhat.com, bhupesh.linux@gmail.com, alexander.kamensky42@gmail.com, piliu@redhat.com, kexec@lists.infradead.org
Cc: aadiga@qti.qualcomm.com, ioanna-maria.alifieraki@canonical.com

From: Kazuhito Hagio <k-hagio-ab@nec.com>

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 makedumpfile.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ecd63fa..199748b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11426,6 +11426,7 @@ int show_mem_usage(void)
 {
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
 	struct cycle cycle = {0};
+	int vmcoreinfo = FALSE;
 
 	if (!is_crashkernel_mem_reserved()) {
 		ERRMSG("No memory is reserved for crashkernel!\n");
@@ -11437,9 +11438,22 @@ int show_mem_usage(void)
 	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
-	if (!get_elf_loads(info->fd_memory, info->name_memory))
+	if (!get_elf_info(info->fd_memory, info->name_memory))
 		return FALSE;
 
+	/*
+	 * /proc/kcore on Linux 4.19 and later kernels have vmcoreinfo note in
+	 * NOTE segment.  See commit 23c85094fe18.
+	 */
+	if (has_vmcoreinfo()) {
+		off_t offset;
+		unsigned long size;
+
+		get_vmcoreinfo(&offset, &size);
+		vmcoreinfo = read_vmcoreinfo_from_vmcore(offset, size, FALSE);
+		DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", vmcoreinfo);
+	}
+
 	if (!get_page_offset())
 		return FALSE;
 
@@ -11447,11 +11461,13 @@ int show_mem_usage(void)
 	if (!get_phys_base())
 		return FALSE;
 
-	if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
-		return FALSE;
+	if (!vmcoreinfo) {
+		if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
+			return FALSE;
 
-	if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
-		return FALSE;
+		if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
+			return FALSE;
+	}
 
 	if (!initial())
 		return FALSE;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
