Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXz62-0006wC-Bu
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 23:09:13 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN8fNb038826
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:49 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24rqx1wp5f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:48 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:08:47 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 0F29C3520068
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:08:25 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BN8jjk23593358
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:08:45 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BN8iG2027366
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:08:45 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 09/13] powerpc: Add code to work with device trees in
 kexec_file_load.
Date: Thu, 11 Aug 2016 20:08:14 -0300
In-Reply-To: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1470956898-5991-10-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

kexec_file_load needs to set up the device tree that will be used
by the next kernel and check whether it provides a console
that can be used by the purgatory.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h       |   3 +
 arch/powerpc/kernel/machine_kexec_64.c | 222 +++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 83b81b7bdca1..f263cc867891 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -96,6 +96,9 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr, unsigned long stack_top,
 		    int debug);
+int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
+		  unsigned long initrd_len, const char *cmdline);
+bool find_debug_console(const void *fdt, int chosen_node);
 #endif /* CONFIG_KEXEC_FILE */
 
 #else /* !CONFIG_KEXEC */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1e678dc5096a..897b724ea9fd 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -683,4 +683,226 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
+/*
+ * setup_new_fdt() - modify /chosen and memory reservation for the next kernel
+ * @fdt:
+ * @initrd_load_addr:	Address where the next initrd will be loaded.
+ * @initrd_len:		Size of the next initrd, or 0 if there will be none.
+ * @cmdline:		Command line for the next kernel, or NULL if there will
+ * 			be none.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
+		  unsigned long initrd_len, const char *cmdline)
+{
+	uint64_t oldfdt_addr;
+	int i, ret, chosen_node;
+	const void *prop;
+
+	/* Remove memory reservation for the current device tree. */
+	oldfdt_addr = __pa(initial_boot_params);
+	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == oldfdt_addr &&
+		    rsv_size == fdt_totalsize(initial_boot_params)) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting fdt reservation.\n");
+				return -EINVAL;
+			}
+
+			pr_debug("Removed old device tree reservation.\n");
+			break;
+		}
+	}
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node == -FDT_ERR_NOTFOUND) {
+		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
+					      "chosen");
+		if (chosen_node < 0) {
+			pr_err("Error creating /chosen.\n");
+			return -EINVAL;
+		}
+	} else if (chosen_node < 0) {
+		pr_err("Malformed device tree: error reading /chosen.\n");
+		return -EINVAL;
+	}
+
+	/* Did we boot using an initrd? */
+	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	if (prop) {
+		uint64_t tmp_start, tmp_end, tmp_size, tmp_sizepg;
+
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		if (!prop) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		/*
+		 * kexec reserves exact initrd size, while firmware may
+		 * reserve a multiple of PAGE_SIZE, so check for both.
+		 */
+		tmp_size = tmp_end - tmp_start;
+		tmp_sizepg = round_up(tmp_size, PAGE_SIZE);
+
+		/* Remove memory reservation for the current initrd. */
+		for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+			uint64_t rsv_start, rsv_size;
+
+			ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+			if (ret) {
+				pr_err("Malformed device tree.\n");
+				return -EINVAL;
+			}
+
+			if (rsv_start == tmp_start &&
+			    (rsv_size == tmp_size || rsv_size == tmp_sizepg)) {
+				ret = fdt_del_mem_rsv(fdt, i);
+				if (ret) {
+					pr_err("Error deleting fdt reservation.\n");
+					return -EINVAL;
+				}
+				pr_debug("Removed old initrd reservation.\n");
+
+				/* fdt was modified, offsets may have changed. */
+				chosen_node = fdt_path_offset(fdt, "/chosen");
+				if (chosen_node < 0) {
+					pr_err("Malformed device tree.\n");
+					return -EINVAL;
+				}
+
+				break;
+			}
+		}
+
+		/* If there's no new initrd, delete the old initrd's info. */
+		if (initrd_len == 0) {
+			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-start");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-start.\n");
+				return -EINVAL;
+			}
+
+			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-end.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (initrd_len) {
+		ret = fdt_setprop_u64(fdt, chosen_node,
+				      "linux,initrd-start",
+				      initrd_load_addr);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		/* initrd-end is the first address after the initrd image. */
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
+				      initrd_load_addr + initrd_len);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
+		if (ret) {
+			pr_err("Error reserving initrd memory: %s\n",
+			       fdt_strerror(ret));
+			return -EINVAL;
+		}
+	}
+
+	if (cmdline != NULL) {
+		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+	} else {
+		ret = fdt_delprop(fdt, chosen_node, "bootargs");
+		if (ret && ret != -FDT_ERR_NOTFOUND) {
+			pr_err("Error deleting bootargs.\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+	if (ret) {
+		pr_err("Error setting up the new device tree.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * find_debug_console() - find out whether there is a console for the purgatory
+ * @fdt:		Flattened device tree to search.
+ * @chosen_node:	Offset of /chosen in @fdt.
+ */
+bool find_debug_console(const void *fdt, int chosen_node)
+{
+	int len;
+	int console_node;
+	const void *prop, *colon;
+
+	prop = fdt_getprop(fdt, chosen_node, "stdout-path", &len);
+	if (prop == NULL) {
+		if (len == -FDT_ERR_NOTFOUND) {
+			prop = fdt_getprop(fdt, chosen_node, "linux,stdout-path",
+					   &len);
+			if (prop == NULL) {
+				pr_debug("Unable to find [linux,]stdout-path.\n");
+				return false;
+			}
+		} else {
+			pr_debug("Error finding console: %s\n",
+				 fdt_strerror(len));
+			return false;
+		}
+	}
+
+	/*
+	 * stdout-path can have a ':' separating the path from device-specific
+	 * information, so we should only consider what's before it.
+	 */
+	colon = strchr(prop, ':');
+	if (colon != NULL)
+		len = colon - prop;
+	else
+		len -= 1;	/* Ignore the terminating NUL. */
+
+	console_node = fdt_path_offset_namelen(fdt, prop, len);
+	if (console_node < 0) {
+		pr_debug("Error finding console: %s\n",
+			 fdt_strerror(console_node));
+		return false;
+	}
+
+	if (fdt_node_check_compatible(fdt, console_node, "hvterm1") == 0)
+		return true;
+	else if (fdt_node_check_compatible(fdt, console_node,
+					   "hvterm-protocol") == 0)
+		return true;
+
+	return false;
+}
+
 #endif /* CONFIG_KEXEC_FILE */
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
