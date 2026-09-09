Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1736C79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZj7gcoR1BSM5qRU6zyoL1d1abYxfkHpfCAN9EDmS1M=; b=qT1eLb9vavQaS1xq2pA+fkwJfH
	SEfRXCkXUJJ/qj27lvTmF4iDNgHtaEW51eXUdUVA2FvQuWP1qvfk7tnngXOXOe7ATXg+M2W73xfUu
	3dFuTJlPkZcMRONwqtR2++5uIRQ2wU1ezbB3dUnCVjeDL7AmfUPia53TQIor+97hWMkwy2suQKPsZ
	cfHEaXKXXJLDnqcd0OA2dSFNXqSVYe8Iq76Xpov4FtePsQNFGuzFgfZI3KC7hM0deYGzJ3EluOmZh
	vhzPW5844ik18Yy9QTwVS3+k/cl75y/V8L8h7JngekikLyod3RDm4YawlLsAndDlp9Ggsfx2cTm9e
	hMXX7BTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I7K-0000000BlG3-31AW;
	Wed, 09 Sep 2026 13:13:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4I7J-0000000BlFw-3TIg
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:13:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 32ADE42B83;
	Wed,  9 Sep 2026 13:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECD1F00A3A;
	Wed,  9 Sep 2026 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959613;
	bh=IZj7gcoR1BSM5qRU6zyoL1d1abYxfkHpfCAN9EDmS1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1/4Stf0ONAeUDQwpGd2ObDI4Y1eUAi/bIJeo3Kg/A3Q4m++iPAtNGiq119atWnZi
	 /1Qj8UCIt68EW/K8SkdnNb2muOzmu8IfBBZL4/DN4hb53pE4PI0oomqX+wm/Mt8q+M
	 UYBAkF2jGPLZCEGNzHB5LJxRE7hwUQ4jmmtfEqQ8Wt28UK4W6myJBSi6sfNOPWWx6Q
	 /iTvGzpidk91r6b78Ipmjhxg3nx52Y2hBdHDVR3sAA9sFUCqHA8PAM6LOKRQ6JBB8z
	 Pi2OrAlsfgMSBia74jxXsVq2C4ZLCvRj8Vr0VhyJILFcI6NHxdYTmrmeiisqi5Xe0F
	 +LS5tDzC2tsjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
To: "Andrew Morton" <akpm@linux-foundation.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Michal Hocko" <mhocko@suse.com>, "Zi Yan" <ziy@nvidia.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Mike
 Rapoport" <rppt@kernel.org>, kas@kernel.org, "Suren Baghdasaryan" <surenb@google.com>, x86@kernel.org, "Vlastimil
 Babka" <vbabka@kernel.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Breno Leitao" <leitao@debian.org>
Cc: rmikey@meta.com, linux-kernel@vger.kernel.org, riel@surriel.com, harry@kernel.org, linux-efi@vger.kernel.org, kernel-team@meta.com, kexec@lists.infradead.org, linux-mm@kvack.org
In-Reply-To: <20260909-hwpoison-kho-v4-1-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-1-359313564495@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:13:30 +0000
Message-Id: <20260909131331.1BECD1F00A3A@smtp.kernel.org>
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

> Hardware-poisoned page frames are tracked only in the running kernel's
> data structures, so a kexec loses them and the next kernel doesn't have
> this information, thus, tripping into them again.
>=20
> Add an EFI configuration table to carry that information across kexec.
>=20
> It is a bitmap with one bit per EFI_POISON_UNIT_SIZE (2MiB) of physical
> memory starting at phys_base, modeled on the LINUX_EFI_UNACCEPTED_MEMORY
> table, and it rides the EFI system table to every kernel in the chain.
> Basing the bitmap keeps a machine whose RAM starts high from paying for
> the hole below it.
>=20
> List the table in the x86 efi_tables[] too, so an SME host maps it
> unencrypted like every other EFI table.
>=20
> The Kconfig symbol has no prompt. There is nothing for a user to decide,
> so it is on wherever it can be, and it only costs 64K per TiB of RAM on
> a kernel that already has the EFI stub and MEMORY_FAILURE. It is
> restricted to 64BIT because the unit arithmetic would need div_u64() on
> 32-bit, and there is no 32-bit EFI configuration with MEMORY_FAILURE to
> test that on.
>=20
> This is a similar approach as used as unaccepted memory.
>=20
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-hwpoison-k=
ho-v4-0-359313564495@debian.org?part=3D1


