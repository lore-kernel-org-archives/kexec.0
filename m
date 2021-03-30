Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsx-004vXy-32
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:55 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 16/43] kexec: PKRAM: prevent kexec clobbering preserved pages
 in some cases
Date: Tue, 30 Mar 2021 14:35:51 -0700
Message-Id: <1617140178-8773-17-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

When loading a kernel for kexec, dynamically update the list of physical
ranges that are not to be used for storing preserved pages with the ranges
where kexec segments will be copied to on reboot. This ensures no pages
preserved after the new kernel has been loaded will reside in these ranges
on reboot.

Not yet handled is the case where pages have been preserved before a
kexec kernel is loaded.  This will be covered by a later patch.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec.c      |  9 +++++++++
 kernel/kexec_file.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c82c6c06f051..826c8fb824d8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/pkram.h>
 
 #include "kexec_internal.h"
 
@@ -163,6 +164,14 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	for (i = 0; i < nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 5c3447cf7ad5..1ec47a3c60dd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,8 @@
 #include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
+#include <linux/pkram.h>
+
 #include "kexec_internal.h"
 
 static int kexec_calculate_store_digests(struct kimage *image);
@@ -429,6 +431,14 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	if (ret)
 		goto out;
 
+	for (i = 0; i < image->nr_segments; i++) {
+		unsigned long mem = image->segment[i].mem;
+		size_t memsz = image->segment[i].memsz;
+
+		if (memsz)
+			pkram_ban_region(PFN_DOWN(mem), PFN_UP(mem + memsz) - 1);
+	}
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
