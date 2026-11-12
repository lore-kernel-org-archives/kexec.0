Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65952606AE82
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fqJ49pZr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xc5w+S3I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MdbkCxCU7/AF99KJTL3mzreJ0+eB6Wu9s8QEaPYfYa0=; b=fqJ49pZrxb1q+QL1ZKyLpo1r2s
	na8i+MO0L54iPGZkhxPQnhJTF/L1/RjEWU0Nm9rVa+3PB5asDpj4FjH7mVyJSml4Ws6Mys4Up6KDI
	kEH9MmkQh3mYr8EHx3QzsBnkQMZuD/2boJW3zpihQ5XcwSAOdnVOgUbJ+3yplt5PfBWQTW2ExlCWd
	46V9CYKZUUsSq6LM48P+LUNLm+WXlxNS91+2WRZQ5LkRQN4oLvTiWSWZ8iwrcS+vKfIhbhtuc7g1w
	vjKGjnJV0lVBpKrCRORm20A3YoKbBA3JC61cqV6RigcwLFGTjSam35ZEPbkhgI+K2Hh1ELvB2zvym
	q8rT2XHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVSJ-0000000ABoE-3gXq;
	Thu, 12 Nov 2026 14:07:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVSI-0000000ABne-2KWK
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:07:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB3E062D1D;
	Thu, 12 Nov 2026 14:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4CF1F00A0D;
	Thu, 12 Nov 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492429;
	bh=MdbkCxCU7/AF99KJTL3mzreJ0+eB6Wu9s8QEaPYfYa0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xc5w+S3IUzIyWwnblHOA/JuYv5ZePHzbQreZF/yeQ0Esve7wjltG1saYOJKs7rOsm
	 uUj3j6GO6miOEvKRcPimWOdwJAPXQ1FDYHmIgGfcz29RO5gI6jJ6pRZf/XxTE+ADnj
	 XO8khdEBawOpox46zOn6ZVrrtZRTXxMBNh927+nkT93APC9Jp1vn574ipE+1Kph6J0
	 mtbIadoWvGQW78BuRRFghf3XmsOGInlnTrEBSp13xwggudbu42K2Aue5jjwCwg2ajq
	 WyXzvLVUkmnucbYU5N6uSavyT4PbPuwZK09WRFcHR20E+p/EUhNdczbbQQuUIMqYVE
	 QgXuxlM3ZXjtg==
Message-ID: <sashiko-outbox-211262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/11] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-9-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:07:07 +0000
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

> Arch loaders truncate nr_segments when a placement fails, so the CMA
> pages of the dropped segments become unreachable.  Export a per-segment
> helper so they can be released first.
>=20
> No functional change intended.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D8


