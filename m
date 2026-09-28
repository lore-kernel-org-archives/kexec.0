Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003C0CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rTHP+RKFRTvsoz5ZQC0H2auzr0/LWHqaonCSO4TGaa4=; b=ZfVFT122tmL73e
	INO/GtVmWpZDaVh3V4SiYtBsEcBm8tBjkOta7oCytJuoNwdMTeDYRk9JToGCoUhVYvYa9BecNxEEi
	BMB/txNhZ+4NtPLt+Lthplm2+uyO/c4vJwDbNJi0q97epO7dMY0gBeFB8i4OPwXQBatWRskMxFDSc
	7g4NEAOl136vmJTfjl84Arv7s2eddvJSz2uJLUE/n458EUVZ7KAn0+zf7OaDPDAo6yP+mTgHcfvdI
	BpCtZwr4pk6NipnoPzAuH2NeIoGylnzAke4XNy0678ok5NAtC2BiB3mkTlDLRtFQ00BfMYSvhYSsg
	QT2wLXFEboev3KfNAC1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaq-00000001FXg-43pZ;
	Mon, 28 Sep 2026 17:56:48 +0000
Received: from mail-vk1-xa64.google.com ([2607:f8b0:4864:20::a64])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFao-00000001FWo-30Cp
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:48 +0000
Received: by mail-vk1-xa64.google.com with SMTP id 71dfb90a1353d-5cfa94ccd6aso99165e0c.3
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618205; x=1791223005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTHP+RKFRTvsoz5ZQC0H2auzr0/LWHqaonCSO4TGaa4=;
        b=OlYGFOEoCPM+yzC+eIIMsnCoHJNSVITfhMH48NocX5NUlf4XWw7MT6a/RFf8+6bwg0
         ZAvEFxt49oAg4Lc1eEstW0zWJu1kv1fc6h+7DpazTzEQSuguT4NA3fvvTjFKEefzy7RW
         9eS194+Crg4LBb8U63785Kjp54/33bcoktZD5+pHlBqHewOkHHEh4od+gysqh5WVaHF9
         tY3LDklZIRPY1edssxXR1meC4qab0CKTy9s6iyO5HcstxFuOneEkKdOgvmtn54zSPbFQ
         mCJbmnZissaUwbUW5sPhcIWmEdW/aQF0k+qlN1Jrs4PzVq5cVb/WAqQgWCyUqx8FQA3Q
         r9Mg==
X-Forwarded-Encrypted: i=1; AKwUvBz7VIIqbR4HcypOYIGU8jNKPyt96OGnzxtlo7UQyUvNa4PHMQQcjF4a2vn2AkzoNPAccHdAkg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJQEe3souw3DZD2QZinMcRW3881A8q+3SKrEqBvjCjGPxq4AGtz
	3Ci+qOsW44ewnld6+KtEeGRFW+hBT9yqrmCIp9MJC0AV7KRFV1+hNkzYqYTGnIgZrvl2MCpZV1D
	77b5X8lZhnmluOMC0jZKmeJ5uAGJC0ozNTBwOsv4wfm/01fqtbAGQ9ETsH8sm/Arewk7SVjH3gB
	uzbXp186xP3CAURm0sZKV56Eg0At0/Mc0nvq2kpaTqoLcHTw8arBTASdqZH7ExJvjWlF7d1cjV+
	0dJo6xu6J43
X-Gm-Gg: AYBFou0rLhSMgFarKjDvm27iBXXHynv/TeciMCol9SaHKJLH9dhh7EA55/MtqywDIYT
	vTLNCCKQKeBx8cBwJxEO43JHoBNlgvLHj2F97I+edpx77HiT9FW7lqaR9F9xv5TnqecSKHi/zJi
	E8dliObIKzDK/gbmRzB2WYur46DMdYjpnsv8suIUKnxBJf5EibCwGB+TYG2e09ofxnPtJa5kR6s
	+ArshRYHY5a8zAq/RF1ykAVMkpYz99TaQ0uQp+rjPPdKS4WfyQi656lskXrbMfRpUEJsDkwwY6H
	+DqTQriq7DiiJNQtZQKMQdkPREUbQP4yQY5cqrbzCqlTlqAPpR2VGPbdN3CF8VqV/2TdL3fvhhs
	ITJ66n8UKZux/9bteJWYDuMzCNQeZyLBOV2mQFoMvvL2Kkt9txL4KzzilF+OPH2pXmzPZkh/A1L
	F3s40U4BhCAJ/lZ950L5HvJ9awxxQMsYWt
