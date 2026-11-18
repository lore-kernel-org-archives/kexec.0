Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C908606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MqREJB06;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=h6BgGpfD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=R4uwpzc2SXxT7GyHeLuy79qw30desez58Shax9ewH5U=; b=MqREJB06donpwPS6s4/EHv3rbS
	x6463nVKN5fioceQ3TQDpjAOkYb6yxUlcwhKiXOl83GqPdaO1RhlaJqbvb+29QxnKEvnNcKMS2nsh
	GBAttj1fXCUpMJzK0g+BRI4zy0OnLJU/Tt/s/DsmDeoGtaKZwYpHQFoepGq07M72/kCGwhM03/3lQ
	IdmSOyBI8LwGeh8n7tC5wfm2cUMKF19qps1LqXewZMxgtWvwVJtq5g16buksbDeqvTxVuIbGGxrxR
	Y8hMOvQeJXOZW2EY0e2ZrDIZ55nYiocvysB9bMjsoXSVn6tX4dfc3f2PfGWekDUeYqxqaNvy2Ty6p
	lhhxSXcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYpz-00000007pwd-3Fzo;
	Wed, 18 Nov 2026 06:08:07 +0000
Received: from mail-ua1-x962.google.com ([2607:f8b0:4864:20::962])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYps-00000007puD-0FyC
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:08:06 +0000
Received: by mail-ua1-x962.google.com with SMTP id a1e0cc1a2514c-98301b325c4so197155241.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982079; x=1795586879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4uwpzc2SXxT7GyHeLuy79qw30desez58Shax9ewH5U=;
        b=wQCq090ApM/1nQD5T+awRl0OLOLzg5j/8Fea66l2FeKA5wWVrZ02+4nReI+Z0MIUUF
         OFdAPQUJh7WJjlfDJBVF3Xc+6+E0Sa9sqjeJlpgXBDhXzzZs3aQpuBg2MUYvOD7bOzkA
         cOLvhGz8mgxM1AQSZEuej42dQ9ZxJDmjzLTCSViZ1KOzgelA8qWmXzDdfxfKZ0RXv1ty
         rAN2RMuRASwey9IQr1eqfflWaiF3HyYCH2Ymx2LFdU7LYxDEabLERCNvb84kQaQXGCml
         jqr427MquUtwwrUoBLUU7l1cmP1WweEEINPg7J19uj67vrwll02kelaEl8PXJfLCWzT1
         ImqA==
X-Forwarded-Encrypted: i=1; AL+hErHgSYDsLlmUMjn10wDfV6UiLu3Dc2iHG9jD+Mc42mWsKg25I1OhxdECfeRLgfqtNrKtBBu8zA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/tjKLB6qZDeG3dFPfqwc5Pwi6G3xy4V31ZPyJEDt8R+uJGbcfU
	pJehp9GOKGyGYh6GLSCEVirmivlE0i33+am49UTD0bWtz7U/DsvvY90zSmjwtlma/CvnVaIHn+p
	DA/Na0tzCcVbgqMN/Uj3JXRf/HHOLs68AIwvm/Q6eTn8np88GqSYMemyzWtjjqHtw1k7+MkkFfG
	YM8ZVZQi+ZvAEFNaYC/AWA76mik1lSC4asUAuPxa0BLL3sZe/r1NpB5JkdQvc5SprS7wq8NGvK6
	IgJA/gZm/hB
X-Gm-Gg: AYBFou18TfHbuIFKx7gv01oHRMjEHjwO3BGwJev+QwRR5PgrJsym2Iy30fdBtmySrZp
	g5U7Wgijsms8OuE4dQ8+zG6TsHLGpN02LNOu+FG+N7CF7eVcQfC3vfneYnPk1xdVcdhalN9lgX+
	qrz0+I8EbOVUZHMkQLxBPH0SsNZ7R8Bax7HJ+BW6jsUQHPIKE6zOQST3uk7aAZWBkSGpOrSbUcr
	8SInQ7Nb42uwZOfSILhxGERd5EqedV21Qd6Lm+vBGxhLlbuYB8YGyHypnJgLNpxw/NkglemsBW2
	583kp7QGXSnSgHEJ3tc/+86Dh/PUjVnZ6gx8U9eOH2w14tDCsx9GZEUGzIM2I2LBToSuJ3p/kEY
	1UPoNkj3ZWQ43RrUS3PnI9UzDCzN6jK95OoXespPJQUUZKgW7me4OmPDk3mbjVZTWqKBIDfLW7C
	cMeX0t+0GeiWYZWx76A/7w2gsO7sptipgpmis=
