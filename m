Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F72CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BrsL21RjbuMM3T2X5Mk11zBR+jvjayaUF3bi078MKuY=; b=xmCt+eMDYjNRUyedfLNHoRSkc/
	wj0cvsKVKGGu+2lGJACF7suIxXWC+AtUYSWEnxy/hnNtdNqqkRX8F+/etYdpBN2FfO+dwz+5kD7wZ
	aiZc9WQER6VAo2Tfm2/sF5jzWz1zPpGufsjkoyrcqyqqcLItkM++qnvs5Sg8kQ2q+Sk3VKEl/s3HN
	H6vTK904gVcUYr947jt0vh5woLhxLdnzEzHwW9XBToseQt2WXTLT/imo2YIqBaTDHtihPKF4nJXhV
	IN6BwWG9DoayF3zQYCk9m66bPfAlSJn8/Tctw0/farC29H7btBXo42PjfQeYsS27Gy0/6d0//2uK1
	M4TmMZKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGKK-00000004Q7V-0YPm;
	Wed, 27 May 2026 15:37:48 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGKC-00000004Q6W-1QvC
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 15:37:46 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso102539835e9.2
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896258; x=1780501058; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrsL21RjbuMM3T2X5Mk11zBR+jvjayaUF3bi078MKuY=;
        b=aE7+frSNjwroS+x9oTKfcwRPF2Qbq5jRb0h5c3bsfu2RATd15Zp2kyt1vs/2S1RnWb
         UuFRmHV8bFEWqBw1TDZfBX4xUnaGf2Gmtv1r7bFbbAGT0Os2v9Obe5dgDT4L9y+bgvsU
         S38hQlZTkKBrcnNjrijmXZaPJvJ8k7TDl9X2yP89Ne3FyJro3fYvhot5ZpnBubKitJ6T
         vdmiPUfpVLTIqgqYwqVuvMQq1eToTF6iH/eJqPYzifdH/vSlkJxBhzI9rGhc3TJekmjU
         MyU53BciL9Vyo6Lto8RtS4kw0JDSC2/woIV8o40oyMO7PD1pUGzJYMgI6p4LV4pBlq3l
         Mucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896258; x=1780501058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrsL21RjbuMM3T2X5Mk11zBR+jvjayaUF3bi078MKuY=;
        b=Fzg91lHbNTAAP6SE6iC8phQp8vSM86lzmDFwSDNv/dNRmvesohmInrzoUrGpW8294R
         Crcek+7St1CFuXsUr59aZSagZdVH1IespmalmgwpD0W/NwYV++OZ7pwEPJ0u8/kXhX3H
         550pvvNTv8IDLOtu26MWY4YBcypMB9ZmP63S0A3hlGH62bpRZ9Bi4flHODceAPokFHQ9
         O7DrUG/+SsF5VlnBeJh9nv1TSY+PFN7V2eVdnjxEjgP4cVmDZnW57QiLhE7Yp4YU8ZPy
         6/GqsBfmPRnoWtg0Og66MS7ceNJLBVKRp437lcKZJ7OcJY2mJBH9NPcR+rDilwBFemDA
         uXGg==
X-Gm-Message-State: AOJu0YxYH/y7n4I+UhObVTZmIq4oys5R9eiSGd5t4MH6h8Jhhw+nh54g
	uonwvddax2U/Zy1+RWEQ7dqc9UobraRYg4S0hIP4/c4fWIOzhm46AHQksQf4ng==
X-Gm-Gg: Acq92OFc20LVUFXsaVrp9tAkcUkrr5CbFofBUm6CPYngJdutfB4S4MGxWUiLXo11H2I
	iLlregp0R0Zy/YxJo87cq5wFPezZnXnw+cjvcdw0Je0ZtB3+ThdYj4TgrOgXODAw2DH84t+aERt
	44YFBaqj6fNsqY0O0k4KYnbvFte0GzC8Z0qQ9oEbfwETHJkRWKXLLbkSihZiMnjRh1hxeEwbJO+
	U4WwA8DDCGRUPgiaJ5OnwNYqFB4yWlqjhgV143+ujGxagTiJOn5JxW9v1Wq/6zlqhKGIYGORCGY
	nx6/Bd6r5S1tzRdaB0hWrObJUDLxu4b68cBnCA/qbfY0rs28lllxUtMOQfqf+A26ukciu9I0sAF
	ncKkBOCuFj91EyUFBUegcK+gfAJovVMQZ/wmuE0LRADc3OpdSQNe8iF6OXQXurDUTxvWVJebPXs
	ZkrOwppHMM7ff6M43OHq7VEzA0xCk8
X-Received: by 2002:a05:600c:138c:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-49060cb56femr268982935e9.21.1779896258063;
        Wed, 27 May 2026 08:37:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:1c16:588e:9e26:6aeb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561a33dsm370360215e9.11.2026.05.27.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:37:37 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH] liveupdate: document current compatibility status
Date: Wed, 27 May 2026 16:37:12 +0100
Message-ID: <20260527153725.1770394-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_083740_397131_4F8A5976 
X-CRM114-Status: UNSURE (   8.32  )
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

We currently do not guarantee compatibility due to ongoing
development, so mention this explicitly in the user-facing
documentation.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
 Documentation/userspace-api/liveupdate.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index f6efc32fb40b..cdd74627ab75 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -14,6 +14,14 @@ ioctl uAPI
 ===========
 .. kernel-doc:: include/uapi/linux/liveupdate.h
 
+Note on Compatibility
+=====================
+
+Note that the Live Update feature is still under development and subject to
+change, so compatibility is not guaranteed when kexec rebooting between
+different kernel versions. This is expected to change and stabilize in a future
+version.
+
 Userspace Integration
 =====================
 
-- 
2.47.3


