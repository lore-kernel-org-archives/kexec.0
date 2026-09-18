Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314AC982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=; b=fPOvdFewyD68qzTmVUTqfvFOB0
	oWxGZsDtS8vU60TMi1fTfqpo0/m+7p3ay7ZHpKCuE/ohaOFLSf1IWX3LWv5kHpAJVatghyg5caGcN
	Cxl5vmlwbkP3pVx9vVD0uPa+s/D9nDV56WTRsco6ix1XnNhtghTsBsAjJ8IXoQYANcYAX6nmPttyU
	UNTACALuZVflKfB1fRmRegXdYFqv3W7Y4gvIbaA+ccQ4Nt4j5wqYpDJl72VQI4aqwd+XDc8cdxDOL
	hAlk00xt+9x4PKQvwqvCjXx/PWCU71jXY9lCWRVHEQgt4e8A+mceeZZ/zoFMjduz0oykmGYlfbUi9
	sHt3fNyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4p-00000000NTO-1Is0;
	Sun, 20 Sep 2026 20:23:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Vv5-0000000E6WM-110t;
	Fri, 18 Sep 2026 10:34:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1DB840524;
	Fri, 18 Sep 2026 10:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8601F000FF;
	Fri, 18 Sep 2026 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727654;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQiwVwcrQYLLOMOj+NzO2JrLYChumnio/fc/mR5O1sf+FXz56jqfp8xu3Zrn/AQ+s
	 UPQyFX9daLLzA6NyhjGsoN+Am67E0Plu3Mfyd5MMPIetvbNA9eZOvvUVUwHG4KkIpd
	 Hm/jAvYbKzwaavhWLnLyf8e6cQcV9SfiClrlMIomraUmmkXu7tWNmkMAxTVqQ1kGvu
	 3PA8y2MCJUX2uWkWgRxGYr4d1uKTFqRc5E5X8XQb4BwZPPMAW4GtRKnetdW/5jxo5v
	 HIf7SrFWALwipQXYaKiwGiTgnED/7M//LvvFLI5CfiI/ADJfkSN8KaNbw2mngKa4Vn
	 EsC+2NfERzkuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] crash: Fix TOCTOU race in crash memory range
 collection
To: vishal.l.verma@intel.com, linux-fsdevel@vger.kernel.org, jbouron@amazon.com, linux-mm@kvack.org, sshegde@linux.ibm.com, bp@alien8.de, maqianga@uniontech.com, mpe@ellerman.id.au, kas@kernel.org, gregkh@linuxfoundation.org, chao.gao@intel.com, mingo@redhat.com, kernel@xen0n.name, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, chenhuacai@kernel.org, seanjc@google.com, ritesh.list@gmail.com, pratyush@kernel.org, tglx@kernel.org, pasha.tatashin@soleen.com, yeoreum.yun@arm.com, gshan@redhat.com, chleroy@kernel.org, liukexin@kylinos.cn, thuth@redhat.com, eric.devolder@oracle.com, linux-kernel@vger.kernel.org, kees@kernel.org, dakr@kernel.org, mark.rutland@arm.com, x86@kernel.org, leitao@debian.org, blum@kernel.org, catalin.marinas@arm.com, zhangtianyang@loongson.cn, me@linux.beauty, mclapinski@google.com, palmer@rivosinc.com, loongarch@lists.linux.dev, ruanjinjie@huawei.com, rafael@kernel.org, will@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org, hpa@zytor.com, james.morse@arm.com, tangyouling@kylinos.cn, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, baoquan.he@linux.dev, lizhengyu3@huawei.com, maddy@linux.ibm.com, coxu@redhat.com, linux-arm-kernel@lists.infradead.org, guodongtai@kylinos.cn, hbathini@linux.ibm.com, ruirui.yang@linux.dev, 
 adityag@linux.ibm.com, graf@amazon.com, akpm@linux-foundation.org, sourabhjain@linux.ibm.com, driver-core@lists.linux.dev, piliu@redhat.com, ardb@kernel.org, robh@kernel.org, bgwin@google.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-13-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:34:10 +0000
Message-Id: <20260918103411.5E8601F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D12


