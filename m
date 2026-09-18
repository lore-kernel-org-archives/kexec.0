Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C24EC982EE
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=; b=Dr8MQtE36863wumVMfI4l4JVj0
	Q0vnMPV2Q13zENd5KDMSOIaMJF86u7ia0myCfUX0NQN53cQy9ncPDUOBjuvmvl2I6+fiedVKhQru5
	r8z4K+3kbL3YkWPJrAxM2OEezRAujjL+TpEnl4WWeuNxLBYbn6da/6DC/ZtpLFeqinXzlm5NNfoBe
	6pLjoj48+TtaVI37FNXfBtbI/aDJCihwlGuMVXZebtiBbyeXNKYYA1a7jEwVN3ixmH8kfQqf8jDQl
	Y74CapjbJ7fttCUHTknfSinCtEFgobthVDItj3fjB973X0lEnzOvlW9kFNKbjAcrvF8mR3Df2pGx6
	rYW1ICvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4h-00000000NBo-1iF9;
	Sun, 20 Sep 2026 20:23:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Vmd-0000000E5eC-2T1L;
	Fri, 18 Sep 2026 10:25:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B11B41418;
	Fri, 18 Sep 2026 10:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170481F000FF;
	Fri, 18 Sep 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727130;
	bh=XCX7OD0MFSj63jeBdnj32V2m69meKqvW8/7zSh3AOsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgn07gul2XbQMTEsRc4NB0SooXCoVClfKj7xYlHbS0pB2k+p9hs37drFAnbcjmF6s
	 4uQTP4i4RTHhMXyDNCKCVqtp09Vt4jf/2sZpt6hXCITDDYmNLKHl/7GEuioB10pBbq
	 KgC8pFhunF4pZVF52aAyqYLmVje7onyZnDtkoMo7M+n8lrWgnW2qD56PzJwaioLm4S
	 fHUW0/h/VQS1YQuMks/Kfw+mvY5dmMgMBMzsknhX/LGDPMoVKKagSg7iLX1wTh+7zx
	 SfTRxREogXbxKWtWO3h7HjVP9J++VI67o4Pb8NZxEUTXLM29u8MBaqpCcwe6O9eeSz
	 2AjhZSXEB/PNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] elf: Introduce elf64_phdr_size() helper
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, lizhengyu3@huawei.com, dave.hansen@linux.intel.com, mark.rutland@arm.com, bgwin@google.com, npiggin@gmail.com, mingo@redhat.com, mclapinski@google.com, thuth@redhat.com, ruirui.yang@linux.dev, sourabhjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, catalin.marinas@arm.com, dakr@kernel.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, pasha.tatashin@soleen.com, robh@kernel.org, sshegde@linux.ibm.com, chao.gao@intel.com, rppt@kernel.org, seanjc@google.com, chleroy@kernel.org, liukexin@kylinos.cn, linux-mm@kvack.org, takahiro.akashi@linaro.org, piliu@redhat.com, akpm@linux-foundation.org, pratyush@kernel.org, ruanjinjie@huawei.com, kees@kernel.org, hpa@zytor.com, rafael@kernel.org, ritesh.list@gmail.com, blum@kernel.org, linux-arm-kernel@lists.infradead.org, coxu@redhat.com, maddy@linux.ibm.com, eric.devolder@oracle.com, palmer@rivosinc.com, tglx@kernel.org, adityag@linux.ibm.com, kas@kernel.org, chenhuacai@kernel.org, yeoreum.yun@
 arm.com, maqianga@uniontech.com, gshan@redhat.com, guodongtai@kylinos.cn, gregkh@linuxfoundation.org, x86@kernel.org, zhangtianyang@loongson.cn, jbouron@amazon.com, bp@alien8.de, tangyouling@kylinos.cn, loongarch@lists.linux.dev, james.morse@arm.com, ardb@kernel.org, mpe@ellerman.id.au, leitao@debian.org, will@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com, me@linux.beauty, graf@amazon.com, linux-fsdevel@vger.kernel.org, kernel@xen0n.name, driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-15-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:25:26 +0000
Message-Id: <20260918102527.170481F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

> Add a common helper to compute the total size of an ELF64 header
> (Ehdr + program headers) from the number of program headers.
> Replace open-coded calculations in powerpc, x86, vmcore,
> and crash_core.
>=20
> On ppc64, struct elfhdr maps to elf64_hdr, so the powerpc change
> is a pure cleanup.
>=20
> No functional change intended.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D14


