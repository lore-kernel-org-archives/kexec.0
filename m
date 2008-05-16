Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwnZ6-0003jU-P9
	for kexec@lists.infradead.org; Fri, 16 May 2008 00:12:53 +0000
Received: by rv-out-0708.google.com with SMTP id b17so737235rvf.42
	for <kexec@lists.infradead.org>; Thu, 15 May 2008 17:12:51 -0700 (PDT)
Date: Thu, 15 May 2008 17:12:58 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH] Prototype ifdown() in kexec.h, not nested in main().
Message-ID: <20080516001258.GA6259@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
Another generic patch extracted from my Windows porting work.

 kexec/kexec.c |    3 +--
 kexec/kexec.h |    2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f898428..de9765e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -956,8 +956,7 @@ int main(int argc, char *argv[])
 		sync();
 	}
 	if ((result == 0) && do_ifdown) {
-		extern int ifdown(void);
-		(void)ifdown();
+		ifdown();
 	}
 	if ((result == 0) && do_exec) {
 		result = my_exec();
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2d3a748..9b45476 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -209,6 +209,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	int buf_end, int phys);
 extern void arch_reuse_initrd(void);
 
+extern int ifdown(void);
+
 extern unsigned char purgatory[];
 extern size_t purgatory_size;
 
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
