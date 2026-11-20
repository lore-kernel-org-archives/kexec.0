Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3D60A2609
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R1AvLgvt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=xaF+rmxtC3GqtPJ6J932duj6LKs7x2LwNY6gfCcbaCs=; b=R1AvLgvtour8RFriNLp5I6JUU6
	o/57HM4fZqP5W4PJRMEgXrWNCoi1qScXUagv3yJE0085rW/WZUx5Vd3gpZhZ+a/eCwxjFBUfJziSP
	lhRgpwr5FZjkcTKzRFYrjjUQLKs27i32y901xK+F1n0v4JILqoRYgZ0zg/9nSyaT+CX08wscb932X
	g5m7a2geLw0CPIO3iY0EO2A/f0jCh1umU1Tm6JiI1z7t54P2ieAXA+AbSGX01yxUkljeY6uQ7ig5T
	pk0zjGpXedOBcBgSA7xvbZ5sXL73ws1Tlt3DTUUcNq6eWCV7JWCvZW9zKEn1+d7xybYbsedfpsIOA
	didjnA0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJRd-0000000EHSP-1JvM;
	Fri, 20 Nov 2026 07:54:05 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJRY-0000000EHRU-0iAo
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 07:54:04 +0000
X-UUID: 7f592de2e4b711f19a56ed5b684f684d-20261120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c329d75d-bbcf-4dfd-816f-13e579cbd64d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:73dd7473d614ad41d298eae4d82ec331,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7f592de2e4b711f19a56ed5b684f684d-20261120
X-User: zengxiaotao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zengxiaotao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1278361121; Fri, 20 Nov 2026 15:53:39 +0800
From: Xiaotao Zeng <zengxiaotao@kylinos.cn>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	duanchenghao@kylinos.cn,
	zengxiaotao@kylinos.cn
Subject: [PATCH] liveupdate: drop redundant lower-bound check in luo_session_ioctl
Date: Fri, 20 Nov 2026 15:52:52 +0800
Message-Id: <20261120075252.684604-1-zengxiaotao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_235400_570916_F1A27EB0 
X-CRM114-Status: UNSURE (   6.99  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nr is unsigned, so for cmd values below LIVEUPDATE_CMD_SESSION_BASE the
subtraction nr - LIVEUPDATE_CMD_SESSION_BASE wraps to a large value that
is already rejected by the ARRAY_SIZE() upper-bound check. The lower
bound test is therefore redundant.

Drop it so the check matches the one in luo_ioctl().

Signed-off-by: Xiaotao Zeng <zengxiaotao@kylinos.cn>
---
 kernel/liveupdate/luo_session.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 74bc66929f4b..f1b86f701238 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -413,10 +413,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	int ret;
 
 	nr = _IOC_NR(cmd);
-	if (nr < LIVEUPDATE_CMD_SESSION_BASE || (nr - LIVEUPDATE_CMD_SESSION_BASE) >=
-	    ARRAY_SIZE(luo_session_ioctl_ops)) {
+	if ((nr - LIVEUPDATE_CMD_SESSION_BASE) >= ARRAY_SIZE(luo_session_ioctl_ops))
 		return -EINVAL;
-	}
 
 	ucmd.ubuffer = (void __user *)arg;
 	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
-- 
2.25.1


