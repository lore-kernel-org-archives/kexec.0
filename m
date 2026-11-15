Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA94606A336
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fAMfw2l4;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IQF1/Uxa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oMjYG3/Fyza/CbXoIQUPnk8H85cPMajtM8cpJ9BN7sY=; b=fAMfw2l4CymzBwEYYd6lg7rBeL
	wvYYc/srJ1DDxzcVVt8ezJPhVu94ostNCxplkKIKM0qhd9A/u5SPVJxZlntX9lMyTou5qCttB7tEi
	7PXcxmtxa5Xbk4wWBdtwJsB4HooXeWCjvfYc6jl2wClQF3JNObGRE8K/SdYiCU/Wro+e3QFUAUpuS
	XciDizHCvFqnkD4rWkg3zlVNR6ILAaHAN/gnxUAHPISkbKFjlMIYGNkz+QSrFevFSKESw4O0BoVhd
	KCyGThkaQsOg5OtOogJafcPfpXNEAyHMe9DDJx+ydko79FUMvw9JGfYFhZ9TPm/BVSHsR+EvoGmft
	2bo5zQ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTMv-0000000H6Qo-0KsE;
	Sun, 15 Nov 2026 06:05:37 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSTMs-0000000H6Pq-1qxu
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 06:05:35 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-37d424f1ae8so783775eec.1
        for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 22:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794722733; x=1795327533; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMjYG3/Fyza/CbXoIQUPnk8H85cPMajtM8cpJ9BN7sY=;
        b=IQF1/UxaleCZ4hk2W1r/2FImQj7qVuAgstxnCTgb1Q9kMM32qBZJfgyGwnWnjUuvO+
         VHjWq++XOvxHFDFe9IGxda6wQpdJCTYPpQPCIG+/28QxjsGvpAkaS3c6CvnNrKqfYohH
         hHmE/IsWAtI9zLVK8XLT7tcOGXbxdTNw3xk5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722733; x=1795327533;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMjYG3/Fyza/CbXoIQUPnk8H85cPMajtM8cpJ9BN7sY=;
        b=GlDFxnrWMN3RYYNcGsfmoes9DSUbn73Hpp6XmgzCZwOgqLj6nvTl6eUMF/gBaK3Q/2
         209X+Nhesa+aRNGrZhaPb/TvBMLqQKpXu5hHMT2ktumFuxMDcteENNL/POjUkJqKEVXX
         5WGP3D92hk4SHimxSuErp9KjpnKERav8uTN2Nf6MsxaZcW1vcoMNDddCC48PyTmNAimP
         ZluvlNeLT4RDOjbwCiKWgxeJujx8DYfwWBEA2xE2OLSdJ4BeKYk/jwC7yswiSO/ZEDHC
         C/ocbdyKKGaootbQPlSW7n2gdSHgL7gtXAqjE/7ESk1rHZPptqhiaur09byO7pZdbSMs
         TQlw==
X-Forwarded-Encrypted: i=1; AL+hErFlXYKzKNzZ0bTwsr6koocZ+LqX1XO3GTeDdSJoZ9m9vJODsgtmiN+xYyDkJ7kBagM7AAnhOA==@lists.infradead.org
X-Gm-Message-State: APuU4Z9tYya9cbfRqzgr7YXWAFYWA46k7UNuNX5U7B/41OZk85/TUyXX
	AkdJVkGeOmbUWeCYPKzRJF8LZkfwoBKHtS+3wR2gnlUO5uWtN8D6cTqFJxhAYbHNKag=
X-Gm-Gg: AYBFou11qd8s9vUQuW6biNp8M4fgwsZfAs/SJ01kgQ0Lss+CaIG3MX4gaEzEhk+K39s
	axQJRqXFzoGiuIzeABP+jk7j3cEuB3zdZyxcPSbbx/hVE5OUu5nbiZfEx+XBE1jG1bhZRVOOEnj
	c4g2i77iVaCjFrgmbn8JWnhTrPIyu6NAhKEFc2S1VZZfjHB57X9Ss3SbvlbHLVI/0H/i4uwXi9g
	Qb1WiD+jyU7QRx442NYYWgo3/g2asxPPEIuyII20zGsXPI4O3ngxlA88PKk6q2a1VIrdClSWDZ7
	2m5jCLLrVhPyk7XmR/3G32tYkTYImy+zEMiNkoPS6Njj0tVRrrL2k9XtMGABulAJTWfdarUmesR
	apgc2pGWlhjepOEuGBhxQoyyyEHiRF5UWQoRw0QkTdJvh0ODSm0xFc0uZ2VVN3l02CobRUTN2SN
	7fRi6SM1KiciJ5m8C7fK6ceEbRxFOKo71DFy6A7GqyxY/0Pd3915EVdoq/t98tQGFeJmZo4hDHz
	gBc9R/XQZDZlzZUN2MQiUssukrpidld8T4aYY/Q8F3YUeS/lJs8VKoRxYSLHZRkpReYv3b93pnA
	CkGYurB8RIUQ0V5acACR+TXGfT75YbB40rH7RWdA1Os7MTTLssPgfngVK+v59UzradWZ2gWoSF0
	IFQro2j1YokTPwPXEDMtu/rMOFpyPsVqUjARPOOdtUrvH42HUTikFb/lUF98U7q6RTWovXWnQrn
	be1py1kyoiM8FKfIOFtiecoJPfur7jCI772bbZwirtvZ/QdEV/HDumXHn2enbkQxxc
X-Received: by 2002:a05:7300:7481:b0:375:c5e1:931d with SMTP id 5a478bee46e88-37966e3aff8mr9995533eec.25.1794722733483;
        Sat, 14 Nov 2026 22:05:33 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm39445329eec.21.2026.11.14.22.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:05:32 -0800 (PST)
Date: Sat, 14 Nov 2026 22:05:28 -0800
From: Chris Down <chris@chrisdown.name>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/memfd_luo: keep memfd frozen until finish
In-Reply-To: <20261110175855.2437084-3-pratyush@kernel.org>
References: <20261110175855.2437084-1-pratyush@kernel.org>
	<20261110175855.2437084-3-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114220528.f7d9874a014dbb5d@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_220534_502907_F56E993C 
X-CRM114-Status: UNSURE (   8.84  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: 1.2 (+)
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

Pratyush Yadav writes:
>+ * Restrictions
>+ * ============
>+ *
>+ * While a memfd is preserved, and after it is retrieved until the session is
>+ * finished, its size can't be changed and holes can't be punched in it.
>+ * Operations that would do so (``ftruncate()``, ``fallocate()``, writes past
>+ * the end of the file) fail.

Not a big deal, but there's one more thing that fails in this window and
isn't listed here. Adding F_SEAL_WRITE to a retrieved memfd before finish
now waits about 150ms and then fails with EBUSY. That's because
memfd_wait_for_pins() sees the reference kept from kho_restore_folio() as
an extra reference on every folio. Once the session is finished it
succeeds straight away. The same already happens while the memfd is
preserved in the old kernel, so maybe it's worth mentioning here for both?

Also, fallocate() fails with EPERM in every mode while the file is frozen.
That includes FALLOC_FL_KEEP_SIZE inside i_size, which neither changes the
size nor punches a hole. "Operations that would do so" makes it sound like
only some fallocate() calls fail.

Otherwise I've tested this across a kexec and it works well.

Once those are fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris

