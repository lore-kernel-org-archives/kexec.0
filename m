Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5A5CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s35H72d+77FYJLR12nijBq1KSdcBQQdrhTAC7CnobQU=; b=hpz00w/HFtkACT6gCGBik07FUK
	ezJcdDh9xJbGosrlM3jNompOoQok6NMnO3Eq0cy0P+K7kBmH6XSs6o7NSa6fkc0nKTQ5cTwKzkkMB
	sWgz3hdKkg1DdX3kjS1WJRjgZf0cLBCiD5vop4GmlFOHVN6Zvwzo0Rbl1hx98/A2MeQEoRUz0pX0Y
	3gy/NJrEdhCv/a0bPIqumX+/l/deQoF97/16MqN2az1bsYuv89H8WndNCAYwgIcMHttFju54MyMRY
	lHG4sbRVOhnriX6tHSS9fLxhvj0Vh9nwFsbsmSqk81BJpWONRWGcx1BNP98Yo4MVLHbsUctvbf6yX
	iw2MzmIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbUi-0000000281e-2Tsm;
	Fri, 16 Oct 2026 06:32:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbUh-0000000281O-2o5g
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:32:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 973E3601F0;
	Fri, 16 Oct 2026 06:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD8E1F000C8;
	Fri, 16 Oct 2026 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792132362;
	bh=s35H72d+77FYJLR12nijBq1KSdcBQQdrhTAC7CnobQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vt1OeF+x4b2yxRdvfHGJiAufmJvygGY2iNsBd475Xm2Wf3Krj5sf7dFznIeMkQRtZ
	 AUivHJ9u+3sqJ16UAcU2urw1/Fbdy3bPCH0c8bcPadQeeF8nErMTdQFZxYelFdgWGZ
	 KFelM6ridR6OaWbe9D9g7C+UyCAFLpHnN3JIjAq54ByJjSt9cbiKH3ODVgAY9D4WbK
	 edqcQHhqJlFDgZxXbU1wlltiqBMwdSkaOiN/X2gM/ep0QSJcZV9FHmKRm82WbJEaOp
	 nuvk4hPaal6irLBQf1mIDhay0VMFQgYJvbTP4Bj6hypALc9USIMZNtXilqeqE2J6Be
	 qiACcj+1ngxow==
Message-ID: <sashiko-outbox-173868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 7/8] of: reserved_mem: mark /reserved-memory
 entries with MEMBLOCK_NODUMP
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, devicetree@vger.kernel.org, kexec@lists.infradead.org, conor+dt@kernel.org
In-Reply-To: <20261016061549.4181390-8-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-8-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:32:40 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] of: fdt: boot panic on sh due to memblock_mark_nodump splitting be=
fore resize
--

commit c3780e76cb8942c20c5a5a3858d45f390651c1c3
Author: Wandun Chen <chenwandun@lixiang.com>

of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index ecc9231026224..a5f223a74b7ea 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
> =20
>  	/* Save the statically-placed regions in the reserved_mem array */
>  	fdt_scan_reserved_mem_late();
> +	fdt_mark_reserve_mem_nodump();

[Severity: High]
Could this cause a boot panic on architectures like sh that call
unflatten_device_tree() before memblock resizing is allowed?

On the sh architecture, unflatten_device_tree() is called prior to
paging_init():

arch/sh/kernel/setup.c:setup_arch() {
...
#ifdef CONFIG_BUILTIN_DTB
	unflatten_and_copy_device_tree();
#else
	unflatten_device_tree();
#endif

	paging_init();
...
}

Dynamic resizing of the memblock array is only enabled during paging_init():

arch/sh/mm/init.c:paging_init() {
...
	memblock_enforce_memory_limit(memory_limit);
	memblock_allow_resize();
...
}

Since fdt_mark_reserve_mem_nodump() applies MEMBLOCK_NODUMP flags,
it forces memblock.memory regions to be split. Because memblock_can_resize
is 0 at this early stage, if the device tree specifies enough non-dumpable
reserved memory regions to exceed INIT_MEMBLOCK_MEMORY_REGIONS,
memblock_double_array() will unconditionally panic the kernel during early
boot.

> =20
>  	/* Populate an empty root node when bootloader doesn't provide one */
>  	if (!fdt) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D7

