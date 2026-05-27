Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358CECD5BD1
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 03:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osub7jqB1KkbojdE6IP/r6iEAlyJyU/eaCe2RQB9Q9c=; b=RmD2jvuFwpJH6svzUkNvVdW4nd
	K1NFYoiE51dVE8I2tDwknLhlE2kPLtDyhYVs0iZkXe0GnNzCdLI3UrRnB/NTMGRcHaaiWTbLIy/uM
	4gFmJ7PYwR0mJwRJhfCSfyCqETnziedNgGzcmECwTrZRWiFaFu/+dPWIYx4l4wI2lIXbMakOO/s0B
	x+I5gggB+ODlzMk8mSqQqJU0vhIKP11qexQnh7qbA3ABx78FLI9GNwvmEEsAYzKvkfPCsX2OAnyNw
	8EkI/cjspT+w+CjzIK9BRo5AiJ8l8Hi6ww0iIkgDFKRtn1OjjJOQeMlqOzXRdyXZ3/c+1Mw/uDdqT
	VBsn48nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xl-00000003ERU-06LL;
	Wed, 27 May 2026 03:29:45 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4xi-00000003EPM-1CXf
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 03:29:43 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so5624901b3a.0
        for <kexec@lists.infradead.org>; Tue, 26 May 2026 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852581; x=1780457381; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osub7jqB1KkbojdE6IP/r6iEAlyJyU/eaCe2RQB9Q9c=;
        b=UBVZHyiR9v8k3KOo6WtdJqSHeUOW8/lw7rLcCabFnjp5O18AfEuwHm9iQUC2uFm6lV
         v2rpWFF4kDjsPzSQXQH+1wasZVQSSAUjOtIgJJX52/ANGN6NHGGdTU9fu3wfI+hJtKM4
         W+KVfC+bUX6wuAiuJIY7iow+FN0yWAK1UegFeKbx2BgYSQbW+rDtFKK18InUF+QsA/T1
         KAOa4B6lmIUOlwNir336VfmK7KY/fb8GaJnPI6l0rvY6o7gldgjQfE20YZsV9d5ghrml
         5AynPYDf/JdaI7FF4B0JY5P7iJMDdClMFE91aP+lEHYb1DCZ9ObDfa5HysbdjpKMS9VA
         fnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852581; x=1780457381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osub7jqB1KkbojdE6IP/r6iEAlyJyU/eaCe2RQB9Q9c=;
        b=WmZ9WnBkkpPMf1w4DNR0zZsmx2m6MKYKlRJgcD+QMd8JYhe47syIccHxQgSnGSkPHM
         oCCBmtk8cjUPiEfOc09Hfke+1pSLWymFBuzyVrOoK8JAaVbMjcoowtsR5J3n8UkSlL/t
         hboPWNZOhy8MJeksUzoTxiAUJSXkSQkG94xZHK+bGJy0NJ79v2v/7RGtBQ9njfEDXfYv
         orMhS2N1II5/Hzym9LRGJmnm8cyz/XPYHTzoT9Dcgc6QVdlSJ0TQWetV6WT7K8sFOHim
         Xg28ugmpC8s/rOMc/hSxs8AdrTeeNITwtLO2zqMZNtpmf04HfzAj7d+QLlk8dVonMg6a
         AJug==
X-Forwarded-Encrypted: i=1; AFNElJ+jgoiU8aEOW8D5aw7TuD+ArLKEalLHWG65DEu4QRLq52zp9/MDoLV+etJrVyyAVdiUt5lsxw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYMYa4ziZXQ3qhTlEeZGF4ALXa6qDu51xZ1qrLFzUf7EMi9q8G
	j/RygfzjFs//TgkZCHgRVVSozZJ8QvsuwNaEFseSmIsdp+eM7PfaQxcG
X-Gm-Gg: Acq92OG820woq8OnuG/tn884v5FFwEJ2R7NKuv2re0s8TsqwMN4qouzq01rH+Q+babF
	W2CaKTSg1zR78KDm2ZlsL2rkzIYRO+cAW6Osc802T81qVpdVpvWN5IihTJR2SK3/MJQwzhHOP+t
	dB58vmpK5VyRhfO3YmOejTdq0dGzsEpczqatW0qYUPxlQewX/CcHAg8BNmHCb7SumR4HJkenbG1
	5lmT92pKbhwjfeAkqt3kMCceSvd7O0DANINoXX+TIZOWCsf44rG7qvGQ04eGIApOb4fQBMwiZWx
	OxaqZAT7/TMdRe6VNlxmtYTSkagVPsN6JMKcIZb23tqhpQIJbVDfirROfUn6sJ7P1W1QbWgdk1j
	zcnpEl3ZkzgvAuK8IVNmWWDVkPXk2oDWVoR06qM9M4+TpTH+0aFifH+oc2SJTZZtx/BGXXDbRaG
	2RReLe7FGs7EYCwI09/ezg17Klh5Qbzuq5ogM8
X-Received: by 2002:a05:6a00:7702:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-841dc7d511cmr264256b3a.25.1779852581229;
        Tue, 26 May 2026 20:29:41 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7307596sm749688b3a.59.2026.05.26.20.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:29:40 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	quic_obabatun@quicinc.com
Subject: [PATCH v3 01/11] of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
Date: Wed, 27 May 2026 11:29:07 +0800
Message-ID: <20260527032917.3385849-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_202942_320755_53B54AA4 
X-CRM114-Status: GOOD (  10.92  )
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

Prepare for an upcoming change that appends /memreserve/ entries to
reserved_mem[]; such entries have no name.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8d5777cb5d1b..313cbc57aa45 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -788,7 +788,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 
 	name = kbasename(np->full_name);
 	for (i = 0; i < reserved_mem_count; i++)
-		if (!strcmp(reserved_mem[i].name, name))
+		if (reserved_mem[i].name &&
+		    !strcmp(reserved_mem[i].name, name))
 			return &reserved_mem[i];
 
 	return NULL;
-- 
2.43.0


