Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B521CC79F82
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIZhE29+oVPTSBZvjxk3RWug8DvHvEXFsH8XGpUQx0Y=; b=Cf1GUXYjQqw/YKJpbuBPsNuxmu
	6MvXORzTmXi2rQDoZCKnuAp+PO/AeLTxkS1IKGpyAuBvccniLXS8eKpRXtTzih5/eO9rkZ5SFSqss
	8G0moZm9FeReMcwdbJAiYrRvVe6sWZj7Wk+8aJZDKCxAKZtsMNXSKfi+g9gDiiE+2al2tmAMsni5d
	sK2m+j22MY3e1uNNbR3/Rs2stil9kbvVsHITsBncZIrLMKP7yhqDBqUDF99QhtYrJkoac8e9t3W1D
	Re9+k6nBLVtbfUQahLMglZ+GgzzfTUWHECYgyQ0e24ku1kN8orzoYpsY1FzD4Cx6n0q0+CKOOf9oP
	b5YAzXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EL-00000009w7U-3nie;
	Tue, 08 Sep 2026 18:07:37 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40EJ-00000009w6K-19NV
	for kexec@lists.infradead.org;
	Tue, 08 Sep 2026 18:07:36 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-855d2bfae95so5895431b3a.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890854; x=1789495654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIZhE29+oVPTSBZvjxk3RWug8DvHvEXFsH8XGpUQx0Y=;
        b=Ud2iYTjGLpcbOjHSn9LRbQhoOfrJ1yTv/SUQOpZUakktX8bHskzA0qJBrHh1Nn15sp
         T9wuqHh86CyIoEOMKxxn7t+6FnBe5QK6rHaCLC7H7OvWdFYO+nG3OHUA41OoS87TKRcG
         g9JERHVHMdoW/E7CvPOoA9+ZddgFkErepoDg3uC3ANiYtzUmuwHh4uY+WcGtKoGcwlW0
         Ult7S8Od+kic4OhWfSz1Qy5NSZt6WZVVyiwae2CkW1B6PBYiY5YqOMLYbdZ9lnM9ztf/
         EI8Zr4xEypKIOOIy4Gi3oece5HS0B7UTtL74V4evYQSzBjcs+cGm2pa4EdaR9AuncUYr
         rblg==
X-Forwarded-Encrypted: i=1; AKwUvByFoDYrZGfVPg4Sav5MZ1KZKsAmtZP62nRpwINPFemonUu0VogNPsMCIs+9efhJ2sx3KZmuQQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lOCkFxAvyko6WYvondWf3cm9qJ5M23yHPECIzPM4nWBIL4Zplr
	3il7BussdGcZPBV9oknpYfUFtn+FAOPyDiABW4anz4Jfxvlo8589lwmwIfAphuCnq3nCF4BQRnE
	ow0wWz+ksEiiBKDKoVpl+iwiBB5UOLIe4IdjA6m4bx2lfB74luOnpPXFQX8vFQCnhuTY8exokk1
	9r6JY/KY+4rXB9KCU8eiflQMWclfeaMmART7Aj1rnhnhdfwBusYJBaLjqcJyO+k2Yw6bWM1yQjn
	SD4z0ExX3mb
X-Gm-Gg: AYBFou2qz9+XZiNdlyYAL8dhOlJWHmrCTOKeguFb2xGOrgf3fTeiqcCWMq6snz/JAcS
	wTGg3wcZ8G+nd+Llry/Qg8XoVfl4IyCj7mIj3f2V+d/zxdrdvI+1x8qbUK1BNy5JQfsyKS4UI3i
	gy5z4J1FGH1iaobCeT9sGhEE6sCKIcrL7P4xI/zuWPEhZOznmD007itBcEZsDWYk6daeI/e7onM
	IhUkkMCTqYu+57d4uCVFxzfYoxygk/YssKIbW0blRZ1kT2poiwvuV9kqjQJMvZ32ItZ2A4Bt0+j
	AO85sCzpr7gWcUpBu4VdvEReK9Ju7WN7+T0ebWNs5NAX4m9J+IRueRaR8qUG5VoKKX1dmH2LUPq
	GBKqhewQ4bV1e1brEw8gGPh7MGRvYVXzQtE5yD43zJvc2WMq4qJrN7qRREWFQUTKXZiw8O4YxUl
	oDvZeeSGKkzV5RY4LOCua44cxf9uZbQ83XuM8=
