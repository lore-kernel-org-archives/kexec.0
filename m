Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBE606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P8IX62OI;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=fOhn8+l1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GNJE6UZ1rBDrjDiT/mTO/LT/Bdfa8O3VHkLcxkHxptk=; b=P8IX62OIXmOmzw
	l1/aRBMlhO8bEaRc2s8u72LuhH44vD3UkoEthFINASCrXb3m1qEWojICFP+8k0BLOf/JMHYyz7XN/
	SkiFs228cJYW4MSeHOCkO07PzciQK5atENED7RqXLYEuYa6NNxwxUC1CHetQ7IZ5Lg3JAvvC9Co4i
	OSceNsHQ+dFHTz/zzCJG61r3rrp4pAQ4b2n7QGDg1keMPua+sJyMRXUkvsHtYQK3o2AwFSgacbf6+
	6gea5G9VhlrVABFXXuwDcv3J8287C/EiIw3yQVd6GSRw/AcwVdKftMeFCrivJWUcAns7kPB7mH/UV
	2Pyfr5hfSJbvzVgfc2aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTw1w-0000000B1f2-0BcU;
	Thu, 19 Nov 2026 06:54:00 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTw1s-0000000B1eb-33AX
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:53:58 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5ece3ab2e91so663252e0c.2
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 22:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795071235; x=1795676035; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GNJE6UZ1rBDrjDiT/mTO/LT/Bdfa8O3VHkLcxkHxptk=;
        b=fOhn8+l1mjJksAO5srRtUKK6VjIvcQw0//9mFBtr7ZTkb+kYBgKgy9+ITighqw+e4e
         mJ0n5bvpvMPTgH2Y4EUGI6qugUfeiQsqF1F4SBxI2hzcTHDCtzLt91+Vcp1Ew2SbMWb/
         RcfBjZf2eefnx4cGXnqDFMC6X2wpsYVsQsgSp4UGeIlQfiIOuNtI6aG7/5rfX/MSiU+3
         RzSsabQG4tUKH+15ah/A+hp2dm/Udkhes7UfoEo+pwbAwj+2ne1SUcK6A9acW3Y/fjPv
         O/y5PJVT2G0jVz3FNhUt3+JyRvM/RLwWrP7V3nuKecX2R7RcnisPnIg69R1MDbjKAr2q
         qQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071235; x=1795676035;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNJE6UZ1rBDrjDiT/mTO/LT/Bdfa8O3VHkLcxkHxptk=;
        b=LpV1MOhdTCF/L1gMgUC6a07aByGFq9LTs2sk25XKlUu2LyKfE0KUtiL3Nz7PfTM0W8
         z+lFprjZn66lcj5ELUFqNvUGrvNNu4hI1wxDq02FUOp91iJ+IygUNCMVaezCsHneRw8a
         NanKNYDxUnYsu5xPzG2nTek04usXP140Mm1EWHOw97AJsS65fWi/DDemklNh8XAONkQL
         NWMaji9nMieTi2J1tFV5wPX5HMZqhym2L7yjMpGWjmJGr9bXcJNeX9AQ9WVwcz/L2EVF
         7Gq+3z3ytOmzEWl6ocxTcXFtxdbZQ3LQU6FYy23AqrUACljfMZlYcYL+3urVx3TMGTCE
         k2HA==
X-Forwarded-Encrypted: i=1; AL+hErFfmP8v0fGtrWDw+R4hcLiPhRIZkDAzVzGJR8hqQuv/i84aehOAO6iMfYrRgoQJFlimBgGH7g==@lists.infradead.org
X-Gm-Message-State: APuU4Z/5iNL814SaMiBDchyjkiz5bUDepTZ6LqBPRWFGxCSRtSdF7Won
	91sfV6KIOfCAMVBkB+iQU82MmUFTDlkJANBJ50PbuXutsGz9qMTI7IkiydRshEWwgt4=
