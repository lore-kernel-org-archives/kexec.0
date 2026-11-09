Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1E606A323
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sJGbFXYS;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLwFaRxj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=+qpfaa8PB4siPyxqqKNcOFnVRd7Su/+oqhhjIbgVahw=; b=sJGbFXYSDhNQfqBWSegxYb/BcA
	PwahzaAQ/J5gkt9GOJRSa3wXnCglszmJ9mPQdoBKj3fAmIrGOAgQiHHAiTCCkiRq1BUQt/lmCgvJF
	Cu9l1dKZN9O1nSiuW5RzXPNSo8+xaoVX8T4aegsvIYrvsPbZ9QPueCeAXZhXQ+DI+OH+hST7tWZbJ
	uZLhdk/3JPqTPIUBHi2WnxFCOVFcV35bll5XjmKzq4do5rhMkJQr1ziuxGaVci/s7qkgnWz8m/eUb
	6TXB1sG7QnhY9MsjOv3VmcVgART93ZMzwIfijLhUk3z5fUaoizBGGMRA0cEFIv3TTVhv3SXPr19Hr
	7Bl11sqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQKG6-000000000mC-3rwR;
	Mon, 09 Nov 2026 07:57:42 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQKG4-000000000ls-1oXX
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 07:57:42 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso3324825e9.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211058; x=1794815858; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qpfaa8PB4siPyxqqKNcOFnVRd7Su/+oqhhjIbgVahw=;
        b=DLwFaRxjAuSej791DTT+HWh9Hdw8U51Mb15BvoxGDUWexh7o4lK8BCzyFWTXjg0VHh
         CABYoMBJWss6yJro3FSIJLMaq7POA+fIhcbk0b7j4Gq3q6+qe8EPakagLhtrHqtZk+zl
         XHBYvmvDJd5WfnfkUhwkvubI4Ircb1MtpsAhLBiSTyNXKmI58Ox+xNgqMPmXBCpLMREw
         KpfLfxeF/Yc8G8llZXWp4nrqnY6mXjPhZWEcJA633bg0goHbCr3XUaD1HhPrpuRPOzI5
         V5Yq7vyeoYFqrrJrm8w+zY4Nvs8xXs4r+VbFz1zywumm9Wx9S0HW5HNc7ikPS6XZmhop
         4MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211058; x=1794815858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qpfaa8PB4siPyxqqKNcOFnVRd7Su/+oqhhjIbgVahw=;
        b=db/Sdaqcu0qS2CGKu1fLcAuGmvbwhpeus2h05JLUr5q5hse+TPXUJSoxRvLSGZZjtt
         YUkQ7f8NrnSCRdXcxQxvgLj1GY/0lIhrNDNDCO9+Fd+mIYdYNabLuNiCQW9wfxoUJZZB
         IQ1uEz53l7WDj2MJu8f2Tnlws/7gRYPA8ly+YtZY5t2OKNmNyjiqdyAWySMmhy7a9CzJ
         lDTQyT8YEoDIKEwr6dES6yxpbbk/EtqwlnVsOZ6e8BD7eXGWFW7xZgIPBgT1cITUZEKa
         2ilkyFgyLXy3BdWtNsyAbNJs3Vv1nx4JL9vXeheor3JwNmMdUD8YeYUvWnpl61PSKu/8
         x+6Q==
X-Forwarded-Encrypted: i=1; AL+hErF8jHec7UGcDgDgsZiE1LSkyL0HrxxFfi+NKzGDj78UXo+xmyaWELrmf6J1QEAVnGcdaqggbw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8JPtU3AK+vJqkiMd+4l1kpVAOe+kQjlD9u7CJiuUwkKWDGsEHB
	h+ANHu/Uoih7gSjSawd2iCox7szbQc+CtBRG23wxcTgfLQhxVRWVPuQQ
