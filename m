Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADE606A325
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LFUezJNy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fya1x/6F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GubAvimFnS8wBBdifXrVct3JxxOkJp+Byh7apTODJBY=; b=LFUezJNy6KLY0699CVL79khbx1
	8EkKVyTJ+XKnohKQV9W5lIYp8qrqTBvS4SHWh+Uprd4vMTRRv+8ba64x+xaYsP/A2rwWGgZrovLA8
	lvbGO0z/N6DcMqGUIqCykVnY6QXdFNr9WCmMVCwILId6ggVeHB2tIvjxXrx9F/Gn49XqHebYwldko
	HjT9YS0c8INHmKkUUfuFulg0plFYa4LhFmHmM7nVQPCVECYlVCp2sqorysgMhrYX7ciYgYyGK79Uq
	iod/LZtf6A5zycF7mJdR+r+dtBdnxaUQw+AwrhCTyejJhf5QHwRo65cddjwdDz3B+C2m0ge701CTX
	w1lSr3Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIlx-00000002McS-2Q9g;
	Mon, 26 Oct 2026 11:21:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIlw-00000002MbH-0y6e
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 11:21:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D937601FB;
	Mon, 26 Oct 2026 11:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647CF1F01829;
	Mon, 26 Oct 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793013707;
	bh=GubAvimFnS8wBBdifXrVct3JxxOkJp+Byh7apTODJBY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fya1x/6Frtv2kARtrHawgqGuX40S7rS+sS1UkF6O2690ZcV91SFhTa2UKvVNBVPni
	 rmjjGS4h9/fgb8mC+O9RH+H3w2RqsUDn8wZhWJB380WocXiJs3fkqBp/XDiiWJ1kkN
	 5mz6m2S3/wB2BH4apULJWqW+YmNCkVTmQVFuYgWAa971IPVyU/C29hcWn1Uh9A+PAf
	 hFZHKcmt5FrIahPC8d9FIX7/AWvhQKm5eI+RBpeB12ZawJ4xsgrj1ISo5cmVKQpTvQ
	 hY9xvVelBRK2YOyBPve3H7SCG9GztjkIoC9Y2a8iHQwYucHqp+YCRATYw+3ba4LBXp
	 N4+bIyHgOAL0w==
Message-ID: <sashiko-outbox-185090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/15] riscv: kexec_file: Use
 kexec_load_other_segments() to simplify code
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-16-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:21:43 +0000
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

> Replace load_extra_segments() with the common helper.
>=20
> The purgatory, DTB and kdump command line move to the setup hook. And the=
 elf
> core header is now 64K aligned.
>=20
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D15


