Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794C606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N+PBOtHL;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngmpksV/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MLCVQipA4Q51nEPYebVa2UVEhR7m3/Zxk/h1UgiI7/A=; b=N+PBOtHLX1z2T65FM0ut6aBWld
	NQ4esI1xoSVz7TJ52ElvW1rIzTS8DquGW5pSfr9Agh+1U1wuwbomBOHEteYFkOVBLSC5yXZ/mletZ
	j5uSSRD11ypEYo3JDB93+gCUXICMcISPfF6f8FRWzvOuPzeU81ha6+CMGx2rRlxevnTb3u4enoXF9
	o7LQODY6W9L6P7RRGs6qR8c7Ha1Ju6ZGDZfqQCAbhmCZhM+BnuK+ezm24pHcf4GtZBj9wOKHuvrT4
	xQJhTpAU+nBp6sF1AsLOvMaUQWBcSPQQg8DiRcePmLmrrmUvmLQIR9ATYVj7bXspta8IoiWSaTehw
	eFX9kTZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQILW-0000000HSwd-096l;
	Mon, 09 Nov 2026 05:55:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQILV-0000000HSwX-18eo
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:55:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B426643DDC;
	Mon,  9 Nov 2026 05:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488CB1F008A3;
	Mon,  9 Nov 2026 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203708;
	bh=MLCVQipA4Q51nEPYebVa2UVEhR7m3/Zxk/h1UgiI7/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngmpksV/quRsyPLoSZMlswSi2ELbcPXzWc1TmAdTxshzkrS7tfO+6xNPMfoRhYjaB
	 HuJANxIKKJQFojwJcc72T+0LrnrIE5HzCd74AKg30xpcdOj7+/E1V+rnBWmn2RyXKl
	 o2VhZyu9LIU9oaeNfOKrGPUcy0Ao17Dk57dKGJtPOslhQ4DTpSMVl45JYNeUJ69Nc7
	 BuTGMN7HbUY0kI8w6CWMaFV6FXWhKKvWIWJNj7I0OoXDLWWfcahERu7uU8mIHMgbB1
	 4KW+NRYS3lIfWp9azzfj+tdEkPBYtD7oGaotlSIu2KKXME/a1CZSh8++TnMzWVjOaD
	 K/biHa8e/vzzA==
Message-ID: <sashiko-outbox-204465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:55:04 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Michael
 S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John
 Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah
 Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian
 Forbes <ian.forbes@broadcom.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas
 Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Allow administrators to disable host log transfer on ordinary guests or
> opt in on encrypted guests. Expose the boolean recording policy through
> kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> Zero disables recording, nonzero integers enable it, and reads return
> 0 or 1.
>=20
> Register the sysctl only after the logger is ready. A registration failure
> leaves the internal default in force. Document that the log is sent
> before kdump, and that disable_panic_notifiers_platform_list also skips
> it.
>=20
> Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw=
7f3zjbz7c@srfabx6lsusj
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D3


