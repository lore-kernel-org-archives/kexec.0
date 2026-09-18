Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A37C982F9
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=; b=Ky3AhEpBML2A4LEGm+dWhQGlRY
	uuPMKP022LzJMYEH6iqdpsma6vsR04jixnKcMNCHKXFXo2w/Wp728RxDQ29QcfE8zlTCVqLn+hjQK
	QeXlJxXjIcizG1Qpa/keQZlUhjfNUwZgUQMYihJN6OJ2KdO32hAoOpvsZZ016Tx2dHMy4HndCW+x4
	K4ifI7Vt2sdonRZ803mHU2wWvkI6751smMnFecFY4B9v7YNugtxzIZz2G73bPH019FmCkA9qRE34v
	JRBuKeDXW+WwaUrRWiiRR7PD/6Ki4bE4iFWxV8TnsqB1+XKIGHVyoR6tdMl9SreSKSmxY2BP/T5Ik
	CDUxQ3Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4Y-00000000Mlo-05PY;
	Sun, 20 Sep 2026 20:23:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Ve1-0000000E4vL-1bXc;
	Fri, 18 Sep 2026 10:16:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9722160A5F;
	Fri, 18 Sep 2026 10:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39531F000FF;
	Fri, 18 Sep 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726596;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPNSou3IuShNKs2wqjrBJbH6XQctu6cWqLaMc++I1FCOeysna31efy1k8r1o8USDO
	 2KqcArHiYXdTZ+TCjG/tGsBMKjgm0re02mhBVnEtqMPm6TY1HXd/oDObyk5RBwAemO
	 jATEzxTr7dl4SGEuYHCs0/sMh9/aDZWRxCUGgiAaKdBlebXVmL6UJvtC61NzE0id6H
	 jhaWLG2USeHwgB16NAE4AhrbRZEmLVBnc7w0vh5qLGmVn+sfh2LwhNAQzWtMCKSqyr
	 Mu6jRStNkeupLKN8zuiSxlhEUKsG9ytbHpOCM4iRwDSrdR9sKb4gq/5t73W9G3xoen
	 jXkRNjs+uULHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
To: ruirui.yang@linux.dev, rppt@kernel.org, bp@alien8.de, vishal.l.verma@intel.com, linux-arm-kernel@lists.infradead.org, yeoreum.yun@arm.com, chao.gao@intel.com, kernel@xen0n.name, tglx@kernel.org, takahiro.akashi@linaro.org, ritesh.list@gmail.com, hpa@zytor.com, sshegde@linux.ibm.com, kees@kernel.org, tangyouling@kylinos.cn, will@kernel.org, piliu@redhat.com, me@linux.beauty, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, maqianga@uniontech.com, gregkh@linuxfoundation.org, pasha.tatashin@soleen.com, npiggin@gmail.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, thuth@redhat.com, maddy@linux.ibm.com, blum@kernel.org, chenhuacai@kernel.org, mpe@ellerman.id.au, sourabhjain@linux.ibm.com, zhangtianyang@loongson.cn, robh@kernel.org, graf@amazon.com, seanjc@google.com, hbathini@linux.ibm.com, guodongtai@kylinos.cn, rafael@kernel.org, adityag@linux.ibm.com, kas@kernel.org, gshan@redhat.com, coxu@redhat.com, jbouron@amazon.com, liukexin@kylinos.cn, driver-core@lists.linux.dev, mclapinski@google.com, eric.devolder@oracle.com, linuxppc-dev@lists.ozlabs.org, dakr@kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, ardb@kernel.org, bgwin@google.com, linux-kernel@vger.kernel.org, james.morse@arm.com, lizhengyu3@huawei.com, baoquan.he@linux.dev, loongarch@lists.linux.dev, x86@kernel.org, palmer@rivosinc.com, pratyush@kernel.org, catalin.marinas@arm.com, leitao@debian.org, mark.rutland@arm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-10-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:33 +0000
Message-Id: <20260918101633.F39531F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D9


