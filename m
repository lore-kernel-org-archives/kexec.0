Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB7606A31C
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dCkpuc/t;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gZ0StCU7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcMZ05Of
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=; b=dCkpuc/taDmnx6
	QcXYmpKa8MsDCFySburFxBquqjfRJgizJh2kBD6+o8PE4C03pWwH3fNjcwWmVROEEVE9fNLny0hL+
	6GJVLVrb9TRXEbPjFK8Vjs/KxSdf2RMeDpRSr8/PLmJPIpXubjzBgr7nRPQTCk6GYtlT7CYbRZuPm
	Wbgt5GuO4gFhFaNm2u6taSCmaPtu98TZhmRU++CL5V4+7bJ7Fo7izZFAkFxbw5FURhT5R2V8NOkkA
	avXJk8rRHoaruOq84aV1cT3t8hlRi1xeFqF149GrhvxcpIJRiEPLiNWiQLp2IS9+A8Y3GGbWH73yL
	6aReUe8lyBFQj+ibSsNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxT-0000000FNGF-1JGT;
	Fri, 27 Nov 2026 09:09:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxR-0000000FNEV-3wSW
	for kexec@bombadil.infradead.org;
	Fri, 27 Nov 2026 09:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=; b=gZ0StCU7FdYCm7zV4lySueqlnd
	mQU/M02qU5e52IOKf1pBefVPBfX8Bk3xfncmOnYvfccuiLPhudXE4eWrn6u1rmH3Oyu6fHWv/bklR
	kqwBg5Cf7aDN/24lzdw0wO70xMmAxWvRnP3GMQOO01G4hh4VMJypHYM8eOyxhjN6Wu3EaDl+dbjqe
	54t3y87vgS8u+/4WL+heOiqGotesyQqrbaZWjLcwsUStQNtRfBzAKZSAAa7VHvof39geB/y3TlHU4
	CiTCw4WHbSSDINZw8uObfWY/nLl0/POziNGn/47DrEA4PuTM+o2h3N+cpYktcmh/sjaPHzpHaiV/q
	P5dod6Bw==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWrxP-00000007UjW-00lp
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 09:09:28 +0000
Received: by mail-pj2-x0b.google.com with SMTP id d9443c01a7336-2effa00323fso31000735ad.1
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770565; x=1796375365; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=vcMZ05OfQT7jzQfJgVSOrOdv9VtrytrudlFrf8W8SP/fygaCgKH44dgrJe4fjqee2X
         76Bclwj02dPPLZV2IRpKYvGSHkKO+BsItUf4BxpIBGjuvsz/XZVchicc2SRi6OgNzfRh
         6DWLTDRFE2mqzej3FSanlSOGdkMN3hIJoJUyK5hjgjx6UOZvRORsAC8PKq2kvcCeqDAi
         mlaiuKQ0YwTQOJwsr/qU40NIKwDrjdsOwGTzxOHc+HJGDFhcYsXky/YoGFomKQ92h7Nz
         hpeopo9m+kiNF9dCFEsekRYPk7qBjjeD4OTzZ5SlVHCrLrDCcu3E7V1Llzjn8OJ9FChu
         FGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770565; x=1796375365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKmXp2d3TpfvxuGqVqHnwKm3WEcWPeyk8O3QNAPgerw=;
        b=nhxH+U+qY8VyDmb4d2q/iuYsEpz6vByQHRbANIJ8+TDO0zMHArABfLhXNKNDJ/lBit
         WBaDSEuAk0X0Jt4BmK1lOydc4hZ34L1tH1ky+jfDYpOohqxfWFNEKChgmj07fRt/Ovjk
         26UVM77c/WnAEx/4gII5xkDblqE1QZJwIF+56ck2chbd6ksUhv1uhut5bMBfH03gj+ra
         bQhx0a6zd8AVy+lxFXp2ficgAiGsIwaw7K4/Xuv+mmBn+TIJUe3X3cl6WJ73JG76iMtc
         A0uwjxWDfGREH5xaSt8ab4RFC+eh0u8UUSENFbb9FGLthrMlN2mL5sK5fbDk8ZerFSmN
         6rHA==
X-Forwarded-Encrypted: i=1; AL+hErHNgrgVxgiQrnlpY8h7wr5ugsLPweDK3ZY2RuKVTdgXpqyay0xMk3JSypuWkmpnCZxQ1AIeSg==@lists.infradead.org
X-Gm-Message-State: APuU4Z9slQ/YKZGjh8m8TFkdgcXfvxhHoL0rKCWNnutgGKfdahN0qQqv
	+DXkcLKmnBxV+cgLUewA1ek9lqNPCQ5B9hKFPCORkHSen1j9QRODxeXE
X-Gm-Gg: AZFdTZe+7SlLx3b7CRraoXPLOekRT+dWrGEjCAcFCkMeeMjcjEr/nRp6Xj/Dv2kmxYG
	oEc5Bqqjp+M8EWNIVMjjz7jAC5cuS0C2GmoBZKDPujzNUKnNgvEVNNKk9BWKWmcrnaWlfQkShpR
	+JVqCOrXg+IRIrlRlRSsla2kkgg7BoEPLro7DJLZdVmwMB7xpaeBQVsdKmTT6DP5PcxvEOSEu6D
	/rcIacN02TnaLWCth4snSO9li7MCx+7DNvH2NDaZ2PDF97e0O/5jzuaJmVzmfl5jW1C3iHZ2kHP
	SoaOO34JXC/IKVEw4BtsPr6GwE2IK4yUKo78b9fCLsWtT2DDnX0Kp8ManGGe1fewXj8VVGpuP72
	+nfK57vGR3kk7FNoZ/9uqAyDfB7G9+A8LkdQyqlYAwsnbUEWQnegtHyBbh7+hxaeGg0W3c0G/YU
	mkRULvApoxlth17aDtPW7+rE0gtBrTKvBP5S0SJghM3x+K3/LNydllYrU1EeRXMf0uDaDtpzPrk
	PAjifbh/TS+whMCkEjP8LOYZnI1eN4kJMrXE/OFdYxCNrr5phibdBWDQMW38jX8jmaT0ijoRwTI
	jMJdT1sb/ram2A0QuTY8XuVhTS8aqNLD3eFz6FAbpQ==
X-Received: by 2002:a05:6a21:3a41:b0:3e2:30c1:fdf6 with SMTP id adf61e73a8af0-4014e5562aamr21306213637.89.1795770564971;
        Fri, 27 Nov 2026 01:09:24 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:09:24 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
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
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 8/8] crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF header
Date: Fri, 27 Nov 2026 17:07:23 +0800
Message-ID: <20261127090723.741253-9-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_090926_990089_F54E8F3E 
X-CRM114-Status: GOOD (  10.21  )
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


