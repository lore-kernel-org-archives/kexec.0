Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzxwY-0006xr-38
 for kexec@lists.infradead.org; Thu, 14 Jan 2021 08:25:23 +0000
Received: by mail-pj1-x1035.google.com with SMTP id p15so2596126pjv.3
 for <kexec@lists.infradead.org>; Thu, 14 Jan 2021 00:25:21 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [RFC PATCH 3/4] Get kernel version from OSRELEASE in vmcoreinfo
Date: Thu, 14 Jan 2021 17:25:08 +0900
Message-Id: <1610612709-18887-4-git-send-email-kazuhito.hagio@gmail.com>
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
 makedumpfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 199748b..fdfe437 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1182,6 +1182,7 @@ check_release(void)
 		}
 	}
 
+	info->kernel_version = FALSE;
 	info->kernel_version = get_kernel_version(info->system_utsname.release);
 	if (info->kernel_version == FALSE) {
 		ERRMSG("Can't get the kernel version.\n");
@@ -2480,6 +2481,9 @@ read_vmcoreinfo_basic_info(void)
 			if (strlen(info->release))
 				continue;
 			strcpy(info->release, buf + strlen(STR_OSRELEASE));
+
+			if (!info->kernel_version)
+				info->kernel_version = get_kernel_version(info->release);
 		}
 		if (strncmp(buf, STR_PAGESIZE, strlen(STR_PAGESIZE)) == 0) {
 			page_size = strtol(buf+strlen(STR_PAGESIZE),&endp,10);
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
