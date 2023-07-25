Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173FC001DE
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kZZWbbSYYcIi3B0+1YjTocVFVWsbhtfxio9ELh257lw=; b=IO1tA/cneN36MM
	4K50vw5ma8bqEhk6QKKJqFNJqXvFm6BtnZEC2J+vY6WT80VqbHSBKJ8wqfMahsd6UgiY624GSMUGr
	RrkBPpKvqOvx09jrmHy137LfVEcl92D04hWpalbR8TFZ1pVLzWmGgxtVyXBHmJw26zsoxItW4q8cx
	ndhTbsc/2Q0YrRlEznRc3CIQ1osKcAKJJCTCBY+mruAtg13l8XeiXmrCqJB+ADioOHTdMXLbavZEG
	w7G/M38o/BmX850iRzOTo7K1LpRgOlgem9tHPqgpCqmMwhU0fznUTJgIzPxD+sMoRzKhYavBXAXgT
	LesiBe24wndA0pUQcGQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOEw9-0072w0-2G;
	Tue, 25 Jul 2023 10:06:37 +0000
Received: from bee.tesarici.cz ([77.93.223.253])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOEw6-0072uG-27
	for kexec@lists.infradead.org;
	Tue, 25 Jul 2023 10:06:36 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1C8DE16F842;
	Tue, 25 Jul 2023 12:06:28 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1690279588; bh=bsblOb2yuHRfSrcFSBe2L6Bqn7/ke9Mqkv30xQt0zLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9zbyxXosVe7/i3cGzouFYdyaK2xuWiq+TlgP72QAwvphy3I51X4hLDDKWz5mQknb
	 f1+gY0FrHcbtxf5F8so6QwH5PmMDKt+yqWYOan7zd4uZvTP7FxmO27K7jxfC/W1JGs
	 qiMDF2ak9seJtUQhQC+4X8HkwUiB9KXTHQ1EFSy3m9nb/dtbmKIdmvaozud1A4eDup
	 9bJFavifkQ4Xt2sTb+vxwdApaDx7pjdpdNtGy4tNim/QkVBU7E3ZtUBL4v64qDAuV3
	 SZq0woBGpx9f8hGJKRbFeHNrStzpK2+h9No9RBMM6SQIQdwXfi0J/ZxIKeOS8ZoIAy
	 ZGa7bB3JNoJiw==
Date: Tue, 25 Jul 2023 12:06:27 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v1 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Message-ID: <20230725120627.32963156@meshulam.tesarici.cz>
In-Reply-To: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
References: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_030635_157469_000BC56B 
X-CRM114-Status: GOOD (  14.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

oops. I wanted to _add_ the kexec ML to all other recipients, but I
somehow screwed up, so this version is sent _only_ to the kexec ML. If
you reply here, the other recipients will not see your reply. The real
thread is here:

https://lore.kernel.org/lkml/cover.1690274483.git.petr.tesarik.ext@huawei.com/

I'm sorry
Petr T

On Tue, 25 Jul 2023 12:01:07 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> This patch series handles additional relocation types and removes the need
> to implement a Global Offset Table (GOT) for the purgatory.
> 
> Petr Tesarik (2):
>   riscv/kexec: handle R_RISCV_ADD16 and R_RISCV_SUB16 relocation types
>   riscv/purgatory: do not link with string.o
> 
> Torsten Duwe (1):
>   riscv/kexec: handle R_RISCV_CALL_PLT relocation type
> 
>  arch/riscv/kernel/elf_kexec.c | 7 +++++++
>  arch/riscv/purgatory/Makefile | 9 +--------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