X-Received: by 2002:a05:6102:e0c:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d6ba35b7d8mr410944137.13.1794982078317;
        Tue, 17 Nov 2026 22:07:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99e4a52634esm168445241.7.2026.11.17.22.07.57
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:07:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9210bbc04abso10546696d6.2
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794982077; x=1795586877; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R4uwpzc2SXxT7GyHeLuy79qw30desez58Shax9ewH5U=;
        b=h6BgGpfDzSAMxVjTvCQl9hsrnwkYPYnbYgI+LNm45MmDfR++QPpL4NXYnwczoNzjDH
         9Ao5IYGzXas+Xs9OiM3ALntmo9kLvudP73aWmpUYqOw4GFGb7xTuKJrhSzKyyT9SJclb
         rvu62GFgRJvm1h/EwLAs5stbqzLPmsXyon7sM=
X-Forwarded-Encrypted: i=1; AL+hErHVKW/j9lWHIxc0SD5c2lWuqRcnqTGMYChmfDhxo4bTaMr0vXv3awAxNXzx23RBaFy0CMFucg==@lists.infradead.org
X-Received: by 2002:a05:622a:4ccd:b0:536:6ff4:6528 with SMTP id d75a77b69052e-55d5a543d65mr25648321cf.23.1794981724877;
        Tue, 17 Nov 2026 22:02:04 -0800 (PST)
X-Received: by 2002:a05:622a:4ccd:b0:536:6ff4:6528 with SMTP id d75a77b69052e-55d5a543d65mr25647841cf.23.1794981724238;
        Tue, 17 Nov 2026 22:02:04 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:01:59 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v4 2/4] x86/vmware: Add a bounded panic log sender
