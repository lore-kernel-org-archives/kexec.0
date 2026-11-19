Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347D606A324
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m3eaafQ7;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lC6uMZzr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z3UaETqrvFfA005xDH3cLACWIQAJP32vQKwKRzUivqI=; b=m3eaafQ7lTc7pl
	vY2sWCtCPyGwaCquf3mESkSTuoGBm+o5h7uuMODAhOPacVxnWJqpHMNyt4usi3dFduA9o8N/pCKzw
	B2kal8+5Q/W7BflDJIR5R+TNE+v2+AwIrtxBYtcOel84UyFT3QDknCuVJMpfQiYGJ93GrwGQRzYDO
	5iwhEU16hDjtlD+ve5mSL21WDvQYP+bArjtPfszCSyZoYHLuIrryWz4LZef/9F3APc9Z/jPBbXm7t
	D95JyHRGtrANIGKcyR9RRe9yEq+gTazUQptXUtOIMXrc3qltM++6JVOSOzJlgj8TRRrVSHBarN/Hb
	P45kiSO5apSkk7v+yifg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU1Nc-0000000BrDF-0AHV;
	Thu, 19 Nov 2026 12:36:44 +0000
Received: from out-81.mta0.migadu.com ([2001:41d0:1004:224b::51] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU1NY-0000000BrCb-0Pft
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 12:36:42 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Z3UaETqrvFfA005xDH3cLACWIQAJP32vQKwKRzUivqI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795091797; v=1; x=1795696597;
 b=lC6uMZzr3ePKQeAmTHxIhjRO54prPfHzsGIGlwdxiRYK/x13orsA38lW/OKGvJ2UJwbnLaGu
 IJaqHUFanrC7+JPI1DpsvL2OT+FfjO6qijHirmQdj3INbUcFwvjLFj1Rdau0Gt/Mp99dF9OE8i1
 8w25qsNQUOiPVzeU3R/Bc0xs=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 22a63bec1e9ad1bd;
	Thu, 19 Nov 2026 12:36:37 +0000
X-Mizu-Trace-ID: 22a63bec1e9ad1bd
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org,
	ardb@kernel.org
Cc: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	shuah@kernel.org,
	ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a configuration table
Date: Thu, 19 Nov 2026 21:36:31 +0900
Message-ID: <20261119123631.11165-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2vxzecch3x6k.fsf@kernel.org>
References: <2vxzecch3x6k.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_043640_324267_EE8B57B3 
X-CRM114-Status: GOOD (  12.33  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

On Thu, Nov 19 2026, Pratyush Yadav wrote:
> Do we even care about non-EFI boot? I'd say ignore that for now until
> someone comes with a real use case for KHO on such systems.

OK. The fallback is only the existing setup_data path, kept when the
table is missing. I won't spend more effort on non-EFI boot, and
whether to remove setup_data can be decided in the x86 series.

> This should be a follow up series. Don't get your series get caught up
> in x86 changes.

Will do. v7 will keep the table common with LoongArch as the only
user, and the x86 patches will follow as a separate series.

> Sounds good to me. You will still need to chase Ard for an ACK on the
> generic EFI table though.

Ard, you asked whether this could be an arch table handled in the
LoongArch code. Pratyush would like a common table that x86 can move to
later, and the x86 prototype above used the same table without changing
its layout. Would you be OK with keeping it in drivers/firmware/efi/
for v7? If you would still rather have it in arch/loongarch/ until the
x86 series lands, I will move it there for v7.

Thanks,
George

