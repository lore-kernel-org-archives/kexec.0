Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A684AC982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTlfKzJ0Vr6DSRpLT6CuScs/v+wf5LCST8fvQa+xTPw=; b=uPc7BM0FB7o7vQgg6OJpGZbLMW
	wsM/yXtGXQ4Nk98u7eoewXGTR3qocwPQD6nF2DQ7yqczQ1N0vgd0JoH1O92zbtcXfvgmtL+KV5HBW
	QVAjrbVLy3J2enu9pIwbymNUWrP3cAFdSCiYikH5VLPmaeKDhh1mYC0Y4NiV5Fd4Wvk82vOeiRmt2
	iYMZAsPmSprE5ONrhnRM31j6bJXZ3r53/82YQufg/EdYYt3g6BIFbxJm2u6d/828mIYycu8YE+aTY
	h+wKkMr527TAI0b+Ojtv0IsAbFSoWMDFjcwBy2OmclCqY5g9l+MXpV0sC5tOKMYAkQ1po+kud0ZZ0
	1CYjqGfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wIq-00000004n8r-3V5e;
	Tue, 22 Sep 2026 08:56:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wIo-00000004n7Q-420r;
	Tue, 22 Sep 2026 08:56:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D76660234;
	Tue, 22 Sep 2026 08:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C21F000FF;
	Tue, 22 Sep 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067397;
	bh=pTlfKzJ0Vr6DSRpLT6CuScs/v+wf5LCST8fvQa+xTPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjMMkTL3IajEia8updhKDn0B0sN4uZ+B51lBn49hz7hBmJ7MzWBYI5EcEuEfwLN1o
	 4jfNijR50BmzKGvcn4d3dOkVX34YzyVllzamWislCB7YlbrZGEahwe4J+IwHJKC6N+
	 1iHed7xRRr8Ru9DsDsXeS3ulEnbHJ7mRbt9vy/crzJg0ktncs3zhFh3LbWpiZPc+44
	 4UnH7475pFNCOVwqBQNdH8sjwnNDLUk/7fK7JR1SNGnthWoIVt6fcSbAzIpSdigwMw
	 lla9CdSpA7/mRiWzZ1SLBxmWzFq0xLxG5qwc+iTmamJ1wxAjXz1oC/erw2cD0LGg4j
	 xiUpRSRlL0knw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] crash_core: fold duplicated memblock arch hooks
 into the weak default
To: "Wandun Chen" <chenwandun1@gmail.com>, m.szyprowski@samsung.com, robh@kernel.org, rppt@kernel.org, baoquan.he@linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, tglx@kernel.org, will@kernel.org, bp@alien8.de, mark.rutland@arm.com, pjw@kernel.org, ruirui.yang@linux.dev, hpa@zytor.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, mingo@redhat.com, pasha.tatashin@soleen.com, linux-riscv@lists.infradead.org, conor+dt@kernel.org, pratyush@kernel.org, alex@ghiti.fr, x86@kernel.org, loongarch@lists.linux.dev, devicetree@vger.kernel.org, chenhuacai@kernel.org, linux-kernel@vger.kernel.org, saravanak@kernel.org, kexec@lists.infradead.org, robin.murphy@arm.com, linux-mm@kvack.org, catalin.marinas@arm.com, iommu@lists.linux.dev, kernel@xen0n.name
In-Reply-To: <20260922084256.1515554-3-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-3-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:56:35 +0000
Message-Id: <20260922085636.324C21F000FF@smtp.kernel.org>
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> arm64, loongarch and riscv open-code the same memblock walk in
> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
> the __weak defaults in kernel/crash_core.c and delete the arch copies.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D2


