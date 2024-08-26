Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F19C5321E
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iO9fjemOJ0AliSmlp2sM8BIq5kMNcNxgZdY6DI70OIQ=; b=t3Bxd9vGno+LlI
	njQ2EIsyjiZHkeriSNK+e0N18wpTl8kBOeB7bvUqdFqrsDryjL3NkrlsEQQQYT160vWj4ZeSpInhS
	hQUXNNoPqF4zujGuGAsUvTsmxEXXqJ4SycLktuRP23XpBn0eZtPasRYMDQq3+fqmrwAKzz2fnrNo7
	Qd5l8SAE13nBAme6pDdmhNlxc33k/AtQ42GBzCKoLufxO1y5zzzrdCFCiD1BqgGQhbgjjv6+Z4Y63
	n0u4lj1GdQJ55ZHexEWWWIWjbkuFYBhnTOS1QpEorEI4d68aVUpK1UqrNk+7HtIkvseeOBy9NYHkG
	oYc4V3p8j8oT1FHWTnxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siTex-000000068pb-14zs;
	Mon, 26 Aug 2024 06:57:03 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siTaj-000000067gN-1aP8
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 06:52:43 +0000
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8783B3F183
	for <kexec@lists.infradead.org>; Mon, 26 Aug 2024 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724655158;
	bh=asTw9btpC4r8oJmQ5fgUFJi1d1/GY3upIlP0o+wvCJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=p9EeorMJanp5b8MhTaSguZLNrKbr5CH5lGMpe3DJRNGuqAMmoPLvpHS/SIyuxA/Pj
	 0kyilzLJ9cY6ICqMYwrhJGVupVZsDFFlk2U+tZrWItxSDI7atNeXI+kEesf7rHOzP8
	 Qyb8P3fgtGzOuEznckBM0AqswySJOncVNFrZFBHuvzLWg58FbnAgQxn8blplLjSGmw
	 yXsGBNOiMJYjz4rPeXtvCc0BUcI0fzpiOZA3RvFFLKVgHcQ8TQ9Wsl4WF9wDZvMfEQ
	 XqFyYCs36gI1NduN+2ASTLwU1mxS2BzeDuHvMBC4UzVJjvEOJ3N+hLMbBCMVNaf6yJ
	 A9Zz1UnLdXiGA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7163489149fso3901277a12.3
        for <kexec@lists.infradead.org>; Sun, 25 Aug 2024 23:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655157; x=1725259957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asTw9btpC4r8oJmQ5fgUFJi1d1/GY3upIlP0o+wvCJA=;
        b=sAgMqSdyAwh2RzgdJl36st18Lq2+VXFW8W2IWRd5GlDt3XyTIVyidkbX+VGFJpWnfP
         jYHEutuvg1gw+wvNl5shHaB6ISCtNpAL2lsF/cWFKN6yJzEcDts/sZWIwtMU/+LPclXl
         +z6AAtSqIQ1FNBboncsHURRdDVFfnCkQZR7ROw8zwTnUYCD1F0z63n9cL02Lb2V5qqNj
         1q1OxZOYNtosp0WjVHY9+6hnGnE7s3JEFDIvccZDSoTutgob5xq8KmK8hYQ/JFfi1SdN
         j/gek4uQzjErlboAzo2lx3p2JaBtqtQO5ifSEsa7iuSQ4jXJpZx/rBdAiLYlhNNX6Fgp
         3xXA==
X-Gm-Message-State: AOJu0Yy7uSoHTif+1IQAdutRe/YQQXYmSiu7TGgerTK1oSsYB9RXX0dA
	HtUqECPkU1axNtECP5k/EOf8JR6zS69V6E0hJzRLHgIexj0PPI1sDFboOZprtwRkrKuSwuPBZZq
	rragSsPAsbBVwtfdfsUMea8rKsyzaAlPBOhZpEBM1WqtYi+vxJ9poYEmJJND1cGXzRkN3mBtI8w
	==
X-Received: by 2002:a05:6a20:2d13:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cc89d7dde9mr10964929637.23.1724655156910;
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFshnr0yWWoq+ZC7FQTS4oA6OR3ojKB+L5NDCHocR3E+oUvuPt3+dFTL8nGph077xQHw8MRMQ==
X-Received: by 2002:a05:6a20:2d13:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cc89d7dde9mr10964901637.23.1724655156256;
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09c3sm6472207b3a.122.2024.08.25.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in vmcoreinfo
Date: Mon, 26 Aug 2024 14:52:02 +0800
Message-ID: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_235241_642669_39FA5D27 
X-CRM114-Status: GOOD (  11.91  )
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

Since arm64 supports 5-level page tables, we need to add this
information to vmcoreinfo to make debug tools know if 5-level
page table is enabled or not.

Missing this information will break the debug tool like crash [1].

[1] https://github.com/crash-utility/crash

Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 arch/arm64/kernel/vmcore_info.c                | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 0f714fc945ac..557a1cbe5098 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -466,6 +466,12 @@ Used to get the correct ranges:
 	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
 	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
 
+pgtable_l5_enabled
+------------------
+
+User-space tools need to know whether the crash kernel was in 5-level
+paging mode.
+
 arm
 ===
 
diff --git a/arch/arm64/kernel/vmcore_info.c b/arch/arm64/kernel/vmcore_info.c
index b19d5d6cb8b3..be65d664bdb7 100644
--- a/arch/arm64/kernel/vmcore_info.c
+++ b/arch/arm64/kernel/vmcore_info.c
@@ -7,6 +7,7 @@
 #include <linux/vmcore_info.h>
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
+#include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pointer_auth.h>
 
@@ -36,4 +37,6 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
 						system_supports_address_auth() ?
 						ptrauth_kernel_pac_mask() : 0);
+	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
+						pgtable_l5_enabled());
 }
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
