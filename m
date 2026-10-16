Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD75BCC6B38
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=; b=EWc8fDEMPbVxu4sfg6WR2YhfIQ
	v5/pPpbkahysvEA4BGSMUvHZx2SONaiqF9qyBwKstLIhZPBcFvEMhKFEa6FLaCxYaeU24LtrMZSrV
	HBr+bHGHYa6Fd7E0+TnnB9LNqGnmv+VePMj/U8qHnZZ6FLfv6StbY0o+W4DSg7j2OlAlRF57Qoix5
	V7ve2qmYR7AW7VlI3fHmRewA5awMDbT0IfUYLeGUk9bL/xkKOBYErg543Q1g+usi1qnjOzxmfIPN3
	pOD2iPWOPoqBijh098lRd7mxmbF3Y9ziLD55ZSn96fPjxbOnerNX7SHZO23ZiVRAG18TFn5pM+das
	i1RnFiUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbGK-000000026GT-2Amz;
	Fri, 16 Oct 2026 06:17:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbGJ-000000026FD-0U1V
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 06:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=; b=pu93NbLWma1+12xNiAZ6PhJj7+
	fFpVWE7bV9HAbqxcsYwW5OXGL8ECqHRhsxDKTDFadkTEXsyrJN/MHFWx6TnS/SSSt9fHbDxUau2nf
	8dFr3suP0iOpTboPLfZkOyq9TXU+ujVjIBwCrHNP0TPXIcHSCjwKOpVzXz4BI/O+456a+j3FuSjt0
	BlJjWh14hUA+vlaA51esZdfGdp6HxEe39hzEo43H9DlNopmATuv5F4xtBIlFoK6cLeBcgsk9o2oXl
	wRtEMfZCu5yQW7eZydYnONmA1BPdQpPYCFxq5EMuRZHe1y7DztrjDoRtjVq+KC4rtqSIb54Ptg3Sk
	c6QotvKw==;
Received: from mail-pz2-x0a.google.com ([2607:f8b0:4864:3b::a])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbGG-00000001SDC-0fbM
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:17:49 +0000
Received: by mail-pz2-x0a.google.com with SMTP id 41be03b00d2f7-cd5cd8e8104so622819a12.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131465; x=1792736265; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=qYkfzWew8phzI8+fGLWG54hKmqZzMkgOc8wWznzVXlApKfCS65xsAgLKBfR7ZxOmk6
         UYvn73tjgi/Favpi3CJPqVGRKw3yaWDZ1ndN/jM+8+RL74eivnSPC8iFWD/Tb9vm8Zew
         +cxUdBxJch2tpSIqPYHZjefp2Zz2wPpxCEUpCghfjewO1MfXqgJUmsduVQ9mndmpw/oA
         k3W2z39moXxhUTZpjCc2mmyZdoPKzgv8gq0UxW1oqshbYr/2cF9Yx96V2RzdHnAPYHym
         4X0I8RSsBujrd0JexiqVRNeHHG1oazEnPrWk5gsnjnN1NIRzs5WdxmUb47Rsu7DWKv7f
         ZTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131465; x=1792736265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=ABQRHwgPpHSBbo8OpcHr+P/oC3JbzEwqCxcxl+bWSJVH6AsZporVXYCTagCnrmLO/A
         5M54IE3TY9diUGqBbcW7NgdectZJXSYJyz2CBZ7yNrCN96HQqYiW2XjH5py16n8znkY+
         XKkqxEKEK5qur2vf5crKj3iCqFqhqFOvJoc33xpmGNJ91KDSEoQp3LNMfvRJuwLrCY+X
         XDYBS48WJI9UX/GCV6h0Y/1Y4WdF3J6ZAKOyFURDHJnC19YbA6/3FJPGYHY2vd4g/wb7
         ivznBJXGqg0K6U/HbosfbKSp89zhiZ0ZW8OFRs8AFxrsWlLIbgERvIhUley3YMPpbrMY
         b6Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzGlmojkSbTWt8tEfyiR0Tmp8Yd1+8BNlP7XZr5l5Jj8sRV1jR6udrWzauR4v44+vWjHSMD1w==@lists.infradead.org
X-Gm-Message-State: AFq9FYIg7RicYkgQJQ0MHLHDE2RqIjmqCtTf9hf6BfsQHQYg41YuO0Yu
	LSnUqZ6dDo2eIiBnnj7ZJnqqs44N0kirQsYM8rXqIcu+YoqN59qYGd7D
X-Gm-Gg: AYBFou14RciAL8efiwFrwAxFGnAJQQtHhV+pGKko9mF8Rq3WamKUQ606aUClNXGE+o8
	xZTut4ti5XF0+rKiTPoDmFfTGjmFW6jDbvgHgkaIpCCrMDyr3wWtA1itJNR8RsLx5IVOTCPi7Mb
	qJM8KXZSQr9kJptOXkr+BtchAfBO47fd7ykeL3QMLdoQCV0MAbikvl7f28nuY/wAiCK4ZoEEaAD
	9KWpaW/gl8eLS9fNuGYUlpd+S+6yxKQ/1ocdFCIPw6Gvddv8S+be8WmtZe5xjlYgRJwa2kI6KaP
	DeZMdb0zhYWFuGZwqxjuUtZl5xN/6MDqeyvyz89xFxTXVOjBcKYVoNMhR3OCsYIlrEueODS6ayz
	7t0UK2q61fofK/4KS+KAuAO4Ov2dplES+prwShcHMrgnx9foHWd3NN2zzRBHL7enHO5YxR5FNn4
	5VgrctkfeSB8lt/lEgZu7k+NAbMuuBzQdcaGptdOTYtgsOwR18MD2VTvt94QgdM59PMVf8746Xs
	YjDB9ey+kqPcPpL9TPnsw==
X-Received: by 2002:aa7:88c2:0:b0:886:cae0:fb64 with SMTP id d2e1a72fcca58-897c700e74emr16786375b3a.31.1792131465299;
        Thu, 15 Oct 2026 23:17:45 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:44 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [RESEND PATCH v8 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Fri, 16 Oct 2026 14:15:49 +0800
Message-ID: <20261016061549.4181390-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071748_212402_6021F6FF 
X-CRM114-Status: GOOD (  10.15  )
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

Reserve regions (for GPU, DSP, ...) carry no data useful for crash
analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
reduce vmcore size and capture time. crash_should_skip_region() now also
returns true for MEMBLOCK_NODUMP.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index e161c8b65e00..0e2ddc933b22 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,10 +283,10 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 unsigned int __weak arch_get_system_nr_ranges(void)
-- 
2.43.0


