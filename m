Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73479CD5BA6
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlJTNnuSEkuOFcK//QE/3Ty9SdRnFwE8BVFotGGF+Qo=; b=fIFC830YpFhgOnNxsfK8p/ym0+
	g1opNOa4JSENRG/iX3EIycc1Op9hBpUqydcaAqQGHLo0cgQ6Df5RAfZpJq0FZwiIpGzu4l9Kco79F
	BNjiDEOecO+f6Kp2tK5oXQTWP/yVPoX2kpwXe6LF9nBguY6axdkGkf3u2mgtBWVHuKPGt33OKA2uw
	ZaXLmGXQuBlzaFdWzObonPjpaFCQEmVEyNOlzbk6QIxxNrkv7ziC34+cxeWzDIChGDOJ6DHhO9RaW
	2WDvY+Ujc2vs0pM1pjO7l257WpFv7Mo0i917djahQTG5kkXRbN/CmaqAf4yKRwcKdib96CQm4DrQq
	qc6jSYjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd59-000000046Fp-2zIq;
	Wed, 20 May 2026 09:19:15 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd55-000000046CF-2u3z
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:19:13 +0000
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-c795f441ff7so3725019a12.2
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268751; x=1779873551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlJTNnuSEkuOFcK//QE/3Ty9SdRnFwE8BVFotGGF+Qo=;
        b=E/56IJnWJBxHQu872REyMYghclNbpooTl0ABm8iRv+ASC/2dGWn8nztpZCrmEQd4/F
         D67huKi4ytU9P/jslK8j9EvX4M2IzX2w3uk8iXPvkS/tdrjL4GSA1q4LjAvDmE8JnFH5
         usvLNgfhgP645BEwO/l6PfJ2rwxxEIuLlQ7CZ/oJyOCk4owDfitDiLdni/uswdR19vGt
         5xRJD5k/XnP2/rExtr0NpYgCnuV2TWaJkcMkjHKVNPpnxjC4XROb1emJb5ZGRIVEZk8J
         o+Qc8IeQRIWVs42QyPzooF/pc8DIm1tylfN9MbtHMMdrkHItRugH43c75GZ50xTyuhI7
         DHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268751; x=1779873551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlJTNnuSEkuOFcK//QE/3Ty9SdRnFwE8BVFotGGF+Qo=;
        b=bYPYSoQ29GTKlp7ua58K3KvzBShrnJBjqc2M5nQQHr1Dfi5tIFhqmjdTDyWDXXswqG
         G/wsBx58Kn3jEO+Xpf9FQrP2zIYalyDWplbreAhUAlW0sq87A3ng0/7Tf+ET/zgpkgw5
         CwVljrYj9iOtWX9oa9TsJBVw47MwDwdsG3mnAIM+LuiD2Di7wMddR54wnMAUbrJM2Ap9
         lJgd+m9V+8IIZxOe9Bl7xAvM2m0sYRerXDps9mGiRad9hKivKBeyt9dU5qZMn8J5PkOQ
         bpm+YmG8gWU6T9Go3c2N3PAI0zXhFqMxgeYHD25DAWZZtSekThB7adyRFEe812vhs6zf
         J6YA==
X-Forwarded-Encrypted: i=1; AFNElJ9WAIHtCax3SwIA/uMnPShyRWBRrd70omeBkbiLsIhZE/UbUmeA/uRzs1/uiH/N8OpgVhaYpw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ+EabXYo87WOLP9vzYPlsK221//QzkZ1FmQcwLFfzJ6kLjIU7
	Lw39ZBLrFUvcI39J/MXWFhS3T1b9lGLPC/0Jue0CLnWDoFs9EnMBbHMV
X-Gm-Gg: Acq92OEjBF/YhFZnpssF65wxgX5HowG6tx2rOQ9A+SW23NET7rBJfZp5nJ7EmEgtlUg
	W98mKVrXU9q0sV8ipkpgYTCnPMpraVm2n2aKINEAJfR6430IOAoyHU4xXgjRule+DjjYCUH91O+
	Y4GnY745UNqnMbwFr72/8h1WLVsm6pw5ztjCvIsQCp24IoLg1WH2FxnJa7nIh1R8KgccvZN5xQf
	zyTkzoABESGl4gOraaqu4mWCnsli8QWE1Oji/qxh+bP8cuv0e/hKCLR5E0Dvqy1CpzBo4ru6Vpo
	L172d3Px55l/gxKZrUtOy7bYNCh+3Fra88xAlkB1LLTpgu31fxjxAXAWj+3IRwr3w4gmgMxhQew
	d5xS8E01PLsP9q5BDdXkjpX9D/aKrr3813GShVLSfC/5DpkVduMFykEViDTZiMti7/+ecO9gQmK
	8W9OBYkbcsZeTAdqDTOCQuYuYlXCUiVCcBKwMtPA==
X-Received: by 2002:a05:6a20:2454:b0:3aa:ec28:edc6 with SMTP id adf61e73a8af0-3b22ec63eaamr26158763637.39.1779268750848;
        Wed, 20 May 2026 02:19:10 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:19:10 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
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
	leitao@debian.org,
	kees@kernel.org,
	coxu@redhat.com,
	tangyouling@kylinos.cn,
	songshuaishuai@tinylab.org
Subject: [PATCH v2 1/8] of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
Date: Wed, 20 May 2026 17:18:37 +0800
Message-ID: <20260520091844.592753-2-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_021911_739385_198C69F8 
X-CRM114-Status: GOOD (  10.99  )
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

From: Wandun Chen <chenwandun1@gmail.com>

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


