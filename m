Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaiy-0006XK-26
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:26 +0000
Received: by mail-pf0-f179.google.com with SMTP id p185so1205619pfb.1
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:53:05 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 7/7] mem-usage: allow to work only with -f for
 kernel version < 4.11
Date: Tue, 28 Feb 2017 11:22:41 +0530
Message-Id: <72c8ce7c8c2a54714a8338a08e2ab5ae31e6d4e2.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
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

PT_LOAD of kcore does not have valid p_paddr values for kernel version
less that v4.11. Therefore, older kernel will no long work for mem-usage
with current makedumpfile code. They can only work when they are patched
with fix to "update physical address for kcore ram and text".

This patch fixes the makedumpfile so that it does not allow to work
older kernel for --mem-usage until someone is sure that kernel is
rightly patched and so uses -f in command line.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3b8e9810468d..bf006ea5dd5f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11269,6 +11269,12 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
+		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
+				!info->flag_force) {
+			MSG("mem-usage not supported for this kernel.\n");
+			MSG("You can try with -f if your kernel's kcore has valid p_paddr\n");
+			return COMPLETED;
+		}
 
 		if (!show_mem_usage())
 			goto out;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
