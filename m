Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6892CA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZAMQYYiiCkPWOPSajMdbfju4b+8ZMSrcWzT8+A/DzM=; b=m2tf0vgpjdowW/aHBg80FINu1u
	DFiToTmeTBnYsy9RgbXpkXV52L4YMXYNf+dzdBYv0Qfuuq5rZp/5G9LNuNC4FH/IauRdfsHofQnL7
	p6W4tPZW94Fnznn0/30qVF9DwR0f3kiqnIEIMO/TgsSr0nA59iMXVrH73xvoGTvKmJv5+9D/o2t99
	umbhZDh6lOZip/pU6hPWO5djSYifkoTwQqUVv7Pk9mzUXM+D71sYJ24wMJukrt1LmdF1pemOiGt7i
	N54dzDugDniT/SJ3zea7/W4a1/nv8y2hno+Sp2TFBNdLSOh3ZTYqc8lH17FuPkgM0Ot48aGO5B4Hh
	r8lEthTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFE5-00000001Asc-308P;
	Mon, 28 Sep 2026 17:33:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFE4-00000001AsO-23XW
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:33:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 726A160120;
	Mon, 28 Sep 2026 17:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338DB1F000FF;
	Mon, 28 Sep 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616795;
	bh=ZZAMQYYiiCkPWOPSajMdbfju4b+8ZMSrcWzT8+A/DzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IA++G6KeWHo5KL4bWJkkW5kJ8rbX8uqYdP/N7/J6hUzwwPck9BMUiXbG7dv08mV+W
	 Mkhu7jYEAXKJ1jRG5xqRur6EpFCt+ugPjtVsCE3BOsuKgglOdOrcZwJpNzjmNxa6UT
	 bfZ+1lKO2H+JA+sQJJG7Wl/PBhYmoAXqnfUh7mH3/dnQ6oqK8J2Btnwoc3gVO1El+C
	 /keEp2AcAZTa6AinGiweR+Dc6hX1maKvscK9nl2GolTZI4w+ybNzA4vbF/5Vb0oA0a
	 OrXVKvI9dafmHTw4WBEi7Zkl4TfykIjBJ24IRHEjZfvg+S5xDuHTslMQXkC0rMMmKV
	 /9b/IY3S1qSKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] kbuild: Mark usr_gen_init_cpio as
 no-dot-config-target
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Luis Augenstein" <luis.augenstein@tngtech.com>, "Maximilian
 Huber" <maximilian.huber@tngtech.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Willy Tarreau" <w@1wt.eu>, "Alexander
 Graf" <graf@amazon.com>, "Nicolas Schier" <nsc@kernel.org>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Askar
 Safin" <safinaskar@gmail.com>
In-Reply-To: <20260928-move-gen_init_cpio-to-scripts-v4-1-f437a33c40ac@kernel.org>
References: <20260928-move-gen_init_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org>
 <20260928-move-gen_init_cpio-to-scripts-v4-1-f437a33c40ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:33:13 +0000
Message-Id: <20260928173314.338DB1F000FF@smtp.kernel.org>
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

> Let usr/gen_init_cpio be built also if there is no kernel configuration.
>=20
> Askar Safin reported that gen_init_cpio may be of use before any kernel
> configuration is available.  Add usr_gen_init_cpio to list of targets
> that do not require a .config file.
>=20
> Reported-by: Askar Safin <safinaskar@gmail.com>
> Closes: https://lore.kernel.org/all/20260220191150.244006-1-safinaskar@gm=
ail.com
> Fixes: f8e05c10631e ("kbuild: Add top-level target for building gen_init_=
cpio")
> Signed-off-by: Nicolas Schier <nsc@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-move-gen_i=
nit_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org?part=3D1


