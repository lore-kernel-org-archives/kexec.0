Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F553C982FB
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0lbirbiRFTe0nqD7sNgdCQWa98rjE9GNM+G7wxNPPI=; b=OkNa06uSp5SK6tpacGfCuMSC13
	Wr0K1gS/3uFTaMjfwO+OCVUZqZZSBOd4tUTGt1QD6EANU0Qdw1wHG+oa5eEoftRx5jyQVJMqBwG6q
	neGvNucdmGMpnhbrMbBIoblmYF90Hr4wlh7yls4PlRlAY4Yg782nbKXLqKHZQQpzZMVlwQ5G1wBjv
	bJT7U3snvZLI7YyBoYjjn10l4rMUv4PcyptX67ykdHay7bsh+fRX+pxmwddegVhgAxZTio4T4TeQ8
	lXEX7SvopX1u9tXU8rw40ZlOggobktDgnw2l5E0GAXEKsyJB3vuG3v/ikjMemaaexIisRe4JY3pSF
	Xn17H7PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adH-00000001Zo4-0BjC;
	Mon, 21 Sep 2026 09:48:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8aHF-00000001V8e-1cVy;
	Mon, 21 Sep 2026 09:25:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1734D4145D;
	Mon, 21 Sep 2026 09:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C231F000FF;
	Mon, 21 Sep 2026 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982731;
	bh=h0lbirbiRFTe0nqD7sNgdCQWa98rjE9GNM+G7wxNPPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9GTjN96ydiq83Dx6AwgaeAwNufeqfgnbprIBt6+exthvcfj6KvKHWSrXRQ1G+fIO
	 CR0L87npQ6Ea0jPOMswGc8AY9HnXr6SzLE6hm3nroxAsiTUCFONF1AjBiWKiNkLCdo
	 HfU9pb7exOZunuj/m975SoxT+oZ9pYI08PLbHjYu/fAt6wyUupuuHzXfSz6mCT/nIk
	 r3IcK0eAwtFOVdNOuyV1xOecJJtozZWu9l2Zr6l995o+kAO6IhF78/0PcvtX2Ru4hP
	 wNiuRs4Yr9agDz8f6d2dNNu6+5doMmiXjWlo0apEAt26WEd6BL0MZpD5VMrlz6qyli
	 Z4DPAU2m60XSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/14] crash: Fix TOCTOU race in crash memory range
 collection
To: kees@kernel.org, piliu@redhat.com, npiggin@gmail.com, mpe@ellerman.id.au, me@linux.beauty, bgwin@google.com, mingo@redhat.com, x86@kernel.org, baoquan.he@linux.dev, guodongtai@kylinos.cn, leitao@debian.org, driver-core@lists.linux.dev, coxu@redhat.com, pratyush@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, will@kernel.org, dakr@kernel.org, sourabhjain@linux.ibm.com, maqianga@uniontech.com, gregkh@linuxfoundation.org, sshegde@linux.ibm.com, liukexin@kylinos.cn, kernel@xen0n.name, thuth@redhat.com, hbathini@linux.ibm.com, linux-kernel@vger.kernel.org, mclapinski@google.com, tglx@kernel.org, kai.huang@intel.com, linuxppc-dev@lists.ozlabs.org, robh@kernel.org, seanjc@google.com, james.morse@arm.com, palmer@rivosinc.com, chleroy@kernel.org, yeoreum.yun@arm.com, loongarch@lists.linux.dev, jbouron@amazon.com, catalin.marinas@arm.com, ritesh.list@gmail.com, akpm@linux-foundation.org, rppt@kernel.org, eric.devolder@oracle.com, chenhuacai@kernel.org, vishal.l.verma@intel.com, dave.hansen@linux.intel.com, chao.gao@intel.com, pasha.tatashin@soleen.com, bp@alien8.de, mark.rutland@arm.com, takahiro.akashi@linaro.org, zhangtianyang@loongson.cn, rafael@kernel.org, tangyouling@kylinos.cn, graf@amazon.com, ruirui.yang@linux.dev, hpa@zytor.com, linux-arm-kernel@lists.infra
 dead.org, maddy@linux.ibm.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-15-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:25:27 +0000
Message-Id: <20260921092528.17C231F000FF@smtp.kernel.org>
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

> The crash kernel ELF core header construction counts system memory
> ranges via `arch_get_system_nr_ranges()`, allocates the crash_mem
> buffer, and then populates it via `arch_crash_populate_cmem()`.
> This sequence has a time-of-check-to-time-of-use (TOCTOU) race with
> memory hotplug: a concurrent hotplug event between the count
> and populate steps can increase the number of ranges beyond the allocated
> capacity, causing an out-of-bounds write. If the event triggers
> memblock_double_array(), the memblock array can be freed and reallocated
> during iteration, leading to a use-after-free.
>=20
> Protect the entire range collection with device_hotplug_lock. Since
> the hotplug notification path already holds that lock, add a lockless
> helper, crash_get_memory_ranges_nolock(), for use there. The regular
> crash_get_memory_ranges() acquires the lock and calls the helper.
>=20
> [ ... ]
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D14


