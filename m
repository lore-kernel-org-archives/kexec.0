Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEE9CA6004
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cH56IWVlPRuKjxV86otArl7iW+zMZcLhNGSpmi/ZzZc=; b=kJ+era1tu5/R1mTPLzVe8TVVTf
	aBZFxMXQSn0AIy5OF4icIcrYinGjm+mnFn9UU0Xj3I9HJoEqgeM6g+Q7Gufgo9Ssp6hkSCipjbQrX
	aKgKve87oThEcP4Cf+UikNgH7UAavOO4HGdc3NC9qrYdw5ccC1T3lGmu6buvY/TIb9nrlxoswrlTW
	H4NjnD12HHxubSqQhEcPxDwDIO/4zrak98BKjfvOuHsrxU3l7Dybh6n1CuwinaRQwohmVQfBAlwIO
	uedYISEDYwAM+rOolfdC87/v6ZUOMqSodcRZLvTpfttoAPpCGT8EYYtyATtqYo4g9QaAZ5SQjfWYw
	tZbmymeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEeBU-00000003Ps0-4045;
	Thu, 08 Oct 2026 02:48:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEeBS-00000003Prs-1reG
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 02:48:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81F7660136;
	Thu,  8 Oct 2026 02:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE191F000FF;
	Thu,  8 Oct 2026 02:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791427717;
	bh=cH56IWVlPRuKjxV86otArl7iW+zMZcLhNGSpmi/ZzZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkc3D34l/3054Pkzsb6b9gtNDl9yb8FuToP5FVIi3NhrjSQSrWKuNL+MUlBrK02VE
	 2+uft9ogjJD0hnCkd215d/8ms1B6UEUdCzTM5rinpGKUU7sb89MM57Pkr5bIbiC+Ti
	 nm3MrU4bV3GVLtfFSuuWPstHm6xK99EnkEZQiMTUjfM1GgMVqCWfbk+bQNUBxxPC75
	 rb5louN3f2a8bOrtkLizki+2p2Z78LXJBnjVgXtqLE0CJsputOty8FJ3V5wn6IN916
	 pOL36Cevynub8UolubvRI6Ew9MNrHeUG3zcbql/QlLmxSgA+ZqpNTK/Sc7MWh3qP4I
	 X2FqGrfIxDTSw==
Message-ID: <sashiko-outbox-163521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] LoongArch: kdump: add arch_crash_save_vmcoreinfo()
 support
To: "Mike Rapoport" <rppt@kernel.org>, "Baoquan He" <baoquan.he@linux.dev>, "Yangyang
 Lian" <lianyangyang@kylinos.cn>, "Andrew Morton" <akpm@linux-foundation.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Huacai
 Chen" <chenhuacai@kernel.org>
Cc: "WANG Xuerui" <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, "Haoran
 Jiang" <jianghaoran@kylinos.cn>, "Tao Cui" <cuitao@kylinos.cn>, "George Guo" <guodongtai@kylinos.cn>, kexec@lists.infradead.org, "Dave
 Young" <ruirui.yang@linux.dev>
In-Reply-To: <20261008023419.118623-1-lianyangyang@kylinos.cn>
References: <20260924075655.375632-1-lianyangyang@kylinos.cn>
 <20261008023419.118623-1-lianyangyang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 02:48:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008023419.1186=
23-1-lianyangyang@kylinos.cn?part=3D1


