Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD9C5DF81
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:In-Reply-To:References:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wsYxExfrI1OgfgUtsxz2vPPCZHiFnpZ/4W9NF1DJIH8=; b=JzO8QnuZwNLKeOLYAZx9oW0j1A
	/CXQBw8d3xoc6jykaRLB+Zzq/pBWN+rmm+1g2GdhsYnb5duQrW4BxEwLZMu2L38iUE5w4eU1/GmMK
	1cQhpI2VAw605VyQPR0TmDP+nlA57gBsYlSo1q8fhHwSSRGFpEfXTQErlqtoDKdLlosrj+N+y/tYU
	pu9XG/XJdGYTaVJcZ7ikEincqZb16kCq7LTyWTUSV30z/zpJMaT1wvhAsDfzHthhsXPShWLRO7n7A
	LKnvBUIiaMsaWFXsV6hcwnvuIrdhDKz6XhhmZZ2VAp+6KeDbL1UebLY5m69koLxKsM5PS/j1UAqha
	LEgG+SGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkOK-0000000AJ0Q-3u9Y;
	Wed, 19 Aug 2026 17:47:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkOI-0000000AIxn-1AZi
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 17:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787161673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsYxExfrI1OgfgUtsxz2vPPCZHiFnpZ/4W9NF1DJIH8=;
	b=LBZpDSsGenTXo8/UrP1d6YQu3hgcvau97vbmpDbPODspBJE/JJNHLveG8JlmltEhCnjywn
	e9tXT8A+ZBcm1a2R4t8g/Ja3SjzHDB+9IoMmIWV2P1lwJkhJAAoZhYdc//FBBLrLlFDiaL
	D4iH7XtLf4eAe4SufyW+7KAwaVestlk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-y6GfOYerMeu3igxLR_6b2g-1; Wed, 19 Aug 2026 13:47:52 -0400
X-MC-Unique: y6GfOYerMeu3igxLR_6b2g-1
X-Mimecast-MFC-AGG-ID: y6GfOYerMeu3igxLR_6b2g_1787161671
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3931cd2e4cbso1765071a91.2
        for <kexec@lists.infradead.org>; Wed, 19 Aug 2026 10:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161671; x=1787766471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wsYxExfrI1OgfgUtsxz2vPPCZHiFnpZ/4W9NF1DJIH8=;
        b=pUPM8vbaMPm9yd5OE4nspoGuN2mJ0XoTF66F4eLYA/yKpcWTDF4KFvcca/MGa2Bwmj
         3SOPqjKUITC+SFUvw77ztCjBfAq/6HLTrcTu8Ym/KolOg4u7jHTeSz0i9ttbxhhz9IBT
         08ogyrduuj/mYHncj7ZrJe12BjMesSujL8snzxNmzoGIycY83AhR1ERFlW9nqsx8e6R6
         Vx1C6nG6d+kDzDcnQb0uOEmfIbcUAwylyyMzXR5gUdUvPOT6D7P/TrMTFsHl/2ZuHUBT
         Y/26rkWAIYmPI6+KUQlpmg6O8sTB/szt4hDsOidXo5CoKtOXa9ragTydL0RMnhDhyTxC
         FyRA==
X-Forwarded-Encrypted: i=1; AHgh+RoGJDMcHREEh+DRPyWZ94kbxzHuAv0m+XdCqSr27Qcjdo+oY7FqAalQ0dKbnUb2OG/2l12fuA==@lists.infradead.org
X-Gm-Message-State: AFuF++nRpy1WaCZPZgiAKno1f3hrh/qqwzKTvwbVdfu9WPZMU9iaFGT3
	m7blwSAVrzynBureKFUtswAKBYjwmxDYqevCbA0L+oKMstuZBucdDLqEEuXxFXbdUddRH2oE92K
	fymCEtB+6v9G4N63U9GoA6lqOVOMh/lSqpe54Lu246WeME7FjmBogm/Mn3N1ZdQ==
X-Gm-Gg: AR+sD13MAit5R6xBBabhWyyFi2OM/HBBQruy8rKD32x/RgytvVAZGnusaURnJ6wDy6W
	RKUAH3N66tpikGRFmZvg9GePRIXuiF+eoxG+5B2PDRepBQ9bkd6JFSGGesrnK5Gz4Vt55t3qCss
	C6VmSkC9wJyknVnLXJcel3XI+VMNUtejtIz45dEx0ozNN1pt/JIuXeLnp7fscqhBb8KJt5KKmzP
	OkWh14uG++UPR2zUAPmDk/DbkVKUC0HI77kLNADic0ThVhEvER8DuOApSAg2EZ6EMW38EcycaOg
	XmU5xQOgMYoA+Uv36FxCPpbKONf8CCGO+1L1wOQcvzsqCVfMyEtnDZ1LK0oYr65GWq7Rh4Oyscr
	ThyQY3u6MgLQzZM6BKQ13IRTEgHWYf+Wz
X-Received: by 2002:a17:90b:5105:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-39581070da4mr12374239a91.15.1787161671206;
        Wed, 19 Aug 2026 10:47:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5105:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-39581070da4mr12374130a91.15.1787161670669;
        Wed, 19 Aug 2026 10:47:50 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96ca41sm3319861a91.4.2026.08.19.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:47:50 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Date: Wed, 19 Aug 2026 23:17:23 +0530
Subject: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
MIME-Version: 1.0
Message-Id: <20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
In-Reply-To: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>, 
 Philipp Rudo <prudo@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org, Mukesh Pilaniya <mpilaniy@redhat.com>
X-Mailer: b4 0.15.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3VILPJStu7ZzREVIujiz6Vk7WT4rOJom63KGGxUwhf0_1787161671
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_104754_397684_E6A5FDB1 
X-CRM114-Status: GOOD (  14.00  )
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

kexec_image_probe_default() overwrites ret with each loader's probe
return value and returns whatever the last loader returned when no
probe matches.  The error code reaching userspace depends on whichever
loader happens to be last in kexec_file_loaders[].

Only continue to the next loader when a probe returns -ENOEXEC.
Propagate any other error such as -ENOMEM immediately. Return -ENOEXEC
only when all loaders have been tried and none matched.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
---
 kernel/kexec_file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..b3060e984ef3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -68,17 +68,19 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len)
 {
 	const struct kexec_file_ops * const *fops;
-	int ret = -ENOEXEC;
 
 	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
-		ret = (*fops)->probe(buf, buf_len);
-		if (!ret) {
+		int ret = (*fops)->probe(buf, buf_len);
+
+		if (ret == 0) {
 			image->fops = *fops;
-			return ret;
+			return 0;
 		}
+		if (ret != -ENOEXEC)
+			return ret;
 	}
 
-	return ret;
+	return -ENOEXEC;
 }
 
 static void *kexec_image_load_default(struct kimage *image)

-- 
Git-155)


