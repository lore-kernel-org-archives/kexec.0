Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zBm-00081t-OD
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:43 +0000
Received: by mail-vw0-f49.google.com with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:42 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 1/5] Introduce second memory resource for crash kernel
Date: Thu, 22 Apr 2010 18:23:08 +0200
Message-Id: <1271953392-6324-2-git-send-email-v.mayatskih@gmail.com>
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Currently crash kernel uses only one memory region (described by
struct resource). When this region gets enough large, there may appear
a problem to reside this region in a valid addresses range.

This patch introduces second memory region, which may be also used by
crash kernel. First region may be enough small to place only kernel
and initrd images at low addresses, and second region may be placed
almost anywhere.

Second memory resource has another name with aim not to confuse
existing userspace utilities, like kexec.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 include/linux/kexec.h |    1 +
 kernel/kexec.c        |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 03e8e8d..1a3b0a3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -198,6 +198,7 @@ extern struct kimage *kexec_crash_image;
 /* Location of a reserved region to hold the crash kernel.
  */
 extern struct resource crashk_res;
+extern struct resource crashk_res_hi;
 typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
 extern note_buf_t __percpu *crash_notes;
 extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 87ebe8a..1bd0199 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -49,7 +49,7 @@ u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 size_t vmcoreinfo_size;
 size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 
-/* Location of the reserved area for the crash kernel */
+/* Location of the reserved area for the crash kernel in low memory */
 struct resource crashk_res = {
 	.name  = "Crash kernel",
 	.start = 0,
@@ -57,6 +57,14 @@ struct resource crashk_res = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
+/* Location of the reserved area for the crash kernel in high memory */
+struct resource crashk_res_hi = {
+	.name  = "Crash high memory",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
 int kexec_should_crash(struct task_struct *p)
 {
 	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
@@ -1092,6 +1100,7 @@ size_t crash_get_memory_size(void)
 	size_t size;
 	mutex_lock(&kexec_mutex);
 	size = crashk_res.end - crashk_res.start + 1;
+	size += crashk_res_hi.end - crashk_res_hi.start + 1;
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
