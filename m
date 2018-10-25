Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFYys-0002pD-I6
 for kexec@lists.infradead.org; Thu, 25 Oct 2018 06:18:57 +0000
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so3666969pfe.6
 for <kexec@lists.infradead.org>; Wed, 24 Oct 2018 23:18:42 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] makedumpfile: Update help text to indicate --mem-usage is
 supported on archs other than x86_64
Date: Thu, 25 Oct 2018 11:48:27 +0530
Message-Id: <1540448307-15300-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

Commit 8449bda73ab14516d4bf81d29503c1ea203bb865 ["Documentation:
Update documentation regarding --mem-usage' option"]), updated the
makedumpfile man page to indicate that this option is now
supported on x86_64, arm64, ppc64 and s390x.

However, the help text for makedumpfile (which one can see
by running 'makedumpfile --help'), still reflects the old
support status, i.e. this option is only supported on x86_64.

This patch changes the help text to be in sync with the man
page text.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 print_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/print_info.c b/print_info.c
index 732d5b806c24..0be12ea8803c 100644
--- a/print_info.c
+++ b/print_info.c
@@ -300,7 +300,7 @@ print_usage(void)
 	MSG("      necessary to specify [-x VMLINUX] or [-i VMCOREINFO].\n");
 	MSG("\n");
 	MSG("  [--mem-usage]:\n");
-	MSG("      This option is only for x86_64.\n");
+	MSG("      This option is currently supported on x86_64, arm64, ppc64 and s390x.\n");
 	MSG("      This option is used to show the page numbers of current system in different\n");
 	MSG("      use. It should be executed in 1st kernel. By the help of this, user can know\n");
 	MSG("      how many pages is dumpable when different dump_level is specified. It analyzes\n");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
