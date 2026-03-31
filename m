Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D666FF60F4
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BO7Q7fJTvO07jMNB/2HEJHgEeGh8y95froHiw59EioI=; b=t98suRcUq0zNtYH5S9B21/zuka
	bKLZQTQmmGWGhzWR3Xsob36G68F3Oo5GXwVbW1YCeD+M1L7z1Es+xreqSkEItGalDLJ2d1CNgrVlm
	HmV3SofKNs/wDmAaR6iC4JooYUIqrZ1RjTzIAXjmJO9RZRBz0D2riGOuHdHl875LpCAoBP/WxIByP
	Cl3D8bO0jbPkysaAG2LgkQgCtHOfWvy+GOaiWxtB/J3jh9C08hDLFHfAY+wngBpfzVHFKWuC8HIdR
	aZHCWxyFXboEUuaHUyuhL6mtlvgzbSvzqpFyUtEgW152GdVhMSKdqyi3LhqqqbeJrcuSc/SWOZLgb
	WBsl0PVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dIw-0000000DN9L-2nl0;
	Tue, 31 Mar 2026 17:55:06 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dIt-0000000DN8z-0ZnH
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 17:55:04 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so3364305e9.0
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979700; x=1775584500; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7Q7fJTvO07jMNB/2HEJHgEeGh8y95froHiw59EioI=;
        b=p2HBTv01sZ9RXo8Neu7xwduNW8BsWBgrpxHDPTSKMJVjcXpFd3dXxATbSo6P4JdE/h
         SW0tnT45It6g69a2oaNu4ZCPoofGDMKbe+sGXCJIiKr8L0f7O+yfbfAOyPR1yxderwKV
         XNPAJLWVEww+hYUM7/u6fuNt7pbOlBLIvDS/Jd3qzZ7fz5hxn2y+WazEHTf+oqcu79IC
         XWPqis5V4myf9h4oPgzcrYiDTuO28hB6l2hfDdXbin5i1B/eq5ilJRhIB83BOJOly8oS
         0jGwYrfkqZkdfzft7swwNzHO5fE4R2DFrO+6V5cvc6hX3mKROwMs32HY3AmuQ7hjeQzz
         a+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979700; x=1775584500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO7Q7fJTvO07jMNB/2HEJHgEeGh8y95froHiw59EioI=;
        b=nL0JinRj69EQKmAwqBstuDkwgQCzHqIcfM44hLgf3eo/HAM8qsqFeQFa5t2GCZzGNr
         cO9W9Xf/WBmExtArTnh/5nSjcyrwj2iiMtw+eFWpbxmsvrjcY0e9UTjEytKEqiIxHCQl
         VLa46dvL2vGrJqF/BRe2APJCs8shfVkyrvhgHnJHHOWquqjxvHOzX4Xr3jpMigbmHv/z
         XTlcNHkGusmV7MGW6bO0jTe70NkuLcp+oDkbuQ8Ua+Yc/9qABbkdcG/hpBYTgDXO0dId
         Rz9oWhkmdmImNJq9JyUdeVOdRoptXMC8+lqSZXZt9C/Lher2T0a2Z7pYdxGGQcWZiiAx
         l65A==
X-Gm-Message-State: AOJu0YxJDX1aH4K7BvgPsjJKRvg/F/6Yft4RDYFRgKMJJvXfHZegp/Hv
	Q21i5k9kzKZfJQuOpCuAG70mPlm1Mu9sAn+MDIf8t55gnz6AHGyF1lpVXusCCA==
X-Gm-Gg: ATEYQzxPrPrnDv31oBaiO+RqLyWCZTIZSKIHAh3AnsGAcxauSUWDi186hqbrXnbGQVS
	zXcupvfDVzMG8OQcubWY3eDooobGZY1HauEOfAfMhRRSL/CzbuaQdCb3nF0tevbUBazOaoBd+Jm
	Y0MJ9Oly/b3LyGshsPPU50mCVzZy/Vi+bgcCRXfi4f1UHo+zYopnnX2JxRosb6GTmXnXR1+fhi9
	8EZ9d7ZcrpL2mWb+rywvShnDp+7mtCOjV4QbQ4RyC6lHKuYzh+2fQFAEW9pWI0YyAVdZvPWp3eg
	XYqqGxFYhbm8+uSUjR8CoNQ5tl25uV44pMgunOjBRJlhyJ1CCG2cYd6FR/6mvBj7g95TJ2tRXPW
	TcvZOZrL/FpIOHDr7kI+aCEXvg9NN6LRYDaRb5tdqe+vgF8/SBsno8m9vQPY05X6jpkZvUf/Scr
	A2jpoa+hCvVyekhovAQwgdvMI+t3v1
X-Received: by 2002:a05:600c:818f:b0:488:7ebd:78 with SMTP id 5b1f17b1804b1-4888359d302mr5083925e9.14.1774979700154;
        Tue, 31 Mar 2026 10:55:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:5ed5:ec79:be2b:6da8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4887eb5aff3sm70585735e9.15.2026.03.31.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:54:59 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH] liveupdate: truncate getfile name to NAME_MAX
Date: Tue, 31 Mar 2026 18:54:32 +0100
Message-ID: <20260331175456.4065874-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_105503_189676_8E3640CA 
X-CRM114-Status: GOOD (  12.21  )
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

dynamic_dname() harcodes its limit to NAME_MAX bytes, which includes a
NUL terminator and a 'anon_inode:' prefix. If the name passed on goes
above the limit it results in userspace getting a ENAMETOOLONG error.

Truncate the name to NAME_MAX - 12 - 1 characters to ensure this never
fails (accounting for prefix and NUL).

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
Builds on top of this just sent by Aleksa:

https://lore.kernel.org/linux-fsdevel/20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com/

 kernel/liveupdate/luo_session.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 7836772956406..4a40c7fdfb44f 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -366,11 +366,14 @@ static const struct file_operations luo_session_fops = {
 /* Create a "struct file" for session */
 static int luo_session_getfile(struct luo_session *session, struct file **filep)
 {
-	char name_buf[128];
+	char name_buf[NAME_MAX];
 	struct file *file;
 
 	lockdep_assert_held(&session->mutex);
-	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
+	/* dynamic_dname() rejects names above NAME_MAX bytes, including NUL terminator
+	 * and a 'anon_inode:' prefix. Truncate to NAME_MAX - 12 - 1 to avoid
+	 * ENAMETOOLONG. */
+	snprintf(name_buf, NAME_MAX - 12 - 1, "[luo_session] %s", session->name);
 	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
-- 
2.47.3


