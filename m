Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474E0E743D9
	for <kexec@archiver.kernel.org>; Fri, 29 Sep 2023 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=udxXBTfzH+bOU6QFnfp6REksIJNPPwoo4jgMcX9SGJ8=; b=pPtEijt30xKrqh
	H3xGAXexVNSi3Pg1wydcxUTh8IAuacBfgixT/MhnKzlakFF03aVJ+3wjf/DYnvdzxgdTfjAxO/Dn0
	lnwoQNeuGKoZjVT3e31Jva58JHfQwl6l5yFScUy+8wKAFKGjrHn/xHamlDJ9wne8UB4dJDWtIWlhZ
	HBRuneMDzH+ezHUb41p6dGP0c+nE6xNIdJUwtZNnSdPVqHMMWzvmE+l7RcRMgljTTvbcI/ETQqr32
	oZi9XR8xE3TUDY74inAup6ehTt7l9P0qCB6c3SGVvkfm/Iav23IJAtT28ec4xcCW2nAm6/7IsGVnE
	NA22L+yOQmV9QiR51LoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qm2zS-0070rC-0T;
	Fri, 29 Sep 2023 02:12:26 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qm2zP-0070qQ-1d
	for kexec@lists.infradead.org;
	Fri, 29 Sep 2023 02:12:24 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3512740906dso36491735ab.0
        for <kexec@lists.infradead.org>; Thu, 28 Sep 2023 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695953538; x=1696558338; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqq4K4J4v3GU1zpra4AFU6+X76RkkP22ZNAXzHknflA=;
        b=vmiCBmnKTAurhpyare3JoJbrZje474SDnjx/RRt+kL/0idI/C3LIj63Fc1vTK4JSF9
         z3hmvXSJ2Iwui46kll4+Y5zAoMC0JkTsPFl8MCGyKS6k5fgmRmQFsQOhydSv2oVjGoUo
         4Z3uSFGS98DxPCrp/LR6cYI7lfpT8OSXc70nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695953538; x=1696558338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqq4K4J4v3GU1zpra4AFU6+X76RkkP22ZNAXzHknflA=;
        b=To/AB+h29ldpSr3Jr7VhOHxOTSwUZ8NnjOBfT9BlBb1QtCqSstNarDn0wA4Dx8jl0M
         DUhHxsiVz+LLs0StL3yo0LmhLqdF7fANvDDlqpI1Zxm9CYzHegiyFyzKo343kFP0qgYd
         2zPWYf0sYokhNiF2FJ0x1IPHKP7KIUlQWCv67T5lMluv8YB/KFstU9J9vnhBmihGvhe/
         gLtbd1HlOO8aiIskyxwfhx+69Z2mmUWE6BFw5vk0eXn3L56JpAzr5VJl3D3VGSsXEDnE
         S7dSeXvsHVFENDZYQc2OimXeMalAFd8am3Kor9oMiXVjMdabLWz7hE7H0JLMu1VipKBR
         qwZw==
X-Gm-Message-State: AOJu0Yw3LvUbbEIVkXraoex2cwAH9UBf55HSQV1Ef5TLmUVK1E16l728
	7duVUTlU+vKOPmHdjvz5R5UgFQ==
X-Google-Smtp-Source: AGHT+IEai1UK0aHYmKd2wVeivdN2wmsYyz+oQOdL6LbVDKwokuooeNmu4Sjc7PYclcGvO3aCbuUCRw==
X-Received: by 2002:a05:6e02:152e:b0:351:5acb:271 with SMTP id i14-20020a056e02152e00b003515acb0271mr3427556ilu.1.1695953537852;
        Thu, 28 Sep 2023 19:12:17 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id g6-20020a02c546000000b004290f6c15bfsm4937018jaj.145.2023.09.28.19.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 19:12:16 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ricardo Ribalda <ribalda@google.com>,
	Ross Zwisler <zwisler@google.com>,
	Rob Clark <robdclark@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kexec@lists.infradead.org
Subject: [PATCH] kexec: Fix reboot race during device_shutdown()
Date: Fri, 29 Sep 2023 02:12:12 +0000
Message-ID: <20230929021213.2364883-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_191223_549468_0B231D31 
X-CRM114-Status: GOOD (  11.74  )
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

During kexec reboot, it is possible for a race to occur between
device_shutdown() and userspace.  This causes accesses to GPU after pm_runtime
suspend has already happened. Fix this by calling freeze_processes() before
device_shutdown().

Such freezing is already being done if kernel supports KEXEC_JUMP and
kexec_image->preserve_context is true. However, doing it if either of these are
not true prevents crashes/races.

This fixes the following crash during kexec reboot on an ARM64 device
with adreno GPU:

[  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
[  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
[  292.534326] Call trace:
[  292.534328]  dump_backtrace+0x0/0x1d4
[  292.534337]  show_stack+0x20/0x2c
[  292.534342]  dump_stack_lvl+0x60/0x78
[  292.534347]  dump_stack+0x18/0x38
[  292.534352]  panic+0x148/0x3b0
[  292.534357]  nmi_panic+0x80/0x94
[  292.534364]  arm64_serror_panic+0x70/0x7c
[  292.534369]  do_serror+0x0/0x7c
[  292.534372]  do_serror+0x54/0x7c
[  292.534377]  el1h_64_error_handler+0x34/0x4c
[  292.534381]  el1h_64_error+0x7c/0x80
[  292.534386]  el1_interrupt+0x20/0x58
[  292.534389]  el1h_64_irq_handler+0x18/0x24
[  292.534395]  el1h_64_irq+0x7c/0x80
[  292.534399]  local_daif_inherit+0x10/0x18
[  292.534405]  el1h_64_sync_handler+0x48/0xb4
[  292.534410]  el1h_64_sync+0x7c/0x80
[  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
[  292.534422]  a6xx_get_timestamp+0x40/0xb4
[  292.534426]  adreno_get_param+0x12c/0x1e0
[  292.534433]  msm_ioctl_get_param+0x64/0x70
[  292.534440]  drm_ioctl_kernel+0xe8/0x158
[  292.534448]  drm_ioctl+0x208/0x320
[  292.534453]  __arm64_sys_ioctl+0x98/0xd0
[  292.534461]  invoke_syscall+0x4c/0x118

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@google.com>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Ricardo Ribalda <ribalda@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kexec_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..6599f485e42d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1299,6 +1299,12 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		error = freeze_processes();
+		if (error) {
+			error = -EBUSY;
+			goto Unlock;
+		}
+
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-- 
2.42.0.582.g8ccd20d70d-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
