Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878E606B82E
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PdIHP9kq;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7MkO9Fh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7abgtYcEVDQTOXAqFpfcMLxt8IBHN99WZpu2fJdXQnA=; b=PdIHP9kqqchxd/61zm7mccqYRF
	Oc9Fql/xD9D+BHytbqDby75kf/oNrgWmNvNclxHwFel4pC5D4yFeJNg79yclIgYFc5KiSNi3xizun
	L9eh2LJmhT4L30xWAni6ze/Ztuv2GW09fIrIVsdBdmPgysGRTtffysirA+iA5YsHHZFJPmkTMMPMX
	YytjIY3DjDQzge6awTUZ2NZNbnwKdE1L//6etWDqkIYnDPHP/I28AVWZY378gdSeP9z7YZjuZ42mp
	b7AZzsUc50kYohR0Iaj8tWpD+aD70tI023dctKDNvOicf/QQq2896yeiTh40jXr/hWjwL7SwCLnlr
	1cWzDP/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVgd-0000000AEWa-0kW1;
	Thu, 12 Nov 2026 14:21:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVgb-0000000AEVu-2yk2
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:21:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB2FF6187B;
	Thu, 12 Nov 2026 14:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E451F00A05;
	Thu, 12 Nov 2026 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493316;
	bh=7abgtYcEVDQTOXAqFpfcMLxt8IBHN99WZpu2fJdXQnA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a7MkO9FhufpNLbmHFGykLDi1GUazCd+JFn2pojqn70WwlqVHvz8cu/MJaeIVkSecl
	 wQPaKQ9MS1cFSgN6DyoLMfr1sounB/z3P+G5T37SkFwoonzhGROOoKduYX1TC3hdeF
	 pvhfviRBx4zxfNnVXDfw1UPHVEyI0wNe0CXNNlw9jYdVIDofiteRD/KYnaBH2vRQQO
	 7HyRjmVPIdgwsmRf02kqniOItDkafMoE9YRJfiapmDDxzcIKoV/yfBPEmmvsjgrIRh
	 fVCzQRzKdnjm6RUHGiT5l/LfaQFKKTbnGygPw3vIH679lN4YB4j8HiZi6t9HlEb6DP
	 GZsS4H8bPFuvw==
Message-ID: <sashiko-outbox-211306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/11] LoongArch: kexec_file: Fix CMA segment
 placement retries
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-12-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:21:54 +0000
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

> The file-based kexec system call places segments with kexec_add_buffer(),
> which takes them from CMA when kexec_alloc_contig() succeeds, to avoid
> copying the payload at kexec time.
>=20
> When load_other_segments() cannot place the initrd, the segments of the
> attempt are dropped but their CMA pages are leaked.  Release them with
> kexec_rollback_segments() in the retry loop and in the error path of
> load_other_segments().
>=20
> The loop makes progress by advancing buf_min past a segment placed by the
> walk.  kexec_alloc_contig() ignores buf_min, so once the pages of a CMA
> segment are released, the next attempt can get the same region again and
> the retry makes no progress.  Disable CMA for the retry.
>=20
> A CMA segment can be anywhere in RAM, so moving buf_min to its end can
> [ ... ]
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D11


