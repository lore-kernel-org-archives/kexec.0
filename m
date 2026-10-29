Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF998606A31E
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2bUV4YL4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLuf2ql1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9ctWfCaikZBDGwBDGZ92QONpbazh9MI/L9SBN/1BcH0=; b=2bUV4YL4w39yLEHq8lMuaP6qEC
	ZJzvxbo5TKWwF/CmLgiYaMULrAB2/XYZscxSoXrTmY8QX9Jk2yqKiRLkq8sy+pfnKfd4uvhJQW7xz
	V5KvRQVPge0I9uFxNNoNxhQhj99iKdow8LzAquZrevPXneFraKeuQHtF8HkP7YHNfLWnjcsnDQcOm
	10ZJnmaxZqhoICjGTT14WcMoYthMS1fDIhTDF3TiiRZmee95V7YDO0hgf/EGvbu4lFsPThX9m6ND5
	uYGkavS1cYa/tV66VU2EapodHSddy8X9aIntbkh0WaTsSpKWcXe2s3llbkWvwvqEHJ8/hGzrtDlNh
	qloD4enA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMELF-000000087HM-3Hvm;
	Thu, 29 Oct 2026 00:50:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMELE-000000087HC-29eD
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:50:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39C5E6022B;
	Thu, 29 Oct 2026 00:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D01F031E5;
	Thu, 29 Oct 2026 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235003;
	bh=9ctWfCaikZBDGwBDGZ92QONpbazh9MI/L9SBN/1BcH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLuf2ql1SXVYJMRtj8ZG8+jRqsezkB8gsszBJAgKL2XwG5cR6pi7Lso2HmRr0EC0B
	 QWIcOdBgbXKrO8LhmXYnOExLTGgG7XejY8HVD+56S2+XFXYPIKxz5EgJKkAMLKUiA3
	 tYkv88wAmMt3tbS9U1qLSZJ1soralOR0VFSPIwAhHIbu9mZ370PFygDuI+ffCeJFX/
	 XOFbSr3IJ7s1xi46/FHDUjCTnY57/eVqwH8UnlWa2fudq0As9BuR3IqAxV+G5jUR9v
	 eUQjmHZWY6ucmwyRNm6K+YjoEt5dzNB4tOuyz6BifVxwlnciP+xHsl2607nHTx10Mz
	 Ky9kQK2xDVPmg==
Message-ID: <sashiko-outbox-188577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] keys: add KEY_SPEC_IPE_KEYRING
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-2-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-2-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:50:01 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] keys: KEY_SPEC_IPE_KEYRING uses -12 assuming nonexistent keyring=
 IDs
--

commit 44da1efd13cdd5eb92238870e4d4626fe42f170e
Author: Manuel Huber <manuelh@nvidia.com>

keys: add KEY_SPEC_IPE_KEYRING

This commit adds the KEY_SPEC_IPE_KEYRING (-12) special key ID so that
userspace can directly reference the .ipe keyring via lookup_user_key()
without resolving it through process keyrings or /proc/keys.

>     keys: add KEY_SPEC_IPE_KEYRING
>    =20
>     The BPF, dm-verity, and fs-verity keyrings have well-known IDs which
>     allow userspace to directly address them. This commit follows the same
>     pattern for the .ipe keyring.
>    =20
>     This provides a direct interface independent of resolving %:.ipe thro=
ugh
>     process keyrings and /proc/keys.
>    =20
>     Signed-off-by: Manuel Huber <manuelh@nvidia.com>
>=20
> diff --git a/Documentation/security/keys/core.rst b/Documentation/securit=
y/keys/core.rst
> index 326b8a9738289..64b37817a3356 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -373,6 +373,18 @@ process making the call::
>  	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
>  						  authorisation key
> =20
> +There are also values that refer to a specific kernel keyring rather tha=
n to
> +anything belonging to the caller.  These well-known IDs allow userspace =
to
> +name kernel keyrings directly even when they are not linked into a proce=
ss
> +keyring::
> +
> +	CONSTANT			VALUE	KEY REFERENCED
> +	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +	KEY_SPEC_IPE_KEYRING		-12	the ".ipe" keyring
> +
> +The availability of a subsystem keyring depends on its kernel configurat=
ion.
> +Looking up an unavailable keyring returns ``ENOKEY``.
> +
> =20
>  The main syscalls are:
> =20

[ ... ]

> diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> index 4c8884eea8084..e42fca286b156 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -24,6 +24,7 @@
>  #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring =
*/
>  #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key =
auth key */
>  #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest=
 keyring */
> +#define KEY_SPEC_IPE_KEYRING		-12	/* - key ID for the .ipe keyring */

[Severity: Medium]
The commit message states that the BPF, dm-verity, and fs-verity keyrings
have well-known IDs, and defines KEY_SPEC_IPE_KEYRING as -12 immediately
after KEY_SPEC_REQUESTOR_KEYRING (-8) in include/uapi/linux/keyctl.h.

However, in the kernel tree, none of the BPF, dm-verity, or fs-verity
keyrings have KEY_SPEC_* IDs in include/uapi/linux/keyctl.h,
Documentation/security/keys/core.rst, or lookup_user_key() in
security/keys/process_keys.c.

This leaves an unexplained gap (-9 through -11) in the UAPI numbering and
makes KEY_SPEC_IPE_KEYRING (-12) the sole entry in the kernel keyring table
in Documentation/security/keys/core.rst.

Was this patch based on an unmerged series that assigned -9, -10, and -11 to
those keyrings, and should the numbering and commit description be adjusted
to match the current tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D2

