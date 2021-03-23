Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOdqr-00EZ8G-OV
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 10:01:32 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/3] crashdump/x86: iterate only over actual crash memory
 ranges
Date: Tue, 23 Mar 2021 11:01:09 +0100
Message-Id: <20210323100111.8365-3-david@redhat.com>
In-Reply-To: <20210323100111.8365-1-david@redhat.com>
References: <20210323100111.8365-1-david@redhat.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: David Hildenbrand <david@redhat.com>, Simon Horman <horms@verge.net.au>

No need to iterate over empty entries.

Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a301ac8..43e830a 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -988,7 +988,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */
-	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
+	for (i = 0; i < nr_ranges; i++) {
 		unsigned long start, end, size, type;
 		if ( !( mem_range[i].type == RANGE_ACPI
 			|| mem_range[i].type == RANGE_ACPI_NVS
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
