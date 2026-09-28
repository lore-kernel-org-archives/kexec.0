Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01864CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zm1ZvYYOTuQ3ScOHQ7pIKzUfv4/g7hN/0crXo96RuGA=; b=MDhTiEDgkBAuxGoc1gzK9R3W55
	gKw4hcuBwXT2NvBki5P/sbi43JEDyowjfOP8Bz9T2JiaPYOr3d6Cece1Q0/PVDZ1Eq+D4duI0wtUw
	VB9ZCazu/i+mLNyRHKhdixzNM2ZgCVCd8+G3EWTKwzL7aUCT9oFWEuVwxiD+1zbddhPlGnX3EGo3q
	a4bHyIRNuX1rYaz2u27m4ED7o20P6V89vLgc2Z/x7Qw5Tbt/BD8FkdaWfwryF6XoNvcKOMn9c10JC
	NpHxNcU3v8hqWt4CltGIKRo6XWyZmPPqvMMpjLPNpUcRgxuE7Y+gWPTvmTLJ7PmB/d8Xj9udoQA4F
	p5NXqbNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFi2-00000001GYm-2mMJ;
	Mon, 28 Sep 2026 18:04:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFi1-00000001GYe-2Wtq
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:04:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A71C436E8;
	Mon, 28 Sep 2026 18:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682061F000FF;
	Mon, 28 Sep 2026 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618653;
	bh=Zm1ZvYYOTuQ3ScOHQ7pIKzUfv4/g7hN/0crXo96RuGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGJbMF8n7bcIQZiTn9RDUXb8IanJtLkNsZmHKna6T83BQoN+26fYS2G2okDl2MPya
	 PcN0XM/ontOUv4E3k++ARPjPXLbFBmfANvUWhgeO5a539SWdA2ULMjfohteKV1y0xc
	 6umSP1i+NadDHLoophmTeFdLrCzv9OgMHHTo4YZlzFnu8cNrFLhv2mWu7FqjalvmgX
	 Lor+y7KbUtuVqLjSpw3OKYPNOplV7I2JM/L8KUcI23kDqKODMpnwEEyXHVg1Dq+Xar
	 EnjXJtnvNU1rofcEIOcMUxaI9snofrIri1B8tN6ZVMCQax/NuLkvEhsigE68AHCrVH
	 N3VclxkSozUjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
To: "Baoquan He" <baoquan.he@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pratyush Yadav" <pratyush@kernel.org>
In-Reply-To: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:04:09 +0000
Message-Id: <20260928180411.682061F000FF@smtp.kernel.org>
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo
 Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay
 Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, virtualization@lists.linux.dev, Steven
 Rostedt <rostedt@goodmis.org>, Maaz
 Mombasawala <maaz.mombasawala@broadcom.com>, Borislav
 Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Selected crash callbacks should not require running every panic notifier
> before kdump. Add a separate atomic chain with an at-most-once dispatch
> helper, and invoke it before panic reaches the kmsg dumpers.
>=20
> The helper permits another call from the crash path without repeating
> callbacks or recursing into them. Document that callbacks may run in NMI
> context, with other CPUs running and the kexec lock held.
>=20
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D1


