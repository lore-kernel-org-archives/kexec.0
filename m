Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DE606A31C
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ITPuajgD;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VYrevuUS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XmGW3ZVF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=; b=ITPuajgDpmmQaFZzjxMhzGFLOH
	lkNUbVlQt7KhDETHQrwp0Ktpt10vK+HMWsqZqHhIazf6s6py/2LdqWdvjo3rwrnd7j6ERRm5GgQCB
	tfaiSiAseV3EMh/3TKwExBdog5FuPin2KnwVdXMuK70hcckq0+iJ6k08MvXUfHSmAbGQ1eRgVvFGI
	Pq0yh2Lk4bGCzGCTZYIK5FKtXXHYvgcC1nw9wCT4CVIn+csR90zYFxAUgylhWyr38/9G2L6I7rKdA
	WUSNGIYj3YdG0A7jo33WoNRrDQWCqBKqVJkdu7ago3pzWM6j2rMuqZO35U6vXiwTDXM6Pu9Adxs0k
	SG+9w0+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRkI-0000000BNMj-0QC6;
	Wed, 21 Oct 2026 08:32:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRkG-0000000BNL1-2rox
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 08:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=; b=VYrevuUSSlR6oMVk+0AFi39dFt
	WYr100PzLCEHDzF4WaPChXryfpEI3juSLo6d3Jglj1w5AeHqJrGBKqw06UD1+9kQGBUyNDARxuBN8
	Ud7JUbWyCxg8z/fhp9HrSIGkmim6udH+lsQrhnGPBa/j4BUcqQGRMSPDigavoF9SfX2673ARuGfex
	n29kYQtAunEuILrDn062EREovdGxOOEjbi45O/pcRLwrkkLJvhlw8GxeZTtgoU/pGIIZt91BCijxo
	pJS4ta70Jcmp5A1vO6YexgYJzrHsAZ1inAV/nh4gc1VqAXVJQIozSN0IQVit3Af4lHjVk+TtriQ+N
	nmXhV4Ww==;
Received: from mail-pz2-x07.google.com ([2607:f8b0:4864:3b::7])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJRkD-00000005bHu-2Mt8
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 08:32:23 +0000
Received: by mail-pz2-x07.google.com with SMTP id 41be03b00d2f7-cc7c286026aso155123a12.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571539; x=1793176339; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=;
        b=XmGW3ZVFrgzye0+AsPU8BKAONp3N4Fw8GwhB60TUlmPdr9IJnwy+zvdFde3kVgDIbh
         UZAhOYIm/C44cxeAVM7n3sckPgekeQMuEnFsNy/oHHTwsP9SXZ7nMRIFuArbcaj/FIPq
         REhUEy0yzlYythPQ3D7tM6/N/5b9+WqrOAqNRK/NtfH9cOw5t4wCCObqllDYD4lYeeeC
         MqCYmASR/gCHOL7YNdN9+w0+RK7FnsPtVD5TeRYj5We1L98y9aqA7xAUwkHTUf/+a9x8
         hyJen3mkgWkjFvEIzoamgsE/gOJdiS7CIjZ+2dRW3OPCh0PDb//1bDn4RWwzACkR/sfa
         6/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571539; x=1793176339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUG85+B7KqrDZpPXGb0QyiCfKe+tueHmqLD38rgeJ0Q=;
        b=AqFdwIL0ZQv+2r0KxyXjddsnAj2/6a1ma0Dk5BNymCnPp9+q4e8xIXI5fYb4yDXGdy
         jzp+UiM/cTU0Bd/slELKZBA2FJs4dXe5ddeubY6UtHSHyFeprumP+geO1bNjNbi2uvFH
         7vRINLw+qhNGZj0QztRxgsxHBhPOLTDw9HPJJxCKeVXml1hpzu5YftqI/VoGRcPPEgI2
         UYNOjrN/Jda22d/j7Xlz2Y/hidmkh+8WfKCARMhylmmDTMulrqX/mbjMy+NYs5DELSRd
         HkneimsgdCVlThFeIHFwCgkU8nsxY8kLInE/AsFQCSMSIGJjxxyn3uhKVxaIiXL4y7Dw
         Vezg==
