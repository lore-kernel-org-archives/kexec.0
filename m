Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14EEC982DA
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=; b=K1+stz8sifSGMfu+X82Gc0648N
	ivLe9JCNzrUqOfN8LpFy+WACVtOSRgpnm8MPBVZHVSs6ikmiOiMaOnYrDpzLSVkXzds8qQY9zwSWz
	ClSl6eTlliJVpY6FPFQOGLWqjlMIX6wFNXOLaurFI3oujllXP4YvktC62WyI7W1LxK8bMFBhNTsb8
	tkqk9Fo3hM37quwNaV9iZc5jdOxc9x/VgMav/3SCpcIqDr+VUK2HhDICpqcq/KEZicVRNIInFu6ha
	nZbXXh+hwBcwy5WnHDFxyGMpeAr2u3LYkw1hbIctSZ8fcHMWqTC0RaQ9mLlurYx+Ph3htvwZMXJoB
	upaE5RPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4o-00000000NQI-22Ab;
	Sun, 20 Sep 2026 20:23:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VsH-0000000E64y-20Hf;
	Fri, 18 Sep 2026 10:31:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C568542B79;
	Fri, 18 Sep 2026 10:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741621F000FF;
	Fri, 18 Sep 2026 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727480;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4IsE2dENzW5204Qi8D7Aq+qhe6TkI4pWZ4xDgTIhfw9ed/XtIK5tfxl8+yCcICC4
	 Dymcq8txAd0AjT2q3l8IwlI8B563zHCLB5HMuAOnTzfCQwWuCfkN9buTwRaFNBwk6J
	 wIlawl87RShg2Qmf/1CfzSShnRYNoMz7czRzo6x2/vHe6XlthNlrzUQIGAB8olUV6V
	 q4OjPaCfD4y0E/Hg+Tkq/aCRCfI4ubLfdpHPFhkUF9Z5NsCCbEGKRRutdxEoTkrrCa
	 9xFhLj4ygDBWKboxOoR1+RkSeIIqSN3RTLAchc9X/WWqsc7PKxOpDuDrnt7bmhriSG
	 McaM840XqhQ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] crash: Introduce crash_extra_elfcorehdr_size()
 helper
To: hpa@zytor.com, robh@kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org, rafael@kernel.org, thuth@redhat.com, dakr@kernel.org, driver-core@lists.linux.dev, kas@kernel.org, coxu@redhat.com, linux-fsdevel@vger.kernel.org, ruirui.yang@linux.dev, dave.hansen@linux.intel.com, kees@kernel.org, tangyouling@kylinos.cn, yeoreum.yun@arm.com, linux-mm@kvack.org, rppt@kernel.org, will@kernel.org, eric.devolder@oracle.com, ardb@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, x86@kernel.org, hbathini@linux.ibm.com, liukexin@kylinos.cn, mingo@redhat.com, mclapinski@google.com, bgwin@google.com, james.morse@arm.com, pratyush@kernel.org, pasha.tatashin@soleen.com, loongarch@lists.linux.dev, kernel@xen0n.name, adityag@linux.ibm.com, npiggin@gmail.com, vishal.l.verma@intel.com, akpm@linux-foundation.org, ruanjinjie@huawei.com, lizhengyu3@huawei.com, linux-arm-kernel@lists.infradead.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, gshan@redhat.com, maqianga@uniontech.com, mark.rutland@arm.com, baoquan.he@linux.dev, jbouron@amazon.com, zhangtianyang@loongson.cn, ritesh.list@gmail.com, me@linux.beauty, mpe@ellerman.id.au, chleroy@kernel.org, piliu@redhat.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, graf@amazon.com, bp@alien8.de, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, seanjc@google.com, guodongtai@kylinos.cn, maddy@linux.ibm.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-16-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:31:16 +0000
Message-Id: <20260918103117.741621F000FF@smtp.kernel.org>
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

> Extract the elfcorehdr extra space calculation from powerpc into a
> generic helper crash_extra_elfcorehdr_size() for use by other
> architectures like arm64.
>=20
> Strengthen the original powerpc check: instead of only checking
> the loose CONFIG_CRASH_MAX_MEMORY_RANGES, the new helper enforces
> a strict compile-time BUILD_BUG_ON() to guarantee that the absolute
> maximum theoretical number of ELF Program Headers will never exceed
> the ELF physical limit of PN_XNUM. This ensures absolute safety across
> all architectures with zero runtime overhead.
>=20
> The helper also provides a zero-size stub when crash memory hotplug
> is disabled.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D15


