Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D52BC9830E
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhgSzrfp/pMMNZb9pxFnuj0VXMHs0TjA//aVTOauAkw=; b=FpHZcH43QX+fHoCtgAxbS4TNki
	VH8LbQKU7fWB2Zm5QkMgQSHyaJkQaRIyQ5s7YrAIeV0UPyxx/K0kxh1W7hSiRRb7/taqKHSAyg+Nl
	2ol3FXydxzuRZHEesvyouiFYaDdEBUjR4HFPiJnBO3OLE63M8DcHCuaoBAGL7pexMzPUA+ygXgSJ0
	sCgEF4ggw5m2GhEtFEBCLQKSlxutXiLIHSSWiHM45GGnKxvD07bB6ctHHN0hQRF1w2zZhgpnJRNDP
	S8RSQ8sRDsiNYUUfV5UGoaIsA/umvkgRoeOYPid7FIhSwzh8kvr/yZhZhhhQujTTEKmaPZV0gYZPI
	rVMbyJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABgH-0000000EH6B-3G7C;
	Fri, 25 Sep 2026 19:34:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABgG-0000000EH5s-2LEi
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 19:34:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DB6843DDB;
	Fri, 25 Sep 2026 19:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC591F000FF;
	Fri, 25 Sep 2026 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364840;
	bh=vhgSzrfp/pMMNZb9pxFnuj0VXMHs0TjA//aVTOauAkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJcTgrQy4zKteYhB+2eS4JxXxiByQG6+6Ay4P6egHkQiQIBuIBS7gzHlibknm5l97
	 hitC6GxzFuFpPe2DEbiiVpjy+vYvgrlX4yFojtBwMzywJ46zwuTWUs9NkBpvHAuNNG
	 zOBL/sF8klXo7k/0X4MQjKpt4NiOYYxmjcX0/6aaOkqCkEOYsi2IRx+rQo9VK+T7cn
	 fWo0ngx0AcN4K2VWv306HPC7mb0iP2A+4PSBs3HMU3MhUuF0zZMtunnJge1c0SS3wg
	 K85c9Spcycj2xoEI70kiMhp7vQPBVpz2nrxFX8NOXE961jb2Q83OxfxggLQfV6ZUxw
	 FmKd2NlR1y5vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] kbuild: Mark usr_gen_init_cpio as
 no-dot-config-target
To: "Shuah Khan" <skhan@linuxfoundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Maximilian
 Huber" <maximilian.huber@tngtech.com>, "Nicolas Schier" <nsc@kernel.org>, "Luis
 Augenstein" <luis.augenstein@tngtech.com>, "Jonathan Corbet" <corbet@lwn.net>, "Alexander
 Graf" <graf@amazon.com>, "Mike Rapoport" <rppt@kernel.org>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Willy Tarreau" <w@1wt.eu>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, "Askar
 Safin" <safinaskar@gmail.com>
In-Reply-To: <20260925-move-gen_init_cpio-to-scripts-v3-1-99c493f76722@kernel.org>
References: <20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org>
 <20260925-move-gen_init_cpio-to-scripts-v3-1-99c493f76722@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:33:58 +0000
Message-Id: <20260925193359.3EC591F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-move-gen_i=
nit_cpio-to-scripts-v3-1-99c493f76722@kernel.org?part=3D1


