Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A4606A327
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uHiFkRTW;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD2aFOlE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wXEsuqzmhbRZwvT1tBI9GhdUn888IQZv7O7Uyc2biIk=; b=uHiFkRTWde5Wd7kuLA9I71Uahp
	wBxCqjwDU8CHkvA5SYFTfkCBkS0WSeCOlEwCBvBw3sByWljA9x79w3HOCEuvbQjW6VdR8MeynDGb2
	wVloJoGh9hHDL+0+nKwBLgIpd9joC05CK/vEYceqJzeQN/PIFuLEJEtUkmyqZZcCJNs2LVrm1+9mA
	ilK+hr2Sp5ZjZ1Yr2KisCR31/NLejePiJ1oK/Za0fJ+CPTBB8ahz4bjr0BMFjr6pWB4njMQdhM0Ys
	2VDOxOUB0XoORXTwf21rzzuCjAgc41kZ6gvrp9sohdaEZqW/O0Jpw3w/EvuDKMoiB2OrY1YcLMJ5X
	mRu1+AvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRV90-0000000A8Vp-0LD4;
	Thu, 12 Nov 2026 13:47:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRV8z-0000000A8VV-2gdW
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:47:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4EDE542E02;
	Thu, 12 Nov 2026 13:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18011F00A07;
	Thu, 12 Nov 2026 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491233;
	bh=wXEsuqzmhbRZwvT1tBI9GhdUn888IQZv7O7Uyc2biIk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hD2aFOlEfkzkQ5Knd1q9PDXY3pkWekPm6VP+ZttkXX8mIVP/cu8WiF4pN1zBl5Otp
	 j6L3iJJYAKqZdHtb5jXfBzn5Y4fm7zFYz5QsxoZYojG+BL35YEaCpF9DyRVrdUsBWb
	 zmAOR/Nv9PIz8Kl6PYdCdQn8amF9ntUi8hJeX2kvEK6rzklocJ4hdAnCMThqUCkGqt
	 yN/FIiSWKO3mO30xxz8ekG+Vz26oCUdkqO02HNdBILz3BXZ8Hy0ozUgn5uVRDfZE1t
	 Js9qyWeSF/WqmZn3yB2CalNyKh6gnJwTv6/hDsih12rgHdg2Nv3z7JnV1Fs6geK3NK
	 V8vy/dhCgVjgA==
Message-ID: <sashiko-outbox-211223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/11] kexec: Free the elf core header in
 kimage_file_post_load_cleanup()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-2-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:47:10 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D1


