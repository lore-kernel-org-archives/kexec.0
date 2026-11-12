Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD74606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yIxoG2DV;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLeXR5PC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4u+Ic34wBvx+q022HFksT90Gutr/fU55HnKLfSYtA9s=; b=yIxoG2DVWpEti0jv7zEhXV0Aft
	+AcxOziuWNY2JdOZsOIKom7YD+Rttp1MsNSkLxLcqvgFNC8kprp3dOA28qQvEArlr98PRFit212pB
	cczLb9MZLhvmcODEE64aSpOLFX5TqkHHDdiQVucm1xZDJgXoUzFlrn/jcLQbX4BKiqPL0baZuXq7n
	blcdwlkxOT81a+v8peGtKu6d2dEKmX8LfKw95UxFjoBIbjme+1Jt3LdFD+85z2+P4cKBY+46VAwy2
	D79/ngbnbssjzMZE03LNEJTcMHk/s0iZf/hokKZ1Mdkh3bdI1B5iabOtAzMnpHenwHivRMR875y3R
	sqdp6wWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVED-0000000A9Kt-1p1P;
	Thu, 12 Nov 2026 13:52:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVEC-0000000A9KH-0ncx
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:52:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A08764462F;
	Thu, 12 Nov 2026 13:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CD31F00A05;
	Thu, 12 Nov 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491555;
	bh=4u+Ic34wBvx+q022HFksT90Gutr/fU55HnKLfSYtA9s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MLeXR5PCdsOLdKcYEoiMsMXJMmZJlSzE56uPW//t9+GPS3hY6LIkfussPLavIRoQg
	 gq76stelTqLHWC0exea0/cZHyV7Ge3rZNdGqlNAfotLYeme4Msf6NfBQdM1PGnfna3
	 8QnP0OHyMOZN+evvaorAr8TsFk4cq5SOSVeShxv8ug2qGIvcISixMCh2JPYUn6cfPw
	 ooHRkrkRWZZbvP3u46Xom+o0cgMPruhjV7uOqn0gRkJTzPhoOGh6cNU/4qEVcY+GAT
	 rzJrY9IWMxPz/otIbc/vVuqLADkCGg/GUYQPc1eWsLGDtjm6n8f9QRJ2stb4OKkUr1
	 TQG2V4K3BUEBw==
Message-ID: <sashiko-outbox-211236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/11] LoongArch: kexec_file: Load the other segments
 with common helpers
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-5-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:52:32 +0000
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

> Use the common segment helpers to load the elf core header and the initrd
> instead of open coding them. The initrd and the command line come from
> the image.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D4


