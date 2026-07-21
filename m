Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A7C44536
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pbKDGyNNyhDV1H5PR4A8c50OlkFbCH78KDfnPB0VA6w=; b=UQWCwILjPc25hr
	JemJQC+cogR3xMnamay0TE9jTTQJeVajim9RiyRznhXB2jThcPnHtxk+e4y7TyWsq3RFXofI0KfHG
	43qQjyvTUUJGWVgYRbIudaWTBujwhGh2SpI1DwRShGlUhWtF6eVy4u3Uxz5LWMPVqfERmBJ8hV5yN
	YIBqgNU8ztUmpaN+uoHPMnBOMM9/8140trD1WT2qp/MaIEEQvuL8nibOOiGBk5Gob+TaNRCPlGHoM
	cS1fKwdrFmoqsgGGcDQk1WXB5u28cfuKKENdklRImGhVpDSVOy+9TsdbB6u9MB+dLvY0Em1lzht43
	UD39r86DJkKckcop7fBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAk-00000009lnW-1tBP;
	Tue, 21 Jul 2026 15:14:18 +0000
Received: from devianza.investici.org ([198.167.222.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAd-00000009lhn-44IC
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 15:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646849;
	bh=pbKDGyNNyhDV1H5PR4A8c50OlkFbCH78KDfnPB0VA6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFNLM+vumosCC9EyEK+PQKYA3EUr1upq2TWPePwN5KH/nfU+TDJjZKakbxvqim6Tr
	 ogeSAoqUrtIBnKZCBVDsjE6iOIopbbttQjh89NqivAhDIAMBTS6UAuTYgvL6+vOncf
	 TQZ7MZ6puX+XljlXxojFfCmlbxHpsua38BRpNvwY=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWj3LXyz6vNZ;
	Tue, 21 Jul 2026 15:14:09 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWh4sK6z4vyJ;
	Tue, 21 Jul 2026 15:14:08 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [PATCH v2 1/3] reboot: log the task that initiated the reboot
Date: Tue, 21 Jul 2026 16:13:56 +0100
Message-ID: <20260721151358.4185467-2-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_081412_165595_FD4D41AD 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: pavel@kernel.org, tony.luck@intel.com, baoquan.he@linux.dev, rafael@kernel.org, kees@kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@kernel.org, Bradley Morgan <include@grrlz.net>, pasha.tatashin@soleen.com, pratyush@kernel.org, lenb@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When a machine reboots or powers off, the kernel log records what
happened but not who asked for it. The reboot syscall throws the
caller identity away, and userspace does not reliably record it
either: systemd only journals shutdowns that go through logind,
anything calling reboot(2) directly (watchdog daemons, container
agents, orchestration tooling) leaves no record at all, and the
journal is being torn down while the machine goes away, so even the
lines that should be written can be lost. The kernel is the only
place that always sees the caller, and a kernel log line survives
via pstore or a serial console when userspace logs do not.

Log the comm and pid of the calling task in the reboot syscall, once
the requested command is committed and can no longer fail, e.g:

  reboot: initiated by systemd-shutdow[1]
  reboot: Restarting system

The existing "Restarting system", "System halted" and "Power down"
lines are left untouched, so anything parsing dmesg today keeps
working. The two ctrl alt del toggle commands are excluded so init
setting the mode does not add a line to dmesg on every boot.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index aa08c3bbbf59..3fb8d8533563 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -172,6 +172,7 @@ extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
 extern bool kernel_can_power_off(void);
+void reboot_log_initiator(void);
 
 void ctrl_alt_del(void);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index bed6967bfa96..3f4534cd5b9c 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -717,6 +717,18 @@ EXPORT_SYMBOL_GPL(kernel_power_off);
 
 DEFINE_MUTEX(system_transition_mutex);
 
+/*
+ * Log the task that asked for the transition once the requested
+ * command is committed and can no longer fail, e.g:
+ *
+ *   reboot: initiated by systemd-shutdow[1]
+ *   reboot: Restarting system
+ */
+void reboot_log_initiator(void)
+{
+	pr_info("initiated by %s[%d]\n", current->comm, task_pid_nr(current));
+}
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers
@@ -764,6 +776,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	mutex_lock(&system_transition_mutex);
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
+		reboot_log_initiator();
 		kernel_restart(NULL);
 		break;
 
@@ -776,10 +789,12 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
+		reboot_log_initiator();
 		kernel_halt();
 		do_exit(0);
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
+		reboot_log_initiator();
 		kernel_power_off();
 		do_exit(0);
 		break;
@@ -792,6 +807,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		}
 		buffer[sizeof(buffer) - 1] = '\0';
 
+		reboot_log_initiator();
 		kernel_restart(buffer);
 		break;
 
-- 
2.50.1


