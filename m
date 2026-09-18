Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F29C9830F
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=; b=hVgWd4tRsG+idGkWXl4OJy3Mi7
	/Pa8Klug4gpjQWDPqFkO6dcam4Ihgs6EAJ5wV8RTn828+aXI2qwLpryFiYzFLPL0giHQyQDQrjI/U
	CxlYuYRmWbGRhb844K03y8M2HIwwV3ah4T2gfX8qcWhzYGl7ZvK8ii7AXD8rJA60Tm+c3VFobIwyR
	2aX9MOoHlAZ0nRW3vbrryMaW7Ykhue23LXQP+anC/z+IW6ZLdZTf7R7jjC7hGNsrPQoUULmXnohpV
	wTmthZz614Qy8gY6fI/6EkpqNQ91w0LEJBZrrbn9PIiC1uKiGHnNNdQvq/a2uezw/dWF1tvDm/y/b
	cYdvlNEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4X-00000000Mk0-1wZD;
	Sun, 20 Sep 2026 20:23:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VYs-0000000E4Ax-2rYW;
	Fri, 18 Sep 2026 10:11:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D1BD860A5E;
	Fri, 18 Sep 2026 10:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD41F000FF;
	Fri, 18 Sep 2026 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726277;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llH/FkFITAB5xWYHwFUPLbdE2EaF3GC1eSoCiDjrZavq4ujmqfQALeKu52aFVVMuR
	 pBuHSv80cKI3j9Mho4y3xdPug+GfNG/zgAkh8wZ7OoahnhoGS7E5dhRdqhsQ+I51pr
	 f7NWcn+fOKRoo9iweVcxsXDWvRhgpceUNC6h8Ptlkps8SWZs2CmTh5980BC6sEHNlB
	 0CM2Rk/czy1YuvNhpd/QUpJNpu47BkJRGDZBlBtd4x1ODrJ76w2qvFvIEJ442SLha5
	 zUwFARxcYBBM4yGx2Endjllgko7Mxt/Jea4yXamZO8XPgdLllRtjg2f1JDx3w8mdGp
	 uPU0nMOTpRphQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] crash: Extract crash_get_memory_ranges()
 helper
To: maddy@linux.ibm.com, tglx@kernel.org, loongarch@lists.linux.dev, hbathini@linux.ibm.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, guodongtai@kylinos.cn, jbouron@amazon.com, thuth@redhat.com, mark.rutland@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, gshan@redhat.com, sourabhjain@linux.ibm.com, chao.gao@intel.com, piliu@redhat.com, eric.devolder@oracle.com, baoquan.he@linux.dev, pratyush@kernel.org, ruirui.yang@linux.dev, bgwin@google.com, chenhuacai@kernel.org, linux-arm-kernel@lists.infradead.org, maqianga@uniontech.com, bp@alien8.de, tangyouling@kylinos.cn, mingo@redhat.com, driver-core@lists.linux.dev, blum@kernel.org, takahiro.akashi@linaro.org, coxu@redhat.com, linux-mm@kvack.org, palmer@rivosinc.com, akpm@linux-foundation.org, ruanjinjie@huawei.com, vishal.l.verma@intel.com, npiggin@gmail.com, dave.hansen@linux.intel.com, liukexin@kylinos.cn, hpa@zytor.com, chleroy@kernel.org, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, robh@kernel.org, lizhengyu3@huawei.com, leitao@debian.org, yeoreum.yun@arm.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, mclapinski@google.com, james.morse@arm.com, pasha.tatashin@soleen.com, dakr@kernel.org, will@kernel.org, zhangtianyang@loongson.cn, me@lin
 ux.beauty, ritesh.list@gmail.com, gregkh@linuxfoundation.org, kernel@xen0n.name, seanjc@google.com, x86@kernel.org, rppt@kernel.org, rafael@kernel.org, graf@amazon.com, adityag@linux.ibm.com, mpe@ellerman.id.au, ardb@kernel.org, kas@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-11-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:11:14 +0000
Message-Id: <20260918101115.1FCD41F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D10


