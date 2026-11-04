Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A4606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fhp012Bc;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cQg6Fz14
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QGFVMoJRZR79GkB1zDENh+lvuQ8N4gNHeoEkuezJ4HQ=; b=Fhp012Bctc9nx3
	kRpihpZiknGxsjjbcIniLjt/PXBA/ZVK6lWh18tYKuFO/mLisE0k+Qlem5eivu415pn/6PFatL02e
	DzquA1GVLd+jUeOsg75aZM4NWNVsiAZT+DGhaEylrSJX/Lb+rEHVCmOJZLYFUZxLmOtCi+CtGdb0m
	hlT2qjD+RO8BbUr5e4m6gUTmfNELg+g2rFC9TZ8HHYEgoyOviTeM9/ZZE7LQNEXCglYMvZ3jqdAJy
	oVaGpD/XEMDX+ldGzX/OFiCXKTfSKn5HBQ4tfKNmwlUhvyhyiTlBDDon5FtPA1W/Mv7CPvcixs3ma
	opHb8KpB8tX+NSk3zBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObJQ-00000005VwB-2IHK;
	Wed, 04 Nov 2026 13:46:00 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObJO-00000005VvL-0KyN
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 13:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793799955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QGFVMoJRZR79GkB1zDENh+lvuQ8N4gNHeoEkuezJ4HQ=;
	b=cQg6Fz141ge859rVLWY64KUCghhlsaItbkiCFQe6EVIflNVQlxpPjgQMulwHxXxIXqftbxwIOLwAU1osu38QwTZ1OVStPuUGAovtEsadxQm01p3GSgKBymPQtuN1TW+voyCN+Gr1lEcocPn8GUXgA4uoWCSUxL8Z6twnuz2211k=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XE5sgSS_1793799951;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE5sgSS_1793799951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 21:45:55 +0800
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
Subject: Re: [PATCH v2 3/5] riscv: Add support for kexec handover (KHO)
Date: Wed,  4 Nov 2026 21:45:47 +0800
Message-ID: <20261104134550.1779-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-196857@kernel.org>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com> <20261103080926.2079-4-cp0613@linux.alibaba.com> <sashiko-outbox-196857@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_054558_295553_0E79A3AE 
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

> As reported by Sashiko on v1 [1], will kho_reserve_bootmem() fail on 64-bit
> RISC-V platforms where DRAM starts at or above 4 GiB, or record a 0-byte
> region when all DRAM lies below 4 GiB?

Both, confirmed by measurement, and neither is riscv code. Mike Rapoport
has a patch that resolves it, so this series carries nothing for it:

https://lore.kernel.org/kexec/20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org/

Best regards,
Chen

