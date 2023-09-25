Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2E0CE79A1
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iUOreVv80i075J75n2mdaJFQ9919GdpcKh29q55taoM=; b=2aUbJucWSADAjj
	O5N3Wp4oIKM1nJlQifVO6XGrpAa0f9/HM1QkkcFMtJanGiMf/lgtisbA9gMrS5x7cyTcGApJwd7b1
	pymwBvmYHA6jrbZ6su82TwuuXIFTFq2gdXBkeRz70YWo5jEKdFhznu81Zu2eVs17ZnzitMiZe3QUn
	ke1x5nle7hbiCHqlTEmVfaZwGcAdhGnFAA3/xFzDx84/YBfKvZ1F9SLzICW88d8Z1ZrMQP8vbkSED
	Eu74MMS0/RpG6c2OxCAySR2Vi5R43jTX0zoVmyP94Taeqx3uRl3pqAgo796IcXfK95lfSLfrYgAKy
	Kr4aXvVVb8fykG4XKLPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7Q-00F3Ec-2m;
	Mon, 25 Sep 2023 21:27:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7O-00F3Ds-0W
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:27:51 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2FB66212C81C;
	Mon, 25 Sep 2023 14:27:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FB66212C81C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677269;
	bh=qnZ5Xu4spnd++5roGWKZwrvGaezBYrs5S2IO+MMawnE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ij9r5NNdZTlutCpHM2H2+lh5bP0m8uJe/cvx090MoIIrC+5VpAugr4jsfJRiODw4i
	 7u5DsbyEiy95Pd40PgtvddqZ4ekhQHgcKxe0hY6A3ws8wHWUG6bSepooE3AxAkwafD
	 gHNL+oOT88IPNEs0HH5n/h0TUJ9hrwy/e5M173N4=
Subject: [RFC PATCH v2 1/7] kexec_file: Add fdt modification callback support
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:27:47 -0700
Message-ID: <169567726766.19708.8904010689974887517.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142750_220650_AA848D9D 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

Introduce primitives to:
- Register and unregister callbacks for flattened device tree (fdt)
  modifications.
- Invoke all registered callbacks.
- Check for any registered callbacks.

These enhancements enable the use of a device tree to store kernel bits.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/linux/kexec.h |    7 +++++++
 kernel/kexec_file.c   |   24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..c9c70551796d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -282,6 +282,13 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 	return -ENOEXEC;
 }
 #endif
+
+struct notifier_block;
+extern int register_kexec_fdt_notifier(struct notifier_block *nb);
+extern int unregister_kexec_fdt_notifier(struct notifier_block *nb);
+extern bool kexec_fdt_notify_list_empty(void);
+extern int kexec_fdt_notify(void *fdt);
+
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..f9245d5e4459 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -43,6 +43,30 @@ static int kexec_calculate_store_digests(struct kimage *image);
 /* Maximum size in bytes for kernel/initrd files. */
 #define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
 
+static BLOCKING_NOTIFIER_HEAD(kexec_fdt_notify_list);
+
+bool kexec_fdt_notify_list_empty(void)
+{
+	return kexec_fdt_notify_list.head == NULL;
+}
+
+int kexec_fdt_notify(void *fdt)
+{
+	return blocking_notifier_call_chain(&kexec_fdt_notify_list, 0, fdt);
+}
+
+int register_kexec_fdt_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kexec_fdt_notify_list, nb);
+}
+EXPORT_SYMBOL(register_kexec_fdt_notifier);
+
+int unregister_kexec_fdt_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kexec_fdt_notify_list, nb);
+}
+EXPORT_SYMBOL(unregister_kexec_fdt_notifier);
+
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
