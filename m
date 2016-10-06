Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bs5K1-00031p-Bi
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 09:50:38 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/3] makedumpfile: Get info->kernel_version from
 SYMBOL(init_uts_ns) earlier
Date: Thu,  6 Oct 2016 17:50:06 +0800
Message-Id: <1475747408-25666-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1475747408-25666-1-git-send-email-bhe@redhat.com>
References: <1475747408-25666-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: dyoung@redhat.com, kexec@lists.infradead.org, thgarnie@google.com, Baoquan He <bhe@redhat.com>, tonli@redhat.com

The current code assign value to info->kernel_version in check_release,
this is too late and buggy. Because in check_release(), it needs calling
readmem, however earlier get_value_for_old_linux depends on
info->kernel_version to get correct KERNEL_IMAGE_SIZE for MODULES_VADDR
which is used in is_vmalloc_addr_x86_64(). This looks a weird circle.

Since we have exported "OSRELEASE=%s\n" explicitly in kernel, we should
always use it to get kernel version. And this breaks above weird circle.
Otherwise MM randomization will come and make it worse.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d168dfd..89e1089 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1139,12 +1139,6 @@ check_release(void)
 		}
 	}
 
-	info->kernel_version = get_kernel_version(info->system_utsname.release);
-	if (info->kernel_version == FALSE) {
-		ERRMSG("Can't get the kernel version.\n");
-		return FALSE;
-	}
-
 	return TRUE;
 }
 
@@ -3832,6 +3826,12 @@ initial(void)
 		debug_info = TRUE;
 	}
 
+	info->kernel_version = get_kernel_version(info->release);
+	if (info->kernel_version == FALSE) {
+		ERRMSG("Can't get the kernel version.\n");
+		return FALSE;
+	}
+
 	if (!get_value_for_old_linux())
 		return FALSE;
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
