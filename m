Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBj5V-0006S6-BY
 for kexec@lists.infradead.org; Mon, 15 Feb 2021 18:59:14 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id c25so3596436qvb.4
 for <kexec@lists.infradead.org>; Mon, 15 Feb 2021 10:59:12 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 1/1] kexec: move machine_kexec_post_load() to public interface
Date: Mon, 15 Feb 2021 13:59:08 -0500
Message-Id: <20210215185908.257724-2-pasha.tatashin@soleen.com>
In-Reply-To: <20210215185908.257724-1-pasha.tatashin@soleen.com>
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com, will@kernel.org, james.morse@arm.com, ebiederm@xmission.com, kexec@lists.infradead.org

machine_kexec_post_load() is called after kexec load is finished. It must
be declared in public header not in kexec_internal.h

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec.h   | 2 ++
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..3671b845cf28 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -309,6 +309,8 @@ extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
+int machine_kexec_post_load(struct kimage *image);
+
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 39d30ccf8d87..48aaf2ac0d0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,8 +13,6 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
-int machine_kexec_post_load(struct kimage *image);
-
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
