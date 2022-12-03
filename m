Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBDCC4332F
	for <kexec@archiver.kernel.org>; Sat,  3 Dec 2022 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N5vnil9wF+DC+D/qwaFyM3fHw2xv1eWILfJ/XDQC2W4=; b=cc86r/Y+AMSqrV
	MYoVoG1++2f5B3Zs8Lg1Fzxv6KpajO2u2Grv7dQWGY3ZPpfE8mecU1a2dpQW9nyAbyza0R/LDaBs6
	o2ntlj+lsSYOIH2lGT0qBYewS4k6rPkXQExWsPbKPK9S16/XacaeASpE9e/kQX0epa+pLIkgTulK+
	yU/EDuyOindCQ2NwcrdqaeARdIlQ/EiuAi7IuXoho/zqLbrxbjnDA0FziNAlShJLfhxVYfey+2L9P
	ARrfRjJ+Ee4E4aZRrg3ctq/Lq979h3IYajOnO3mHPTBTQXjf2nxDmWCEIvZoWNqaPaPtk0S4Wz8mn
	tV7hpjhJeIUhgJYPqFtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1NLC-002ni0-6H; Sat, 03 Dec 2022 07:53:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1NL9-002nhP-5h; Sat, 03 Dec 2022 07:53:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A11CF60110;
	Sat,  3 Dec 2022 07:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013ACC433D6;
	Sat,  3 Dec 2022 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670054016;
	bh=v+fh+f5UA4ZMllDwmHzwUHLTYaB/xEbSJdsmYPmGyc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nak2BiuBVIBjFil7xWnOsIfDvMuVuJBsI472Ldeg2GUE7pcB1ArCRx7eg17HRgeYH
	 0TGSX+xJK4awCHCe6gQSEX3j2UzrqNjRi+WQZCbGMK3fJhdTW5ZetIv07E21tMha2U
	 6UDJKKUbjpDogCTeeBe8mjjKIulcgFe7rBucQyDR7ceVA5CzibAJIqRJEq5CkW7O4Z
	 Re4JncxHC1G5WYvVoKHbleoOJmX1zGPA+LmjSHM93CvBr6hg4Qk1NyBMXJZjsmG09/
	 pSt2yVCi6kyx2OrYWxRfzSX9vOcVVUy5isUUhh3UORRTsNcZPSZX0ATi7CElgwvdVO
	 NHxKWR4GUo3YQ==
Received: by mail-ej1-f49.google.com with SMTP id fc4so9480751ejc.12;
        Fri, 02 Dec 2022 23:53:35 -0800 (PST)
X-Gm-Message-State: ANoB5pmQwrs0RAGmIQw4X7jWPzaAqELaFBOHA2Exyg1XRhH+IOyy58JE
	DrfCT2CnEDIDQE+/EuYY1a011QDR6WOMSlA+ZKo=
X-Google-Smtp-Source: AA0mqf5v7PsMXkly2t9Dyuk1Ofpw2XwAbMWTqS1nzBeDCH1bbzqPn4lCENo9DXWjvMuC+kBTe4Amiepcel2hKDVj6Iw=
X-Received: by 2002:a17:906:99d3:b0:78d:c7fd:f755 with SMTP id
 s19-20020a17090699d300b0078dc7fdf755mr6375844ejn.702.1670054014194; Fri, 02
 Dec 2022 23:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com> <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
In-Reply-To: <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 3 Dec 2022 15:53:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRYwiPUTZWgWHTS5_k4mJsY9ZivbY+PCRfEDpANKNHXTA@mail.gmail.com>
Message-ID: <CAJF2gTRYwiPUTZWgWHTS5_k4mJsY9ZivbY+PCRfEDpANKNHXTA@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com, 
	vgoyal@redhat.com, bhe@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Conor Dooley <conor.dooley@microchip.com>, bagasdotme@gmail.com, dyoung@redhat.com, 
	Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de, 
	Xianting Tian <xianting.tian@linux.alibaba.com>, anup@brainfault.org, 
	aou@eecs.berkeley.edu, hschauhan@nulltrace.org, yixun.lan@gmail.com, 
	kexec@lists.infradead.org, heinrich.schuchardt@canonical.com, 
	linux-doc@vger.kernel.org, crash-utility@redhat.com, 
	linux-kernel@vger.kernel.org, k-hagio-ab@nec.com, 
	linux-riscv@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_235339_291114_DEAD896F 
X-CRM114-Status: GOOD (  12.99  )
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

Hi Palmer,

Here are another two fix-up patches of kdump for the crash tool.

https://lore.kernel.org/linux-riscv/20221020141603.2856206-3-guoren@kernel.org/
https://lore.kernel.org/linux-riscv/20221020141603.2856206-2-guoren@kernel.org/

On Sat, Dec 3, 2022 at 8:56 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> > need to update according to Bagas's comments.
> > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> >
> > As others patches in above patch set already applied, so this patch set only contains below two
> > patches.
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
>       https://git.kernel.org/palmer/c/649d6b1019a2
> [2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
>       https://git.kernel.org/palmer/c/c5b4216929eb
>
> Best regards,
> --
> Palmer Dabbelt <palmer@rivosinc.com>



-- 
Best Regards
 Guo Ren

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