X-Forwarded-Encrypted: i=1; AKwUvBxzv5QwQyW87TJgTdHSP2oWtyXXApxXx6PuK9JG516NNx4NygGkErhlbPofLRvChydqr+3rNg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJPLX7/4QLRkezPLJppkl8uKqvXXGYTdsLc0Y+YjfIot4Dkc+Jl
	NNnYx3yfVoLcwHzGyTsLwIhmQTwHHBXgaN8tgikBDo3t+Td+hWPe8Hja
X-Gm-Gg: AYBFou05IIevdG+o3cTBZrjrhard8iLFGJheuLRpcugbwK5X3BG3+pXZHhe4wn2kHPJ
	lOJzM0w0Sd/V+n/AzRWx9PLuOKzVK9OxYOJxvfGjSOvQpZtXcK1R0yN8yko28zeoVbJb7bx0XVl
	BGYtiItOBdV3sASykWo2MDmUz+z1uPG0o+0RSmcjy7CL4tuf8nj4JN+BNyNvoLVNErVOr6CWcMh
	PL7+OrMwb5IQ6sVyuCxBtlQ8EmnCAVDYR6XMDyYc7+jO41FQFaQkxgXecUf9KFwYtL9j6CTdXB6
	KLvbjuQD6KhgrA9N1vIRzESOYK5AHklQKlQW/S39OalbKOXisBvS0W8VPLMMWMTOWWCnaspW45s
	XdvSIGwER4J219X0OrFcPnAwEgowo9azXdo9r2zrnFTMipeLop0hmi5fMwFlu+gnbZkwpgBwBiN
	SPlHbmLQNOkm/uf4fX9HqhlmUCgQL/yXxGIGwTXbARr/iuzWaFHLjnDqpgcttNjL7uzi2HW0O7X
	1mP7VvsZWQkgno3tSOEZahsflaNLxSrXWTQKw1gs1qlXVf4mBIzhNalJZlQzMPFYBSL
X-Received: by 2002:a05:6a00:a0e:b0:8a0:1435:fda0 with SMTP id d2e1a72fcca58-8a089d4702cmr1201474b3a.51.1792571538862;
        Wed, 21 Oct 2026 01:32:18 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:09 -0700 (PDT)
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
Subject: [PATCH v9 7/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Wed, 21 Oct 2026 16:30:10 +0800
Message-ID: <20261021083011.2170525-8-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_093221_827679_CFDAA132 
X-CRM114-Status: GOOD (  14.73  )
X-Spam-Score: 0.1 (/)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP and either CONFIG_KEXEC_FILE
or CONFIG_CRASH_HOTPLUG, so kernels that do not build or update crash
ELF headers do not pay the cost of splitting memblock.memory entries
at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/fdt.c             |  1 +
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ecc923102622..a5f223a74b7e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
 
 	/* Save the statically-placed regions in the reserved_mem array */
 	fdt_scan_reserved_mem_late();
+	fdt_mark_reserve_mem_nodump();
 
 	/* Populate an empty root node when bootloader doesn't provide one */
 	if (!fdt) {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 0ae16da066e2..505735732c13 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 
 int fdt_scan_reserved_mem(void);
 void __init fdt_scan_reserved_mem_late(void);
+void __init fdt_mark_reserve_mem_nodump(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..db2bf76000d2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -677,6 +677,24 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	reserved_mem_count++;
 }
 
+void __init fdt_mark_reserve_mem_nodump(void)
+{
+	struct reserved_mem *rmem;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_FILE) && !IS_ENABLED(CONFIG_CRASH_HOTPLUG))
+		return;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		rmem = &reserved_mem[i];
+		if (rmem->size && !rmem->dumpable)
+			memblock_mark_nodump(rmem->base, rmem->size);
+	}
+}
+
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
-- 
2.43.0


