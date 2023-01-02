Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11850C4708E
	for <kexec@archiver.kernel.org>; Thu,  5 Jan 2023 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmAsHfkdvrhf/bWxhrbIJ1K1Aqe1sdvwk1/JYosuTGo=; b=tguR5+OEKeVOL2Sx06UDUki1nK
	P6bV53utOJFZ/4AdDJMFZcHiqqb8AXqCCjM2senYSqQQELmhL3ZPWJJJpFrgh630OvhSl2XNAYmuy
	H/A6XsT46uTAMcrfAqXCruQEIpznh6popGrbpihyhEAcCfx3osgrkvyJ5zJe+GmwLTMHlesd2Fw1M
	qCjL8yiVFucFda+HgJDvzMdVx6s3ZmNmdypdJ9cybypCArWPsdRKFXZbBgqJkR9cBw+WGDvee2OrA
	FcYLIed0wTj2f4lUtyFZQNfzKxpOKwp8i+bivI0UhQgJkAqHSyhZbzIywz7KiKb4zObIkQs1BzLcm
	Mfqd1mPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDTvU-00CskD-Ro; Thu, 05 Jan 2023 17:21:12 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCKkg-00BWke-Cq
	for kexec@lists.infradead.org; Mon, 02 Jan 2023 13:21:19 +0000
Received: by mail-pg1-x52c.google.com with SMTP id h192so13492533pgc.7
        for <kexec@lists.infradead.org>; Mon, 02 Jan 2023 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSkWLDZTpnagtlRlVfYNfgcz9t18lpyMm2kr1NP8PFs=;
        b=QZ/xZHVbUbW+EUjQjZSe1C/+Aif6Wa/hyyCwiIGIiJ0IT2DSPokiKWNFFY5Vr0qoUi
         l9TS2twjCl6FsSoLe8W0BsZ+naFrE2g4rget/c+2z+CSuN9OnNUxwP5cp4O95rtenx8j
         nEPfv2k+nqKVlY/JHM9ELKcHGqCNlIute5Y4MPhZUamn2Wd4OQCx6bQi9q4mFoq+wliK
         em4m8WYX6qMs1BG5KlogmCjg+cSFr5JVZ3oRucX++XRU3EWdFs7wGQ1TXo8eMyk2fr4Q
         pFhmwZ0P5QZ6Y+eEmdt9ylXU3jJ8Ozprt5HmVm2RKbn64glFSRXsbQPx1dCCGb7fNKoU
         aoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSkWLDZTpnagtlRlVfYNfgcz9t18lpyMm2kr1NP8PFs=;
        b=I9l5iz7So1/0yFQBZ8hBYELfS2/MtUh4luWkNQF2VtzDtRUGo7pqwIIpxy9ZcE0VVs
         LDzRqgK9yge6To/OZCO5lb90r7WXgvg6Ar2/swW3Dak5fZ5HvcByiz31Y4jo/ugKDdKm
         XB/0Jky7rgU0O4rN145QTJQ9kAY5Q4MhSNkAqy+fDzi6Y3LvSuDc0tFCv91bAkeDhrnr
         Ohs2Fir373Z+u+Flc/McRVLRJZxZMQ7t3cgBLVfd/7b4eWPF+zUvxzN/a4yCfYKAa3kV
         Tn0dEilmbkuwCbVEWX7IBd3UYOidJa9uA5q3eRB3FJAETP8emh3p1+MnIq+UAQkvuYNe
         gAeA==
X-Gm-Message-State: AFqh2kqvPyC7WlAQX/NlXY+Voqv1pRXJOf2ppZbWxWkDccbZC7W8wEcZ
	IvRDNDJiH14X6JA4nMPXqos=
X-Google-Smtp-Source: AMrXdXu7X4w4321RqAMqeENd1IZfT405t/lzS0zBr2+2eQ+BtgL8g0kQ4sN33qtvjKFSHRe7xqbNYw==
X-Received: by 2002:a62:65c3:0:b0:566:900d:6073 with SMTP id z186-20020a6265c3000000b00566900d6073mr38705046pfb.24.1672665675995;
        Mon, 02 Jan 2023 05:21:15 -0800 (PST)
Received: from debian.me (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id g25-20020aa796b9000000b0057627521e82sm6248544pfk.195.2023.01.02.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 05:21:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
	id C61C51017FB; Mon,  2 Jan 2023 20:21:11 +0700 (WIB)
Date: Mon, 2 Jan 2023 20:21:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>
Cc: Ross Zwisler <zwisler@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <Y7LaR1GcoQ8uVsGh@debian.me>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
 <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230102_052118_477101_F6DE9DED 
X-CRM114-Status: GOOD (  15.16  )
X-Mailman-Approved-At: Thu, 05 Jan 2023 02:05:39 -0800
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
Content-Type: multipart/mixed; boundary="===============2445571757724810257=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============2445571757724810257==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Je/2KglVQyb0wHc8"
Content-Disposition: inline


--Je/2KglVQyb0wHc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 08:45:59PM +0100, Ricardo Ribalda wrote:

> +=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +kexec_load_limit_reboot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

You need to match the length of table borders and section underline:

---- >8 ----
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index a3922dffbd474b..a64b340c3ae509 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -469,13 +469,13 @@ This parameter specifies a limit to the number of tim=
es the syscalls
 image. It can only be set with a more restrictive value than the
 current one.
=20
-=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--1 Unlimited calls to kexec. This is the default setting.
-N  Number of calls left.
-=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+-1  Unlimited calls to kexec. This is the default setting.
+N   Number of calls left.
+=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 kexec_load_limit_reboot
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Similar functionality as ``kexec_load_limit_panic``, but for a crash
 image.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Je/2KglVQyb0wHc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7LaQwAKCRD2uYlJVVFO
ox6mAPwJd+dr2pYcjPBSrmh2DO+4fkJEDz4cr9YmilzKXxOD9AEAvEwnvgKAVF+2
eX+sEuilG5QdLjp0nsxuui3Xf/UYkwM=
=LOUf
-----END PGP SIGNATURE-----

--Je/2KglVQyb0wHc8--


--===============2445571757724810257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2445571757724810257==--

