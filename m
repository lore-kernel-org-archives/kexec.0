Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C50606A331
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k8OOpzO3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHXDdl/0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r+p9CWsvki4gFWoEf4phi7R1PRk80mGP3t1GcsR85fk=; b=k8OOpzO3GFO2J19nyY02poq+4z
	l5moTt7J413Aj+nqQ6IVVVL024I9U+NFJ1hzCqepKnoDpBAkWnFdSoWNtWNFMM3p6Wi4sfvQ+plmX
	thtmFvPt5U3AkEqV04F/N/uZ+7ldOnbLxeMkRML5Ga/IfN0eBUP9HG9DRRlN6G2XlVRa97mMX21OE
	U+v1aTalC48qfnJiL+ePCxFBVW72A2EWzjTQ37/xnml8doqoy/jPUssr+oqoqQb0VwoLT2ekGK3UA
	1NZ21no/yPcOvbDpbQg+mTccNwppap3tDRPfoLhlSKupRK99UlM/3RP1ioKNtT79Lheg+izELXcWF
	2hDcEzyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTet-00000007N02-1YpN;
	Wed, 18 Nov 2026 00:36:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTes-00000007MzY-01Lk;
	Wed, 18 Nov 2026 00:36:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 93AE8459CC;
	Wed, 18 Nov 2026 00:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C80A1F000C9;
	Wed, 18 Nov 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794962177;
	bh=r+p9CWsvki4gFWoEf4phi7R1PRk80mGP3t1GcsR85fk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=WHXDdl/0EiLouLi+MGg08FvcqvqZP4js9AonYgqIzmzUe3K/XuplULWC+xJEwPygQ
	 QvifdtnAJEtyI6bcM9i72IshrE2dTnaDjFtXILMkioUxqh+f45QAshi8Z3DjjBsS3o
	 /pgvgpWi03BU4s0zfUOfHdvD0jWrMamvbKv7JcqCWcyu6vSEijFi+GZqVomEz78pDf
	 AwqF33in7XSuZ3WuM3378SNDogiZPh/C5JYmA5NqvB01j+9o/WBuWB0AXyidZTYGOc
	 8cx6E9Gnz+1UJyi2z6K1EMYCF+yHZX5pPbCDgzuZIGnN6blT2SXTSoq+KdCmVRYWu2
	 34ueIPw6CLNFA==
Date: Tue, 17 Nov 2026 17:36:15 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>, rppt@kernel.org
cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, 
    pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
    shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3 1/4] riscv: Call early_ioremap_setup() before parsing
 the DTB
In-Reply-To: <20261106071459.2003-2-cp0613@linux.alibaba.com>
Message-ID: <68812baf-206e-4916-faa6-78f8e7fa4433@kernel.org>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com> <20261106071459.2003-2-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike and Chen Pei,

On Fri, 6 Nov 2026, Chen Pei wrote:

> parse_dtb() can reach early_memremap(), whose return value is composed
> from the slot table that early_ioremap_setup() fills in - and on RISC-V
> that setup ran after the scan, so the mapping came back NULL. The DT
> based kexec handover parsing is the first caller to hit this:
> kho_populate() cannot map the handover FDT and the handover is dropped.

This makes sense, but ...

> Run early_ioremap_setup() before parse_dtb(), as arm64 and x86 already
> do.

... this statement isn't right, since neither ARM64 nor x86 have a 
parse_dtb() function.  Better just to say that early_ioremap_setup() needs 
to run before DT parsing.

With that fixed, then 

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

