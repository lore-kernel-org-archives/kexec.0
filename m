Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5923C433FE
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=R2n6ZQii3707fwuzY27uzawMic/py7jBPtfSj96pC/A=; b=fHLWaWixTL+4Q3
	PloYhUYvOcwzWdPLfX9mazJ26htCrrF8zUfg0jur40wjzFJMD+s45/IuFtEjWzJ6g9BCFtxxlwhrF
	f94SCnIHPbrtylmAIkhaLFlvTiFl7LWm9QQ6zV0vq4FqxyaLzIGiZXnFnY3YnsC+WRfAB90Cp1vpa
	9vteZnIN8AJ5HnvyhfZXNw/msn/lGJE/4pUwZw1akXGUxMee5LEdh/KQuzMQGSuuJXmVVyMZY1nXT
	tN7H1sbLJnrlcB7gVDlTSQyND45a0f0EURm3XvHY81VwFH1BOn0E7S2J5n4j83laP0HJ6bVl2Zv3L
	ZXTKfnlryvF+elAYhjNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovOWQ-007Qz2-GA; Wed, 16 Nov 2022 19:56:34 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovOWM-007Qup-Eh
	for kexec@lists.infradead.org; Wed, 16 Nov 2022 19:56:33 +0000
Received: by mail-qt1-x830.google.com with SMTP id l15so11429725qtv.4
        for <kexec@lists.infradead.org>; Wed, 16 Nov 2022 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unotCeI+jeIlE1s8Z495KMzeSar7HGNW9+QZlv24Mc0=;
        b=JLXjqnMarhoB443eFEIA54k6GJ0U0S4rNPJ+GyGzrlLZpjYobZRmXxOcntlkxNdK66
         AoE6GZqDSOLngKrVX+i5I2dmc7rroyWGTD0qxilI+Xy00RY4voMkQn3fR+OP74VVfdCb
         w2Wi2Q6Az3wxXFI4KnwCfAcHn9CGbzckViPKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unotCeI+jeIlE1s8Z495KMzeSar7HGNW9+QZlv24Mc0=;
        b=vUAT+juhkDO0sUoDQmDNNTlUF0V090xNn/05pJAuDmek9NhRRVgu3gIkPbd7T6LOno
         ig39Kq4GFyCUP6ElKZ0sgWbg81Mj4X73D6ZZYjyXCDXHrRqCtorj9ZVTNIS1AcPthJaM
         d+SDGoMXZRWbIKHfUSVZLxLKwUGYD2PNMT4ffsVHoDwUrX4Xh7powL9bxWGaM8LahKig
         uYdEnQ0PltCvyqAn/czxSoQbdGNGf7SDrZWYEa0KgXEenjjegovo4y1oqcRqSDpxFkRo
         WIhaiJEBJx1cH+s/amdhFhQgJYD+bdZykBIbHTrB06U4ez4TFJ2iCAfiCfLRzOA97Al7
         0eRA==
X-Gm-Message-State: ANoB5plsL43ibDq22L+E2LfzKl169nKChaK7QsyM+fe5kVcyiIs9sdd7
	4k3hAqRBJnKCNy0W7MYTIkB00w==
X-Google-Smtp-Source: AA0mqf5zbBn4zYWKsWWXd4ugdUWjcPVGndvzFtw4YUKhlueTCEBUHl4UpJ5zN1OhsT0rWKd51pNFQA==
X-Received: by 2002:ac8:100d:0:b0:3a5:2751:ce81 with SMTP id z13-20020ac8100d000000b003a52751ce81mr22369259qti.322.1668628587639;
        Wed, 16 Nov 2022 11:56:27 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b006ce9e880c6fsm10345986qkc.111.2022.11.16.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:56:27 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	rostedt@goodmis.org,
	ribalda@google.com,
	zwisler@google.com,
	robdclark@gmail.com,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org
Subject: [PATCH RFC] kexec: Freeze processes before kexec
Date: Wed, 16 Nov 2022 19:56:24 +0000
Message-Id: <20221116195624.124092-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_115630_518084_320E1F88 
X-CRM114-Status: UNSURE (   9.92  )
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

During kexec, it is possible for userspace to race with
device_shutdown() causing accesses to GPU after pm_runtime suspend has
already happened. Fix by freezing userspace before device_shutdown().

Such freezing is already being done if kernel supports KEXEC_JUMP and
kexec_image->preserve_context is true. However, doing it if either of
these are not true prevents crashes/races.

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
[  292.534467]  el0_svc_common+0x98/0x104
[  292.534473]  do_el0_svc+0x30/0x80
[  292.534478]  el0_svc+0x20/0x50
[  292.534481]  el0t_64_sync_handler+0x78/0x108
[  292.534485]  el0t_64_sync+0x1a4/0x1a8
[  292.534632] Kernel Offset: 0x1a5f800000 from 0xffffffc008000000
[  292.534635] PHYS_OFFSET: 0x80000000
[  292.534638] CPU features: 0x40018541,a3300e42
[  292.534644] Memory Limit: none

Cc: rostedt@goodmis.org
Cc: ribalda@google.com
Cc: zwisler@google.com
Cc: robdclark@gmail.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kexec_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..2614a7f1f8a6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1175,6 +1175,12 @@ int kernel_kexec(void)
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
2.38.1.584.g0f3c55d4c2-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
