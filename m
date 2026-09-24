Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50918C98314
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKd3Ee2wwpszSTcHMWC9Vp5q123rbV4yhxViyI+qQyk=; b=bTOe60zSHhbiOzhAiTsNnta6qz
	nwwOg0p8CawXMpkOZD2pwv3Z05yUJHm2cGcFm7fGv5pYINDB1AGUyZC638t2siLKl/QcgfFgfYDHq
	HbYlkLRO6DuhLt6UYVswdM5lG+M0kb2Ty9BuhstmrvNhCv2owVFauceY0up/C8i3CObXxrfX/Hg3q
	/uEK483G2cq2p468uuiwU4FuXRzcXhJlrX4wvfqtYfCls3fFFL/xqxOkc2PNVT3T69chpV1I4vHaQ
	YX4DyPoC7XGWcjUg23QfK8fWguaRWoZ33bxWHkaw8Lx5kN2SLlqvMlSy/cFzPMaXUvVFp8b5LSJ5Z
	NiSEscBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9eRt-0000000AO0G-3r6w;
	Thu, 24 Sep 2026 08:04:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9eRr-0000000ANzX-40iO
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 08:04:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33C0560220;
	Thu, 24 Sep 2026 08:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B681F00893;
	Thu, 24 Sep 2026 08:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790237094;
	bh=sKd3Ee2wwpszSTcHMWC9Vp5q123rbV4yhxViyI+qQyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1AQMwAkmdnV44EXHhXPmEuHRUG2YQ6pBh0NPzzqWXCa+/cFyzyawg/XKevzlbv1m
	 +3Rp0+F6O6ijeb6n8JtM0GqA6NE9UmJdX4WBVfNFtHKCu8/WWYe9zkrri5aGpWdB91
	 Gv1Jckf163saFWmT/H7ENujwc2roDsrq+Of1GozJSOsMuaW5hN5vS5i1P+S7XLUSko
	 UKEHn43l343/dRKS1QfDrmiMFbBF3ajHWPrKPNHxVjEI7TkHccma8yk3dvE/op5miq
	 3O0bc8I5xN+W+YP7JTlmf6Y/8sYfdqc1c5XKG5RtvseW6XcjaGXwDlNffLYl8YECKX
	 Feyq0nHq1YPAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: kdump: add arch_crash_save_vmcoreinfo()
 support
To: "Yangyang Lian" <lianyangyang@kylinos.cn>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>
Cc: "WANG Xuerui" <kernel@xen0n.name>, "Tao Cui" <cuitao@kylinos.cn>, "Dave
 Young" <ruirui.yang@linux.dev>, "George Guo" <guodongtai@kylinos.cn>, kexec@lists.infradead.org, loongarch@lists.linux.dev, "Haoran
 Jiang" <jianghaoran@kylinos.cn>, linux-kernel@vger.kernel.org
In-Reply-To: <20260924075655.375632-1-lianyangyang@kylinos.cn>
References: <20260923060349.146780-1-lianyangyang@kylinos.cn>
 <20260924075655.375632-1-lianyangyang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:04:53 +0000
Message-Id: <20260924080454.30B681F00893@smtp.kernel.org>
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

> Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to
> /proc/kcore") the kernel has exported the vmcoreinfo PT_NOTE on
> /proc/kcore as wellas /proc/vmcore.
>=20
> LoongArch does not provide arch_crash_save_vmcoreinfo(), so the
> arch-specific values are missing from the vmcoreinfo PT_NOTE. The
> generic exporter in kernel/vmcore_info.c already provides
> NUMBER(VMALLOC_START), but tools like crash cannot derive the module
> and vmemmap ranges, VA_BITS, or the KASLR offset of a LoongArch dump.
>=20
> Since commit 18210a104bb9 ("LoongArch: Expand module virtual address
> space to 2GB") the vmalloc and module boundaries are no longer stable
> across kernel versions either, so vmcoreinfo is the only reliable
> source for them.
>=20
> Provide this function in a separate file that is built at the same time
> as its caller in kernel/vmcore_info.c, and add a LOONGARCH64 section to
> Documentation/admin-guide/kdump/vmcoreinfo.rst.
>=20
> Reported-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Suggested-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Tested-by: Tao Cui <cuitao@kylinos.cn>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Yangyang Lian <lianyangyang@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924075655.3756=
32-1-lianyangyang@kylinos.cn?part=3D1


