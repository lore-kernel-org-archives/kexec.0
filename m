Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF1C982DE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3VWhm5DK1BFR53HtMU+M8vTk1Nt5oNf8CDsE/3Y3vo=; b=4L1wYgVdJbjQiFe5Iszw3vu4rr
	EZPxsSo+bF/AVNFdq1H7LwI1oQZdk28DKvfSrNZL27xLn045/aIsqSDIXojJYS92fJKvivB730PdN
	U9O2xIcgftSrlcKrzV4CsT6djJbcplfK+hRxRlEr2IUy+KEBOB0JRE2a+UA2zDuExt4/raELsXqfN
	m/aOkPRSukZSpm9qDIqOtgU/LqZsdKT+iv6g/qNtmGwAiAHE2aGtfl1FNrJB8ySg1VPCzICW7AyU0
	+q31XihELNAqNbZoTGktIH9iZIJhvKA1eowGLT49fE2H58cv+svOnQ6jgFkkZFXIO6nbe5s4UXxiy
	SoDmxXPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adG-00000001Zko-0VFW;
	Mon, 21 Sep 2026 09:48:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8aBL-00000001U98-1RUi;
	Mon, 21 Sep 2026 09:19:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 99DEA600C8;
	Mon, 21 Sep 2026 09:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B91F000FF;
	Mon, 21 Sep 2026 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982366;
	bh=R3VWhm5DK1BFR53HtMU+M8vTk1Nt5oNf8CDsE/3Y3vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YI2jAtzThTRUXkLRo3VokSMs5LXJ3b+47X/wzjp2A9MQPJXtTVCJgeZMMH20BHsaB
	 euMHtjmsZbFr3gDTAo01ri5nLzp+TeSj/709aes7F8xnEyIftuq9ly0dTraeFNKm7J
	 0hlftxFkdl13WZQBqOdVwrPt0qOhy0ZUtWiu9DhhAFL+OxA9Qy7DqAdUPrjFGYMiDC
	 AR4OrQxYuq8Pyr2Dyv1AhLZ5nNp96h0XFxyxdmX0mtMCABbBR7MfmWvkLeNzO8TiWc
	 ship2/zQCSp5Lriz6Kmzn2p8d1YcvXMKV9qCHv3HvFRiqSHdDkkPXkMq1TJO/CXGmA
	 6EkmbF5tXmFLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/14] crash: Extract crash_get_memory_ranges()
 helper
To: catalin.marinas@arm.com, hpa@zytor.com, bgwin@google.com, mpe@ellerman.id.au, vishal.l.verma@intel.com, takahiro.akashi@linaro.org, chleroy@kernel.org, baoquan.he@linux.dev, yeoreum.yun@arm.com, maddy@linux.ibm.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, rafael@kernel.org, coxu@redhat.com, loongarch@lists.linux.dev, leitao@debian.org, palmer@rivosinc.com, robh@kernel.org, rppt@kernel.org, jbouron@amazon.com, kees@kernel.org, james.morse@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mark.rutland@arm.com, npiggin@gmail.com, will@kernel.org, sourabhjain@linux.ibm.com, ritesh.list@gmail.com, pasha.tatashin@soleen.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, bp@alien8.de, thuth@redhat.com, chenhuacai@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, piliu@redhat.com, driver-core@lists.linux.dev, graf@amazon.com, me@linux.beauty, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, mclapinski@google.com, seanjc@google.com, maqianga@uniontech.com, chao.gao@intel.com, guodongtai@kylinos.cn, tangyouling@kylinos.cn, liukexin@kylinos.cn, dakr@kernel.org, x86@kernel.org, hbathini@linux.ibm.com, zhangtianyang@loongson.cn, tglx@kernel.org, kernel@xen0n.name, pratyush@kernel.org, eric.devolder@oracle.com, kai.huang@intel.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-11-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:19:23 +0000
Message-Id: <20260921091924.321B91F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D10


