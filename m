Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3BCAC5AC
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZcoNSnoVG+qrJMfOZX2XuUrCCP36J8i1i8eJwvKVKg=; b=d93zIUrjMZ7MPGESkDs9PAvBJu
	84y0QjxP3zbET2RL8xxJD2dDe8Zal43x1sKKwNoTML2u+9z5Vi2dDezCM4zSEGQuXvP7iexnhAXAk
	hOiJI9O2fjf1GxYnLgpR21LjGGCU034wrjbTh39VnhnTQBUMwnv0uncXjQH5WSHnXMdTwhln4x45c
	S8zD3nvthNt2aQfLelaZpcjRB4O3MJYjaZ1qtqaFWnnKntk3o17RQnrghZCVgUj6dhsp8BK0c6aUR
	CIzNH/sClylCr9cwAnr6BZFN8jDVyPi+GJouh5wuDFjIajesuFrFDhfOebrlCh7L6UM55CiifN/2f
	Rubhz+Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v13nN-0000000Dfv8-2PrT;
	Tue, 23 Sep 2025 14:15:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v13nM-0000000DfuN-12Ug
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 14:15:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AA07760284;
	Tue, 23 Sep 2025 14:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474CFC4CEF5;
	Tue, 23 Sep 2025 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758636903;
	bh=hOgqFqGCOLHkWPioyYxLY87soOchuPqBxZaAvGiM3FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvRwaUvHyjz4luMpeZOS3By7g29PeRV5kPqTQmcrXNnOOymwCWvvxQbOzJOT7ID1b
	 7JKV7WhGrm9Q62/io6FxpsZnwdePuGS0A95C/j7C3bjyijCi/oyMHY7CufaKbP4zrz
	 eH+A5aWjRZvLANpke5ESNzZMohG30AshP48WD7oljhFt56x0nO8JaMDu8oyUP1EQoh
	 cgO9FGNEVxl9YwoyRlG9SQ7VCtDgT2PCAxOWjx3Den6kYxr/34iDK7bnpNQj8RLmbr
	 nx3M/HOsrqPrinHvk6pNf8S2Yb6sTdGU1hRsj7FgbmSIaW5hUjdCGzUAf7ddqafGIb
	 z/yU2HgtgiEFg==
Date: Tue, 23 Sep 2025 15:15:00 +0100
From: Simon Horman <horms@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: kexec@lists.infradead.org, tangyouling@kylinos.cn,
	chenhuacai@kernel.org
Subject: Re: [PATCH] LoongArch: Change COMMAND_LINE_SIZE to 4096
Message-ID: <20250923141500.GB1084957@horms.kernel.org>
References: <20250922021057.206063-1-duanchenghao@kylinos.cn>
 <20250922025821.GA317763@chenghao-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922025821.GA317763@chenghao-pc>
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

On Mon, Sep 22, 2025 at 10:58:21AM +0800, Chenghao Duan wrote:
> On Mon, Sep 22, 2025 at 10:10:57AM +0800, Chenghao Duan wrote:
> > The default COMMAND_LINE_SIZE inherited from asm-generic is 512, which
> > is too small for modern use cases. For example, when the parameter path
> > in the cmdline of the kdump first kernel is too long, the limit is
> > easily exceeded when loading the second kernel.
> > 
> > Increase the command line size to 4096 bytes, In LoongArch, this is
> > consistent with the upstream configuration of the Linux kernel.
> > linux kernel commit: f7794a4d92ade518c813de69a01b27ca6d8d86f3.
> 
> I'm very sorry, but the commit ID in the previous email was incorrect.
> linux kernel commit: f7794a4d92ad(LoongArch: Increase COMMAND_LINE_SIZE up to 4096).

Thanks, I have applied this patch.

- LoongArch: Change COMMAND_LINE_SIZE to 4096
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b8f6c2a98d2c

And I updated the text when applying to read:

  Increase the command line size to 4096 bytes, In LoongArch, this is
  consistent with the upstream configuration of the Linux kernel as of
  commit f7794a4d92ad ("LoongArch: Increase COMMAND_LINE_SIZE up to 4096").

> > This patch is necessary because the Linux kernel has been changed to
> > 4096. When the kernel cmdline size exceeds 512, the --reuse-cmdline
> > option of the kexec command will inevitably result in an error.
> > 
> > The COMMAND_LINE_SIZE in kexec/arch/loongarch/crashdump-loongarch.h
> > is unused, so it is removed here.
> > 
> > Suggested-by: Youling Tang <tangyouling@kylinos.cn>
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>

...

