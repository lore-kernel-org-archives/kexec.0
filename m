Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18544C98318
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 05:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDa9npNfJuDxNd7gtgXXdOumIY/2QpBZnEXtltyonF0=; b=varYoIZjJvEmTXFvQjQAX9/zp1
	Pm5sd5ODudIq/dIaXPhrNe35DKb9LAr/LIx9X9NzWzalhZjJ/5epYexehZGgcNWhlUr81F12/26Ip
	rGvnKRnBSbPC1c1eOj3smHYcrjPssba+ctQZCyV1YHxLx6G4NvAOrAHcAyGUW9ZSKmR2rK28wr1LN
	Xqhl/a1SaNbXvgOKpcc+w6KOB8aGIZ2tgCR4sC+Xq++Xaljnx5yoRHTzPAguoDMMprReMiQ1oK3A4
	Ni5DhIuY4UYP3I/LWK1Qn4K3nAWx8NxJHPTjUZSTzSDF+Y5Clx57ndpdCw0emDbwC4D4KVyThBu4g
	L4hd0ysg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKvQ-0000000F1bm-3pmM;
	Sat, 26 Sep 2026 05:26:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKvP-0000000F1bY-0qNK
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 05:26:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D75F34037F;
	Sat, 26 Sep 2026 05:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9971F000FF;
	Sat, 26 Sep 2026 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790400374;
	bh=hDa9npNfJuDxNd7gtgXXdOumIY/2QpBZnEXtltyonF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDhp/qQtHrKjJrdjeYqTs/N/AKf61PUhzJtReOlXhhjr97YI2ZUyncE4iDULD81Ag
	 kpJZe2/HAfOxFGWjpINVGb5RFfl4TVa0mKcSWhNv2rzZsOYMGqTpNZ3wr+Bkn260ZT
	 qxGQ3t4TW93zZO3tLe9dJuIN94uEM8K5ZBKbT++8J5koFcq7QVPcSxeuWAe3NQq5mM
	 8LLhLxCgqErIsNGWPSuGIfQMTY4UuaP/9TImNnNPmNVGzU7o9qxZaq5hcvEXRLY8Gr
	 0m76P1dmTlUtCBs+nVONlepNlMQ1nv80GBfJnymEh46LnPMpSCXXGpTwnpRCp5rhHt
	 VCWChmEV6dZVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/hibernate: Ignore page-zero RAM in E820 checksum
To: "Matthias Goergens" <matthias.goergens@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: scardracs@disroot.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@kernel.org, dyoung@redhat.com, io@r-ricci.it, x86@kernel.org, linux-pm@vger.kernel.org, yu.c.chen@intel.com, kexec@lists.infradead.org, baoquan.he@linux.dev, hpa@zytor.com, moravec@ukf.sk, jlee@suse.com, dave.hansen@linux.intel.com, bp@alien8.de, pavel@kernel.org
In-Reply-To: <20260926052117.3613637-1-matthias.goergens@gmail.com>
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
 <20260926052117.3613637-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:26:13 +0000
Message-Id: <20260926052613.CD9971F000FF@smtp.kernel.org>
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

> The legacy kexec_load path reconstructs the E820 map exported through
> sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
> transition, so a kernel entered through kexec_load can see conventional
> RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
> range starting at zero.
>=20
> The hibernation E820 checksum compares those byte representations and
> rejects the image, even though the maps agree from page one onwards.
> A QEMU guest showed this transition:
>=20
>   firmware:     RAM [0-0x9fbff]
>   kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
>   firmware:     RAM [0-0x9fbff]
>=20
> The checksum covers e820_table_firmware, which trim_bios_range() leaves
> [ ... ]
> kernel carries on.
>=20
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y map by md5 digest")
> Reported-by: Roberto Ricci <io@r-ricci.it>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926052117.3613=
637-1-matthias.goergens@gmail.com?part=3D1


