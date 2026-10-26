Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510E606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3DTAWrUn;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wxpYa9L1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=US0uto/7eSBm2nirGVeihVV9dWVz4q+SUEGpM6IyKCM=; b=3DTAWrUnhgCSy2
	04X9A46/61JU5ut8OI2XsSUO3GiJMhIjXqA781cmM4hadMnYmymUdw2GLuCz4SfDtW5cx8fcGqbcb
	JSEf6s/+BxLzZ7EjYZ2Af/4BazCxtDu70xeDNbZGLg6Vkn+2Zm3iXiG/SKKzj3tIwk6PSVnYFWPbU
	n0PR+cZukWg28YqfZs1o99VgMxCcL300JVKKZFVtZYKjpNZPZt2VY+oltbF58sFqlkwQPtsHO0we1
	WONQJRxi8UlBwlBDPs4rP4qV+xCQ3AOyySmZqYnfdF26AM/rh06I4XnTvBEQFYDIze9iotX6tUgUD
	vVl0TqqM/w6HJL69q+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLGoE-000000021iN-0UkH;
	Mon, 26 Oct 2026 09:16:02 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLGoC-000000021ha-1UJe
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 09:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793006154; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=US0uto/7eSBm2nirGVeihVV9dWVz4q+SUEGpM6IyKCM=;
	b=wxpYa9L16PYztk7C+KBdLnVZPmQuCi/EzAnvPiytD1A2ShanQa+NuY3ptSFenWijIBTNDHI+crRruEWrJD1tLohTNxPat+BSGaHKx0GMpOneYPxFjs35OE9I2jnPmq7z1hU9RbJOxTJnEmq3fDoCviy5b+4qO6MLu4pou/Ic7to=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XDWAIMZ_1793006149;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDWAIMZ_1793006149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 17:15:53 +0800
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
	sashiko-reviews@lists.linux.dev,
	shuah@kernel.org
Subject: Re: [PATCH 2/4] riscv: Add support for kexec handover (KHO)
Date: Mon, 26 Oct 2026 17:15:47 +0800
Message-ID: <20261026091550.9348-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-183678@kernel.org>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com> <20261023111612.2134-3-cp0613@linux.alibaba.com> <sashiko-outbox-183678@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_021600_598543_965B419F 
X-CRM114-Status: UNSURE (   6.81  )
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> [Severity: High]
> Can enabling ARCH_SUPPORTS_KEXEC_HANDOVER trigger a BUG_ON() in
> linear_mapping_pa_to_va() during efi_init() when booting a KHO kexec
> kernel on a 64-bit RISC-V UEFI system?

Confirmed. Reproduced on qemu virt booting through edk2 with
DEBUG_VIRTUAL enabled and "kho=on" on the outgoing kernel: the first
handover dies in the incoming one during EFI setup, before the console
registers, so it stays silent without an earlycon.

This will be fixed in v2.

> [Severity: Medium]
> Also, will kho_reserve_bootmem() fail on 64-bit RISC-V platforms
> where DRAM starts at or above 4 GiB, or record a 0-byte region when
> all DRAM lies below 4 GiB?

Confirmed, both halves. That is generic KHO code, not the riscv
enablement, so I will send a separate patch for it.

Best regards,
Chen

