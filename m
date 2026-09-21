Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A793C982F6
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Ht9zG85Yv7vBKbBbu1CVPAY2kC2RSmX6uHImGsyNrs=; b=XKeatkWNzLPNk+xBepWY7hNr9i
	IoW7EhlkwndFumYJZzPyXsY4+f0FPQ+aBbX5Nv3FJElYk2ZNscYU5/RdlK7FkNykl2jowTlcwMKzu
	LoJuyQ7gW7HcMMSk1OkVNjtFfs4EPA/B9cExKJmkp72o07ulQ0Jn65HUA3SpuWaEbWcOcZTdxVo6D
	iTisWEJLkttFep1BnnIRKi/9/hFTGVhas16juA9sCMJ9g9tL1K21H0GnC61UIrmRgjLboe4iR/7Fk
	or7drV+3E223yJ1GApQhReQ1JwFm0cRqW4TKgofvDPzC52DOSthufsjCOqzRkCfAv19skJ145CDC5
	d6gx+cCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adF-00000001ZiQ-0a2v;
	Mon, 21 Sep 2026 09:48:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a9x-00000001Twt-1Tnv;
	Mon, 21 Sep 2026 09:18:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 120AD432D8;
	Mon, 21 Sep 2026 09:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E11F00893;
	Mon, 21 Sep 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982280;
	bh=9Ht9zG85Yv7vBKbBbu1CVPAY2kC2RSmX6uHImGsyNrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TghQBBFFrE9MMw0lPBqk6tyi+qI/Y2LCJDRdECrz3HZwpozy3VrRCMsZqQxxRXloA
	 la/b90SIj/gEF8SVQNZiet4H9/RAwxfX5JfsuQr6jUbwO+V/9RntTbYiEU0XBpYyG6
	 fM1Jwy7DhPFjeKy1KRcEEqkJvuGXeu6uWhku62y2olZtEAGlHEpBZrO4y7LgDMIQ+h
	 wsffgpzifRVDr/R4EeOrazNAaFqQpVpvSPUI5SbJbYkrBn3MlN1kwuDGiTh7ktfJqJ
	 fU1bCfpfjq8dBiihAxS2e//9bTsR1+Ui/rFuIyh6Cu2yL+wAeSY/NVh53byzGHsgmk
	 BgR4rNzd+3Dvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/14] kexec: Fix CMA segment address translation
 with non-zero text_offset
To: sourabhjain@linux.ibm.com, rppt@kernel.org, dave.hansen@linux.intel.com, mpe@ellerman.id.au, bgwin@google.com, kees@kernel.org, zhangtianyang@loongson.cn, chenhuacai@kernel.org, eric.devolder@oracle.com, akpm@linux-foundation.org, chleroy@kernel.org, sshegde@linux.ibm.com, chao.gao@intel.com, jbouron@amazon.com, mclapinski@google.com, tangyouling@kylinos.cn, mark.rutland@arm.com, seanjc@google.com, palmer@rivosinc.com, leitao@debian.org, yeoreum.yun@arm.com, x86@kernel.org, ritesh.list@gmail.com, maqianga@uniontech.com, kernel@xen0n.name, mingo@redhat.com, takahiro.akashi@linaro.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, bp@alien8.de, robh@kernel.org, pasha.tatashin@soleen.com, driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com, pratyush@kernel.org, guodongtai@kylinos.cn, graf@amazon.com, catalin.marinas@arm.com, kai.huang@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, npiggin@gmail.com, vishal.l.verma@intel.com, baoquan.he@linux.dev, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, me@linux.beauty, coxu@redhat.com, hbathini@linux.ibm.com, will@kernel.org, maddy@linux.ibm.com, liukexin@kylinos.cn, piliu@redhat.com, ruirui.yang@linux.dev, tglx@kernel.org, dakr@kernel.org, thuth@redhat.com, rafael@kernel.org, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-2-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:17:57 +0000
Message-Id: <20260921091758.110E11F00893@smtp.kernel.org>
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

> kimage_load_cma_segment() and kimage_map_segment() both translate
> a CMA segment using page_address(cma), which returns the CMA base
> address. This ignores segment->mem.
>=20
> On arm64, image_load() adds text_offset to segment->mem before the
> segment is loaded:
>=20
> 	kernel_segment->mem +=3D text_offset;
> 	kernel_segment->memsz -=3D text_offset;
> 	image->start =3D kernel_segment->mem;
>=20
> so segment->mem no longer matches the CMA base.  The kernel payload is
> therefore copied to the wrong offset, while image->start points past
> it, and kexec jumps into the middle of the kernel.
>=20
> [ ... ]
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D1


