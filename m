Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD3CECAAD5
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dPI/3vIjZkAjQWgj19HP16ZCXGaEmquql2mqgonum1w=; b=lJMuFZlFgQSua4
	P0yMgg2DIOHd7pJhIBFQQ8UDADcwssOgx5ktdyDWkVv1m155G++jlYypmsa8TDuVgwgIxyAYQAjoH
	d4d5YpnCtUqp3gvNA94yfZRdkFDvzPtJni73TWMsui671ZQjW5vkB43Xd8sBBHOMI4jOotdiPuL+S
	jGu0mIfQ/+jw2HKvOvjlOpRWT2WVdljRR7JRj1/oZ4YPGrzcE4r3CUtKG0RtEwdv937f0a0VB39fs
	EiTP1x1vQlYqBtjkjYi5IZqEGh9sMI+G4dhj5BHA+LVDasxx69QirWMUP24f8mzvi+gUWlfprQ6bw
	hU2vAhjlVm2+q+/HcyTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCrb-0035cq-6O; Wed, 31 Aug 2022 01:49:55 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCrP-0035ZZ-5a; Wed, 31 Aug 2022 01:49:44 +0000
Received: by mail-yb1-xb30.google.com with SMTP id f18so2157513yba.1;
        Tue, 30 Aug 2022 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WBgIYiK0R8MyjOrBW9Qr0NQe4i20glZFZfsxiGjR9Js=;
        b=UrrZ3gdP0DYEzt2tLaTueomDMpcDl9rxoco194EQny8lyNhVtuVOjWt0NhoRhkcQXf
         MToHlti/EMdQyxSlvPHLd299yLJj/5rpKMd99Ugqaqyqp332oBu0v9TF1tStCO4Wf1pZ
         hybPkjtxwYlWHqdBAuPxA9U3Czk1LSlkvi9cOeEfNBPmTQiGChjDHINeA9IfVG0Hw92s
         z0dRDzENZOXd0RuKe0vP6cyFn2Fs8RWXdhLBUnCzlub4yMsxiTb4hHdJ6bQj+6KJFEm1
         cagvjZcos4RlGUx1EOi9Liz2wC9KfP40z2qkwmEAGrX1lljSKkdJ/Tw4/VKjlJQqCLdw
         00xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WBgIYiK0R8MyjOrBW9Qr0NQe4i20glZFZfsxiGjR9Js=;
        b=JO+3pkCcEFhKaSbUc1vygAEc1LReWeZP02hxwxttVyYWw92ZZ1ZtFYisJWQ9bFF99o
         +s2cACoRQ/oUanRVOQL9DPc5XyF45pA1b0gsFy0GcXCCERMaMPccCBj/NEPlUDirTFds
         ACvCRGz1A5IzzKdrbQNciKUHgI9yTaS4tBNfBgUEt2x7vEGBkkt5jDKEuMG38mAFOGq1
         9nccMH+uqIpkaI2Cu7ZFsVu822fO2YvtkH8h66362fR96C2fYBeXKkNzP/3GJ5p13pzw
         WqaF+5E99ceo2Oj2guNh0sstNAbxcL0vY1vN9I+IexLF0HPTFlhI9RlynI1xuiQ0mCbH
         22UQ==
X-Gm-Message-State: ACgBeo0iIAH00LaraOVcogvuycTHgZePExsM1AufOUtAilo8fAvMbIY4
	zLY4vyXUMX2sfEfHFYEcCsLkn0h4axSfAHBWMmc=
X-Google-Smtp-Source: AA6agR5v+P0bjKc/LRs/ofzxWFzyP4hxcvl7IhyadMjop5OY67JxjkkGONKU+jN+FlyzR2h3D89Cee0OXwhomiRh1XQ=
X-Received: by 2002:a25:9948:0:b0:67b:fc24:642d with SMTP id
 n8-20020a259948000000b0067bfc24642dmr12933701ybo.42.1661910581149; Tue, 30
 Aug 2022 18:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv> <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
In-Reply-To: <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 31 Aug 2022 10:49:30 +0900
Message-ID: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
Subject: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To: Baoquan He <bhe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_184943_246379_3619C661 
X-CRM114-Status: GOOD (  10.49  )
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

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.

Add one more extra cmem slot in case of crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
Cc: stable@vger.kernel.org
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c
b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..a11a6e14ba89 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
  u64 i;
  phys_addr_t start, end;

- nr_ranges = 1; /* for exclusion of crashkernel region */
+ nr_ranges = 2; /* for exclusion of crashkernel region */
  for_each_mem_range(i, &start, &end)
  nr_ranges++;

-- 
2.35.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
