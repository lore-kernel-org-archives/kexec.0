Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4870ECA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yiEqvVPcujwO0jzo0ebX90rTLmO4XRBVQ6+xmjHfKA0=; b=TV8++wYv1Q0M2u
	aW9nhgwq3q/BXqVRvEvjxw0yuAl3Wo4WFWfhsI3ZZ0rl5jXi8c///+k/wRlXL3G5AiCaf31xpT1ts
	cPhx/tETuB482+vfUR0qxU4cYqNvQov25kgtj8bF4K6z12Y2LkYzwG31mCHm8FFiq9/XOOKBviKNh
	K6UZtVwumAmKg/CEKdc+obQFRTIEvPR+xVsJMW3vs8UfZ0BWDClsmXiYGbMPSUx1afTEPiZcIaDSf
	E/9pBF1718PIts/B+LJdRiOrf3H9veRPI7G7VAr/oqItLMjpJFpAFvYVXgWo3W0N/Xljaob55+8uW
	8lgvzzjBqs5pk3uDfrYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFb3-00000001Fb8-0H9F;
	Mon, 28 Sep 2026 17:57:01 +0000
Received: from mail-yx1-xb162.google.com ([2607:f8b0:4864:20::b162])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFb0-00000001FZy-1KCN
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:59 +0000
Received: by mail-yx1-xb162.google.com with SMTP id 956f58d0204a3-674183ca360so305410d50.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618217; x=1791223017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiEqvVPcujwO0jzo0ebX90rTLmO4XRBVQ6+xmjHfKA0=;
        b=Nyd4P1b9nPGznNM8nO5lVA+CrmgimbXuj6rQScPEkJzAiR2pzkVYk3rldF4glDpRoj
         hK8+eF9U1f4+87HnEC/ZqVzmi86KBW0ruvzTKzO0WXYZaNi815u/AdcCUJ9gw3yycdZT
         1kVchSX/wuZxRgr7WARU4XUbfK423yXJl9KjuAubYnUAaBxQH3Cz9mwfQXsCphGkjOx0
         6oeAJnl94Iv2WMhBa5ND5qOUgdT7cEidRW5oCBtdIcrAl34G7AtKhpOK5Gtn3rebkWTd
         NpNcvIXLGCQfPB8s/FFwy+QbEBkQXysntdaTl/jGLf3l76nmrCn7pjV1Imd6/n+0k+Dk
         YU0w==
X-Forwarded-Encrypted: i=1; AKwUvByYl3Fj2q14QHUFMRLQRUAGMZQ3J7BSiNuaDVIT5rSs4nXzuRj3+c7cBejvTES+RwY12lOTLA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJKt5B6t2TfmWQlwDLokdymugd6Bw9hDljgVYcQxA0xFIK+RZG8
	jAHUzHGM1uOjJiQ+H91t3wjXPCuzIh1KJpo48whGaTRi+4s8lIfasz/BSL0yrNXbocQz+PE1AvM
	fVDicoO5fzqbRa/dLAipOuY4hfg78wLXi+giUtdkX6iYgi0/W3dScRGtMvusK16k9l+/JdN1gq5
	jZcA0Sl2FS2ErHFRMWEQr4qjCXdCiGIiU85PqfT5ENxeJwPmfZ0n+FrEMmO64rqpGM7VPDLK1v7
	jSfCKForq8s
X-Gm-Gg: AYBFou1qYDHwFUbE5z9xdOyeUCNaq0cGEWsQh6RdkMqPQS/Xn9oHgcRM8bG4BQe+8Z3
	Gcv/jsPIqOcwah3MQwsSDJifho8a9L98g9IW6532of5iGRWLKJW45EJVfloKHCzgljPRbUdG7YR
	p3nuuZ+mmpFnjq+4fZXE5oYB1nTi7KGTq086VeCHoqvuheJpvkQktoPVms1c98a7UVYUVS2Lejt
	GAadJFD2/s2vD9ecSELhZAh301aoPo9Jysx9XPBgyPodQR+U4ip1a4wQko9XTpoXnZ7ATtObOh3
	nZm7cQUm1evIxrRVeE6En1T1d/U/j5BQf0qakiEjqqP/dm9ONlKxvBcDioIDezsiKbib/AnlVL4
	whQy4jY0vZOn4vMIhjf+q/M00hSPWLxqvN2MDUVUt3thppLEY3z0vEgjcZeJWZFYmHxQOQSRos3
	IM0fLJoxn4dRMTQctdlshbWxb3EsTHXwAx
