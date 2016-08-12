Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x243.google.com ([2607:f8b0:400e:c03::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bYDRG-0006xE-FQ
 for kexec@lists.infradead.org; Fri, 12 Aug 2016 14:27:59 +0000
Received: by mail-pa0-x243.google.com with SMTP id cf3so1563675pad.2
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 07:27:38 -0700 (PDT)
From: Ronit Halder <ronit.crj@gmail.com>
Subject: [RFC 4/4] Enable memory allocation through sysfs interface
Date: Fri, 12 Aug 2016 19:56:52 +0530
Message-Id: <20160812142652.6299-1-ronit.crj@gmail.com>
In-Reply-To: <20160812141838.5973-1-ronit.crj@gmail.com>
References: <20160812141838.5973-1-ronit.crj@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: vdavydov@parallels.com, jack@suse.cz, linux-mm@kvack.org, krzysiek@podlesie.net, mnfhuang@gmail.com, hpa@zytor.com, Ronit Halder <ronit.crj@gmail.com>, tglx@linutronix.de, aarcange@redhat.com, bhe@redhat.com, mingo@redhat.com, msalter@redhat.com, bp@suse.de, dyoung@redhat.com, vgoyal@redhat.com, jroedel@suse.de, mchehab@osg.samsung.com, dan.j.williams@intel.com, kexec@lists.infradead.org, ebiederm@xmission.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com

Modify the sysfs entry "kernel/kexec_crash_size" to allocate or
release memory at run time. The memory size will be written to
the entry in MB. If the user uses high memory (in x86_64). Then
size will be only set for high memory. The low memory will be
allocated automatically. If the size set is zero, the both the
allocated region in low and high memory will be released.

Signed-off-by: Ronit Halder <ronit.crj@gmail.com>

---
 kernel/ksysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index e83b264..4cc286d 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -116,10 +116,31 @@ static ssize_t kexec_crash_size_store(struct kobject *kobj,
 {
 	unsigned long cnt;
 	int ret;
+	int size;
 
 	if (kstrtoul(buf, 0, &cnt))
 		return -EINVAL;
-
+#ifdef CONFIG_KEXEC_CMA
+#ifdef CONFIG_X86
+	size = cnt << 20;
+	if (cnt == 0) {
+		crash_free_memory_low();
+		ret = crash_free_memory(crash_get_memory_size());
+	} else if (cnt > 0) {
+		if (!crash_get_memory_size_low() && crash_alloc_memory_low())
+			return -ENOMEM;
+		ret = crash_free_memory(crash_get_memory_size());
+		if (ret)
+			return ret;
+		ret = crash_alloc_memory(size);
+		if (ret)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+	return count;
+#endif
+#endif
 	ret = crash_shrink_memory(cnt);
 	return ret < 0 ? ret : count;
 }
-- 
2.9.0.GIT


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
