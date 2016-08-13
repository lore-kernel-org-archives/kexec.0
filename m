Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bYPTi-00068J-R6
 for kexec@lists.infradead.org; Sat, 13 Aug 2016 03:19:19 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7D3IwQT025446
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 23:18:58 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rtx5bcey-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 23:18:58 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Sat, 13 Aug 2016 00:18:56 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C2DAB352006C
 for <kexec@lists.infradead.org>; Fri, 12 Aug 2016 23:18:33 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7D3IseF26935756
 for <kexec@lists.infradead.org>; Sat, 13 Aug 2016 00:18:54 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7D3IraY013834
 for <kexec@lists.infradead.org>; Sat, 13 Aug 2016 00:18:54 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 1/6] kexec_file: Add buffer hand-over support for the next
 kernel
Date: Sat, 13 Aug 2016 00:18:20 -0300
In-Reply-To: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1471058305-30198-2-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net, Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>, Eric Richter <erichte@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org

The buffer hand-over mechanism allows the currently running kernel to pass
data to kernel that will be kexec'd via a kexec segment. The second kernel
can check whether the previous kernel sent data and retrieve it.

This is the architecture-independent part of the feature.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 29 ++++++++++++++++++++++
 kernel/kexec_file.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ceccc5856aab..4559a1a01b0a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -388,6 +388,35 @@ static inline void *boot_phys_to_virt(unsigned long entry)
 	return phys_to_virt(boot_phys_to_phys(entry));
 }
 
+#ifdef CONFIG_KEXEC_FILE
+bool __weak kexec_can_hand_over_buffer(void);
+int __weak arch_kexec_add_handover_buffer(struct kimage *image,
+					  unsigned long load_addr,
+					  unsigned long size);
+int kexec_add_handover_buffer(struct kexec_buf *kbuf);
+int __weak kexec_get_handover_buffer(void **addr, unsigned long *size);
+int __weak kexec_free_handover_buffer(void);
+#else
+static inline bool kexec_can_hand_over_buffer(void)
+{
+	return false;
+}
+
+static inline int kexec_add_handover_buffer(struct kexec_buf *kbuf)
+{
+	return -ENOTSUPP;
+}
+
+static inline int kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	return -ENOTSUPP;
+}
+
+static inline int kexec_free_handover_buffer(void)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_KEXEC_FILE */
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 772cb491715e..c8418d62e2fc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -135,6 +135,74 @@ int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
 	return -EINVAL;
 }
 
+/**
+ * kexec_can_hand_over_buffer - can we pass data to the kexec'd kernel?
+ */
+bool __weak kexec_can_hand_over_buffer(void)
+{
+	return false;
+}
+
+/**
+ * arch_kexec_add_handover_buffer - do arch-specific steps to handover buffer
+ *
+ * Architectures should use this function to pass on the handover buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_kexec_add_handover_buffer(struct kimage *image,
+					  unsigned long load_addr,
+					  unsigned long size)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * kexec_add_handover_buffer - add buffer to be used by the next kernel
+ * @kbuf:	Buffer contents and memory parameters.
+ *
+ * This function assumes that kexec_mutex is held.
+ * On successful return, @kbuf->mem will have the physical address of
+ * the buffer in the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_add_handover_buffer(struct kexec_buf *kbuf)
+{
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return -ENOTSUPP;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		return ret;
+
+	return arch_kexec_add_handover_buffer(kbuf->image, kbuf->mem,
+					      kbuf->memsz);
+}
+
+/**
+ * kexec_get_handover_buffer - get the handover buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	return -ENOTSUPP;
+}
+
+/**
+ * kexec_free_handover_buffer - free memory used by the handover buffer
+ */
+int __weak kexec_free_handover_buffer(void)
+{
+	return -ENOTSUPP;
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
