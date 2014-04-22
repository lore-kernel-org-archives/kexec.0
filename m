Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcQtf-0001Mc-Az
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 02:57:23 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v7 3/9] x86,
 cleanup: add other types of memory range for 2nd kernel boot to
 memmap_p
Date: Tue, 22 Apr 2014 10:56:41 +0800
Message-Id: <1398135407-30142-4-git-send-email-chaowang@redhat.com>
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

In load_crashdump_segments(), memmap_p[] is used to contain RANGE_RAM
memory range for booting 2nd kernel. Now adding types of RANGE_ACPI and
RANGE_ACPI_NVS to memmap_p, so later we can pass all the types of memory
range to 2nd kernel. These all types of memory ranges are all stored in
memmap_p for later reference.

Signed-off-by: WANG Chao <chaowang@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Tested-by: Linn Crosetto <linn@hp.com>
---
 kexec/arch/i386/crashdump-x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 6dd2e65..f97d79a 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1006,12 +1006,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	/* Inform second kernel about the presence of ACPI tables. */
 	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
-		unsigned long start, end;
+		unsigned long start, end, size, type;
 		if ( !( mem_range[i].type == RANGE_ACPI
 			|| mem_range[i].type == RANGE_ACPI_NVS) )
 			continue;
 		start = mem_range[i].start;
 		end = mem_range[i].end;
+		type = mem_range[i].type;
+		size = end - start + 1;
+		add_memmap(memmap_p, &nr_memmap, start, size, type);
 		cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 	return 0;
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
