Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WiMTJ-0008AQ-DP
 for kexec@lists.infradead.org; Thu, 08 May 2014 11:26:41 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH RESEND] condition check fix
Date: Thu,  8 May 2014 19:26:17 +0800
Message-Id: <1399548377-10417-1-git-send-email-chaowang@redhat.com>
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
To: vgoyal@redhat.com, horms@verge.net.au
Cc: kexec@lists.infradead.org

In commit 91f5b9c ("kdump: pass e820 reserved region to 2nd kernel via
e820 table or setup_data"), I made a wrong condition check.

We should only add cmdline for a memory range if --pass-memmap-cmdline
and the range type isn't RANGE_RESERVED.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index cc33347..999a837 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1000,7 +1000,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		type = mem_range[i].type;
 		size = end - start + 1;
 		add_memmap(memmap_p, &nr_memmap, start, size, type);
-		if (arch_options.pass_memmap_cmdline || type != RANGE_RESERVED)
+		if (arch_options.pass_memmap_cmdline && type != RANGE_RESERVED)
 			cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
