Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC4C98300
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WfwSj0SUsP3uLadBypCB3UfgoCzQVYDLKWPCUa5wNE=; b=pIDt5JmVYTI7nifUd8vnQN1iku
	LENPJxG4Kr+eP0Vl/MJiLvrH+wLIvkts84dB/+lj2A2lGlkRneQkKRQ/W3fvpwpXTz2J0lINCbvi/
	XRZ6iPQe1cBeKzJaP9rUqaOgbTaJ0tHFyG5Ww0yvGSXYTYJdmDq4yXbWnx1R82sJYgyfU6/qWSsSw
	3uFsGgsuRibxeMp31pMixh9quywug5Kj30wAQRY4rG/pKwpoKB4MY+RlsyXr72oGYCliX0r9wYzXM
	EsiKqZDhUH+ZCXM6NCY4XmyBZtWi8lvTdhh/Lg4v6ffgyPEIHPDhSvRPPx7gFu2Dm074gXfy3l4Dw
	fd07y0qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad8-00000001ZX4-1bza;
	Mon, 21 Sep 2026 09:48:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a58-00000001TBk-1iii;
	Mon, 21 Sep 2026 09:13:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85213600D1;
	Mon, 21 Sep 2026 09:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE01F00893;
	Mon, 21 Sep 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981981;
	bh=/WfwSj0SUsP3uLadBypCB3UfgoCzQVYDLKWPCUa5wNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1I5zBeYLORpIuyWyUAUWC0Uh4n7bfpfDQAmO+S9O5D57CCdmuhZF6EHDQKvq/cvP
	 10Ma/TXixn8nltQYxWYicB+x3A+NX/4RaAo1K7Tx0Tjx1iSzhDndqP8qwl+cccnN/m
	 VUHXD5OXwJQ5Jm0HeG0etX2xLkzEPw0djSKWw++95ZnUnQnTc45gqQe36GKIoTpmuF
	 v//DReeWe2iedyVaignylzPCkPZ0it/t+3xsjyTinWBvdvSulYQ1WtQtZThfTYfS05
	 U5nZGjbVM8cX0R7Lh1TWDvzVTZbekKD/d0sm+/dQnWzMHFE+oITkFOBWsGfA/tHjUv
	 j7eilNaaRHp+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/14] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
To: kees@kernel.org, rafael@kernel.org, chao.gao@intel.com, pasha.tatashin@soleen.com, mclapinski@google.com, robh@kernel.org, will@kernel.org, bp@alien8.de, piliu@redhat.com, catalin.marinas@arm.com, dave.hansen@linux.intel.com, bgwin@google.com, linux-arm-kernel@lists.infradead.org, rppt@kernel.org, gregkh@linuxfoundation.org, yeoreum.yun@arm.com, hbathini@linux.ibm.com, coxu@redhat.com, chenhuacai@kernel.org, sshegde@linux.ibm.com, tangyouling@kylinos.cn, linuxppc-dev@lists.ozlabs.org, pratyush@kernel.org, graf@amazon.com, mingo@redhat.com, driver-core@lists.linux.dev, thuth@redhat.com, kernel@xen0n.name, vishal.l.verma@intel.com, sourabhjain@linux.ibm.com, kai.huang@intel.com, chleroy@kernel.org, akpm@linux-foundation.org, hpa@zytor.com, guodongtai@kylinos.cn, james.morse@arm.com, eric.devolder@oracle.com, ritesh.list@gmail.com, takahiro.akashi@linaro.org, mark.rutland@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, tglx@kernel.org, ruirui.yang@linux.dev, leitao@debian.org, lin
 ux-kernel@vger.kernel.org, zhangtianyang@loongson.cn, me@linux.beauty, x86@kernel.org, seanjc@google.com, loongarch@lists.linux.dev, baoquan.he@linux.dev, npiggin@gmail.com, palmer@rivosinc.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maqianga@uniontech.com, jbouron@amazon.com, liukexin@kylinos.cn, dakr@kernel.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-10-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:12:57 +0000
Message-Id: <20260921091258.5FEE01F00893@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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

> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
> 4KB page. However, the elfcorehdr segment can span several pages (up to
> hundreds of kilobytes).
>=20
> The original code blindly copies 'elfsz' bytes at once via
> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
> virtual addresses.
>=20
> Fix this by copying the new elfcorehdr page by page.
>=20
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%4=
0huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D9


