Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92306FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R4Zhc8gGgRynhB3pjFfj0bHF1QgAjZt+4XAvOQyKioc=; b=3YpxzZHDe+H4j2k/fPH8tXQq3p
	pOGDAVwSMqnbYM5ZFC6asInxtQYkC9ii0bWgqWuWPgxN3VVg2cmSI2RbU5qHh3txb1MgOLE9yqmaI
	r/P4HdOnIJb0jkaExgRbBdOM4jJZVuQBtRNhN525TFzTAauvVtNnWk6sfwON9GiGBfRFBCerrUiLY
	o22mOq588A4RWU+gyXQpIiVm2WZ0jDakZ+WiJiq/P+g8fV2l/B85wqUnf0dkYYq/OqxZkxyoc16vu
	t9NXjc/wsHYRGGHBV3BIlJrWgkpgBB84q6jv/wVtTIAZgG4rcNimaRB7f+kicoGM60WODXSPSEB6u
	8mnNJGjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyuV-000000036PS-3pOn;
	Wed, 29 Apr 2026 07:00:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyuU-000000036Mz-07IB
	for kexec@bombadil.infradead.org;
	Wed, 29 Apr 2026 07:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=R4Zhc8gGgRynhB3pjFfj0bHF1QgAjZt+4XAvOQyKioc=; b=MlnIaS3WfU8kk+GPNwCg5Uw+Ub
	I/LUHbhvXvrlyDzQ1REenuo1r/wzBAF/okD1cC3B74CgQmhZLKOZcDeeqrZLB/vk2G29T/Q9PGmdl
	uP4o20QxX3cT/VilrtVJKcIbDeNAw/gunkHkDgS/Dg51E3mgvR8In77y72EYLO4/FoU8sfbhHQoLK
	ZqUuHPFYZnmxYSZy3rghEk5Nv53855PYRVDWR7m+J/oF3QSu9blze7VPjBZaohozFNXmFn0FknHY8
	12VpQDSM7jGyTDxDK1PIQbrukWsyz5DqXXvF5Wl7h+BdBy8ZNnRrl3D/BpCldz/c/FI7bukHjO3Jz
	Okcloftw==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHyuI-00000004iEc-0Vuz
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 07:00:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-82f8893bff3so5739624b3a.2
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446023; x=1778050823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Zhc8gGgRynhB3pjFfj0bHF1QgAjZt+4XAvOQyKioc=;
        b=LFudkao5oCag3MoYvIYD1ZXkeTmm0xi/P7AwIH3ECBG+HBIBIgN1sXnGBvSGEIrG/W
         zVDsCvZL+l+8BN9srixxT1QJTiK4tWWomzc0nM/biqmtoclbghnZ2Kiu3+QtrA+YkinG
         gbksMhzQPs888oq8is6Kn6PFxeREEvGigCCBCbt6rF/aodXhDkmbW2Qr29JMvy7CDbQS
         wCrY+n9hH7Y2z3BsV7vRPC2JIAeP6/iLhtLjDb7mtA98p5BgyTxhozKQSuda8IdGegKO
         Wr+wuk0z2m/tjXy84+2snBL9/U0zKTM1S94TUkJv/wIIPf3EDK1kiNcgd8/oHRG93PQa
         +Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446023; x=1778050823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4Zhc8gGgRynhB3pjFfj0bHF1QgAjZt+4XAvOQyKioc=;
        b=CAyfoX/kynDheyLL8C8/fqlTdox11OlvIVf9YSluF18PALoFiwmhUBlreTyiZ1HcVW
         RtmMhQXUj/CUtg5C6jD0R697EVKxWAijQLRCXyx+Vo91VMpNdlRHsNllvLPnZootssDM
         LY3P2Q12q/7pgtt2fggQTEs8xcZ1wsnn0tN1phtBVnY95SPf7khiC0HseCfwpgAAuaqr
         TOhOiP/uRFKxf9xP511kQ2081MZEbo7w6WZrgfWg7DB5TcRhxK3w27H+6bE1/xE6BmfK
         DkMsKO/60T+PADuYfLLtxuuoxiNof9rfaPLcQU7O5RaLpd6BJ0daSVncRxdYknBcsuPD
         0XFg==
X-Gm-Message-State: AOJu0YwISAnOtpdEUkg/cNMIqMXZraRINKS6t5G72ofmm/YhnCdRQn7w
	1U5viA8YzXpQP+0JBhmKirgXEcLOAClgH6zmYqq/TsPrnpieGlO/r3rnxbit+SJougVqo1BJ
X-Gm-Gg: AeBDiev9uafoDGRLC32RSkEL7egg9xjc66P+vukF5SkBslD1gjlnTq5nn0g09jeguYP
	ql79XDL6L4qk9DHTbDTO0arh7wiKohA2UICKObXOhcP1HB0WLi7pGRxqQR7CUstOCPBRMJPvnSk
	jHWbmL4hIRk3DuQYavCf+A5g5drg4VBKOPOAfGdcTIK8r2Vqdi+jCgcJAloH5xaU1PL3dIQzTDE
	nklDPdCgfEpDSUzgPZc78rf6kaVn4Hz+WjBDeJZdOfYh2yJ6u0uVEitlxEnYMox1QTbhevtvSgn
	Y8S5ULhV6C/DsGucVvvoLEYpvBb7DMoYgAH3qMf19ASPwdlQ29FApsacSm2QCdggGlyn0Mnhbac
	Ab3FRdZrcbIlyYxfZMzyzsX+6sgKhYd1Budxiwkmujp3eYR0Hj6AsoPb4NgSdFP6MMLrsN8tXz6
	dcMt2OW2OsycxuCB4bF+EHSusL/HC3VMCz3ZPD34xGcQweNDs/
X-Received: by 2002:aa7:88c9:0:b0:82f:b519:a5cb with SMTP id d2e1a72fcca58-834ddc50c40mr6750211b3a.37.1777446022861;
        Wed, 29 Apr 2026 00:00:22 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eaf93sm1043146b3a.40.2026.04.29.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:00:22 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	chenwandun@lixiang.com,
	zhaomeijing@lixiang.com,
	everyzhao@126.com
Subject: [PATCH 10/11] loongarch: kdump: exclude no-dump reserved memory regions from vmcore
Date: Wed, 29 Apr 2026 14:58:30 +0800
Message-ID: <20260429065831.1510858-11-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429065831.1510858-1-chenwandun@lixiang.com>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_080027_023483_DA0564F3 
X-CRM114-Status: GOOD (  10.54  )
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

Apply the same no-dump reserved memory filtering to LoongArch kdump as
was done for arm64. Use of_reserved_mem_exclude_no_dump() to drop
flagged regions from the elfcorehdr PT_LOAD segments, and
of_reserved_mem_no_dump_nr_ranges() to pre-size the crash_mem array.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
---
 arch/loongarch/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5584b798ba46..742fb9affcb9 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -67,6 +68,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_no_dump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -91,6 +93,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_exclude_no_dump(cmem);
+	if (ret < 0)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0


