Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOdqp-00EZ7T-CO
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 10:01:29 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 1/3] crashdump/x86: dump any kind of "System RAM"
Date: Tue, 23 Mar 2021 11:01:08 +0100
Message-Id: <20210323100111.8365-2-david@redhat.com>
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
Cc: David Hildenbrand <david@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, Simon Horman <horms@verge.net.au>

Traditionally, we had "System RAM" only on the top level of in the
kernel resource tree (-> /proc/iomem). Nowadays, we can also have
"System RAM" on lower levels of the tree -- driver-managed device memory
that is always detected and added via drivers. Current examples are
memory added via dax/kmem -- ("System RAM (kmem)") and virtio-mem ("System
RAM (virtio_mem)"). Note that in some kernel versions "System RAM
(kmem)" was exposed as "System RAM", but similarly, on lower levels of
the resource tree.

Let's add anything that contains "System RAM" to the elf core header, so
it will be dumped for kexec_load(). Handling kexec_file_load() in the
kernel is similarly getting fixed [1].

Loading a kdump kernel via "kexec -p -c" ... will result in the kdump
kernel to also dump dax/kmem and virtio-mem added System RAM now.

Note: We only want to dump this memory, we don't want to add this memory to
the memmap of an ordinary kexec'ed kernel ("fast system reboot").

[1] https://lkml.kernel.org/r/20210322160200.19633-1-david@redhat.com

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index d5b5b68..a301ac8 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -271,8 +271,14 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		str = line + consumed;
 		dbgprintf("%016llx-%016llx : %s",
 			start, end, str);
-		/* Only Dumping memory of type System RAM. */
-		if (memcmp(str, "System RAM\n", 11) == 0) {
+		/*
+		 * We want to dump any System RAM -- memory regions currently
+		 * used by the kernel. In the usual case, this is "System RAM"
+		 * on the top level. However, we can also have "System RAM
+		 * (virtio_mem)" below virtio devices or "System RAM (kmem)"
+		 * below "Persistent Memory".
+		 */
+		if (strstr(str, "System RAM")) {
 			type = RANGE_RAM;
 		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
 			/*
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
