Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45944CA5FA3
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aXEt8cLj5MZO0I73asHe3zofPVNAzMphdpTAK0N6FfY=; b=Y+fCLcqHU2jflr6vy0lv1DaYG6
	/FamY94Qxhkg4Qj+ykygp7peRaX/IprqwO2ofjimby7YH66Kiott9eJu4QzH0djWYHLNrcrIcg7pM
	/0fGM+Z3whK2KliYZy5YFs9g+z8gaKep7qUrQHtXWEUqdnoMRSJyCpa1gujCv0NRWIjluz40hOaHp
	y/C7NfuHXI62LMmQquI5ALHw9BzCM554qePc2S4FHc9L4QE08rbMtvS9zAli25NzsiMzfIso+Ozxb
	X35SwMVvcKrSN8ZBrxvPi1DeqryIfBQyCBDsagfwevn5LxA3YSsjC0QhqZtLeU0ieiwHUbnWZ4K3P
	0wAarlYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFkn-00000001Gwp-18Cb;
	Mon, 28 Sep 2026 18:07:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFkl-00000001Gwa-3i4Q
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:07:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F30F437E4;
	Mon, 28 Sep 2026 18:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F9E1F00893;
	Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618823;
	bh=aXEt8cLj5MZO0I73asHe3zofPVNAzMphdpTAK0N6FfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkdDllWBAWV5FGuXwvbjEPRrpIDNW0dE7ueXGI1WvWp/AW/N7EAHBRQDMLs2+H3nz
	 pLEKPGak1yaX9UVq9Fb1ucxNAhmv6RWC70uuRxMLoWv6SR2MvvK3A5DtgZ6u97b+A3
	 xQtUpOQCtgBAySTeKXC1iLN8suUD9vmVagzo41ghn1qN/UGn5ubVotTTdDczQLk4gS
	 4K8YIEQOask3UeRdr8cFTjBIok+hbWq/Fb567PzFNDVn/hhYv0r2cv5Hzs+d0CRxoO
	 LwTagIm3x2qKu+gV6bbSJY9txsQB9ar07NT+kGal5ajgx0Hveq3co6x4xFXdGLYrEK
	 zAwMIRi9TF9Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] x86/vmware: Add a bounded pre-kdump log sender
To: "Baoquan He" <baoquan.he@linux.dev>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Petr
 Mladek" <pmladek@suse.com>, "Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:07:01 +0000
Message-Id: <20260928180701.99F9E1F00893@smtp.kernel.org>
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
Cc: linux-doc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo
 Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio
 Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz
 Mombasawala <maaz.mombasawala@broadcom.com>, Borislav
 Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael
 Kelley <mhklinux@outlook.com>, Randy
 Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Preserve the newest kernel log tail in the host's vmware.log, which can
> outlive a guest with no working userspace or persistent storage.
>=20
> Allocate an 8 KiB buffer during early init and register on
> panic_pre_kdump_list. A 4 KiB buffer can omit useful stack-trace
> context. Use a fixed byte budget so transfer work does not scale
> with PAGE_SIZE.
>=20
> Copy the newest records, prefix them with "log ", and send one RPC over
> the low-bandwidth register interface. Bound the transfer to 8 KiB and
> at most three checkpoint attempts; zero-fill a partial payload word and
> close the channel after every successful open.
>=20
> The callback allocates nothing and emits no printk messages. Enable it
> for ordinary guests, leaving encrypted guests disabled until explicitly
> enabled by the sysctl. Skip initialization without printk support, and
> leave logging disabled after allocation or registration failure.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN=
6PR02MB4157.namprd02.prod.outlook.com
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D4


