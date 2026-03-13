Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD70106FD9A
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmwiR5JbS+usss8ODrAL9jskrM3z8cFZvm5LV3mBIS4=; b=2XfveHEYL+pSLIqU02/Rs5NHxr
	7kNEq6BMqfiD3VJv+G6HggxVnbvsGn+EeNtPk0yJqyklTXV8LqV86Dm8Iu9/juj9srVEhSAOcovVm
	f+JAhOj7peKF7DBF1UvdJMhSvvbQpX2cSFrdXSFvPyegSbEBE2iuRlHhsGyW3pOVjiHjnLrlXGBkD
	H85Dz1HrUtxDaPkYrx1BmBXeYqnypaMP8Neyakj014OK1QWI/fZND4O24nosvaYSL1nIHs8SDQ+XE
	NFk2LHtHKGZo8i/H7IJp/XbB824owVRQfBM0kqe1NPG4J0HCj5JMWZlRIsPY8oI7K4n6OqIG+QzvS
	BGC5Rjog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yFv-0000000HJX2-1LOZ;
	Fri, 13 Mar 2026 08:52:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yFu-0000000HJWv-2HQW
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 08:52:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 923FD60132;
	Fri, 13 Mar 2026 08:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF24C19421;
	Fri, 13 Mar 2026 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773391945;
	bh=48k43o44R/1vbm7ZEvmXByIBhou36tIdTyYZQ1Vswss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qadvyg2437vfW5DXSZvv+CTqQWYfifQQKqWfgWHaJ/5gs38GhaRMECVorotU98mC+
	 xy+q4cnZa34bPUgke9m0gPtLjLxLa3lwRB+wOovw7g5hF87Qt99FnCk0+XSHBIzDyp
	 UB4PvEnNrHzvEbv1BgArxECDF0c2D/aKqFExA1t/mYr9NrCb5yVV4eLL88Coz/q33f
	 xreztvIlCLTYme80VQxmFOvchlxqDGgXUYtEGoUGwQknBmWmmlRD8yuZQ4WtkyCrXg
	 9llfCseyBYDHAtXJyxn9YR9ky583XFOVCBFXYy0bwWFTKubLLxrA7nuEQceelko1Co
	 g0CriWexDKXaA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 2/6] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
In-Reply-To: <20260309-kho-v8-2-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:45 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-2-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 08:52:21 +0000
Message-ID: <2vxzikb0glh6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Mar 09 2026, Breno Leitao wrote:

> Since kho_add_subtree() now accepts arbitrary data blobs (not just
> FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
> its purpose. Apply the same rename to kho_remove_subtree() for
> consistency.
>
> Also rename kho_debugfs_fdt_add() and kho_debugfs_fdt_remove() to
> kho_debugfs_blob_add() and kho_debugfs_blob_remove() respectively,
> with the same parameter rename from 'fdt' to 'blob'.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

