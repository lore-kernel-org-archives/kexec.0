Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB3J-0007jY-0A
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:13:45 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 03/10] x86,
 cleanup: add other types of memory range for 2nd kernel boot to
 memmap_p
Date: Thu, 10 Apr 2014 17:12:56 +0800
Message-Id: <1397121186-9353-4-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Now memmap_p contains all the memory range for 2nd kernel boot.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index e695eaf..43eb8f7 100644
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
+		size = end - start;
+		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
 		cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 	return 0;
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
