Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcQtu-0001Xt-BA
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 02:57:38 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v7 6/9] x86, cleanup: Store crash memory ranges kexec_info
Date: Tue, 22 Apr 2014 10:56:44 +0800
Message-Id: <1398135407-30142-7-git-send-email-chaowang@redhat.com>
In-Reply-To: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
References: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, dyoung@redhat.com, linn@hp.com, vgoyal@redhat.com, hpa@zytor.com, trenn@suse.de
Cc: kexec@lists.infradead.org

Add two new members to kexec_info structure:

struct memory_range *crash_range
int nr_crash_ranges;

crash_range contains the memory ranges used to boot 2nd kernel.
nr_crash_ranges contains the count of the crash memory ranges.

Signed-off-by: WANG Chao <chaowang@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Tested-by: Linn Crosetto <linn@hp.com>
---
 kexec/arch/i386/crashdump-x86.c | 6 ++++++
 kexec/kexec.h                   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 39c35ea..7b618a6 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -997,6 +997,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		add_memmap(memmap_p, &nr_memmap, start, size, type);
 		cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
+
+	/* Store 2nd kernel boot memory ranges for later reference in
+	 * x86-setup-linux.c: setup_linux_system_parameters() */
+	info->crash_range = memmap_p;
+	info->nr_crash_ranges = nr_memmap;
+
 	return 0;
 }
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index d69bba2..22d4a42 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -148,6 +148,8 @@ struct kexec_info {
 	int nr_segments;
 	struct memory_range *memory_range;
 	int memory_ranges;
+	struct memory_range *crash_range;
+	int nr_crash_ranges;
 	void *entry;
 	struct mem_ehdr rhdr;
 	unsigned long backup_start;
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
