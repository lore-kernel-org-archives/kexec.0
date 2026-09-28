Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1852CA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TVGlTnr9IEkHnZ4PdpN3QONqUPUFWJ903eZT9nZGA+U=; b=z83PpqJwhXLffU
	uD4iTUXv9RNHj+VMeXpXAKUc+JGbQ53X4Lh0pSgzGgKmSl1lzkTSO39llQdjbrAB7R7Z/7ycbHiaH
	iKyL5+QoZhmSnbVmf66APcDjwlvzTYFeFvzsI+pZv2TppwXtENo4F21l3/n45964LGAco9pnYHRRV
	JFu2e+k+gsoUqR0W3nbwnrbY9ot4ywbY6idAS8UusubKRZaUlrBpNWBrD6eq5qklh1AeldiL0cb+B
	pwjK6Q4/dLKBPjIO5xisREy5BURTRVgqG3+rgUQUGyNkDc+a23Gl8G0rz4vGs6pCs6vWJGGDjZrps
	bU5dMg7XKpo+b4AG+Qzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFag-00000001FUa-2Acl;
	Mon, 28 Sep 2026 17:56:38 +0000
Received: from mail-yw1-x1164.google.com ([2607:f8b0:4864:20::1164])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFad-00000001FTE-22dU
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:37 +0000
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-8834d10a4e3so589067b3.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618194; x=1791222994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVGlTnr9IEkHnZ4PdpN3QONqUPUFWJ903eZT9nZGA+U=;
        b=XDIBhU2Db8mddY1zBRkA/h2tXNX53sNy/Hxtr2xg4Yz2SKy77V52Oyc4kFYcSqbjfx
         58qtCGGIaozD3kTUfptIi7bN8hUOUJ8DmaC4vbPNolYwxnO4q2E/K7vXLsPHUd3i5Ycp
         1O5lYEJh8jNrNt9BVEFn0VUXm1urs48F+3ZO4Ieh01E9ahxrB3BDrbN40+bRrnAUCgEF
         x2YjZ6DXJt1meaaxUFwNvYF1EJmng6KboQaeFsqDx+H67Q/E00r4FLI+wHDbnDv6u26k
         damTFLcQn4/cOQjSSLh8DvSNseZuSVY5Ng7WRnAZkFVXhM9UlKyjMUHKhSr2zQgJzIf7
         to6g==
X-Forwarded-Encrypted: i=1; AKwUvByP+aiNPAd+3glF7mMyRmpld0V16kkuZpFeEyv+P6lqWJfTDvbFtFHbatuPmsDd6BXHTektFQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIhb155YPsWwgEEjEnDiFMrwoYn5orH2rvpah2YsHHzmFlBU3St
	8dbkh560b3JCJP3GBigNfYiaU1PIYEgzkrBHsK+nfONKwt67BQ/pRLK0rEEy6xPqKSjuALtjtzv
	IEZsnp7quTRvOJIavDjLq8XK7VUa2Kajuok+MVcODWeqIcMMh38WhgA1Ew9XIbqSSKMuYmEG/L7
	psnGBfvmv3XY/ue5j4ipRYPfnb5UfbbPn9sYY99OojTBzNmT0CBErIPHbHq4DvsLIjUQ5LfPkRb
	2EPwEkSLd8S
X-Gm-Gg: AYBFou1bKpEbb2oMvE/1lrzWLylM7al1idQ5SQCQF1URVjxMPHMVB5QS850pHxi9K50
	mJMQSfOguw2PjtOhB0yj+ib5qfJt54n0xPKihxT1MmzaKrKMmzOhuxYp65lW/+qXw/Pmtv4yO4R
	ZaewN9qcE11WBJCU0BI5TLPIAIgOZTztDCiA+Wy1LCyGg14eBCq/dcDziUAjV4dAAg0a850UFN7
	2YUFdfQTDl6e4A/GU/EV1jfHna5GNOMmOar+UNBNa8kYzO6yL6IvUAMxtyh7Slmi7YreNbYI0AS
	xNHBC249o05URv4g9a8NNDUOSMVDvZeTDhyzwZQ86fGnlA/SZjrP+wrX6fWwetdoroNN/ZmBZOM
	cMk4J6EfcH7H0DJxhm6nc7kSdDYs7Sfx/L1HcSTdiQJQeOQPf5FuTxwFLboF3Lt01kB0dGc8wM+
	dOjH2fL15cyX0UwIBbsadWQ5eFSt9bCa4L
X-Received: by 2002:a05:690e:13c6:b0:66e:5332:a911 with SMTP id 956f58d0204a3-67560bc3e0dmr50822d50.21.1790618193795;
        Mon, 28 Sep 2026 10:56:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740ebe34c3sm1472985d50.2.2026.09.28.10.56.33
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342b66c0b06so119785eec.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618192; x=1791222992; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVGlTnr9IEkHnZ4PdpN3QONqUPUFWJ903eZT9nZGA+U=;
        b=fA5TdxZRIBFuShoq5X6n0Nfufx7D2L5Umv08MoiiqiLT5l93TTTuC/pKvBwHokUXOp
         acbCBOOAXnQZejda/OQTsgsnGU/I5sFJchFI39ujCNt73IDK4tQPZZTV8m+Qw4ZZ/BKA
         HCtHXMdDKMo1EOfLtjSlUPV7V7r8xNr++1Bu0=
X-Forwarded-Encrypted: i=1; AKwUvBwy9J2jBB4pRJYTUuOS31QFR6vEOP0ibG+Pq5fxj4vJrrhcr04xyFqsrN3b2SCie0dYVIj4+w==@lists.infradead.org
X-Received: by 2002:a05:7300:6705:b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-34af62b1643mr148599eec.12.1790618192295;
        Mon, 28 Sep 2026 10:56:32 -0700 (PDT)
X-Received: by 2002:a05:7300:6705:b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-34af62b1643mr148550eec.12.1790618191428;
        Mon, 28 Sep 2026 10:56:31 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:26 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 4/6] x86/vmware: Add a bounded pre-kdump log sender
Date: Mon, 28 Sep 2026 13:55:38 -0400
Message-ID: <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105635_555925_6AEA6FD7 
X-CRM114-Status: GOOD (  19.98  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Preserve the newest kernel log tail in the host's vmware.log, which can
outlive a guest with no working userspace or persistent storage.

Allocate an 8 KiB buffer during early init and register on
panic_pre_kdump_list. A 4 KiB buffer can omit useful stack-trace
context. Use a fixed byte budget so transfer work does not scale
with PAGE_SIZE.

Copy the newest records, prefix them with "log ", and send one RPC over
the low-bandwidth register interface. Bound the transfer to 8 KiB and
at most three checkpoint attempts; zero-fill a partial payload word and
close the channel after every successful open.

The callback allocates nothing and emits no printk messages. Enable it
for ordinary guests, leaving encrypted guests disabled until explicitly
enabled by the sysctl. Skip initialization without printk support, and
leave logging disabled after allocation or registration failure.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v2: use the pre-kdump notifier, establish safe guest defaults, and
increase the fixed buffer to 8 KiB as Michael suggested.
Maaz's v1 Reviewed-by is omitted for renewed review of the new callback.

 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 173 ++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

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
index 34b73573b108..ccf8dc84b30e 100644
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
+	ret = atomic_notifier_chain_register(&panic_pre_kdump_list,
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

