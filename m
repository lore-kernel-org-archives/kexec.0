Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A20606A32C
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TZThLwaI;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NftaLBSd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VBHdHG0IvkfIox653vorDa3irUr9xVe5wSK7A8Aj0NM=; b=TZThLwaIgso8/t
	7xGe+i9LhSDMYD9pwleSZ9r9BDRYkk5qvXr+y/C6gYNQyO2vsNVqpLVMhjDvBqM/xz3i/IOdytawA
	/VAzLOJjZsTVqoK41Qonhfm+FvydGaKiKXZcZQ75HYcrRhL8CCG6hVeJ7zZA/oNHFcMQ2mU4lSk+f
	NfiGb7xjLD/m1aTUndiGkmgvIg4dHtU5snGhEYwWBVfj02IzRgoigbl4h5lhZatiqe7cLJB0wcrk/
	exELulPg90YXyiMp1Ju1EiKXVdSsr0Y11wzAjynPNRkAbkY6bv8cqH8Zy9/jxpfei6lbYxHeiumTg
	l9sbWawldhSBfaeWSrcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPiKU-0000000Etwa-0JCL;
	Sat, 07 Nov 2026 15:27:42 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPiKQ-0000000Etvd-26G9
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 15:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794065253; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VBHdHG0IvkfIox653vorDa3irUr9xVe5wSK7A8Aj0NM=;
	b=NftaLBSd8viefNCtqZMIEChVV70uT5GRcJFArIQLasXx3ASF1SMeFh+NvDqayRva7y1PxX9gPtdta6kED6K4aS3uYCWH3oWkKn2BUEuXYpiWl2xuY0ZYgigixREErjdFNsnDJktMCB5NpcaYV6DvIUvkuT1F931hizk9EQWeE5Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEEpSZY_1794065244;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XEEpSZY_1794065244 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Nov 2026 23:27:32 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: sashiko-bot@kernel.org
Cc: alex@ghiti.fr,
	graf@amazon.com,
	guoren@kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	palmer@dabbelt.com,
	pasha.tatashin@soleen.com,
	pjw@kernel.org,
	pratyush@kernel.org,
	rppt@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH v3 2/4] riscv: Add support for kexec handover (KHO)
Date: Sat,  7 Nov 2026 23:27:21 +0800
Message-ID: <20261107152723.847-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-202683@kernel.org>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com> <20261106071459.2003-3-cp0613@linux.alibaba.com> <sashiko-outbox-202683@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_072739_091699_72EA2785 
X-CRM114-Status: UNSURE (   4.64  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> [Severity: High]
> Does enabling KEXEC_HANDOVER here hit BUG_ON(!kernel_map.va_pa_offset) in
> linear_mapping_pa_to_va() during early boot on UEFI systems with
> CONFIG_DEBUG_VIRTUAL=y?

Greg Thelen has a fix for it [1].

> [Severity: Medium]
> Can kho_reserve_bootmem() fail on 64-bit RISC-V systems where DRAM starts
> at or above 4 GiB?

Mike Rapoport has a fix for it [2].

Both are generic KHO issues rather than riscv code, and both are already
being addressed upstream, so there is nothing for this series to carry.

[1] https://lore.kernel.org/all/20261023054518.3258350-1-gthelen@google.com/
[2] https://lore.kernel.org/kexec/20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org/

Best regards,
Chen

