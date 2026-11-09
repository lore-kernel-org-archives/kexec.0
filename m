Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593B606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Clum2qdC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZC8u7D4E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=; b=Clum2qdCaMTSFiUiGzd5l3bo1i
	mLBZGhnMh0UewVpGWEmIBSCnczI+RGPotN0lSBhZcGH3OLOpg2krJyWid76tfwv5AKwT6aRsJfvN3
	QDbfgeY62Xn4AAAP7yaiPX4gtdQnVS0R50H8l9hsW3FiU6XAWQ56QikMcy7MbdLy06wQ/5PZH5wBl
	1GyGWehGNDjUmvzh4tDD9H+8ksWE/BrrPpTegTUDGwH01Io04ZtY9BOapAwWAiRsK7TsmUaAzxNZo
	OU+LFFYFwmt7c7otqF294Q6F7CjkFmPhAevL0D+BbL6FZux7LdJur11pagpmdDd7gIO1IfycTetgm
	xiwHRLEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEm-0000000HSBQ-1v7e;
	Mon, 09 Nov 2026 05:48:12 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEj-0000000HS8x-1gLB
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:48:11 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so246052a91.0
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203288; x=1794808088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=;
        b=y+lnieq4t8688oq6e5WUtSJhyOHs7MwuZn9K4nvLr38G+WgF54xqcL8W17ah+Sy3mW
         u5J+yjy/X1/n1iIof/VcZwnyKuAPhApjyc4Dp5K1HkyeIxhM2QTGYZoG+sKJopdwonK2
         Terndn+958Bict+egC/W7exz6xvTrryOj+lqf5LdLBPoHYmcYZAjEkveFvxHSvRcZbFM
         k910tUnAomdG1pJebJL0TNYPLxdXd4LohwEX/gfaW1sl7c9EIswPozFaC6m/MKESBYIQ
         b/VRYcSALUq1WB53g/modQdr767kQM64yA8qh6ORAbVIOjUWF5JNp31WcRiaPfZm43EJ
         fI6g==
X-Forwarded-Encrypted: i=1; AL+hErF/DzyafRix9cg8RNn/AlkFDRJHj2gq+iCSz+BKtlQCJMVsoqGsTJ2N5+X2WhSBv7SIr9jHxA==@lists.infradead.org
X-Gm-Message-State: APuU4Z99vveIFfUbNxKk8IUcCZtfnWDUAshXpNS07iv3Gn4tIr/FLa47
	1PP85jrfmtVUMvCwMvJnFM7HrMB2ksKirxU9JdaLgJo+NI6r3oRZP2vdMxYDOGW7fT9QaRrmx2P
	PouB8vmbaJISujB+JXjJ0oHIcybicciy22jAl5uQMFDyReQcpm6gc9c8UPkv1scb/uoqWDHfjaZ
	GrY4Q3VEpu9OBidQV3QxMfleBOspPhIRM69+0yIshd2d5IBp/chwdoW/DiCHYdV2uahjQ2PKWVW
	EjWV/frkZeU
X-Gm-Gg: AYBFou3hqj/PCUBzD4Vsh+qgqWi3SskeeJyuIk221xlTNOQMQiIbTkyN/KvCm7iYYsm
	AY3F8eGbqpr/If4sEvDmqa9dGtuVUL3Y/pkuCuKTCO2dP5Ikv+iIQLawPIg4Iu7P+T/vJR0TK3u
	EMPwYDkLzBsaS+9j+xXpkURoPZ32YMfcubD1UPAPBlX0vdTjs14kXtmN26/S5yJlxPbGxr1MY1r
	xQm0uURdmwO3xkVVfg9dtdJNFJW+ugxFPmnar2eZBfavL5RT5VPjsvVP+9qDFvCpvh2RV7tig0v
	bF8J15cVX+o+/xp0YiImxs/DaqfL4vi1hujZGqtDZ/+he2K6eClTr5ucqJeGMMhCPf31/T0oilh
	XyIV4AFuxbUjh1XcDkQmXYKb2tF6OTLVjDLoBcEdBftiIcJptoJrUkRdiRxyUquU/3DuEwKYaqj
	uZqnAp/+3MLDP+HMQIlxcMbCr/cG5QA8t9
X-Received: by 2002:a17:90b:57cf:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3b12d4698c3mr2759817a91.48.1794203288366;
        Sun, 08 Nov 2026 21:48:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1278ae657sm3001024a91.4.2026.11.08.21.48.07
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:48:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so2292334c88.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203286; x=1794808086; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=;
        b=ZC8u7D4E9bUO2WPcyecUCtgHLlekmfz05s8curg85L7+L7UhkL3OAabPiYZFANh5e9
         Pjg54RjwzXY0yJiJh3Ah2eZTgCWfuR3K31WMozmeivbhRI9y4R2C5t4iKC/znVKYLBeP
         1njFa+6wYwzjz/zbbLwfLftYvHL/Yyh0FhMEQ=
X-Forwarded-Encrypted: i=1; AL+hErEVRVB+PV6sBCNyHJH8zBVDVYe8qM9HqeNDs6bClwcDc5z2oQrBL+zGLHJ2RnBZZ0jNIO4E7Q==@lists.infradead.org
X-Received: by 2002:a05:701a:844d:20b0:153:21e5:4328 with SMTP id a92af1059eb24-1b39fe9a93dmr4799608c88.17.1794203286120;
        Sun, 08 Nov 2026 21:48:06 -0800 (PST)
X-Received: by 2002:a05:701a:844d:20b0:153:21e5:4328 with SMTP id a92af1059eb24-1b39fe9a93dmr4799565c88.17.1794203285441;
        Sun, 08 Nov 2026 21:48:05 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:48:04 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v3 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Mon,  9 Nov 2026 00:47:39 -0500
Message-ID: <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_214809_444096_8DA41B8A 
X-CRM114-Status: GOOD (  19.12  )
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

Allow administrators to disable host log transfer on ordinary guests or
opt in on encrypted guests. Expose the boolean recording policy through
kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
Zero disables recording, nonzero integers enable it, and reads return
0 or 1.

Register the sysctl only after the logger is ready. A registration failure
leaves the internal default in force. Document that the log is sent
before kdump, and that disable_panic_notifiers_platform_list also skips
it.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v3: Document the platform list ordering and the disable switch, and fix
the short section-title underline reported by Sashiko. No code change
from v2.

 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 608055d7ccc4..be2d5aa52362 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1680,6 +1680,26 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+=======================
+
+Controls whether kmsg data is written to the host's ``vmware.log`` on
+panic. This setting does not control the separate VMware guest-crash
+event. Writing zero disables recording; writing a nonzero integer
+enables it. Reads return 0 or 1.
+
+= ==============================================================
+0 Do not write kmsg data to ``vmware.log``. This is the default
+  for encrypted guests.
+1 Write kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+The data is written by a platform panic notifier: early in panic,
+before kdump, and also when a fatal oops enters kdump without a panic.
+Setting ``disable_panic_notifiers_platform_list`` skips it as well.
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0c6f7248a665..8c8b6dd7c3e8 100644
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

