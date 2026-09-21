Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15E8C982F8
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zf/aQsXCzB2e/77wVQGKOahnDXi6wvJ7QdslTWDQRvM=; b=sIKAvZJWXCiY9QPE8egCwMkhlf
	wywKsjW7IIn7C1sogYseXmQwwft2+5tkyRtw2BmYIDlP2K7dl9ryx7GZlDiwgE4V2zuebEIQMwHhP
	hc9+f8zNA2j3LTEoYtjz0opu69e3NGFZvlsWcUZ1AjupDMDbc+ROhOy/5vYWWm/NVZ0LNAEufMssn
	sESrlupqEHZuhWTZNcKmn7gJhEyYZVjDCCx7bp8nCXxSB/0ALcgbHG0b7KjcJZ8rxvvGZ8iU4jLaq
	a8RhVzIth509QTdGQOvGOJ/hvTweBsLuVhZHMbYEn14DU2fd8qOWyWVXwH3iLZlP2/NojL4jjeTGQ
	rp04LgFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adE-00000001Zi3-3yTS;
	Mon, 21 Sep 2026 09:48:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a9e-00000001Ttc-3N1N;
	Mon, 21 Sep 2026 09:17:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 863E041E49;
	Mon, 21 Sep 2026 09:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910851F000FF;
	Mon, 21 Sep 2026 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982262;
	bh=zf/aQsXCzB2e/77wVQGKOahnDXi6wvJ7QdslTWDQRvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFlwMSx4XeKM/6ODRT6JIAmtyQ4iEB13D+VkG7AENmXdbJad/d+MVzmnISIIvek0M
	 f+CHwALM7JHKTxEDD43GtZjOUgeokyAc9m/HG5veIoAOJnardr+uvolW59fEQBZ7OU
	 I+vkPy+6giY6egbg8LMvh/SdU7D+6/ePY6zyRKrlMCbvKsfKsmvv2GxY3etcV07GF6
	 /VjWuDWk6CJbQVZ8ECqpM7BX3LYQ+rc3uhPtMWw5iTdlZLsTFvMC8UBtOzw7FW3trh
	 Pm8gM7D9e5FWg2yIhbkwsqxRdTXs4ftgrC4VptFd7h8AmD6MVY6etE1HFkZZJnfZKd
	 R60b4F6ylFMOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/14] crash: Factor out crash_find_elfcorehdr()
 helper
To: dave.hansen@linux.intel.com, chao.gao@intel.com, driver-core@lists.linux.dev, tglx@kernel.org, leitao@debian.org, chenhuacai@kernel.org, piliu@redhat.com, seanjc@google.com, chleroy@kernel.org, gregkh@linuxfoundation.org, kees@kernel.org, zhangtianyang@loongson.cn, mclapinski@google.com, will@kernel.org, kai.huang@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, eric.devolder@oracle.com, akpm@linux-foundation.org, pratyush@kernel.org, loongarch@lists.linux.dev, x86@kernel.org, mpe@ellerman.id.au, robh@kernel.org, rafael@kernel.org, pasha.tatashin@soleen.com, ruirui.yang@linux.dev, jbouron@amazon.com, tangyouling@kylinos.cn, vishal.l.verma@intel.com, npiggin@gmail.com, yeoreum.yun@arm.com, mark.rutland@arm.com, takahiro.akashi@linaro.org, mingo@redhat.com, liukexin@kylinos.cn, kernel@xen0n.name, maqianga@uniontech.com, sourabhjain@linux.ibm.com, linux-kernel@vger.kernel.org, sshegde@linux.ibm.com, james.morse@arm.com, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com, hbathini@linux.ibm.com, linux-arm-kernel@lists.infradead.org, thuth@redhat.com, graf@amazon.com, dakr@kernel.org, bgwin@google.com, me@linux.beauty, guodongtai@kylinos.cn, palmer@rivosinc.com, bp@alien8.de, catalin.marinas@arm.com, coxu@redhat.com, rppt@kernel.org, maddy@linux.ibm.com, baoquan.he@linux.dev, ritesh.list@gmail.com
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-12-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:17:39 +0000
Message-Id: <20260921091739.910851F000FF@smtp.kernel.org>
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

> The elfcorehdr segment is located by scanning the segments for
> the ELF magic. Factor that scan out into a new helper function,
> crash_find_elfcorehdr(), to clean up crash_handle_hotplug_event()
> and prepare for its reuse in crash hotplug code.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D11


