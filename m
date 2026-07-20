Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CE4C4451B
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnU7ciTdIjFA0g6aeFkEA3BJ1LdKH9Ggkt65tWv+LHA=; b=25L10Iuk5B5kWvdP2z+v6T8cJe
	tHjSEzI+ui1QuI7EBw2wsAagaIyyzjlxafhFsAtDdJccqTNaIvG7yWMm4KRS4oAOf6yvDJStNs6Hf
	WYMiZNdxwx4TLqmm+kqlh+h7tYz+CLHQ9wq9XmtRx/dR5PaYE7gfkmbLOqh7LZD3sSLA5leEbZeDg
	IYJbPmhkeRUJ+MtDqZLY7YKklzXqX7M4QFxowO8Cg0AY0wjlGfeMO8EThBsxO/8mwSuVuEA7PkaBo
	ypz8CC7FkONuCBoekDgMfWJGmaJOZk9HeaLipenMWMmXcVo1FiCrqhPbeOAIA4FFB53LvceqoP2pk
	N0o7C9Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkL4-00000006KA9-3jTx;
	Mon, 20 Jul 2026 09:31:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlkL3-00000006K9Z-1VrB
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 09:31:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E92B640767;
	Mon, 20 Jul 2026 09:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A41F000E9;
	Mon, 20 Jul 2026 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539864;
	bh=AnU7ciTdIjFA0g6aeFkEA3BJ1LdKH9Ggkt65tWv+LHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fR6E/vqji2DLB1TVZEVFIiJAOnTRfrb7bMwZ8jsFzD1C3pvLBxUepnJBSAMtQ9p5J
	 IHjllTcJyxL5O9BY9ai3W53eiQQySMrMcIfHM291Sizvl9o2hMTpmpBx21ELs5u2wT
	 u98eopd8rSVsPZXEtALKIfvfJK6HrDde9RnNk13Iubif6DgizWaID3SO4DnQBb3c24
	 HHsxDzaIn8qaeOMAhKyTuXFBmb8XAacQSlVPgwSuXoomU5KAjmhrMvyUkKmb9YpKYS
	 pArZx0oW+SVrNtlCe9v+S0400fEiG/DMKG9S90dMlGxBRFerT9rMH6gIi0UwgX0FqX
	 9RdzhnNzQQrhw==
Date: Mon, 20 Jul 2026 10:31:01 +0100
From: Simon Horman <horms@kernel.org>
To: luo.haiyang@zte.com.cn
Cc: kexec@lists.infradead.org, zhang.run@zte.com.cn, cai.qu@zte.com.cn
Subject: Re: [RESEND PATCH v4 0/4] =?utf-8?Q?kexec-?=
 =?utf-8?Q?tool=EF=BC=9Abug?= fix for crashdump load on riscv
Message-ID: <20260720093101.GD1736709@horms.kernel.org>
References: <20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624151934989G934gVJVvk0Mc95CogNWd@zte.com.cn>
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

On Wed, Jun 24, 2026 at 03:19:34PM +0800, luo.haiyang@zte.com.cn wrote:
> From: Luo Haiyang <luo.haiyang@zte.com.cn>
> 
> This patchset fixes kexec-tool related to crashdump load on riscv
> 
> patch 1: crashload should use all system RAM but crash reserved memory.
> patch 2: make the phys_to_virt function return the correct value.
> patch 3: vmcore-dmesg accesses the address located in the bss segment,
> use kernel image to creat kernel text elf header.
> patch 4: due to the kernel image being additionally exported in /proc/iomem,
> the kernel memory range is not correctly handled by to_be_excluded.
> 
> Changes from v3:
> - sorry for the incorrect email format in the previous submission.
> 
> Changes from v2:
> - use kernel image to creat kernel text elf header
> - do not exclude kernel memory range
> - https://lore.kernel.org/kexec/20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn/T/#md89827a089395745d3bd361889e4f3c490641732
> 
> Changes from v1:
> - Add patch 2 and patch 3 to fix other bug
> - https://lore.kernel.org/kexec/20260513171150519t11GTC14QEEV4EgIurNHM@zte.com.cn/T/#u

Sorry for the extended delay.

Applied:
- RISC-V: kernel image memory rang should not be excluded
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=8ec8f4156d10
- RISC-V: use kernel image to creat kernel text elf header
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=e7cd74c17c82
- RISCV: Fix incorrect virtual address translation in crashdump load
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71a968623b94
- RISC-V: fix crashdump load memory ranges
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=bbcce8a3d4ef

