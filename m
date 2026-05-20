Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C7CD4F3C
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mxzEWL1R2sDou1abx9yR2WoOGdqqnaGEsR/cU7KUoPM=; b=oz/Vj9lBjXq9FzHVC8a96bZjeH
	ZbD/B0pjE6dKYKG9F73S42Ojs6Q9Vu7/jAanGYfT9l0a2+e7goe5lrtPZdqvx9tMbYoae1R4YCnSf
	xRKlWl7d5j9iNcshiS5OUNwwm0NzV8kLbMloZbGoXS611c9DanWnuEYWZa3MY2a/5yIEN6BiDt0ft
	+mxuYFLZEw1Q1+nwBmXTvdrohzW5VFzkMnvKaFb5AOIWbRH5v6UTkxCom6hcSOyA1epw6nX1KeSj2
	U3iesc3wvr1TOC2aGPOQDqsNIxrC9/aBLH88SUNdZgzdr5xk6h1NWnERYYc68Dhr0UpUX/j7ju78l
	clqdCvsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd4y-0000000469A-1N7h;
	Wed, 20 May 2026 09:19:04 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd4v-0000000467m-2lUA
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:19:03 +0000
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-8383fb7143aso2046031b3a.3
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268740; x=1779873540; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxzEWL1R2sDou1abx9yR2WoOGdqqnaGEsR/cU7KUoPM=;
        b=rThKbcT7/XKF2v96OpBMLALAgvHsj0e1EvJKpNrLrsrhTovLRYGr8hVlcwlnVetKah
         haGYjWFwW+tTTcnGwUvQjD/g6MmbsZRagSRBMH+OkkJafy6ZuvxT82E/qkPRBjfbWWdj
         dkcWmuLRTYNiztqHlXlC1Hg6AcRtdBW4gr1C/Wp9692E2GhwhE2A1cLZFZ8mQwFsH3Zk
         nor5Ts7yrzV9oNv8GJfoiA1dPpgVkE7LkcFwAfV3AJorBY3EXZRol0vTOPKhmkf/Zfc2
         eAK5x7/dVJ8xBxhngMnZepI06aAcoatREgd8NzrgFNQZWUT83OBzElEt6blOK4aFwcoT
         z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268740; x=1779873540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxzEWL1R2sDou1abx9yR2WoOGdqqnaGEsR/cU7KUoPM=;
        b=BQLkFoNq3DvJc0VD53+c21Y1cCZhqj2s1mvvF8BE1Zb+DbiKoDQhPEDYbeHuu52MUs
         DsB2MwX6MnMQmI3C2AkiQvA84cu3DlxG/hUFYUqZ8IeZ37bUZ59Lhs5Kk9ZDSBKB2bNo
         1Uhaqi2A2HW8oz9x2pzvuLFx3hb+XsjsJ/zDPHIdsg7trVa1RzeLlGlrmuo8tLq2x4DA
         4WVt1GUqG4XjAOpO5SH0/nOuEjwXqZTnFv1hWbdX7v4OJk2jZ/Q82LyKGgdTV4ls9Qrk
         CPQs/lMCunAE7Fyju1UY57t5V8k/vy3XFtcRengH2p87GOsoOXrtKGVgJBJwFRXZNZsC
         vYqA==
X-Forwarded-Encrypted: i=1; AFNElJ9gldJWh48m76FFCu3hHQDA5lT0VSIIuoIJN1JV1hb+Fq5adCLQI6691JU2UTXCp8FztQNzgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1U129A6CcaURG8tXbGLzP32K09DZ9F3Lf7FJtJWU5HGvCtvKu
	236QrIbCuyOuzaBHi8Eul6zW3xgI8qhIwOaUYlEvG1mwavJ1V5Oh/9AW
X-Gm-Gg: Acq92OHV4SUutEz6FXB1IBOE8R/RDiC/M514GQ4ja5ZVLifnNqmxE+hfJ8Ouxtutoci
	SeB06J7M/Qj4Q23rQILjDDuwKns1gZU12c9O2BodMsIbUyxpmOkBoagRnMSxy8HUxItog85EdIW
	pMqjBOpM41t6idLTkxjzdeFOpEVHM/QDlwU8wkpcjAL2k+nYilqqX85dWDbrkryQdtM8emBdnTK
	YKdJF38h0rxiQQdu5zNo1LRp1WEXzeDsUBqmvRHgySjc0H3K8oZusxHV3XWLOj97eNwie3s8SNQ
	Gkhb6gOcjL4SSiHfOF/iyAujWD54aD/spP62k1+bv+MK7+5NM3Qwq/wAxG3njYDf0oHq6TKRfDy
	GN3vMUaywlRGUb4bNkTYXPRAVzVIvTpQQviQK+8MquWsw24cPMNEa2K1BQ0iNQx+r9KWBLyp9tm
	CKkK3osVUOjeahOVKUu95Q1DYdoYz0Ezj+gcEAKg==
X-Received: by 2002:a05:6a00:2c95:b0:82c:e816:4135 with SMTP id d2e1a72fcca58-83f33de9724mr22532227b3a.47.1779268740373;
        Wed, 20 May 2026 02:19:00 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:18:59 -0700 (PDT)
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
Subject: [PATCH v2 0/8] kdump: reduce vmcore size and capture time
Date: Wed, 20 May 2026 17:18:36 +0800
Message-ID: <20260520091844.592753-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_021901_699945_AD6BB22F 
X-CRM114-Status: GOOD (  10.29  )
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

This is v2 of the vmcore size optimization series.

The original v1 [1] contains two parts of work:
 - Bug fixes and small cleanups about reserved memory.
 - A vmcore size optimization that excludes reserved memory out of
   vmcore.

For the convenience of review, I have split it into two independent
patchsets. This patchset focuses on the vmcore size optimization.

Motivation
==========

On SoCs that carve out large firmware-owned reserved memory (GPU
firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
those carveouts as part of system RAM even though their contents are
firmware state that is not useful for kernel crash analysis.

This series excludes /reserved-memory regions from vmcore by default,
and also for /memreserve/ firmware regions. The corresponding kdump
time has decreased, and the vmcore size has become smaller.

v1 --> v2:
1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
   feedback [2], v2 drop that property and exclude reserve memory
   by default.
2. Split some prepared patches from the original patches.
3. Address coding-style comments on patch 5 from Rob.

[1] https://lore.kernel.org/lkml/20260429065831.1510858-1-chenwandun@lixiang.com/
[2] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/

Wandun Chen (8):
  of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
  kexec/crash: provide crash_exclude_mem_range() stub when
    CONFIG_CRASH_DUMP=n
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: save /memreserve/ entries into the reserved_mem
    array
  of: reserved_mem: add kdump helpers to exclude non-dumpable regions
  arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
  riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
  loongarch: kdump: exclude non-dumpable reserved memory regions from
    vmcore

 arch/arm64/kernel/machine_kexec_file.c     |  6 ++
 arch/loongarch/kernel/machine_kexec_file.c |  6 ++
 arch/riscv/kernel/machine_kexec_file.c     |  4 +
 drivers/of/fdt.c                           |  5 ++
 drivers/of/of_private.h                    |  2 +
 drivers/of/of_reserved_mem.c               | 92 +++++++++++++++++++++-
 include/linux/crash_core.h                 |  6 ++
 include/linux/of_reserved_mem.h            | 15 ++++
 kernel/dma/contiguous.c                    |  1 +
 9 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.43.0


