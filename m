Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860B606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gj//wMJ6;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceodIcBh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VWrC05jei+hlVN7dlcF9x627yJHymXtEwCqaE8zRNys=; b=Gj//wMJ6CvM0Y2CYH1/ZMIeEaM
	+ZDcIx6WJg3kWDzQ6ecIf63UjZrbdaS8NryrVyf5+UocUmAMvEAhIsPoN8XN9yVSIQm+qlpd2k4ER
	DmJZJzyxpQhaDZArGnij6cdIXjHtKp4oK7SHdzNMmKbeGU1Wjx/QrLmR305d+bWKPAIiq6g9YewDU
	IYSAjN6/t0KWdyzLczapDUnPS+d3MtOx/t80xrOFIJvxbAL2xMQqeO/k6RlZIXhq1yCHCU+J7xzEd
	PD00qj8txDPWuIHCyp1BZ8HJtnPmmL1F+cybfu8PmXWDs9enKWqkYbUOD4cR3cZ7hHqMjxBSnq0L8
	YdbXD9Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIF8-00000002HwB-1W6m;
	Mon, 26 Oct 2026 10:47:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIF6-00000002Hw0-3yIe
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:47:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1154A436F2;
	Mon, 26 Oct 2026 10:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749001F01825;
	Mon, 26 Oct 2026 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011671;
	bh=VWrC05jei+hlVN7dlcF9x627yJHymXtEwCqaE8zRNys=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ceodIcBhF/aURwcbLV0lwCbCn/gjE+oqRnHkuTwHW/OHJoq5ZrligBc8LOG2+SzRu
	 uOUqictQb+EEMft+/wA4N79xIl0snnpFITco4tLS2q0AeO62DeT9dkGE3taIsFehuy
	 NX5EIeNMzrdA1Yu00NgKCKlVbur8vZ3DEbAm56AEA0Y9Z0Dnjv1hMKGq6yJ7iZ7WvH
	 +ild/Nm+GDPEMlYDml6f6e+nOa9qExPFEFAG4eqIt34NPaIN6Lz0jW9j7oHY6hvghG
	 4XhY2O58T/dUkMnRIvVgNSldKEgFk85TGqjD6HLAFXhJYUrpZ67sJUH4TUEjkApEfV
	 0IYgEzQe7Mlxg==
Message-ID: <sashiko-outbox-185012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/15] kexec: Free the elf core header in
 kimage_file_post_load_cleanup()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-12-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:47:49 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> The elf core header buffer is generic state, but arm64, LoongArch,
> RISC-V, x86 and powerpc each free it in their post-load cleanup.  Move
> it into the generic cleanup, which also gives the loader a helper to
> release it on error.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D11


