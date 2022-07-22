Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EB3C43334
	for <kexec@archiver.kernel.org>; Fri, 22 Jul 2022 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kD/DCfgSzNx1eRh5afz4joTJDd1zi4f6ZCafFbdzXsc=; b=07ueCqjLTS9o+n
	CGEYs7qlTBMPQ37uH2VZictaf2dNaTkwhOPCW5Gtbb79TXmV1VUywUWggQh+WQBjyaFjwkcDcMce6
	SEveiBTOADUTpOw9KX7Ptt+0PCeN37ort03ItywvNhQTCe5Elw/FExVK5bzFY+d9iX6u8bKqBxiJe
	DQzoUfxeHV9CkQc8wUM/MdRxTS5dqBp5IiDq7MnGxmYJsYoB1sb+2COQNMx8J2UvAB+XVL5WaF8wN
	YnlMTmWFUzgaViEnlOWgcBKJZjKMWxykB92mBuMxgyWhdi2r60bJK42y/o3ht4uhY1c2rtx64CA3n
	hXK02RHNrrgRjsYRLZPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEnnH-000vYe-1d; Fri, 22 Jul 2022 08:13:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEnnB-000vRc-CL
	for kexec@lists.infradead.org; Fri, 22 Jul 2022 08:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658477623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFrJKjNNYU0491FNuTI8t6vKob0kktI0zA4xaCL8j/E=;
	b=aNhzsfrpBTpY/1VEU5Mv1Qwc4/XHi1MB5oE9rU2f+D9K1YRKq3Xm17g/Upx37yIgkfGU6l
	wt9WmmmxjkN2JkY9TKL8ufhgTPO3K/7ehBTeqURgFjjwNiXVti6uGM/hC1YaFno+BFvXyq
	YQYRJ9ItCdFs6jFS0UXDpCukycDFHB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-nH2Ht0msPDmXS7C0VR5CoA-1; Fri, 22 Jul 2022 04:13:36 -0400
X-MC-Unique: nH2Ht0msPDmXS7C0VR5CoA-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso2175192wma.2
        for <kexec@lists.infradead.org>; Fri, 22 Jul 2022 01:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFrJKjNNYU0491FNuTI8t6vKob0kktI0zA4xaCL8j/E=;
        b=fCu4z5QiLZPhYr6Nt5AIX2bj66p05OA+UF6doQfRdFcPBOm/yljDEezPCcinLYvagE
         OuhfDw8QuyaZAba6ws2tVnWCkBEnvlAT40OVLJzw0G5ajdc9bxJj+pKLN9aOLLeYOs8c
         Nb9zgTIlJC4Dx4KuLEY9Gv739Lf8xtPEytZhZiPxtjGGkc/1BsKSdVBgVvUOgJQwqZx+
         L7Ljs1sf36+mBYfiFKZzfIqQqjaXNQMbIb5U5nGMqjM9leEjmd5TKCLttR081B0fejPe
         1WlL7Ie5adBAQuVFV3wccXrna7PZItxfwoK9ezW8gkePmwnrxm1t0zKwgL4trYMXPz7H
         Ggfg==
X-Gm-Message-State: AJIora8egx0RGofPpOarOgSioJDIiJH2dl2V3TyH6No2NmX1QEeBSlMQ
	mwb9otQwPRc5mHdexnpbnTw5w1/n3D+p4GqvB2LUqjGXbA+WviH26rGWBciQb3p3pCWpG1dC7Zp
	vQloq4yszAMr4O016vvjWmIYpaFXa9FzxsPLG
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id 1-20020a1c1901000000b003a31be34df2mr1603463wmz.146.1658477615395;
        Fri, 22 Jul 2022 01:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVB+HIi9H23yr75K8PX/2qN+oLoitA0TnKRsCF5mFx9I8K+Vyw9ABD6g/5ZglB5xC20l6aZRQ/i9F1r2pHv/8=
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id
 1-20020a1c1901000000b003a31be34df2mr1603426wmz.146.1658477614949; Fri, 22 Jul
 2022 01:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Jul 2022 16:13:23 +0800
Message-ID: <CALu+AoTpiQh7NUJJZs+6A7MCUNWJq=NeSimoF=AVHpRptd36eA@mail.gmail.com>
Subject: Re: [Crash-utility] [PATCH 0/5] Fixups to work with crash tool
To: "Discussion list for crash utility usage, maintenance and development" <crash-utility@redhat.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr, 
	alexandre.ghiti@canonical.com, huanyi.xj@alibaba-inc.com, 
	hschauhan@nulltrace.org, Xianting Tian <xianting.tian@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, heinrich.schuchardt@canonical.com, 
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ruyang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_011349_525165_0EFE5E50 
X-CRM114-Status: GOOD (  19.60  )
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

On Sun, 17 Jul 2022 at 18:13, Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> I ever sent the patch 1,2 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> And patch 3,4 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>
> This patch series just put these patches together, and with a new patch 5.
> these five patches are the fixups for kexec, vmcore and improvements
> for vmcoreinfo and memory layout dump.
>
> The main changes in the five patchs as below,
> Patch 1: Add a fast call path of crash_kexec() as other Arch(x86, arm64) do.
> Patch 2: use __smp_processor_id() instead of smp_processor_id() to cleanup
>          the console prints.
> Patch 3: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>          the development of crash tool as ARM64 already did
>          (arch/arm64/kernel/crash_core.c).
> Patch 4: Add modules to virtual kernel memory layout dump.
> Patch 5: Fixup to get correct kernel mode PC for vmcore
>
> With these 5 patches(patch 3 is must), crash tool can work well to analyze
> a vmcore. The patches for crash tool for RISCV64 is in the link:
> https://lore.kernel.org/linux-riscv/20220717042929.370022-1-xianting.tian@linux.alibaba.com/
>
> Xianting Tian (5):
>   RISC-V: Fixup fast call of crash_kexec()
>   RISC-V: use __smp_processor_id() instead of smp_processor_id()
>   RISC-V: Add arch_crash_save_vmcoreinfo support

Vmcoreinfo changes need to be documented in
Documentation/admin-guide/kdump/vmcoreinfo.rst

Otherwise, I suggest to always cc kexec mail list (added in cc) for
kexec | kdump patches.


>   riscv: Add modules to virtual kernel memory layout dump
>   RISC-V: Fixup getting correct current pc
>
>  arch/riscv/kernel/Makefile          |  1 +
>  arch/riscv/kernel/crash_core.c      | 29 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/crash_save_regs.S |  2 +-
>  arch/riscv/kernel/machine_kexec.c   |  2 +-
>  arch/riscv/kernel/traps.c           |  4 ++++
>  arch/riscv/mm/init.c                |  4 ++++
>  6 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/crash_core.c
>
> --
> 2.17.1
>
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://listman.redhat.com/mailman/listinfo/crash-utility
> Contribution Guidelines: https://github.com/crash-utility/crash/wiki
>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