X-Gm-Gg: AYBFou0GrpUDGFRRA9ib9TKwVcW+PQuwjwqXkUEPRD7x5v+qUDqGn2HxEj72xuNkmSv
	bFrbCmr97b7nlCXcfL935lAV1n9me3pNRKEaSB4cWu3Hi8q6jNVuWvAZGui8K5w57XZg0WjV11h
	7Vq3etQ73ASTj39ByZUG0QLcKIz3/ESrJsTyMxJgnCPcblAaud43IY6ur+XzEyOwfV5v0iGrRE4
	u6HQamJ5DNyEe4V+U1SXEskv4zUsoxAZFPadRMMMWviIJr32jiOESCLZ24+ww3IPX0IkMqXU3jd
	dlU+23bT4BXaMCshEMguyknbFayAieLO0r3WYH4HNEUhvQwai66hngLVPzSoBQ9hfACT70yD2+v
	oqSMD3wKINBJNNDdITytywNdIr+GdfcTrMW9za+W8tGHlAbExsO16L2ZJYo9F4EGRR/2A/4egQD
	qU9y0YMaWaJpbzUashkiHn5KN63xJZEOp8EQoo5jpbtew3rXPEwDJ/ZTWvTJ5DekkaZ4zw4APm9
	hV71AA6uC6RYrVN2P2ClCq3nroTUB1Mrm9RSouYHwD7fnoswcBIJFsAG65AxHeDSiCycH7coiu6
	AbXYZ8I3cOAmOg==
X-Received: by 2002:a05:600c:c0c8:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4b960d9c6afmr43080115e9.7.1794211057941;
        Sun, 08 Nov 2026 23:57:37 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b96cd012e1sm107949145e9.8.2026.11.08.23.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:57:37 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>
Subject: [PATCH v4] memblock: don't allocate new reserve_mem regions on a KHO boot
Date: Mon,  9 Nov 2026 08:57:25 +0100
Message-ID: <20261109075733.9051-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_235740_490112_5FF9C171 
X-CRM114-Status: GOOD (  16.12  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Pratyush Yadav <pratyush@kernel.org>, Mukesh Pilaniya <mpilaniy@redhat.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a KHO boot, a reserve_mem region that can't be revived is allocated
from KHO_NOPRSRV memory, which includes the bootmem the next kernel
boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
then fails:

  WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
  failed to prepare memblock FDT for KHO: -22

Without it, the next kernel puts its memmap on top of the region and
the ramoops records in it are lost.

There is no use case for adding regions across a live update, so fail
instead of allocating, and drop the TODO. A KHO boot with kho=off hands
nothing over, so it still allocates.

Add kho_is_enabled() and is_kho_boot() stubs so the memblock tests
still build.

Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v4:
- only fail when KHO is enabled, a KHO boot with kho=off hands nothing
  over (Mukesh).
- add a kho_is_enabled() stub to the memblock tests.

Changes in v3:
- add an is_kho_boot() stub to the memblock tests (Mike).
- add Pasha's Reviewed-by.

Changes in v2:
- fail on a KHO boot instead of allocating outside bootmem, as agreed
  with Pratyush [1]. this drops v1's patch 1.
- not an RFC anymore.
- based on v7.4-rc1.

v3: https://lore.kernel.org/all/20261105213153.9572-1-azpijr@gmail.com/
v2: https://lore.kernel.org/all/20261104204235.9066-1-azpijr@gmail.com/
v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/

[1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/

 mm/memblock.c                     | 12 +++++++++++-
 tools/testing/memblock/internal.h | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..0f466fcfc719 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2827,7 +2827,17 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_kho_revive(name, size, align))
 		return 1;
 
-	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
+	/*
+	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
+	 * which includes the bootmem the next kernel boots out of. Only regions
+	 * handed over by the previous kernel are supported, unless KHO is
+	 * disabled and nothing will be handed over.
+	 */
+	if (kho_is_enabled() && is_kho_boot()) {
+		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
+		return -EOPNOTSUPP;
+	}
+
 	start = memblock_phys_alloc(size, align);
 	if (!start) {
 		pr_err("reserve_mem: memblock allocation failed\n");
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index ba4d1c02fde5..a68124d76b10 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -51,4 +51,14 @@ static inline bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
 	return false;
 }
 
+static inline bool kho_is_enabled(void)
+{
+	return false;
+}
+
+static inline bool is_kho_boot(void)
+{
+	return false;
+}
+
 #endif

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0


