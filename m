Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjeGn-0005q1-Nt
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 03:52:44 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v3] Only print debug message when failed to serach for kernel
 symbol from /proc/kallsyms
Date: Fri,  3 Mar 2017 11:52:15 +0800
Message-Id: <1488513135-29611-1-git-send-email-bhe@redhat.com>
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
To: horms@verge.net.au
Cc: panand@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

Kernel symbol page_offset_base could be unavailable when mm KASLR code is
not compiled in kernel. It's unappropriate to print out error message
when failed to search for page_offset_base from /proc/kallsyms. Seems now
there is not a way to find out if mm KASLR is compiled in or not. An
alternative approach is only printing out debug message in get_kernel_sym
if failed to search a expected kernel symbol.

Do it in this patch, a simple fix.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 88aeee3..c4cf201 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -127,7 +127,7 @@ static unsigned long long get_kernel_sym(const char *symbol)
 		}
 	}
 
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
+	dbgprintf("Cannot get kernel %s symbol address\n", symbol);
 	return 0;
 }
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