X-Received: by 2002:a05:6122:6602:b0:5c9:c60e:f4b8 with SMTP id 71dfb90a1353d-5cb0bd5fa84mr5972490e0c.22.1790618205201;
        Mon, 28 Sep 2026 10:56:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5cde2c05c3fsm1564799e0c.1.2026.09.28.10.56.44
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so6244203eec.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618204; x=1791223004; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTHP+RKFRTvsoz5ZQC0H2auzr0/LWHqaonCSO4TGaa4=;
        b=DWFxP15bul+UERVrSOxxVrZ6RRs/OocX/jeb0lwwBl6PQKglIlleB/OhNhQZmWzNJj
         8gWPPgwMSlKsyvIz2e7BIU+Ch+NO89Avm/vKxv5kbZwILl0wtf7Em7B1Ig7iJqMxzDJY
         6m3gMuVdUTMHrVxL8io6syI6bc23twCfWlrjQ=
X-Forwarded-Encrypted: i=1; AKwUvBzyWnW0eO345elwXw0DSCoxB6KQvCyCJ1usEoen4Pyjiz0ErqZcH45dXCs48zsNOtRc3FpDHA==@lists.infradead.org
X-Received: by 2002:a05:7301:1a02:b0:33e:84c3:a056 with SMTP id 5a478bee46e88-342710ae7bamr9978542eec.17.1790618203873;
        Mon, 28 Sep 2026 10:56:43 -0700 (PDT)
X-Received: by 2002:a05:7301:1a02:b0:33e:84c3:a056 with SMTP id 5a478bee46e88-342710ae7bamr9978508eec.17.1790618203106;
        Mon, 28 Sep 2026 10:56:43 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:34 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 5/6] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Mon, 28 Sep 2026 13:55:39 -0400
Message-ID: <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105646_772332_DC34FCF4 
X-CRM114-Status: GOOD (  17.35  )
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

Allow administrators to disable host log transfer on ordinary guests or
opt in on encrypted guests. Expose the boolean recording policy through
kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
Zero disables recording, nonzero integers enable it, and reads return
0 or 1.

Register the sysctl only after the logger is ready. A registration failure
leaves the internal default in force. Document that disabling the old
post-notifier ordering does not disable this independent logger.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v2: use bool/proc_dobool as Joel requested; document direct crash entry.
Maaz's v1 Reviewed-by is omitted for renewed review of the changed sysctl.

 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ffea61d448eb..be13c143b8bb 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1690,6 +1690,26 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+======================
+
+Controls whether panic or fatal-oops kmsg data is written to the host's
+``vmware.log`` before kdump. This setting does not control the separate
+VMware guest-crash event. Writing zero disables recording; writing a
+nonzero integer enables it. Reads return 0 or 1.
+
+= ==============================================================
+0 Do not write kmsg data to ``vmware.log``. This is the default
+  for encrypted guests.
+1 Write kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+``crash_kexec_post_notifiers=0`` alone does not disable this logger.
+``panic_pre_kdump_postpone=1`` skips early logging but leaves late panic
+logging eligible; set this sysctl to 0 to disable both.
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index ccf8dc84b30e..4b0e5b084c2c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/sizes.h>
 #include <linux/static_call.h>
+#include <linux/sysctl.h>
 #include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
@@ -260,6 +261,16 @@ static int vmware_log_rpc(const char *buffer, size_t length)
 static struct page *vmware_panic_page;
 static bool vmware_record_panic_msg;
 
+static const struct ctl_table vmware_panic_sysctls[] = {
+	{
+		.procname	= "vmware_record_panic_msg",
+		.data		= &vmware_record_panic_msg,
+		.maxlen		= sizeof(vmware_record_panic_msg),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
+};
+
 static int vmware_panic_log_notify(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -311,6 +322,10 @@ static int __init vmware_panic_log_init(void)
 		vmware_panic_page = NULL;
 	}
 
+	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
+	    !register_sysctl("kernel", vmware_panic_sysctls))
+		pr_err("failed to register panic log sysctl\n");
+
 	return 0;
 }
 early_initcall(vmware_panic_log_init);

