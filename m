Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnlYn-008UQs-NN
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 17:50:59 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 8/8] crash hp: Add x86 crash hotplug support for bzImage
Date: Thu, 18 Nov 2021 12:49:48 -0500
Message-Id: <20211118174948.37435-9-eric.devolder@oracle.com>
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, eric.devolder@oracle.com

The few changes to kexec-bzimage64.c are to record information needed
in advance of when a hotplug event occurs. This information is recorded
when the crash/capture kernel is loaded.

In particular, the index of the purgatory segment, and the handful of
register context values needed by purgatory, are recorded.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..1886c215215d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -378,6 +378,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
 	 * anywhere.
 	 */
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Record the index of the purgatory segment */
+	image->arch.hp.purg_index = image->nr_segments;
+#endif
 	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
 		pr_err("Loading purgatory failed\n");
@@ -488,6 +492,14 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	if (ret)
 		goto out_free_params;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Save for use on hotplug to patch up purgatory context */
+	image->arch.hp.rbx = regs64.rbx;
+	image->arch.hp.rsi = regs64.rsi;
+	image->arch.hp.rip = regs64.rip;
+	image->arch.hp.rsp = regs64.rsp;
+#endif
+
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
 				    efi_map_offset, efi_map_sz,
 				    efi_setup_data_offset);
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
