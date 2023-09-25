Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E668CE79A5
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bKk1TzG1gqd+9pXYnr/zcYk4tPysMYqv33LXwwm8Bg8=; b=BkLbeRXxI4CY54
	jZY08BN73NO0KRwEYlc23xdId5L+b/VNFukLi5X6YNz7HGToAY2Meg2H+wlVETZnTM84wpAc57CX3
	Eb01yrOS9POaqawuEyxt+44o3FjEAdIo4F5sCY0x+qQSF78HU8a+6ykKziBb4fGJwglK114l7IvUT
	yHMxH0SCd53OtuXj/OsVP3iqFRQ/rMjrPaExfpllX5rkO4GD80Zc5TzmjMlb0KK2KVXaimPF4DGdf
	+UXxRUMoMoa6JAooVENlzqLOZyyJnVJo5GF4eAH8Xu+sqyK9BIhUZDE59y88Fep+rhKJtPmFVwl5N
	jbHLFW3+8SvZPZ6nwY0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7f-00F3Lm-1c;
	Mon, 25 Sep 2023 21:28:07 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7c-00F3Je-1Y
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:28:05 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id E58C1212C81A;
	Mon, 25 Sep 2023 14:28:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E58C1212C81A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677284;
	bh=31r3+teMkDng2tqbYlVeWHQusQtnTuIKy4PPrzro3Jo=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GrGaL61WsFhTEwyMze7wRAYu6XpBN7Eh3oADDGL4oljCNrUIkvM4FgsVD8V8iUtOV
	 YtlrPBBjhSckZbP/BHI0u+BGjamKBFeqtF+BmWa+94cAE8NDGEZzwBZz8Tme9rqA84
	 cgz63bBFHx6XTdanh8G50ZkYGy2lH5GGPlGy3urg=
Subject: [RFC PATCH v2 3/7] x86: kexec: Enable fdt modification in callbacks
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:28:01 -0700
Message-ID: <169567728132.19708.15145818489125262286.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142804_590990_41AFFEB8 
X-CRM114-Status: GOOD (  14.26  )
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

This option allows kernel subsystems to modify (or create, if necessary)
the Flattened Device Tree (fdt) using registered callbacks and then pass
the modified version to the new kernel.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 arch/x86/Kconfig                  |    8 +++++++
 arch/x86/kernel/kexec-bzimage64.c |   41 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index efb472e267ec..90da51fbb8f8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2078,6 +2078,14 @@ config KEXEC_FILE_FDT
 	  This option enables passing existent Flattened Device Tree to the new
 	  kernel when kexec is invoked by the file based system call.
 
+config KEXEC_FILE_FDT_CALLBACK
+	bool "Enable kexec fdt modification support"
+	depends on KEXEC_FILE_FDT
+	select LIBFDT
+	help
+	  This option enables Flattened Device Tree modification (and creation
+	  if needed) by kernel subsystems, registered corresponding callback.
+
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index ab9ae02c9a5f..3c6df28d3637 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -384,11 +384,50 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 	return ret;
 }
 #ifdef CONFIG_KEXEC_FILE_FDT
+#ifdef CONFIG_KEXEC_FILE_FDT_CALLBACK
+static void *fdt_get_runtime(void)
+{
+	void *fdt;
+	size_t fdt_size = SZ_2M;
+	int status;
+
+	/* It's nothing to do without existent fdt and any callbacks */
+	if (!initial_boot_params && kexec_fdt_notify_list_empty())
+		return NULL;
+
+	fdt = kzalloc(fdt_size, GFP_KERNEL);
+	if (!fdt)
+		return NULL;
+
+	if (initial_boot_params)
+		status = fdt_open_into(initial_boot_params, fdt, fdt_size);
+	else
+		status = fdt_create_empty_tree(fdt, fdt_size);
+	if (status != 0) {
+		pr_err("failed to get fdt\n");
+		goto free_fdt;
+	}
+
+	status = kexec_fdt_notify(fdt);
+	if (status) {
+		pr_err("fdt notification failed\n");
+		goto free_fdt;
+	}
+
+	fdt_pack(fdt);
+
+	return fdt;
+
+free_fdt:
+	kfree(fdt);
+	return NULL;
+}
+#else
 static void *fdt_get_runtime(void)
 {
 	return initial_boot_params;
 }
-
+#endif
 static int kexec_setup_fdt(struct kexec_buf *kbuf, struct boot_params *params)
 {
 	void *fdt;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
