Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08440FDEE55
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYNhBHB4Fa23TFERZL91AZqtbkE7rN6kiCnLilTbtsU=; b=RRF/ejzge+hyEILJBQnsGimlXH
	d7LBOwHtKkrMhke/w5uYtsXZTCZu7hiEt269+CznmSsu2oKBw+p7Iyox3dHR4EeaXSj/7yJFONH5G
	MMPjVTtQdYJvzkS9oXofsqGi9Y+kuM1zlrcWuN7hBCtZbOHigjiKtrRmWuX6d3XnpucLHe8Ej+XFb
	L0a1f2uor1li/SxbZwve/GFRQlRFgDquekPx+1l+eRLPL5jdNwKOup2DMrvT5Va6NIfCQzn4af/Bl
	2Krc42rMAbDdLshHDW9fhpLaI+BfijhPt3obQKotjTMcbZCzydp+ZWSn1ZwM+fUPuOZYOTLToO9u2
	yrDD69jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n7-0000000CQA2-05ST;
	Thu, 23 Apr 2026 23:49:05 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n1-0000000CQ8D-3jzg
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:49:04 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43d74086e5bso7008455f8f.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988138; x=1777592938; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYNhBHB4Fa23TFERZL91AZqtbkE7rN6kiCnLilTbtsU=;
        b=VZqLm8GVOILvvSPtUOfNA6HB1Sc/Uzk3+TMKluPJYEqd7r19uPHoSNx4UvM70Z/cb9
         g2fidKfSJ1VVW4fBZCe5WmLfwyvpBbmxSrKkj2oRgubICaWGMbVBjGjbeNA5vf7Spye+
         sth669ObxShblqbjINHLUjrzEomaxY0L3h08nbEBaYKbNbKJo148jxJORWFDomJuYl1b
         vY74FjJVTgGJbmNheO6ZpO/0ZK9pb2SQ4O2IJV5fMGXAd7S4X7cU0hXneLepDhb6VWz5
         J80QZ/C0mnLQBVkO85o4Zr4wVLDq5emo/+8GuIP55hC1/WEUXzp9Zf3hv70fGSkJNVpb
         zSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988138; x=1777592938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYNhBHB4Fa23TFERZL91AZqtbkE7rN6kiCnLilTbtsU=;
        b=dM8JjuZGPaPI4D5DbWwpQAVVqCev4vDkgK2JAYIL1DUc9FgFiDoJMt4NzIl50wJYNx
         ULN771rTBQ/NQoXAPUgj6CU6ZGzZnREMrU1hp1n1jM1pUzPBH7sVY1ePqhBeUWv4HctM
         owBuIZI6uX4RBqArakMRpzlfJabhzZdb8IPRMx2s8utKIS+fYMMsVcLtEkRgA8WUwYVk
         I+WzVoAov2wi3WGW7FzSt2xuI/0PEvgP8A3VKEdHmzNmXIpQ8cVeplYKO37ZG+UPuZ6i
         AjkAU07FIeofxNNNmLSapmc3D9YBzmYd7fooknpQcuQ5yOy+GtQirQgMp1BlfbglWZn4
         gmJA==
X-Gm-Message-State: AOJu0Yy176bA4S39+af5AvFeNWoEj2/ULK91AxlQRuhNmRCSE2vi8Zj/
	IbHQ8CI8HiZUyEU5kcNzp4KZ8Vjq11C8lNJpwGD9UmkK3x/QfIQUzLn+bYWT+w==
X-Gm-Gg: AeBDietBnGQq0wcFJMfpZc8j7GGZAe2PHipYLDz+vObx6lRlNZbMo/JpmiewlV7UGJf
	CwD5dSDA5YNzASjF7fhqzzxvUtvjSFU2IFWtJMDRx4fPQH9/aLF6UkaFlZdf+evOB1cdWBgOtuo
	YsC0oChcQe0kias+rSh6SKtG4DuxBLZrb7+t7+ZEcsUo5/nWZLNmjl7AStTCVxJGdPge15Kk5cw
	0Cy7Ext0W1LV39vnjaJsUbOGF9cgTpDTmBcoTlTe/oskSfgHBPVAo3LxqchyGcU+gvGLsRJpMLL
	8KVGsVyPBQVDeygWNh4CI7o3hxW9c406lvCODJGPoSuAmre3fhCSwxFf5207tmn6zFXtSgrBr1P
	AWBVpV04nqeDH1sf7JTqZQB2mWG1PBP23WQrFuGUmdgkeEpJW2n4BEi7/PQzQIUnx1M9oQT7FYi
	OB9dab85EKnpRnxl2PF3Fk8q9W2w1p1wbyKYTQEU8=
X-Received: by 2002:a5d:5d0e:0:b0:43d:7883:87c4 with SMTP id ffacd0b85a97d-43fe3e17215mr46363156f8f.41.1776988137621;
        Thu, 23 Apr 2026 16:48:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e8d7:434e:1f34:2cb6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cc2cacsm55713327f8f.13.2026.04.23.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:48:56 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v10 1/4] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
Date: Fri, 24 Apr 2026 00:44:20 +0100
Message-ID: <20260423234753.3873095-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423234753.3873095-1-luca.boccassi@gmail.com>
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_164859_936754_16D6C4EE 
X-CRM114-Status: UNSURE (   9.67  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

A session name must not be an empty string, and must not exceed the
maximum size define in the uapi header, including null termination.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/luo_session.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 25ae704d7787..5e316a4c5d71 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -382,9 +382,13 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 int luo_session_create(const char *name, struct file **filep)
 {
+	size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
 	struct luo_session *session;
 	int err;
 
+	if (len == 0 || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
+		return -EINVAL;
+
 	session = luo_session_alloc(name);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.47.3


