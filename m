Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70F0C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ll7acMLJOMX286Bwh4wefAJ0802S0CPbRzUFvGgJtyE=; b=zSzIyIYtwCRXH1
	AX4LgEFWiRoXQCVtuaTWGm4RWg3xM/kxZOEnZ3V8aeTn8sInEF9EeJt0ckFgHF+OukTx8mEt5lOrP
	5Zoanskj1txaWIIwQhOyfiFzGRX7lBZ9HqhoDoO3owZ5PizSKE8d60ZuES2q9o2VmN5Q3gb3EFqG3
	osUhCO+bXb/JMpfHl+uYmbPJK06rhaSiC4ozrbfDvQEmTNDxsdlvQ5zikrlmnZPVWkPEPRW9oRoxo
	VL6Pex7C8NMmNTCXpqtvBZ01C+VxT4s3uli+7r7dKWVPter8hHQmPsb2bAS5P8xfMFfkEtJIyo+eT
	oglFTSFvHoT7IZD/tvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2w2N-00GPLH-31;
	Tue, 14 Nov 2023 16:13:15 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2w2I-00GPID-1H
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 16:13:14 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40853c639abso45463415e9.0
        for <kexec@lists.infradead.org>; Tue, 14 Nov 2023 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699978357; x=1700583157; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJaslXnMkKNGe8kNkSR81TKcfbPuYkx4sjlNhJ0HDw=;
        b=BRzd+vo437BTNdgIQj74yUOH7ha3gZcmvGnVl7wJRgTRT+DpEhF6AxFdUxjJTShSC/
         CsaCvJQTzNfsuy5S6LSXWXzvk61R5cxel0vokqr5qZwZgz3yqcKka6r5sfoiXems8CYy
         PBBwKJI4jkBrSPMpBRwY4xnvj7g7isRswSvvyMfn8E1wcXM/gUlhcMv8ikTqNPWs5gYR
         vyV+LjydSBakqr3BZ6xo7AirRV9jiKbvKLA1UUq4nSrvleYYv4M2ZoanDgD2AmLo3p4v
         UFeBRGDoBcxfqqSMBo6gw9qVElQCVolM+TigV2TGAmssM6Ves0KTIRaken5+yBfziHnG
         coAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978357; x=1700583157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lJaslXnMkKNGe8kNkSR81TKcfbPuYkx4sjlNhJ0HDw=;
        b=OnePoK6uV+GwytLPk2CEHmQiM6sXKDe+qDMZd5ZwtDCIDk+dk7Den3ISA8U5sGblWX
         3xLSjetpUZJKlFJsYzUHTkejW+agT4ZA2AbKLszUKjllbvetF6PC7vT+VVRfun/h3IPy
         1tNypUwuEJGPLOlpYZVzvSpzXHyzihpjIaOlUqxUFKh5mHZ779OV73Gj09kIga+x2cgi
         Slq/9ZkEbC9g7g9ijbwGGLAyjbXqcadg998VZ4/EFyWFa4kgMt5YSYQ8VRmLSLzCLHJF
         LFBvhFiJc2+xQQy8Z1WZokdgsPbtviCEjtwESw9gTl8FjEjyAxZiIeMojnprbBzJVIDp
         z8XA==
X-Gm-Message-State: AOJu0Yy7sr2myeSMb2/aBh45gNQSa4S/fQOMb61ujpFcntWxl1q3K662
	zihu/KRkk+eH5nrfOWY3iCsWau4xInVHPQ==
X-Google-Smtp-Source: AGHT+IGaOVZPLVYWe8c39Hj42PrASP9mm7yS8eZ/syrTJwvPgC3uBBYGSmTr3QeOrDl7+76KO43EZg==
X-Received: by 2002:a05:600c:4f8e:b0:40a:3e41:7dd8 with SMTP id n14-20020a05600c4f8e00b0040a3e417dd8mr7451120wmq.13.1699978357319;
        Tue, 14 Nov 2023 08:12:37 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b003feea62440bsm12052427wmb.43.2023.11.14.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:12:37 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] kexec: Use atomic_try_cmpxchg in crash_kexec
Date: Tue, 14 Nov 2023 17:12:01 +0100
Message-ID: <20231114161228.108516-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_081310_455535_6DB56BF4 
X-CRM114-Status: GOOD (  10.49  )
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

Use atomic_try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
crash_kexec().  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg.

No functional change intended.

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/kexec_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..bc4c096ab1f3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1063,9 +1063,10 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
 	 * may stop each other.  To exclude them, we use panic_cpu here too.
 	 */
+	old_cpu = PANIC_CPU_INVALID;
 	this_cpu = raw_smp_processor_id();
-	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
-	if (old_cpu == PANIC_CPU_INVALID) {
+
+	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