Date: Wed, 18 Nov 2026 01:01:49 -0500
Message-ID: <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_220800_124094_0C0C1240 
X-CRM114-Status: GOOD (  22.65  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VMware guest may be unable to save its own logs after a crash. Copy
the newest kernel log records to the host's vmware.log before kdump,
so they remain available if the capture kernel fails.

Register the sender on the platform panic notifier list and send the
log through the low-bandwidth register interface. Allocate a fixed
8 KiB buffer during early init; 4 KiB can lose useful stack-trace
context. The callback allocates no memory and emits no printk
messages. Limit the transfer to the buffer size and make at most three
attempts, retrying only if a VM checkpoint interrupts the transfer.

Enable logging by default only in guests without memory encryption;
encrypted guests should send their log to the host only when an
administrator opts in. The copy is best-effort diagnostics; kdump does
not depend on it succeeding.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v4: No change.

v3: Register on the platform list instead of the pre-kdump list. The
VMware code is otherwise unchanged from v2.

 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 173 ++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index fb011cef01e7..dc3cf8123914 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -57,6 +57,7 @@
 #define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
 
 #define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_MESSAGE		30
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f7ab9e7902cf..0c6f7248a665 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -24,11 +24,16 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmsg_dump.h>
+#include <linux/mm.h>
+#include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/reboot.h>
+#include <linux/sizes.h>
 #include <linux/static_call.h>
+#include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
@@ -52,6 +57,23 @@
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
 
+#define VMWARE_MSG_STATUS_SUCCESS	BIT(16)
+#define VMWARE_MSG_STATUS_CPT		BIT(20)
+
+#define VMWARE_RPCI_PROTOCOL		0x49435052
+#define VMWARE_GUESTMSG_COOKIE		BIT(31)
+
+#define VMWARE_MSG_TYPE(n)		((n) << 16)
+#define VMWARE_MSG_OPEN			VMWARE_MSG_TYPE(0U)
+#define VMWARE_MSG_SENDSIZE		VMWARE_MSG_TYPE(1U)
+#define VMWARE_MSG_SENDPAYLOAD		VMWARE_MSG_TYPE(2U)
+#define VMWARE_MSG_CLOSE		VMWARE_MSG_TYPE(6U)
+
+#define VMWARE_LOG_BUF_SIZE		SZ_8K
+#define VMWARE_LOG_ATTEMPTS		3
+#define VMWARE_LOG_PREFIX		"log "
+#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)
+
 struct vmware_steal_time {
 	union {
 		u64 clock;	/* stolen time counter in units of vtsc */
@@ -64,6 +86,12 @@ struct vmware_steal_time {
 	u64 reserved[7];
 };
 
+struct vmware_rpc_channel {
+	u16 id;
+	u32 cookie_high;
+	u32 cookie_low;
+};
+
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
@@ -142,6 +170,151 @@ static unsigned long vmware_get_tsc_khz(void)
 	return vmware_tsc_khz;
 }
 
+static int vmware_log_open(struct vmware_rpc_channel *channel)
+{
+	u32 info, id;
+
+	vmware_hypercall6(VMWARE_CMD_MESSAGE | VMWARE_MSG_OPEN,
+			  VMWARE_RPCI_PROTOCOL | VMWARE_GUESTMSG_COOKIE, 0,
+			  &info, &id, &channel->cookie_high,
+			  &channel->cookie_low);
+	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+		return -EIO;
+
+	channel->id = upper_16_bits(id);
+	return 0;
+}
+
+static int vmware_log_close(const struct vmware_rpc_channel *channel)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_CLOSE, 0,
+			  (u32)channel->id << 16, channel->cookie_high,
+			  channel->cookie_low, &info);
+
+	return info & VMWARE_MSG_STATUS_SUCCESS ? 0 : -EIO;
+}
+
+static int vmware_log_send_once(const struct vmware_rpc_channel *channel,
+				const char *buffer, size_t length)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDSIZE, length,
+			  (u32)channel->id << 16, channel->cookie_high,
+			  channel->cookie_low, &info);
+	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+		return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
+
+	while (length) {
+		size_t bytes = min_t(size_t, length, sizeof(u32));
+		u32 word = 0;
+
+		memcpy(&word, buffer, bytes);
+		vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDPAYLOAD,
+				  word, (u32)channel->id << 16,
+				  channel->cookie_high, channel->cookie_low,
+				  &info);
+		if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+			return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
+
+		buffer += bytes;
+		length -= bytes;
+	}
+
+	return 0;
+}
+
+static int vmware_log_send(const struct vmware_rpc_channel *channel,
+			   const char *buffer, size_t length)
+{
+	int attempt, ret;
+
+	for (attempt = 0; attempt < VMWARE_LOG_ATTEMPTS; attempt++) {
+		ret = vmware_log_send_once(channel, buffer, length);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+
+	return -EAGAIN;
+}
+
+static int vmware_log_rpc(const char *buffer, size_t length)
+{
+	struct vmware_rpc_channel channel;
+	int close_ret, ret;
+
+	ret = vmware_log_open(&channel);
+	if (ret)
+		return ret;
+
+	ret = vmware_log_send(&channel, buffer, length);
+	close_ret = vmware_log_close(&channel);
+	if (!ret && close_ret)
+		ret = close_ret;
+
+	return ret;
+}
+
+static struct page *vmware_panic_page;
+static bool vmware_record_panic_msg;
+
+static int vmware_panic_log_notify(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct kmsg_dump_iter iter;
+	char *buffer = page_address(vmware_panic_page);
+	size_t length = 0;
+
+	if (!READ_ONCE(vmware_record_panic_msg))
+		return NOTIFY_DONE;
+
+	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
+	kmsg_dump_rewind(&iter);
+	(void)kmsg_dump_get_buffer(&iter, true,
+				   buffer + VMWARE_LOG_PREFIX_LEN,
+				   VMWARE_LOG_BUF_SIZE - VMWARE_LOG_PREFIX_LEN,
+				   &length);
+	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_panic_log_nb = {
+	.notifier_call = vmware_panic_log_notify,
+};
+
+static int __init vmware_panic_log_init(void)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PRINTK) ||
+	    !hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	vmware_record_panic_msg =
+		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
+	vmware_panic_page = alloc_pages(GFP_KERNEL,
+					get_order(VMWARE_LOG_BUF_SIZE));
+	if (!vmware_panic_page) {
+		pr_err("failed to allocate panic log buffer\n");
+		return 0;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifiers_platform_list,
+					     &vmware_panic_log_nb);
+	if (ret) {
+		pr_err("failed to register panic log notifier: %d\n", ret);
+		__free_pages(vmware_panic_page, get_order(VMWARE_LOG_BUF_SIZE));
+		vmware_panic_page = NULL;
+	}
+
+	return 0;
+}
+early_initcall(vmware_panic_log_init);
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;