X-Received: by 2002:a05:690e:11c2:b0:672:99e0:ebf7 with SMTP id 956f58d0204a3-674114688dbmr2947818d50.143.1790618216642;
        Mon, 28 Sep 2026 10:56:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740efc417dsm1494850d50.29.2026.09.28.10.56.56
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1957703eec.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618215; x=1791223015; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yiEqvVPcujwO0jzo0ebX90rTLmO4XRBVQ6+xmjHfKA0=;
        b=KOHOVQGQXHm5QahgBx7T6OEd4QYwSIqvBB2cQKxdjaxJbJ71D368y0Ez5xGrzs8AUn
         EftBfsPACuK+HKaQVnt+H800HVDSVUbSVpbdQVJ7n69eGphelF2+P3wijXMQ9UWXWs7a
         OtFHJkyVh1AZzpH13QLRxtaIldzZwNjE5zgf4=
X-Forwarded-Encrypted: i=1; AKwUvBxW1zDJblwzcYKfWzGK54s8Tt51VCXrrr51/Xc+GS6ZnYFgzLxXv613bTd7wc/5ldKZUjF9hg==@lists.infradead.org
X-Received: by 2002:a05:7300:561c:b0:33c:343a:1045 with SMTP id 5a478bee46e88-342702bf61dmr9331306eec.10.1790618214823;
        Mon, 28 Sep 2026 10:56:54 -0700 (PDT)
X-Received: by 2002:a05:7300:561c:b0:33c:343a:1045 with SMTP id 5a478bee46e88-342702bf61dmr9331262eec.10.1790618214131;
        Mon, 28 Sep 2026 10:56:54 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:46 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 6/6] x86/vmware: Report guest crashes after kmsg dumpers
Date: Mon, 28 Sep 2026 13:55:40 -0400
Message-ID: <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105658_377305_B44E1895 
X-CRM114-Status: GOOD (  17.58  )
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

VMware accepts a structured guest-crash event, but a host configured with
backdoor.coredumpOnCrash may terminate the VM before the hypercall
returns. Keep this event separate from the pre-kdump log sender.

Register a panic-only kmsg dumper with late_initcall_sync(), after built-in
dumpers registered by then. Skip the event while a crash kernel is loaded
so the host cannot terminate the guest before kdump saves its vmcore.

Issue the event at most once. With CONFIG_PRINTK=n, use a late INT_MIN
panic notifier. An unexpected dumper registration failure with printk
enabled leaves reporting disabled rather than overtaking working dumpers.

Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@broadcom.com
Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v2: keep the terminating event separate from the pre-kdump logger.
Maaz's v1 Reviewed-by is omitted for renewed review of the new ordering.

 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 598d4cd448ec..ea2ce5272a00 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -61,6 +61,7 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+#define VMWARE_CMD_REPORTGUESTCRASH	102
 /*
  * Hypercall command mask:
  *   bits [6:0] command, range [0, 127]
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 4b0e5b084c2c..70553da771c9 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -22,9 +22,12 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/atomic.h>
+#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/kmsg_dump.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
@@ -330,6 +333,65 @@ static int __init vmware_panic_log_init(void)
 }
 early_initcall(vmware_panic_log_init);
 
+static atomic_t vmware_crash_reported = ATOMIC_INIT(0);
+
+static void vmware_report_guest_crash(void)
+{
+	if (kexec_crash_loaded())
+		return;
+	if (atomic_xchg(&vmware_crash_reported, 1))
+		return;
+
+	vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0);
+}
+
+static void vmware_crash_report_dump(struct kmsg_dumper *dumper,
+				     struct kmsg_dump_detail *detail)
+{
+	vmware_report_guest_crash();
+}
+
+static struct kmsg_dumper vmware_crash_report_dumper = {
+	.dump = vmware_crash_report_dump,
+	.max_reason = KMSG_DUMP_PANIC,
+};
+
+static int vmware_crash_report_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	vmware_report_guest_crash();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_crash_report_nb = {
+	.notifier_call = vmware_crash_report_notify,
+	.priority = INT_MIN,
+};
+
+static int __init vmware_crash_report_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	ret = kmsg_dump_register(&vmware_crash_report_dumper);
+	if (!ret)
+		return 0;
+	if (IS_ENABLED(CONFIG_PRINTK)) {
+		pr_err("failed to register crash report dumper: %d\n", ret);
+		return 0;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &vmware_crash_report_nb);
+	if (ret)
+		pr_err("failed to register crash report notifier: %d\n", ret);
+
+	return 0;
+}
+late_initcall_sync(vmware_crash_report_init);
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;