X-Received: by 2002:a05:6a21:338f:b0:3d8:effe:34f2 with SMTP id adf61e73a8af0-3da9d9e9c03mr8003348637.12.1788890854212;
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc464393683sm2498459a12.1.2026.09.08.11.07.30
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9105be46009so32716676d6.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788890850; x=1789495650; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIZhE29+oVPTSBZvjxk3RWug8DvHvEXFsH8XGpUQx0Y=;
        b=JRrX7raawMeddEBG9xYrHpxoso5OHivih3+PoYMAR/4XyGo9atBqrXY+GKGLkpPz8K
         bzqOTtZgtlZg82NAuRQbkMLpAPSKGf6csJl+jjSSqYHansBFQuT7aFpgxym/N5AZqWu3
         8GbALyQoHN06zz2BTUmtDKaMO4urvHAvO+8bI=
X-Forwarded-Encrypted: i=1; AKwUvBxdxYEpMU9eP/ITdkzoXeoQ8mMGFg+RMcVfZYaIt5zE4OqQtMUB8dTwr3eXUv1Lfph3N7peaA==@lists.infradead.org
X-Received: by 2002:a0c:e003:0:b0:910:69e3:2983 with SMTP id 6a1803df08f44-91069e33187mr23819556d6.5.1788890849446;
        Tue, 08 Sep 2026 11:07:29 -0700 (PDT)
X-Received: by 2002:a0c:e003:0:b0:910:69e3:2983 with SMTP id 6a1803df08f44-91069e33187mr23818676d6.5.1788890848717;
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 1/4] x86/vmware: Add a bounded panic log sender
Date: Tue,  8 Sep 2026 14:07:13 -0400
Message-ID: <18115e519d85b753c147b45470120721eaf14505.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_110735_321856_DF31D633 
X-CRM114-Status: GOOD (  21.30  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A virtual machine may have no guest-local persistent storage or working
userspace after a panic. Preserve the newest kernel log tail in the host
vmware.log, which remains available after the VM terminates.

Allocate one page during early init and register a panic-only kmsg dumper.
Copy the newest records once, prefix them with "log ", and send one
explicit-length RPC message over the low-bandwidth register path. The page
limit bounds panic-time work and avoids sharing guest memory with the host.

Keep the source immutable for up to three attempts. Retry only checkpoint
responses, zero-fill a short final word, and close the single RPC channel
on every exit after open. The panic callback allocates nothing, does not
sleep, and emits no printk messages.

Free the page and leave panic logging disabled if dumper registration
fails, including when CONFIG_PRINTK=n.

Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 158 ++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae14a2d..598d4cd448ec 100644
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
index 34b73573b108..bf59653d6e07 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -24,11 +24,14 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmsg_dump.h>
+#include <linux/mm.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
@@ -52,6 +55,22 @@
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
+#define VMWARE_LOG_ATTEMPTS		3
+#define VMWARE_LOG_PREFIX		"log "
+#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)
+
 struct vmware_steal_time {
 	union {
 		u64 clock;	/* stolen time counter in units of vtsc */
@@ -64,6 +83,12 @@ struct vmware_steal_time {
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
 
@@ -142,6 +167,139 @@ static unsigned long vmware_get_tsc_khz(void)
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
+
+static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
+				  struct kmsg_dump_detail *detail)
+{
+	struct kmsg_dump_iter iter;
+	char *buffer = page_address(vmware_panic_page);
+	size_t length = 0;
+
+	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
+	kmsg_dump_rewind(&iter);
+	(void)kmsg_dump_get_buffer(&iter, true,
+				   buffer + VMWARE_LOG_PREFIX_LEN,
+				   PAGE_SIZE - VMWARE_LOG_PREFIX_LEN, &length);
+	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
+}
+
+static struct kmsg_dumper vmware_panic_log_dumper = {
+	.dump = vmware_panic_log_dump,
+	.max_reason = KMSG_DUMP_PANIC,
+};
+
+static int __init vmware_panic_log_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	vmware_panic_page = alloc_page(GFP_KERNEL);
+	if (!vmware_panic_page) {
+		pr_err("failed to allocate panic log buffer\n");
+		return 0;
+	}
+
+	ret = kmsg_dump_register(&vmware_panic_log_dumper);
+	if (ret) {
+		pr_err("failed to register panic log dumper: %d\n", ret);
+		__free_page(vmware_panic_page);
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
-- 
2.53.0


