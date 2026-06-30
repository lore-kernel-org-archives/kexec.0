Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED845C43602
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=; b=zq9n5YuS19QJ7DXyAoU0+DsFro
	kpR1A+HL5wc/t6GhBX4Uy5qwQGA70AC7L5NbDTreawCgzZKyGdq44Xu5O2TeFHoes0SLjg6wVK/LT
	bL2WzF6WRL2Mg+mZi4RtDALBFhM/WD7XzcJ277tc6P9v+a1YNP7Fa7B+nIfH/M1v+0V23mhMTZH8r
	VEgR4pMcGm9w1FP4iXrcS8AE+N5vHx9tSuAY4okb70ZKf8m3Pa1G2pBz/u8Ry/eTerieS26Q1dWKl
	7pFcrZMO4Ow24AFD5P7jdQLFdKd3WFrrfVOulPakKkivWHP+B8QqzqsSrPrRAKSCDRFjOI1GZGqjo
	RpC86U4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTC8-0000000G9GZ-2PlF;
	Tue, 30 Jun 2026 07:47:48 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weTC0-0000000G9E6-0Fu1
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 07:47:43 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1818006a91.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805659; x=1783410459; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=T1wSBuc6g2j0NttgVPFu6Jp0dmBuMD+XRqQTk7l+VY8jsXNfUJ3hlviPxU8Ct0G2Ad
         psOLcavGd1g21/gEusyNj2gLPZUzQE2mD3jMbbdmndAt+du1SygmSoNpY1bjnzhChcpe
         tsJ+CdNIlXePb2hvIqWC/4Rv8ym4+vh4qosIxfuOhOpRkl67BNHQmTMo03uzmYMgsMgj
         AvRmjmOhY/7U8AwsIn0Vl/MIMh2dU4oepyohJ/q/p5mh52KCN+v6ElXcjefQeRdAPvl+
         PELofXxnenmTXcjhZevynqNgGCKfKDmHyiY6Ag8gsES3hA9ci4u3qzHHLtG4dviVTWpf
         S7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805659; x=1783410459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1eYeJpEHCAPY9Qi4Hjh6YOaoS1rocMPAJ4EFRgZ7L8=;
        b=m2dzBa2bcb8bmJNeZdmrb1HlPryrLqRS8qdlMfpUI4pIkWWljVbcYYWPsr6V+9QqYg
         k5ptWBypc40AOdbebDuqFRXKih5puzYv8FjGuMi8kYnfaDI38D7hNHQDlYUKCFaq5fUi
         a7D6T1hPo21oNHAQyNZc6Z56Vgrhs8WwwgZpWDnvu0vRKPfTggB/DhbtpKzA6o4v/dMs
         5cs1mlYgq65UQAH4IK++iwUfyCC43nLfv1wDYXEr88+8R+Irhwkd7hdxlvnteYTS9Svf
         EX5r4bgMHMHFCHuskt5BXL8xU6jTxSJvDUe5pf2xOXomzyl45FmNqJK3TenTYhwHuQJW
         xolw==
X-Forwarded-Encrypted: i=1; AHgh+RoCB5Xz8MKJOrxU96sNSX29D1j2yDp7Ba0+gnK1vq6GUk2v6Q3fy4oqBhleGRLivhQ4ux0Hug==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywee5oo/rGRl9aGmV3SSsKqMGUldYJ58m7+8JPUb7bx4/RJSHqT
	ZwF5DuKK0OhYX0+7u7Zpj9pvFMhoymmZCuoN9NaGw6jmQN/JU6bl+J/D
X-Gm-Gg: AfdE7ckJzayJBUMdeXWcV+zHqoghPdmbvbjpYUTwCL7Jg4azjV1hScrSX7eTY4Bcgwf
	u/639btvMft6ieLX//JmZ1wU2HpYpX2RTmPgxkRlW7tAFYF1rr08pPd7ID2aolMn/trGAxxVwJS
	ruRWNHicp34epMoAJxuRMgwxTzNne3Q6DXjw1p3GmqLary9vjnMDAvjRvTdTcBrbVRimmpjgVY/
	jiJk3U/8f6uB+BjpxKJzVdIIjJ37f6EwOisNGkec+yAztm/cxuIrv7/F4Fjt0Z1LL9QnkPqnbaF
	kkxOfbk7GdUEL3UT/iKnav+befT0NBi2F7MfsCgObhykPOZdIys62w8fWsY+5q6cx77pVO8LxjD
	OGmJq8r+Taxb635b+4xyqWHxfNN+xYMwpyC7r0F3/HAb2CAaJVgV4J9wuOAZBOrKUVPk225EMEU
	VXMAmDFdS/XJ2W/DLlJ1Ai2NNXtQ==
X-Received: by 2002:a17:902:d58f:b0:2c9:fa31:850c with SMTP id d9443c01a7336-2ca2ea33e96mr19629385ad.39.1782805659205;
        Tue, 30 Jun 2026 00:47:39 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:38 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 01/10] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
Date: Tue, 30 Jun 2026 15:47:05 +0800
Message-ID: <20260630074715.4126796-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_004740_096892_5EA03F1B 
X-CRM114-Status: UNSURE (   8.82  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Wandun Chen <chenwandun@lixiang.com>

Prepare for an upcoming change that excludes non-dumpable reserved
regions from the kdump vmcore and will call crash_exclude_mem_range()
from generic, non-arch code.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/linux/crash_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..0033d4777648 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -87,6 +87,12 @@ static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
 static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
 static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
+static inline int crash_exclude_mem_range(struct crash_mem *mem,
+					  unsigned long long mstart,
+					  unsigned long long mend)
+{
+	return 0;
+}
 #endif /* CONFIG_CRASH_DUMP*/
 
 #ifdef CONFIG_CRASH_DM_CRYPT
-- 
2.43.0


