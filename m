Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46F9CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To
	:To:Subject:From:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvnLUUTkX/vIglRHw90BFQnofbQcleiKGqQ/3UvoQgw=; b=KTQzQQ+9g/uJhLehqxx1x/wTZx
	Dr4AMhps7Xf6nLY0w5+M/gAVT5vLh0Ntrmunf6O1ziBHl7FwFDR3d4lZz0kNXnRglieu4nD5W/XzZ
	IpHunW10Swt16cgUh4opzuRY2AEpMOX47OxqDmc8rorzAVsxlBRMzttGyPdxTIBUP1Xvw/UtYydoW
	4ApRsh+bVZzNee8tqgkXOL9iTi+q0or/hHQyvxnI1ZUCbQ/Scqh9l1fc1xOqfTHOGpRu4Jh45wyF2
	gP10gIiJBaD920rJXBtLPEzr9YwjtRABLLsdR1l8Ocqrxdwv9wD+L8gd1UHoOQil4iHVoGHePZsfm
	JoBnMiWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFkE-00000001Gqz-41nM;
	Mon, 28 Sep 2026 18:06:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFkE-00000001Gqq-1zC9
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 18:06:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DA31741278;
	Mon, 28 Sep 2026 18:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E672E1F000FF;
	Mon, 28 Sep 2026 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618789;
	bh=VvnLUUTkX/vIglRHw90BFQnofbQcleiKGqQ/3UvoQgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAzBJX+miQZMsrjtZnZVwB+vVsYd8t/CB1vCRrh254uQduyjLc1tWlok7LeiQvVgN
	 kOcV8DN5elvF6rMYTI5lCVXHCpd3Cg8TyCLberdU2d+YykpmwkjSf/Jc28p3vYye8h
	 7OgpThCBX+HO58moCieWN4AWtE4ghMRMRnUVeitcYTFB4fG/XWTpPw8KSUK1l5PPtS
	 bv2we7ISA08i4FUkQV39V3TYifCK7J/C9WVsoU6T/sBmYSNqEj+Anj4m0l8mWATdRi
	 4pmmA/FFIpGQDXLvbReFBLRYn4BRiR5n9QkOaNXJRUm72njTHy5dsGAq2mCQILiMkg
	 bEXDFPbwrp1ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] x86/vmware: Add the vmware_record_panic_msg
 sysctl
To: "Mike Rapoport" <rppt@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:06:27 +0000
Message-Id: <20260928180627.E672E1F000FF@smtp.kernel.org>
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
Cc: linux-doc@vger.kernel.org, Kees
 Cook <kees@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo
 Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay
 Kaher <ajay.kaher@broadcom.com>, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy
 Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian
 Forbes <ian.forbes@broadcom.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: rST title underline too short for vmware_record_panic_msg
--

commit c541f42ddd949c322e4b6facb84fc17737ed184a
Author: Zack Rusin <zack.rusin@broadcom.com>

x86/vmware: Add the vmware_record_panic_msg sysctl

This commit adds a new sysctl kernel.vmware_record_panic_msg to control
whether panic or fatal-oops data is written to the host log before kdump.
It allows administrators to configure this logging behavior depending on
guest encryption, and defers sysctl registration until the logger is ready.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f=
3zjbz7c@srfabx6lsusj

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index ffea61d448ebb..be13c143b8bb0 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst

[ ... ]

> @@ -1690,6 +1690,26 @@ entry will default to 2 instead of 0.
>  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> =20
> +vmware_record_panic_msg
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Is the underline for this section title one character too short?

The title vmware_record_panic_msg is 23 characters long, but the underline
is only 22 characters long. In reStructuredText, the underline must be at
least as long as the text it underlines, so this regression will trigger a
warning during Sphinx documentation builds.

> +
> +Controls whether panic or fatal-oops kmsg data is written to the host's
> +``vmware.log`` before kdump. This setting does not control the separate

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D5