X-Gm-Gg: AYBFou3/TGlSsWuMHVFxL6IqRt7VV/1sqEU+M9BjAuGae32ZHRmE+hHVIMK7UCgxkAh
	TyjH4fbjgyg+hDPlcPxXZQHCeNjqqbgohhKS6tuKD5LBOsp1ZT1W1OjOfaTGs/17rJ0ZodRk/PC
	uA9MXdL3UdkniWsQcN0+ed4osQ/YQxYRiV2kDTvlhZcrey7Gfqxu9ZoxAn44k3+Bx9lP+WimtqP
	1KlCAqpO5r2AMOcKGuhFDyhNciz5uo2+NpZPPp91INXshiOPb6BDByosUiZKVY8X8lbdt8V8NGm
	SRi1mEggPBwwe33k2au/4b/KQpRXh/Zw244de5BbJDI03/3aAEo2EuhELZybZDfQlnjHut+2YvZ
	2OIgc3ebD5vkPI2/iLZQTubgmBez3c0jQYpVoeSVUc52NsTAgOabMYc2NjmsfpfDgQhTbhx4qA0
	IElh4YropTt018Spk4yS1RjXd34IIJXZF/mZSXU9aU2qeSuZ/dl+Qgta/RaAZdRPTiFvwpBncag
	15H2Cjav7EemImPtloZ5emi7eClAVSK0wp0WhQYzhrZneq+xSWdomQeiwex12+YBL4Q+41RPI75
	Uva0//Z2wrLhFrPNr95/W9qdo3Z1Vr27x6rj2hE5O2KlfArhWz3vBME2or8Z5wvPTJqO/M7T5wm
	46y14GwXB8ojNyUyGOOzbRXYJz1DtAGvKTgFzAh8FMTRvKfc=
X-Received: by 2002:a05:6122:62a6:b0:5ec:c162:d58c with SMTP id 71dfb90a1353d-5ee646c8d94mr2473939e0c.9.1795071235328;
        Wed, 18 Nov 2026 22:53:55 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64ed7adesm3423790e0c.15.2026.11.18.22.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:53:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] kho: drop the incoming sub-blob debugfs view
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Long Wei <longwei27@huawei.com>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 akpm@linux-foundation.org, graf@amazon.com, leitao@debian.org, 
 corbet@lwn.net, rdunlap@infradead.org, linux-mm@kvack.org, 
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hewenliang4@huawei.com
In-Reply-To: <20261119063800.698863-1-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
Date: Thu, 19 Nov 2026 01:53:51 -0500
Message-Id: <179507123198.250261.1844561072152549258.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=yPAAYOBOOObp5DgeME+PxCgH3xqwEnbp1bk4PDjGg1w=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq/p0CnroMuBFG1w6cbj8X59tE5O5lJneO9MDj4
 lpdbHwN/SmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCav6dAgAKCRC7dyhM23N6
 3ueZD/9IfpTbNdfM3QFnBSJ+zx3bm2JxD9dV5H5hWe+Gjsh41ZGlB0WnSHEX20Rmk1d5abeMW84
 YuOO5K7r5GSkJRKMvTTacqC2gsAKNdfqmQNE9Ga0TsIUx6HiAtnkCtLw9uR02oz172xoJc4mvO9
 +ZqbgXBHRsVLRs+xIhbKLtgRupLeYNRefvdLlgfYjdO/EvqrXKsRlsp/0kW3yaffoQAvKCsNdmW
 16aMO3CiHE6yaQAN1D3oUdn/8llK8liHPsRBBs0apFi9EfuYvH8w9AdgiNOldeInZFxG3pQ5lt2
 J68ik5kvSGmYv3otuVVHATIhtPCzpFkefbI6TnzDmHQjsOyfAdoBeT+rr7RokoIs40ggiuZWDxA
 zLnpfdyvxylfTyeKBueMX8Ld3bqo8AIIqtoVhuzYNZty9jqG8zbl7FhUCJoAvQXKPlhHUFnwY6G
 HCYj3jsg8dYK/WsOI2Gu4v5CPjLTrlGW5oUPQtaQSzsnt/zLFKTt7EFH9XVT3Zb1ABU4Tdox8Y+
 suCeKE//fMBGowWddh1UZUiThSoAVyasPp/hW3v3sYoZlglqjIdYx9ky+DoCaGj19wrMNL2nFIF
 mY1HnMljaNI4FLF36QYmGhdJvoHC/SNewPtz4kM6nVlGQZym6+GFPOWHPmDV+ClJcKQUMi5Q2kD
 hQHgp+HNhpEYXww==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_225356_935349_963A0E12 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:37:58 +0800, Long Wei <longwei27@huawei.com> wrote:
> kho: drop the incoming sub-blob debugfs view
> 
> kho/in/sub_fdts exposes the raw contents of the sub-blobs described by
> the incoming KHO FDT.  KHO does not own those pages: they belong to the
> producers' consumers and have independent lifetimes.  LUO, for example,
> restores and frees its state in early_initcall, before kho_init()
> (fs_initcall) creates the debugfs view, so the blobs point at pages that
> are already back in the buddy allocator.  Reading them triggers a KASAN
> use-after-free in _copy_to_user().
> 
> [...]

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


