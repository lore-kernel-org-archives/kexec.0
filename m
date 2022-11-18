Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD01C4332F
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cEDvfxeY1XREN9OZTzvkoB70oKn7KSVRb79SeIWLhgk=; b=iG6yK4gFIu1QOr
	/k21y1rVtpT6MUnNb5fSfQy1v9asrUwg7LJFgWbLY+h28FO3jBE8psiW++v9njJHfWDLR+k568Fss
	OhyKkgUgrRX2BTt+OaF4V3ZYqU+E1P5XYjgQ55WjkJMm8g8rqis7MhvRHIhwMeFnci+BQL8uP7dRV
	VfSX9C+HkFdJukgDawtSZlhnRz+2BXYKI6QauX/p3yP3ue56T2iIY3+NE0QbKQFIuU4nkkhI+SHbA
	1yuH03qHZ5bSWWBU+snc/iaXxQd+N6jHYgUk1Io0rt/6rPvDTFTvxUs4Lcpb2++beqoEGU+I/gGpH
	qlZ6/BJ288EMLgHcYcrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow5zU-006PxP-4h; Fri, 18 Nov 2022 18:21:28 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow5zR-006PnX-Aw
	for kexec@lists.infradead.org; Fri, 18 Nov 2022 18:21:26 +0000
Received: by mail-ed1-f50.google.com with SMTP id v17so8259630edc.8
        for <kexec@lists.infradead.org>; Fri, 18 Nov 2022 10:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHmImcxL9iAGolOt03jkw6rJfTuUpPgbG+NBQw+du2s=;
        b=qfdSTviYNXVgEe2DAoyLMOdUXVJvhBO8YYtfGwGtvjjRjsplDjVuqirRNvzTdr5uGS
         PbwNyj/+15TpfplWmxj4tlaGEWfPzwbUxDH/wEU9VgfY5UeqAmnmDsi0UnsnDNw4fmly
         jmcXhH03MjOvEjgKQj90NTHm07yDSPIavWVahX3v1t3sSUim7ZjiKvGX8KrTxuqffjPn
         iHkPOagsEQBilzQ40oMzovXCsjWWS/Bb+Q9dZ5Uyo59VK5+YzpUl1GeQuo6sYguKJiZ7
         QLHNYWXC/z+S8GCUzC6JPLCPx9Jn9g0tmjuBuZVKVRkVqi9u/VqOZ/Rob/od6vmRPeBw
         tZLA==
X-Gm-Message-State: ANoB5pnZSxJlfTR6yP8ufGU6C4F172sLX5GquwKznym+aZkcWB8oFqi5
	0eeV/6RcKBcJtHnUnhesCj0=
X-Google-Smtp-Source: AA0mqf4HW2cAXN/7HLCIYFLfjr1mzfd1wiukbYq7stG5qjmDRAjC2BaYtWfR5PlsJFgCOk7E2B5o0Q==
X-Received: by 2002:aa7:c9cd:0:b0:461:891a:8162 with SMTP id i13-20020aa7c9cd000000b00461891a8162mr7061262edt.398.1668795681705;
        Fri, 18 Nov 2022 10:21:21 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm2078506edt.66.2022.11.18.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:21:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: x86@kernel.org,
	cascardo@canonical.com,
	leit@meta.com,
	kexec@lists.infradead.org
Subject: [RFC PATCH] x86/bugs: Explicitly clear IBRS MSR bit
Date: Fri, 18 Nov 2022 10:21:10 -0800
Message-Id: <20221118182110.1903650-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_102125_405528_6CFCA7E2 
X-CRM114-Status: GOOD (  12.84  )
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

Currently x86_spec_ctrl_base is read at boot time, and SPEC_CTRL_IBRS
bit is set if CONFIG_CPU_IBRS_ENTRY is enabled. There is no change in
the bit if CONFIG_CPU_IBRS_ENTRY is not set.

This is a problem when kexec-ing a kernel that has the mitigation
disabled, from a kernel that has the mitigation enabled. In this case,
the MSR bit is carried forward and not cleared at the boot of the new
kernel. This might have some performance degradation that is hard to
find.

This problem does not happen if the machine is (hard) rebooted, because
the bit will be cleared by default.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..5b59e850de6e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1451,6 +1451,9 @@ static void __init spectre_v2_select_mitigation(void)
 	if (spectre_v2_in_ibrs_mode(mode)) {
 		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
 		write_spec_ctrl_current(x86_spec_ctrl_base, true);
+	} else {
+		x86_spec_ctrl_base = x86_spec_ctrl_base & (~SPEC_CTRL_IBRS);
+		write_spec_ctrl_current(x86_spec_ctrl_base, true);
 	}
 
 	switch (mode) {
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
