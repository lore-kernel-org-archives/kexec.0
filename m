Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.242])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBFj3-0004Hv-5b
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 21:06:53 +0000
Received: by an-out-0708.google.com with SMTP id c24so655728ana.99
	for <kexec@lists.infradead.org>; Tue, 24 Jun 2008 14:06:50 -0700 (PDT)
Date: Tue, 24 Jun 2008 22:03:56 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec/crashdump.c: improve the code a bit
Message-ID: <20080624210356.GA8177@hack.netcabo.pt>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org


Add the missing fclose().
Constify a char pointer.

Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index e0ba36d..92de524 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -107,10 +107,11 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 	printf("crash_notes addr = %Lx\n", *addr);
 #endif
 
+	fclose(fp);
 	return 0;
 }
 
-static int get_vmcoreinfo(char *kdump_info, uint64_t *addr, uint64_t *len)
+static int get_vmcoreinfo(const char *kdump_info, uint64_t *addr, uint64_t *len)
 {
 	char line[MAX_LINE];
 	int count;
@@ -132,6 +133,7 @@ static int get_vmcoreinfo(char *kdump_info, uint64_t *addr, uint64_t *len)
 	*addr = (uint64_t) temp;
 	*len = (uint64_t) temp2;
 
+	fclose(fp);
 	return 0;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
