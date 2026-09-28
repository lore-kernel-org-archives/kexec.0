Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7112FCA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ejipg3r3UVU9vc4qrGUJPGiICgZ3Att93JZtQzMULZA=; b=r50sajeZiTgJjP
	hAJrdzLF2GwJzw4Qu41+uFoByH8igPdGDFPGFTd/8nDe59XNcwr51hF8D81R7G7RhEi56iB7HvPfL
	IVWNR5xHhEdKpavprfWHyQCNS+TUVxzAdF3AYeuTebqMcWl+M82rS3YeKz7VEsTVifVN6WAwwQqYq
	NSz9iwrgN/fbOBHOi0YRLZ37mOK5hNKJq/oDcj2tHXNFTXm3lBufYhcSGtC+ylEgdxFcXy4o/Cktz
	1bCyqgt/9Tco7ZYG1qzpbu2QY1ET6L2YVgLzqx9nCyUycaW0G8WcVyNi7abRmlP6Cwa8fKtSWsQlC
	5C0PnCYPTiCBVTyu2dNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaO-00000001FMM-0lhZ;
	Mon, 28 Sep 2026 17:56:20 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaL-00000001FLE-3fte
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:19 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-3a0e32347bcso831541a91.3
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618177; x=1791222977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejipg3r3UVU9vc4qrGUJPGiICgZ3Att93JZtQzMULZA=;
        b=CSL1aWcWFnodBeKQhMuBMh9w+yGpTvX/m1ZbkPh/2+2ZM86eNILh9Q4DjIO5h8yASk
         /pmq2JxwyyAtoGjylWtPe6XBxprZ0U1Nuv6TXchFDJ+eFD9qgo18RFdM7xYlgabe9i7s
         ufwkQlGH2Puzsh45eFPraKCbqa2sPJmGCVdyo3B7JqmPMfQTP1ZPq1CclrTD0mEzfBX+
         j8tTYrhRbtY8QOYskH/X57+f1wbPjSTiDkFlnRLx1YcJZMLV3nVNMCE5tx7dRCjXLOFD
         fTMZapUO5f+RYse0LIjHM0e7lp80zTv8WsLDIHEGcMLIrjk7RHSDrB0lfaDQymLSMS7P
         +HIA==
X-Forwarded-Encrypted: i=1; AKwUvBxCQZqsjy1q9zrasc2rOe4MaP7PiHba22h1RHL2Ac+HPHP881ly8Cc3gA5dRcvn+onbIoBSOw==@lists.infradead.org
X-Gm-Message-State: AFq9FYIQyhxhDHZijuJo8fMIgnrBueR8CRgdn6illHJScdnNokqqfrBc
	zPrUw0PSLeoMq6AFVIR9XB6R+BZtpOzj9Ktr4frMx5amiXYkM0FczuAEQEzTVF52EGhCeV9rBrn
	SeTw1Zbmg/GDKB2FNCNovRlNwtI7cUQtIcd52k4Wik5UnAjkC90XC5RYz++bGJpzez+xAgZ1lYM
	yLQZ+vWQt3/AmPtBLwHwToJhf27NdPDyjLucOq/DCkHwyIWVs6sY4H33rBGkzkbL9rvYAA6Esa+
	H5phesV30Yv
X-Gm-Gg: AYBFou3uo6NPM5R6rj6EFHZXv0vikUFAGdOBwWioFnIv1KveDUSgQYab4QzD/KYVMAD
	s3QMyLGS7pqV4Z84/OU78QRDhfgSh4+ghk1+VM2FI1oVXgMK0OQw4aabsRK2ClQ6JwLyl5JNZjE
	XMpKFYtCOYEjpVd4naQcZ8Lt+ERMGqlOpt+chbpzG/nUM8nuIBPcc1EIaDycxL/lDqgoM+uzSCB
	ji41ZF/zSYRF/p1k5amlRia070up7cv0u+kV79As5yAYGWjjZ/C/wUtNb+gPv7HqdSVbzpUHY24
	C+WSu38dq/5mt50prkCq26TuS+VCUEZr95peYhc1Co3BdWOEdqYcQOVrfsb/Cs3LsFJ0GH+C47T
	nU+4yGtypsfVyBTXaVNX2oUNlCRRRzZ/Xve9uykYrD52heikLFOhuk708VM3XOWWdKuUxUa+4xG
	jBQeZOStX9yvjPNmvZdmPod4pQsf9VDDRScaQ=
