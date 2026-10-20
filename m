Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67573606A33E
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0+F6otxR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddCy9JWi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IL/ezpdN5w+pYR3PWaXa2V0Ctgdyc4AXOvpXb4+oGbM=; b=0+F6otxR4H1XiyCBIm2naO5pEp
	GcPOny6Sxyb7xEowjFIb9MpAnjAvNvsxHbFgKf1ascLbMjDu4IRCyyG/Dod6xmTEc4cwUe3SYBpDb
	pXOEhLDcRfkZN5ltp54dFNOay+ZghFRL3OfzalI+7j8vByDwXkX1vFO1DlHrVuG6WjT7PJlZPogzG
	A1vMrR3MZvf0VVXnMuARGmrviGTMvEQ4br1RDiGwgbd3e0iZIRoZ9nziFwi1ic2gv/6hwqgwryk/8
	cloESDxixMCrOURFxTXCB464+2lpfBHDeVkpg/nbDSBgzJc4fElTN4eQTzIuzGcsHTTI2mQn4PFQC
	KQqbcYDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56T-000000099kg-09Um;
	Tue, 20 Oct 2026 08:21:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ4vE-000000097eN-0CWq;
	Tue, 20 Oct 2026 08:10:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 753FF43B1A;
	Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDA21F000C4;
	Tue, 20 Oct 2026 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483811;
	bh=IL/ezpdN5w+pYR3PWaXa2V0Ctgdyc4AXOvpXb4+oGbM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ddCy9JWitnHDZO/lVYfOdqe6FqQZqK/Lrwor35sehBH4ernYh/kO3cjbIvzXzvQ+6
	 0t4DbnO6piOaO+yoKOwQnqFlMfHmUtpaktKYDBFT1wwrjS/2kp2ucfMslbKxvU8n04
	 VjwGhSDPDtnrlR2XfSco7VLRf+gK/8QeWu5EwzJzGgttxu7KMxwbxtk07n/uvd2UX/
	 gLSJcKQfIhNBZR8KZujEh6612ZeaQ6mdoQ53uDpB0wSajWSAtsss0dTwuomHZHK6ZS
	 hIQ77WUcqI09pFilPtMe5u2GgZYSGsi3W6zNJ1FXoD3cZFSAVwQwbswoezVhhSbTV0
	 HaGKGBQM22Anw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/14] kexec: Fix CMA segment address translation
 with non-zero text_offset
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
In-Reply-To: <20260921090450.807575-2-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-2-ruanjinjie@huawei.com>
Date: Tue, 20 Oct 2026 11:09:39 +0300
Message-Id: <179248377975.302547.13172455257147735569.b4-review@b4>
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

> kimage_load_cma_segment() and kimage_map_segment() both translate
> a CMA segment using page_address(cma), which returns the CMA base
> address. This ignores segment->mem.
> 
> On arm64, image_load() adds text_offset to segment->mem before the
> segment is loaded:
> 
> 	kernel_segment->mem += text_offset;
> 	kernel_segment->memsz -= text_offset;
> 	image->start = kernel_segment->mem;

That's true, but since commit 751c263bb74f ("arm64: remove TEXT_OFFSET
randomization") TEXT_OFFSET is always zero. This is upstream from v5.8,
so no LTS kernels has non-zero TEST_OFFSET.

Maybe we should rather start deprecating .text_offset in arm64?

-- 
Sincerely yours,
Mike.


