Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30B606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Tym4gkjQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYDTrptA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TwZA6J1WWNQirUHO6lcSIfw8e+F+eLWDt4uPBoTdUYA=; b=Tym4gkjQW2gGs+HMmaI5EJBasI
	GW0QOjvrri4XJwdHTyepk/CzLqP9q1okWITJcFrI6Pz7ojf+jdiQ0e9Z9frv8Yi68nlE8uVdPA8+Z
	nIhxXitaHG1PHGo1lARMcleJ1hzBD779g+0KKwM8U3jqP8fLr54fqBtGWCGL64ybZAO4NOoAnWwXT
	mw4z2k17JvLBkezCDHQG7IolyLFhZe9j4g+NQ6Ypbns+sO8S3JcQeZmHPcKQP99RBIWMxqaFm+Uh+
	GYe+uDqunuymYyI75U1ysFEfucmAFcN4OUzx+6sy5JpOIIsieH61t7ofNVlXIt8/bETQNUhx28Mg9
	HzTwdo+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRY0p-0000000AgKe-0ZP7;
	Thu, 12 Nov 2026 16:50:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRY0n-0000000AgKR-3wKh
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 16:50:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B4EFC60224;
	Thu, 12 Nov 2026 16:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097511F000C4;
	Thu, 12 Nov 2026 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502256;
	bh=TwZA6J1WWNQirUHO6lcSIfw8e+F+eLWDt4uPBoTdUYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYDTrptAlOLs8mQoy3QgA75QPbqhIMrnLgowg3I9BLU6ENeQUCozkSTDdKvFGo6iS
	 HHRmQS2mZGLttM9mvfc0xRYmeuzrfGvhDdOecrkORx+kTTGAV5+QuufluZuWgcvkxW
	 kTTf6LT2aE9yh4b3jclOflFm/98E0LCoMJBqiCGdl5LEVIwNGcT/5fWFWOMjYWLckQ
	 uLdN+amSDJE+vmlYSkC3DlRCMUQbCIxLdnM3jGugd5uyhLs6A+aIumfZUh4CPr4Chg
	 Fwi2Pm6Dij9KW95E/jpZY24SbhlA7ApWAS//9x1yVouofFGb+ryCDddNI2YLIqAeix
	 3Y2PWeBJ9NRkQ==
Message-ID: <sashiko-outbox-211538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/4] crash_dump: recover from a machine check in
 copy_oldmem_page()
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Breno Leitao" <leitao@debian.org>, "Chris
 Mason" <mason@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, "David
 Hildenbrand" <david@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-3-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:50:55 +0000
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> A capture kernel reads the memory of the crashed kernel, and that memory
> may well have uncorrectable errors. That is after all what the first
> kernel often died of. Every architecture that maps a page of the old
> kernel and copies it out does so with copy_to_iter(), and a machine
> check in that copy takes the capture kernel down.
>=20
> On x86 a machine check in the kernel is only recovered from if the
> instruction that took it has a machine check safe exception table entry
> or copies from userspace (cf. error_context()). The copy of an old page
> is neither. Its source is kernel memory, whether it goes to the buffer
> of a read() or, since commit 4a22fd20379c ("vmcore: convert
> __read_vmcore to use an iov_iter"), into a kernel page for splice(),
> sendfile() and copy_file_range(). So a read of /proc/vmcore that runs
> into a poisoned page panics the capture kernel, and so do vmcore's own
> reads of the ELF headers and notes. Breno sees the result on a fleet:
> [ ... ]
> Fixes: 4ae362be5093 ("[PATCH] kdump: read previous kernel's memory")
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_pag=
e")
> Fixes: 4a22fd20379c ("vmcore: convert __read_vmcore to use an iov_iter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-work-procf=
s-oldmem-v1-0-ecdcafd99265@kernel.org?part=3D3


