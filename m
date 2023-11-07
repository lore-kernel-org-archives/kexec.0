Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED6AC4332F
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/2lt2nH7LJAcka40Y6PwU7AOpawIeDqSyX590EZWJRk=; b=ZrKCCJ0/sztWHy
	EISGL4MoKn8LnF0wvTpmK8AuZ80Opx1rMlf5fqsC6kZQTrvlpJJFuO+k+rfPgiSvBvdhyISPL2P3X
	ouCBpmj786BBYAP6/qeJz1dsNrs0eAPoLdt+/33mlhIYk7mwO0z+xWGp975zsYXeM9J5++mcsdAl1
	fXgST4W77YIUD1Lxf9GdubCKGbvY5wY3ln+CxTcYRB65AKUuYYxfm0NrjCWaQqspr+vFOpsgNpRFL
	Ezb18/VrMth3RiqVVRSu/M+iDyq4blSJYCdm4+c9rWu2FfexmU9BDX3Twr2+bUqm99wWGC47UG6lb
	+ePrLHR3AfnkSdD/Zbcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0L9H-001TSV-1U;
	Tue, 07 Nov 2023 12:25:39 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0L9E-001TRV-2Z
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 12:25:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 63653B81691;
	Tue,  7 Nov 2023 12:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE1C433C7;
	Tue,  7 Nov 2023 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359934;
	bh=Ac4qz2ssxrPK0fi2tPq4579QhMScQX00ZzqG9yAO/Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHm8Fe4cv2Kmi+Jrkb+RQkiy9z79d3vfjV6Uu6Y24WtEOLRilLxsNBOC007hAyGo1
	 RO1ap3AoLJstmBWO3l/XgYJQAfMYLQT5n+VpwkC4uCRngtIVHxrUBjK/RnhrC4y1Wr
	 3WNIS+hBTrwvgYihKQpt+E0JcTY8JUcRsOX7ZAx/u3GTAf/iqGHBh/UB7ZDrDplef7
	 TvsHkipBXJXLzfuRVQpNCNYcDwbpST3hhVqwEkQy1CkjJ6RHdzm3+HEhPW+XwnL+Ci
	 g9icT9gw4LcaMAdkVDYM9y9U6eWZzZA+AtAa7TwTpw6mJCo3QSKmL8kzLfKMPw7CPH
	 Tg2LEA5tlOWxQ==
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
Subject: [PATCH AUTOSEL 6.5 14/37] kernel: kexec: copy user-array safely
Date: Tue,  7 Nov 2023 07:21:25 -0500
Message-ID: <20231107122407.3760584-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122407.3760584-1-sashal@kernel.org>
References: <20231107122407.3760584-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_042536_984547_5917746D 
X-CRM114-Status: UNSURE (   9.76  )
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
index 92d301f987766..f6067c1bb0893 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
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
