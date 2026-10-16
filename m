Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F4CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ld8mEjUAGTcPY+16WaZbLCuSIaSIXp60OFSMZYfSv5o=; b=d97PlyMCS30XWu+/71oDqdhLNK
	W4m21fXhPdfTPhXTAM/9sU07vpm/vwPkk1jM3Ypp6Eno0lZr5+M52jpx8TMrb01dWNob+SYGsnN9Y
	HsIQwqvGWFRXbZy7XjX9kuP81tSqvvhn9XB3bKh5H4sq49qvtLhkcrSd9PoDFAN7hIrdaoMMy0Q3q
	aY2dNC/4AChnS6Ht5hc8B+Acx0UP80NJSCOHdd460l9NVU0fuCjtKdUA1mg6B50kVYfDe7dUUbrKD
	XKq7cyaLfu+QAiKpMuuvG9fFGH7C+MhZilDwaiE8/PBNCL3VhdFxagGtpxmWONPiFd5mBuDlM+GrA
	eb2rdKUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbQl-000000027eP-0DfC;
	Fri, 16 Oct 2026 06:28:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbQj-000000027eJ-0CrM
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:28:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E75D60008;
	Fri, 16 Oct 2026 06:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C0B1F000C4;
	Fri, 16 Oct 2026 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792132116;
	bh=ld8mEjUAGTcPY+16WaZbLCuSIaSIXp60OFSMZYfSv5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QfuBhXp5YYIdqHPkUa52SmDpYB55jfo7KcIV15CF906ItE5/81s0tRXqqZFJ/t1Hv
	 c3Jv+GW/9N6ZCWg3M6PeVI56WVBB9Ncj4FEglpsLTScSg2EdJIBq2t04EInaLd39M6
	 bqVpanmIch+g8hHC4dpm2L95jxqNh5iv8YbND12PfqFOVgmoSr5F/bPHotivWf7Q5G
	 4oWXB4uMg6zDs+k/YzyZwG83+uciKo/o8egws94dnSydJXI5OdZyjs5gq5Jkd6h81/
	 XH/n+/KyZfoHdd0600b13EzQO7oolHPlQXfCTZY0WSLfEJClMIHD5BIMyiTz6SfhhL
	 ejn2jBQAN9qUQ==
Message-ID: <sashiko-outbox-173859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 1/8] riscv: build crash_mem ranges from
 memblock instead of resource tree
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-2-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:28:34 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
>=20
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D1


