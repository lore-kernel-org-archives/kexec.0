Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2B9C4167B
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6Y6mSdubiKrc4Az2RxpXNezUHm81yXiPH/FKEfEP+Q=; b=QtZSabdQpbi85m
	rNeBXGZzL+zt9T4HY8cQGUFAw8m2iJVLRublhQUy9HxRChbzy6ZuBAOKKXLomV4Q0lF571I8x2tsN
	rNwsduu/DTQVr1wYdO6LJHNgK74Fi0VdkFoCnPGhxzF5UKNCHgJM+szYLeGXcgqemr86h9i+vR9fi
	KBz5mhgzIHEk5knvXcVM+P9UiwpgLq+UOn0E9awnMyL++MRnWtQF3WCX/9gtcNkRF0H9AF8F8OcV1
	CD34DQt6B7+UB3iupNiPt9B+4ApBbcHF2Hwo5CrfvZ2KAsQMq3njBXdEo/sJrCydCvkrw1X6T6xc7
	Cvhnm43c9lWScLG48IHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0LBz-001UNq-1q;
	Tue, 07 Nov 2023 12:28:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0LBw-001UMZ-1o
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 12:28:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DA0E66117F;
	Tue,  7 Nov 2023 12:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EE6C433CB;
	Tue,  7 Nov 2023 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699360103;
	bh=D1PYTQZiTV/3FHNcwcS5n1/vZC1HqQlHbF/tyBrUkkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8li8544GsDlRrrbHH96lSjt/upuvLRBf4rO7d1aioJmj2CbKd+UfqEglNu7wm2E6
	 1+nuaJjcPnH4QTH6NmVpypHomj7G8f4UrgrEbhpY1/muwRRX/wJOw2gMfsOUn7GOkq
	 anxWgs6YyN1KHm0k5IQ9I/dJrA2offxATeKKCE8OHsokMbXCkdXFcfr1OhgkJ1m1HF
	 RVo19DyF435rtYOCTAc/uHW8dgrwi9sGqfXosmjjnO/KffMDc74EzndP48VRBikenx
	 dbcDP9NN1NOVqkoSVMp1iJWsgmBzMuTQWrx6N/5w88yEBCNnmd6jo2xCDBmWCT6dwf
	 HQjg76Qm2Cjsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philipp Stanner <pstanner@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>,
	Sasha Levin <sashal@kernel.org>,
	ebiederm@xmission.com,
	kexec@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/25] kernel: kexec: copy user-array safely
Date: Tue,  7 Nov 2023 07:26:47 -0500
Message-ID: <20231107122745.3761613-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_042824_650512_047BAF38 
X-CRM114-Status: UNSURE (   9.84  )
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

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 569c8d82f95eb5993c84fb61a649a9c4ddd208b3 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-4-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c7..5ff1dcc4acb78 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -240,7 +240,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
