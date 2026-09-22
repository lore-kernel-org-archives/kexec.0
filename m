Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E17EC98305
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFj2nCVpKiIz+n9fFlODHsR1pKxI11t8bWPyNgAqBFI=; b=qsMXI62xmYX+IhBrIosVrhlLNY
	Nmrex+e5h+C3pYwwdYTaUkX9bXZEoOzkNtLnXcrdx2H0WEPcZw1QZV45A/yb/XH3guFDZTKZFmBew
	zd8E6Np7FgUuZX7vx8Ki+F+KfmR1qRvNqa1NEnpMnSXJEY2Z6RftJAtmWgGmK0nexr29V4+uQzHJs
	XaFn9iIFtIB8vsA6DKH6g7+mQo2XJ3NRvveznwWjX8/J7RpECrNLB0CWTQdhBHAAAKT00P2b2p0O7
	ABoF5CLxGftdAa5tUH2Mz9i2tGduPfKE2JeXSlr6oeXZomag169YP/jNbVUjAAYydtbTGJv/eyQUK
	b4I/EbVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w7l-00000004kBx-1xrh;
	Tue, 22 Sep 2026 08:45:13 +0000
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w7h-00000004k52-11Oz
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:45:12 +0000
Received: by mail-pj2-x07.google.com with SMTP id 98e67ed59e1d1-398e10200a6so2419044a91.1
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066708; x=1790671508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFj2nCVpKiIz+n9fFlODHsR1pKxI11t8bWPyNgAqBFI=;
        b=DmDSfa0QwGpubNSybh/kTABHLrTXuKNAhxPMvMDa09NgAD2ZB39MdRzV1LCbQOdhj1
         E5Lg9tBDokPDWIgd7mX9ffZsR3Ovczd2iBVH5nnjkBTg7XXpwoSyBWcx51CeDbRQzrFo
         AZbiDU8UJDpFZRwgQN7+SYsOuONQxIR/RSHDs2Gc4s1VHeCoGhF+IJacYdn9fMT6GdQQ
         sVSLp9W/rDOGj7uwawKyv8rtstcZe8pfToUh023p1Yv+pIPW18QjoqLh/+j9YyQ+Jyr/
         59Z6fUTI7eKSaJSrW7eazs5MwCNSgIOH+Wgld5ATAxg+JGzC4XRoMYxhLIPLC8xHdztL
         2pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066708; x=1790671508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFj2nCVpKiIz+n9fFlODHsR1pKxI11t8bWPyNgAqBFI=;
        b=25a5+ou7CE4hz3uFh0btJXWuI2cDUpgN0KKgzNruHA+Y4naSyQmstwjwuN74+oMbDY
         nHb/OaeWSI0cpNLeNua7NhmmJcweFl1PsdTV8b/HY9NSHBh5csnSH6yd273HcpCkTlRQ
         9PCx0/hjCE/nUygwvSlBl6OWvU05YA1t0hqoosNyKIF2+CkAdtKdMdL0fb8zAqe9Ka8u
         VNGVhgrnZwzH7EWRZGQYQ99ZjPdyYmdfjY5lvSbqVlsdhsZ81qvvI9r5Ajjy3z8hs2jN
         +4vT4bMrfVxn+1vSZGHItT5qMINGgZJZ8FfQ8okNmq/Idhqt4DuYn+92s7xdA2/LKNyE
         qY0w==
X-Forwarded-Encrypted: i=1; AKwUvBz0Of/7c2orphIaoc81eq+D3UnEnC3WlmUdMTWqE4Ikeg0hC3NwJNwyMOjdHuvcNLdNd2PFMA==@lists.infradead.org
X-Gm-Message-State: AFuF++k5YZ4vwEFY7kz7IXQI5tRkU7VpWr3j4H3Ncfh0xkQK7yUTD43G
	wgaZSWXt9PwvhBSDgcpb81HvAtCOWF3ziQbOL1HnZKkrgSK2zX1B0Bsi
X-Gm-Gg: AYBFou0LJxVy6LL2wKqxDqoD5+WLNCqw3kIg6kn3QLU9Fho+oowW6UOELXbpcYOwb8A
	Yt33/FEavEEHr87m29i41CQZvNBim5GihdwmIZnjBYFLPB6Ge6MVQAoKJDGMtJM8wNrRUbg9xno
	4q3JvoHeJc3LnLAOUcBAb7hr1NveRljowr439SUI5ThLF5NtLeYJ1Igv2NqKVB5luXMnUP1k1Jw
	jdKcAxZe9T+ztiS+TUazID4lhpcEujJRbt6QkttYcChYpg24Y/cXzDCpkfP2HpDTxQLK2AQ9Hpa
	sBF8anL2eAsKNdAYBs1EU6q14kxskhp1QV53VfJ5FUD3UEYIHbxrxciDibDW2bymnrfnY5DnAL2
	6DqHvlO7p1cUFxmDaxNIEvwbl4tlX5Jhh0uNC2QYT3kF8H8cfnzCAeBOjzbokGoDFdKSRgWo606
	38qja7YC/ILKZjJuCK0/yaE4ZgdCj826y0Lw8ZNisKO7JNkAeUSvs0ng6OXvVsR1VwM2hroTkTz
	/Z+o6urYZYisZvQjTfvqw==
X-Received: by 2002:a17:90b:1d8c:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-3a073182cebmr486642a91.19.1790066708546;
        Tue, 22 Sep 2026 01:45:08 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:45:07 -0700 (PDT)
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
Subject: [PATCH v7 9/9] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Tue, 22 Sep 2026 16:42:56 +0800
Message-ID: <20260922084256.1515554-10-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_014511_280504_DCAE45F4 
X-CRM114-Status: GOOD (  10.11  )
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
index c7acb2e449df..fdfeee5afa1a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -270,10 +270,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
-/* Exclude NOMAP regions from the vmcore. */
+/* Exclude NOMAP and NODUMP regions from the vmcore. */
 static bool crash_should_skip_region(struct memblock_region *reg)
 {
-	return memblock_is_nomap(reg);
+	return memblock_is_nomap(reg) || memblock_is_nodump(reg);
 }
 
 static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
-- 
2.43.0


