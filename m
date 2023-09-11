Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E4CA0EC3
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YojqENfxfka8QpojVRrby3UUN2yKdhm7IWEMe4T3yto=; b=OwRyH/Q/qwHmlV
	ZJupqM8ZNJurhHYln+aWVYOG+3oCAFIqwK0IpbDtSVT+Mqy8MBeJrPtRUGjPOrkSCJBghCoLVGeSJ
	P/ITSWYdtK4jWYM8FqoZIq+5C9WIe8ig/zXlpdXxol9kFxPBlzMMWBPGv6HvLPfXBZuMHizPmd5RK
	KQ5Jl+wb6Jsowdil/aOFWUujAEmCs0fGjvOjCHGi9F+TW+0kWk6+R2dVyXlI6KCcxd5m9/aTOI+DS
	6Ss1fDXMx/Dx/314QQhZQE/u+ruxyCtvDL33ZsHtKinPyHSjBiGZtrWky/Gl4AvTgN1/N5LuqS14S
	fEUlxfcdykqsZzJKhqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfozJ-001SYp-1W;
	Mon, 11 Sep 2023 22:02:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfozH-001SYL-08
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 22:02:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D66206151A;
	Mon, 11 Sep 2023 22:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C53C116AA;
	Mon, 11 Sep 2023 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694469749;
	bh=BPQ6dr22xKZeaU3Kgfesl8AdYcWadqw/YEcuDpmDST4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=N5GwXa+SDYrhEIk4TuMtZ7tTjNdzDnsTrHuml88ub+VqXsSBsN2OjmWvPuZBZ4UWP
	 Mo49LFkDV40SawEe1+qf9LrZFe2/UVm2Y3OAcZPB8mWpNvFAcyBv04yeQul4kPWO9X
	 oG9Fgvw400MHs8NRjIuBih87jiOL752wxzGUr0Q75CZiY3EWwNOgqkWPYm/yVFsVXc
	 dvtv3gz7NSqvABf8ilXAYQPtk+lRYTgqBosEks/u89WYpaP+zysbbOJaMRdxWEogpn
	 1hqlYlgt6t2JcOKR8cvXXltniUzh+izqSBl3VsajRTS94b7/l+7asMGhXiD26IsRRg
	 erZQgH3kXmONw==
Mime-Version: 1.0
Date: Tue, 12 Sep 2023 01:02:24 +0300
Message-Id: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
Cc: <kexec@lists.infradead.org>, <x86@kernel.org>, <tglx@linutronix.de>,
 <dhowells@redhat.com>, <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, <bhe@redhat.com>, <bhelgaas@google.com>,
 <lennart@poettering.net>, <bluca@debian.org>,
 <systemd-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
In-Reply-To: <20230909161851.223627-1-kernel@jfarr.cc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_150231_129175_3269C1F8 
X-CRM114-Status: GOOD (  12.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> Hello,
>
> this patch implements UKI support for kexec_file_load. It will require support
> in the kexec-tools userspace utility. For testing purposes the following can be used:
> https://github.com/Cydox/kexec-test/
>
> There has been discussion on this topic in an issue on GitHub that is linked below
> for reference.
>
>
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/
>
> Jan Hendrik Farr (1):
>   x86/kexec: UKI support
>
>  arch/x86/include/asm/kexec-uki.h       |   7 ++
>  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
>  arch/x86/kernel/Makefile               |   2 +
>  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
>  arch/x86/kernel/machine_kexec_64.c     |   2 +
>  arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
>  crypto/asymmetric_keys/mscode_parser.c |   2 +-
>  crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
>  crypto/asymmetric_keys/verify_pefile.h |  16 ----
>  9 files changed, 278 insertions(+), 116 deletions(-)
>  create mode 100644 arch/x86/include/asm/kexec-uki.h
>  create mode 100644 arch/x86/include/asm/parse_pefile.h
>  create mode 100644 arch/x86/kernel/kexec-uki.c
>  create mode 100644 arch/x86/kernel/parse_pefile.c
>
> -- 
> 2.40.1

What the heck is UKI?

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
