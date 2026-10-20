Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18360A2601
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uBAIBFxy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1GiMUt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSsZkzzBNNe/aTV43Z32nPhmjz0NciIMlK5b8uQ8eSs=; b=uBAIBFxy59q+DLxtqhBFCcGVeO
	TtZckQqDjT4scRv/7/yibUNUXMqAbDGml9JUBUKaqHLaigKLz2EMp+KNxbI1+KSulmSquuZQhgQHa
	CHp66wfBVHX23toHokGyZ66qnmUs90aaT0+v6bWzRVpgVsSlIlnVCsPXwUqLAbHBm1uQ3JCQjqLpX
	CySiiRditZZqD1ymEsuAiqARZtWP8hcdZH9+LYCBXPPwsbBoYGTa0L48Yw3oDK1O8d4ubgz62Gvsc
	X9dc/djjSY1qjjRIIMsImz1TOyvNX9/I0JLOujUOYrlvMSfvdrcnfZGev5NdRP5vhkzmtWdbkJ6F3
	tqf4vLZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56S-000000099jt-2Wg2;
	Tue, 20 Oct 2026 08:21:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4v0-000000097c4-1Fwo;
	Tue, 20 Oct 2026 08:09:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A05F8438C0;
	Tue, 20 Oct 2026 08:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361FF1F000C4;
	Tue, 20 Oct 2026 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483797;
	bh=XSsZkzzBNNe/aTV43Z32nPhmjz0NciIMlK5b8uQ8eSs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Bz1GiMUtVdCxcnrgWdw0nUgk3XjmNZkUSWIAKL6542R8NsGR9CCPthO/llpAKQpVs
	 BMrYgVtgXR+WBclpzdm2maK+uihORxVis9YyGSohSAC9tcKWg3sWc7sNaMbPLcTF/m
	 jLqY2p8/fix+MJqukHD6KLRg0t8y8yRkCW7UOIfmhWudURS2yJ4OsYMY6iwbUTnxKx
	 OViCdgx01YkG1X8f7F8+iPsg5qvr+T4GyTzQ7EfBugtX5bw7V3bfLGdboJIhMaLgfd
	 qO1VcSV6mjmsF7exhP7uFHh7iJLKUjxZSpuOx1L0fzwUoXjoX5ANMdrJnQGjqVob3+
	 MfrluQfgmtYOQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 leitao@debian.org, yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, 
 robh@kernel.org, coxu@redhat.com, kees@kernel.org, tangyouling@kylinos.cn, 
 liukexin@kylinos.cn, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, 
 maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com, 
 vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
 thuth@redhat.com, jbouron@amazon.com, me@linux.beauty, 
 mclapinski@google.com, graf@amazon.com, bgwin@google.com, 
 hbathini@linux.ibm.com, eric.devolder@oracle.com, 
 takahiro.akashi@linaro.org, james.morse@arm.com, palmer@rivosinc.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.11812783408034710690.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:11 -0700
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

Sorry for the delay, it's been really busy time for me.

> As Baoquan and Catalin suggested, this patch set fixes
> several pre-existing code issues found by Sashiko AI [1][2][3].
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64, and similar issues on LoongArch
> - Fix out-of-bounds write on 32-bit Highmem for x86.
> - Fix TOCTOU race in crash memory range collection.

It feels like these are three independent series, maybe with slight
dependencies because they touch related code, but it's not really a
single series:

> Jinjie Ruan (14):
>   kexec: Fix CMA segment address translation with non-zero text_offset
>   kexec: Record allocated CMA pages to fix release size mismatch
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>     loops
>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop

The very similar commits for arm64 and LoongArch imply that that we have
some code duplication that should be addressed regardless of these
fixes.

-- 
Sincerely yours,
Mike.