X-Received: by 2002:a17:90a:ec8e:b0:3a0:345a:3620 with SMTP id 98e67ed59e1d1-3a098df852amr10843198a91.45.1790618176686;
        Mon, 28 Sep 2026 10:56:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a498edd9b8sm39561a91.4.2026.09.28.10.56.10
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34afa104860so43419eec.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618169; x=1791222969; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ejipg3r3UVU9vc4qrGUJPGiICgZ3Att93JZtQzMULZA=;
        b=YjVPp0MMSZBAa2QJrutVZbvxozqraHeWfmT6mizYLwqu5GCow3ZQh/54E8f9B07BIJ
         usoJpa8LsPQzzbQDYRHiIq+9UuPTXsqYl/1wI0xlQEoF1D3AMKl4YihKMxxZeF33OG8t
         NPcHSZautnNpmMK5KIiLR/G58MNKRd24uohLs=
X-Forwarded-Encrypted: i=1; AKwUvBxppv3tiN0uI5CH50+gqo73qBZgEYEMgSzfqynWfTmaivs7G13osHSlTRm5+H118hsQZeBXMA==@lists.infradead.org
X-Received: by 2002:a05:7300:3e93:b0:340:f935:5fa with SMTP id 5a478bee46e88-3427384f956mr10865965eec.40.1790618168027;
        Mon, 28 Sep 2026 10:56:08 -0700 (PDT)
X-Received: by 2002:a05:7300:3e93:b0:340:f935:5fa with SMTP id 5a478bee46e88-3427384f956mr10865927eec.40.1790618167270;
        Mon, 28 Sep 2026 10:56:07 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:01 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump callbacks
Date: Mon, 28 Sep 2026 13:55:35 -0400
Message-ID: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105617_923818_01EB6B3B 
X-CRM114-Status: GOOD (  13.65  )
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

Selected crash callbacks should not require running every panic notifier
before kdump. Add a separate atomic chain with an at-most-once dispatch
helper, and invoke it before panic reaches the kmsg dumpers.

The helper permits another call from the crash path without repeating
callbacks or recursing into them. Document that callbacks may run in NMI
context, with other CPUs running and the kexec lock held.

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
New in v2: separate pre-kdump chain, with a set-once dispatch guard.

 include/linux/panic_notifier.h |  3 +++
 kernel/panic.c                 | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..3ad390764a41 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 
 extern struct atomic_notifier_head panic_notifier_list;
+extern struct atomic_notifier_head panic_pre_kdump_list;
+
+void panic_notify_pre_kdump(char *msg);
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..d78e90abb192 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+struct atomic_notifier_head panic_pre_kdump_list =
+	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
+EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
+
 static void panic_print_deprecated(void)
 {
 	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
@@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+/**
+ * panic_notify_pre_kdump - invoke selected callbacks before kdump
+ * @msg: Panic message, or NULL for direct crash-kexec entry
+ *
+ * Dispatch at most once per boot, including recursive entry. Callbacks run
+ * with interrupts disabled, possibly in NMI context, before other CPUs have
+ * necessarily stopped. The kexec lock may be held. They must not sleep,
+ * allocate, wait for other CPUs, or call into kexec management operations.
+ * The message is read-only and may only be used during the callback.
+ */
+void panic_notify_pre_kdump(char *msg)
+{
+	static atomic_t started = ATOMIC_INIT(0);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (!atomic_xchg(&started, 1))
+		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
+	local_irq_restore(flags);
+}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
 
 	sys_info(panic_print);
 
+	panic_notify_pre_kdump(buf);
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
 	/*

