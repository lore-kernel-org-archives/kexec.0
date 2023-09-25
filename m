Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C10CE79A1
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TFPIB93w9Eblm+hHDkEb6KpQuk8DrEJPwLIOlyxLIzI=; b=WDKrPNAEe7xvqc
	UoNbB9iXDkIkjaFwmiTwE4TX0AVesk8NmWsxdEMVKySIdmcUEIaU+lQnX0dKQHDaVB5MNXfcF6gyN
	9qLpCLabRYorizLaHymAgrdVNPeZXVumpNBFr9sQPCkA+zx4hOktXuwG5LtL0Nzw0QjVRLwSsJPEn
	fDX/XbUNmXANebHAdIaiTstP4VruRhNs2dqPw78wx4MhybXzRx191HokDDgqDwSUIN9H8PP77ucoO
	HyLPbCHRE01rWN+6PkZH6+VURGVxb+ZHGjmZ4T+OnGgSL9YqJMRiJQY3srnefv4VGm6J6B0U3KgIQ
	2HPgc8yWErjO3CqFGQhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7W-00F3HB-1e;
	Mon, 25 Sep 2023 21:27:58 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7U-00F3GW-2O
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:27:58 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56A83212C81D;
	Mon, 25 Sep 2023 14:27:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56A83212C81D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677276;
	bh=d9fPt1clGeRPn33BCC4tdwVX7ro+BQvAJ2DtTNtITFk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=M5iue+Y1JZxYmVpZGoFvxEC2uHrLO++xRekrarcyv8eucItPvhyhI0pBWIGDqy/YH
	 zbKtO4aZcaHwng+EkfdrvfZQzrmwoEQ8KVjOKzfbhg765UJp+xnL83VY0D5B7W19SP
	 nZ/hV7gclgrLaT3sBr4WarWvWwETcysRoe+548+I=
Subject: [RFC PATCH v2 2/7] x86: kexec: Transfer existing fdt to the new
 kernel
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:27:54 -0700
Message-ID: <169567727460.19708.8733721379247990958.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142756_833674_6B75EB0D 
X-CRM114-Status: GOOD (  13.68  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

Enable passing of the Flattened Device Tree (fdt) over kexec for x86
architecture, as outlined in Documentation/x86/booting-dt.rst.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 arch/x86/Kconfig                  |    8 +++++
 arch/x86/kernel/kexec-bzimage64.c |   58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14..efb472e267ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2070,6 +2070,14 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config KEXEC_FILE_FDT
+	bool "Pass fdt over kexec"
+	depends on KEXEC_FILE && X86_64
+	depends on OF_FLATTREE
+	help
+	  This option enables passing existent Flattened Device Tree to the new
+	  kernel when kexec is invoked by the file based system call.
+
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..ab9ae02c9a5f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -18,6 +18,8 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -381,7 +383,59 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 
 	return ret;
 }
+#ifdef CONFIG_KEXEC_FILE_FDT
+static void *fdt_get_runtime(void)
+{
+	return initial_boot_params;
+}
+
+static int kexec_setup_fdt(struct kexec_buf *kbuf, struct boot_params *params)
+{
+	void *fdt;
+	struct setup_data *sd;
+	unsigned long fdt_load_addr, fdt_sz;
+	int ret;
+
+	fdt = fdt_get_runtime();
+	if (!fdt)
+		return 0;
+
+	fdt_sz = fdt_totalsize(fdt);
+
+	kbuf->bufsz = kbuf->memsz = sizeof(struct setup_data) + fdt_sz;
+
+	sd = kzalloc(kbuf->bufsz, GFP_KERNEL);
+	if (!sd)
+		return -ENOMEM;
+
+	kbuf->buffer = sd;
+	kbuf->buf_align = PAGE_SIZE;
+	kbuf->buf_min = MIN_INITRD_LOAD_ADDR;
+	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		return ret;
+
+	fdt_load_addr = kbuf->mem;
 
+	pr_debug("Loaded fdt at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		fdt_load_addr, fdt_sz, fdt_sz);
+
+	sd->type = SETUP_DTB;
+	sd->len = fdt_sz;
+	memcpy(sd->data, fdt, fdt_sz);
+
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = fdt_load_addr;
+
+	return 0;
+}
+#else
+static int kexec_setup_fdt(struct kexec_buf *kbuf, struct boot_params *params)
+{
+	return 0;
+}
+#endif
 static void *bzImage64_load(struct kimage *image, char *kernel,
 			    unsigned long kernel_len, char *initrd,
 			    unsigned long initrd_len, char *cmdline,
@@ -561,6 +615,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	if (ret)
 		goto out_free_params;
 
+	ret = kexec_setup_fdt(&kbuf, params);
+	if (ret)
+		goto out_free_params;
+
 	/* Allocate loader specific data */
 	ldata = kzalloc(sizeof(struct bzimage64_data), GFP_KERNEL);
 	if (!ldata) {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
