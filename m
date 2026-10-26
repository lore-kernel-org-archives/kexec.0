Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07678606A96B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lbkraU78;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRjSmEzG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5Fh4SnYgHxQRN5keuI5qaiOFPfqevUoywamYvsfuv+0=; b=lbkraU78PQPuZ2I68wA2SXWa/Y
	8hoVpIfuNZOqvBlW5kNaUg9sfWqrdjsDOLJ11S32Gd7zqH+ycByf4W+FIgOu+q9++p4fEhb8Dn2Jb
	XR4Na05NmY8CeauhsjCrMaid8My5pPUNXCElyqcymBYZb7amzWmvmZ5IWB3WEytLo4+v0WxI+2Kt/
	YAhUKMvphIDjA07I7BNiVotL73GOWIzlkUoUV8oQTJ2VmeoPqslsQJXfIggoGihst7sn/JX6ZHmng
	zhpBqhE9iui3OMu83TB2raK1KYuRs6KofJsC1FmRYA7jHpMUE6bzQzEtdeuBaovYmQDtgO0UJ41pK
	Kpkzpe7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIci-00000002LjI-1BEH;
	Mon, 26 Oct 2026 11:12:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIch-00000002LjB-2dgR
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 11:12:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EDE843783;
	Mon, 26 Oct 2026 11:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095781F01828;
	Mon, 26 Oct 2026 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793013135;
	bh=5Fh4SnYgHxQRN5keuI5qaiOFPfqevUoywamYvsfuv+0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lRjSmEzGwMpaotUUB50YKWxwgIH9MVzJOHNy4O+cyrdNqoz0j/Qv39gdKAJ99HVJs
	 YNPAHgbN9+25UVMIzTociqLWWh6icYC02UI+StzAj9dPc5Ig0Oih7GekjTpZ13smUN
	 JGYKwyYW+FrvDkPCrXk9DbnDlRCRmk3MvqqBaIad9q3oWitkEUovVeY3YKSOCtCKvO
	 5c6Tn3YyV/q+xN6EBbl3zB+IqaA/TxKQlakE2obH3YRp3v8cKE83QDjVnU5cpRd5WJ
	 20IonZ1bcj6Jr/7jXj+sle5K+kgqXa1WdaKwZzOFMpwrAMBGrG1x3N4dkjBqfP48T+
	 DvM3IcIIqj+Yg==
Message-ID: <sashiko-outbox-185069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/15] LoongArch: kexec_file: Use
 kexec_load_other_segments() to simplify code
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-15-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:12:12 +0000
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

> Replace the local copy with the common helper.  The retry loop stays
> and the command line is built in the setup hook.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D14


