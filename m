Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62663CD4F54
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=; b=KdLPTmkDdTt4swiCdRF/fnEPH3
	OtmEBkWt09k8eOciP+Ep0KlP6LDRn2H1+7G689rnjOlfyQzJquRM4TDdDicTncf9KWKBh1LA/JTP2
	ucThMQFb2x8Te53jBhDOppOT/m15mqdmmNprnG+z9V8iBCRxjR9yGDLbWjlFI7CVEnmiXolinCZea
	tF3czNu3RWPIaCRsyfW/jZcU5pWWA/m/JMf5DjkFZDGgnbUA8fq/hmgW4TnBE4oE5rI7ZEjtDLpAM
	69cZ1psJHgoYXY+LgneCgrxkHSKLJ4BkumCbEXuEP/ESWIvY69a4s58qibfbnAWULhUHssSUFM2OP
	/CUO9WtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd6G-000000047ER-0rI6;
	Wed, 20 May 2026 09:20:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd65-0000000472R-3b0H
	for kexec@bombadil.infradead.org;
	Wed, 20 May 2026 09:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=; b=MdJoLlU5kgukdaMEPeB2SwmJ0g
	vMa7bgAp0ZMh8ShCJ79vBkvnmNjss/l575Yy4BDn96vhH2onE50ePL5/MFMB+pyoqLIVxzlHt8Zuw
	JFZzNqhyrTFFSsBeaPjzhNMPgj2NXUBJudXgQDB7GR0jET3bbLvWdB+xul9lHBCyLq+c0743EmS/Q
	x10l+sT/lRZ57ywLxIEUD++Waq4ilyxTsRnmGHVkE2y7WZbNU9maeAvmn6feqDWOvAKiCYBII3OjP
	0s13fjBy8wU+LLSqHJaVtjgvSkN1NjulcY1JvUUPR9okjprLbUTdOoDENf3ySqNbZXMN7/pXWRUbJ
	wYKJ+X9Q==;
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPd5w-0000000GKRR-0xUl
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:20:10 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2046568b3a.1
        for <kexec@lists.infradead.org>; Wed, 20 May 2026 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268802; x=1779873602; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=;
        b=qqQep14R8ot0SxRFzxEURMD6fXKma83dOZJEDjxEJ9oDwmhfRLbujJBaCjWzSF0swu
         vfv2vQNbK2zk2UXBa7ihXxSEH86CaBayUsZYqYdW5G/hKGHUi3xdAyfXmqMy+zE3BHJH
         FaMd03++s34WhHk/WtWFOOUvErcdZNLJS+tyawnHDzVgglBZJRuwEzyDPUctwmvCuCKu
         PcQcrb2lKp8efuqUqgIYA7i7Zwv14s+wknq0sFkcV53b0pDAW5SIRON/nWUKwEEFoeYs
         /D57ml8t6NWsCXIrWSsUPPh/FMME7LAdRlBmMTFJOJsN+PmEhBddRxvZ9pZZWpe4XINR
         6Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268802; x=1779873602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uewrEsj0ZjEAk2x/Pk2ITnSJY3Gqt9vqmVdLwg6RP/I=;
        b=NPV3V34n06HMmMfDqdvRTaETWiuZPKJYHZHLspWnQGFKjUCVMbiqIl16n9yMpjLWyc
         TebokrkKF7VXjKWMDiWyMJoJLqUrg6bFcj2SITBRZy2W4qs1dWPdtzS9u0nuhHG4B439
         JYUJyvq0T9qOAAEM+4RlprbnLQIBfFeD2vVUYZS289RYFi3Dp3vltDQ48DRVAqribXDO
         I28XS8s+5HLsGoLNt92e00g6/VHnl4tePj60RPNivLn8ioe6ziz8iMKtwEFzAviE/F9Z
         +wgi1HPOy1abIg6hWiG7zyBbfnvr88jIZwITsZDrlmjgrvNSAzCPUk8OHeXibVdmqPGW
         dLzw==
X-Forwarded-Encrypted: i=1; AFNElJ9C9TfaIfdgYTAiTm6sZnf8CTfHg+r51MgqnsSvzO+b5Umx1uqqDRsHGe5oJCmERsaAyonDBg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyivb2t7yUOYf+YLljsB+Hcd9VUnZWlpUHaaKvXvRzoUmMGOh1h
	jrWNxR62v33T4IGj8Ol0Zb2bLWsri1nc2e5wuonwK0K/K3PI1Pj/xfA8
X-Gm-Gg: Acq92OFwlUlAaN9JO4gDeDFNjA4EoLVGJCFqM+Ecy475o5g2asZC8RVGgy9xORx5f7y
	VzzUy99nn+FPJi1NEHl0g+ys9XsyOEzRX/sj0+Q0RiVIvECbqt2g3hdBrB7rTYS5NXANN6MXZ6c
	jLdOobBV9WaDdrp2+wKHCZ+/5LvOHtOsMiJJu/PQE7hDG754z5lDclas9sTHmvxSfSQYc8JZt45
	pBK5j4inFSYaoFJBbFHQf/zXdO5lwFpVoqNehPWcVjwR5jyIZE/yblPT9j9VIp6Vld0wcbzJkyz
	iKR/u3GJgr7FHLwjUZXcfkb0yMT7uXFvATR1NHWv6qO1Fzs223f33Je+EgUEff1o7rTPb2+UyA/
	/3WJ55hm2x4PRm67cA932PcJeUMtwzjKARRHnsxvpl0ip/D8vcsMpRlrjsHH5/OH0MWFHCATifV
	mCvaWQDywV4s76uK5VMUYroBPy9YaktQnGeM4IIA==
X-Received: by 2002:a05:6a00:1954:b0:835:366f:5da2 with SMTP id d2e1a72fcca58-83f33d80937mr23397364b3a.37.1779268802457;
        Wed, 20 May 2026 02:20:02 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm10208967b3a.48.2026.05.20.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:20:02 -0700 (PDT)
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
Subject: [PATCH v2 6/8] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
Date: Wed, 20 May 2026 17:18:42 +0800
Message-ID: <20260520091844.592753-7-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520091844.592753-1-chenwandun@lixiang.com>
References: <20260520091844.592753-1-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_102007_437123_4B5160DE 
X-CRM114-Status: GOOD (  11.22  )
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

Reserved memory regions are excluded from vmcore by default unless
marked dumpable. Honor the dumpable flag to filter out device firmware
regions (e.g., GPU, DSP, modem) reserved via device tree, since they
typically contain data not useful for kernel crash analysis and can
significantly increase vmcore size.

Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index e31fabed378a..1d65320c6ba4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
+	nr_ranges += of_reserved_mem_kdump_nr_ranges();
 
 	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
 	if (!cmem)
@@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
+	ret = of_reserved_mem_kdump_exclude(cmem);
+	if (ret)
+		goto out;
+
 	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
 out:
-- 
2.43.0


