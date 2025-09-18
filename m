Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB2CAC59A
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lBr/QAzBiWGNGqKC3WJ0+mxOh+6eQYMDMTmyp1Ahq8=; b=sFEZ9K/2QjlH656LjKgbVm2zWI
	vwZXnjMkmlchXY31hrVvgP4bB5KLedmKrXi7t3rdchEppdEuVwkiV53zmqnQVkAtjTOASq+a8v4rA
	SUncjkyY2nVLYOfu7MbCvqWstIraYKofrqFmFl1T6+xlEWQ/MgEysJap67jNkmRFSbqUuMpPoNxrW
	rhBO+8g946MVsMFTMazDC+sfod61YZezmVuyFbocw0Csc2W9bWpuuavKvXecbrBAvZsAbu0EHyMk0
	7HS4ywEOem4gYQLDFw8Y9O16YOifcaHgTSe8Lt1htodYsNAcBSh0XvGQrfuW+vlp5lgW/PyIUgqER
	M7DsrMLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBdE-0000000Gz9N-2Cce;
	Thu, 18 Sep 2025 10:12:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBdC-0000000Gz8C-06QB
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 10:12:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CF4E44560;
	Thu, 18 Sep 2025 10:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BCBC4CEE7;
	Thu, 18 Sep 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190369;
	bh=o1Cwy5VJ6G9kyEavxaxVgKPCYtlXDCW5Fv2OCftslK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q+jbxauwtdR3DlNbHbBHKcz5hgE1MjHos4i+oNE1mJHqF5Qjt7KV/JZS934WuliS7
	 xuey86HpA+fq59AA7iPhj8V3tTwUVGBSBsGfH/6D11xsRXVnkN563o1RbkRkmj7Sb6
	 d22+zYFiTxbHSr9uYnoClv4geEe7jsUQwdPAce8XCrUFTHdVbzCvmRnc0T8rMvU+FE
	 9jqz6DonfGwvKKRwFGWPsEMHgySm1ktjfNWDzt5dn+XR2tUWXqTRhobZBotKDgvoyk
	 taR4TbkICqh+e6ofP4HSEotbrqSEGGvBdDbmcvrd9COPTJzDZMoGcVXjGm+MYsvddl
	 motQ1jDffkubA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] kho: check if kho is finalized in
 __kho_preserve_order()
In-Reply-To: <20250917174033.3810435-2-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-2-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:12:46 +0200
Message-ID: <mafs0a52sgjc1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_031250_100963_EDCE5FC0 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Instead of checking if kho is finalized in each caller of
> __kho_preserve_order(), do it in the core function itself.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

