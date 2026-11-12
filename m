Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3260A383A
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DcCavC72;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNlWJl9j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=c7zixyf+ZbCe0MuCo4wmHfpAIUBTgRp3Y96g8SRTVMw=; b=DcCavC72wzkxqpfG7uQ5Z/hFTF
	5BoE+jpXqeoas2FOVWn5zd8K9Le+rR9xOXX8lu4Qq8JtkzXP938Eko/cJuo0+uUFtG6Ga6YyY+8bc
	b5JjStu/7D6gEMy0y2q+/jxQN/tes72/v7rfoLNSvnQZQKj/Dhb1RqruurkHwGmiyxuY20Ix1b7Cd
	ogqyy+t084cHGkYo78OgJKPY9ef0Yz+qAY7sIpjdVISAvO86vv7mUZiTwHzzlma1O7roHTKtm3DBE
	gc+WCsTw2+ONMEbFLDN7L96ZLSUuNicg/haY0ZolV+A0RRu5ehEhAsmfaA6mG+yxS06srYsh2oztH
	XdB39Odg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVMk-0000000AAOz-2OHD;
	Thu, 12 Nov 2026 14:01:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVMa-0000000AANS-0Z0x
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:01:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E012B61435;
	Thu, 12 Nov 2026 14:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4A1F00A06;
	Thu, 12 Nov 2026 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492074;
	bh=c7zixyf+ZbCe0MuCo4wmHfpAIUBTgRp3Y96g8SRTVMw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QNlWJl9jaFAufeWxyDYi5amRhVGZ9VGDOHrW1bMt14IKzDKj6ATbOIaOjNS4nYtbA
	 E8zF/92IuE/Olo6Pc9+kDCeApXx3sIPJ4ZfNlojvbeQIWCYiGUgliwsevvMqwAyQcB
	 ddRI9+LpI9AF/+GN0R9Gh8SrtOJoSd6EtbAu0cdh9byAIgSMBldtENG/OL6iKx9wj2
	 /YdQTZ7wVVerp9SbJgbqUq/8O87dTGx8KFMyLNaZA8U/qugm/yJVslKMkWomYJA00w
	 rSFUd67V3o950019/I+/GwpLnJJ0GubRTR1rEijnKYg9hL4dJTt2S7aTaqnuO0c4Lv
	 y0DYqjwULxIXw==
Message-ID: <sashiko-outbox-211249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/11] powerpc: kexec_file: Use the common segment
 helpers
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-8-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:01:07 +0000
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

> load_elfcorehdr_segment() builds the elf core header from the powerpc
> crash memory ranges and places it as a segment.  The header needs
> powerpc specific post processing, so keep building it here, but use
> kexec_add_elf_core_header() to place it.
>=20
> elf64_load() also loads the initrd by hand, use kexec_add_initrd()
> for it.
>=20
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <chleroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D7


