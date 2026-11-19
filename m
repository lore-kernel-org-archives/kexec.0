Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE8606A31C
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RiRbI/H4;
	dkim=pass (2048-bit key) header.d=multikernel-io.20260707.gappssmtp.com header.i=@multikernel-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pzeNjKFM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zFbr6eHg9xAfwCJ+yPPFuSKuvOw6SPSCEC37J1T1mfY=; b=RiRbI/H4j53tcw
	9mJ6Bttbu/m8GJLaWm5IxXShF5vrj0BY6DyD4I+y2VvJgEyVd4TTqmttjHSjkLOLWmDXXWv4PWdE4
	3CQ7Y0KAYBMHdZGjXB1v7vcFgjh5P5FtMmfg7xTZxNbYW32stYX465Y2EXH+N2MdU+uigcp4afYry
	xmx+K7lCMTKOu1oxCamrzThi55yZPmHxnrHfv5uB45QfwhiK6XaeYWU+xyjn2PDP3VNa0WqBCH8ih
	OKsm1NaDdQvucr7rzt4/JEiBCNV6tOf/bdSXvFV9TLdVV67P6Gq/jyFePsvp5YimEHDH8nI7WwOWd
	fA1vQsr1cE8Vj0MVAInw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTqgu-0000000Ac8d-2IJC;
	Thu, 19 Nov 2026 01:11:56 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTqgr-0000000Ac81-2qym
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 01:11:54 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso2221267a12.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 17:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795050711; cv=none;
        d=google.com; s=arc-20260327;
        b=oUnrkoZkVQs8sYWu4CSKi11EJvwHGFeM06WrIG5UeOtkoz1hxFEP1FE6YkuIrr/Vli
         ecdrRgYy60X/F2pUwphB4+fKbJRiUbNMcd1N47lAqcdTD2mS3mPKg27KkKHTp/kLYzUL
         1G9vIefHCz7UgtvUaxJSL2K65CiN98kMD74XsI/mXcIuB4AnPAhQdlapJadBJ/n2Cf1U
         27qgf+X06yq3JnrTUvXu/NlRe6uBQ86XNevV/e6wsIizwyRJDbno+yKDa79ibDzZwWFP
         GtwFlWYIA8knkNkmQEAYRijA8rzm+OY4yUg2eQqpk6XjayCcZC6z90PFWvsbzDLQjT66
         sOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFbr6eHg9xAfwCJ+yPPFuSKuvOw6SPSCEC37J1T1mfY=;
        fh=zD92llNbuFJf5M+bEq05G4pR4/b/QspayXK1pZLebcc=;
        b=szc9xYaEe5ccqtcTYcwD5Y7jLflMDW2VPNB96by4DRyl/Xocds5X4Q0hizpy2t3rVT
         957g47hiP9g/8POB9nDFtj3uzoW1SSYJwj435oQTbwHW47iNJmzD+i9Q63yMfyCIgq4c
         8pICmly7RUX+F+RVL6kLvrkp1sNrYbR2gFtL8sZ3D8WayQw/P8o+grheiGP8GdGHyziI
         SC4l5vDW0kPZPChHNC2OCIA3Nf54YXaGiScPhGHUnPLFmTMsP7zMwGieJ8ug7awx7vai
         uVUqFDhyzJvrUMmAYFbEwyjbIosXW197ZG9QaJDZgWjE3xR8CoLWY3OXY/uCTutd95gb
         ROzA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20260707.gappssmtp.com; s=20260707; t=1795050711; x=1795655511; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFbr6eHg9xAfwCJ+yPPFuSKuvOw6SPSCEC37J1T1mfY=;
        b=pzeNjKFM6U2pU1I++iMvwEq3aG90EGBp2wY4VeixBT0mCaLnzK6FAWeX3jmHocycT3
         OYi+lmJ8kHsmEAYeN/XcqU3Sq/e8LjaLIf7Lb6lE33FHqsT7U4vsnRuHMLXC+7N1cmPp
         hJ3dIgIcUZe/JegnzIB8KWsD0KrIbQqr+KGiAM7J9VGU36hxSS1S2td8bJNE+R/P6OSk
         xwnAFHFUaduk+4GDajBbAG/ps2SmIbn8R33qkD1Ijgs1uMNd1qhqIktiYRXzhWwHb6c6
         68NETkPsRtbwKksu5dCsE7uYFuXl6leLqTTISqm96Q6DrVTeRlMOmQvwfQ960bf+3ZaF
         qPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050711; x=1795655511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFbr6eHg9xAfwCJ+yPPFuSKuvOw6SPSCEC37J1T1mfY=;
        b=Ivj3Clmoz4HxlJmLDYp1L9wOXNTj5ujTZ0uKigp5PvnkW4GG0i7E9BppLx8ZHUnlgj
         1gePIJjH4Kv5mspxHWmBgXZOOWi7GGAB+90su4KYDnXS8TFHjM7MUXcKXFobHnhEW46q
         OhGHFti3eSRXeL97cRZ19TVqWA2YoRdUWOxAy8HouWWynvom0idE6hKT31yZD9DCVTmq
         Q2AVtV/dRra1/vTlOwuTRii8Oc2DuU0SApTvBmJNBLOfk06EnjxeOcLNyClqatmX5sc+
         8iEwe3Rj5tRo14WRH/1vc5cpd2F7RZWsmNixsRJwDHKG6znOBwMYuNDv6GIwzpmDgBzD
         c5zw==
X-Forwarded-Encrypted: i=1; AL+hErHYvIR9U8HES/XO0dey88SaVFfFCZ2Kk+HVmuhdWoHp+J1S+3lfRNOXTo5I/WgHYENGTtXu8w==@lists.infradead.org
X-Gm-Message-State: APuU4Z9p/0yhHPzi/aHHpZzF8ylra/9tDt0SKicYiw386/qh1bXp2nts
	YhjOle9Hdav3VDsA+9VIUED/xYMqFFOEN0zx/b2aTeB8rlSi0M7v53jmQQ5AuuZBqDeSR6S9/+o
	txH5NwxsgIZ60rEBAQ34ML8okwqy74TkEaARbd5HIkg==
X-Gm-Gg: AYBFou0JfHxgdlMeunRQApqmByxYcYulov3uAC24YzuAkFTkRaQXbnffp6DIXBKIh8i
	yB5aYW99jNUq4aslPyisIjPiMuBc3hxz6JIi+LpPuCCkzogdoe+jpvY6kuILqOWUGYYXSvIW1B0
	uPJMNdk6y9f03CoNW9jeUOzrkbXvnFBuPF6R90ETP77mI8uoAwtdhJxZ665VkJaH0OhjgSoH4eg
	UVPQML0fMkwceye39HSp/zs+nkdRRcOiDxV3EMtMHDBkP/ZlsU3ZFI9T5ed5KbOmeC5WkumarmT
	s5rPSTcEE8NQ57ZV9kxvPMIrwD35bXshSP3YQQSZE9oxbRD1OQCYAJwW6fBQgIpSol/SFaazcjT
	xfNggOXsYJ8+H2dXcVB63cleL46fmi1JxaY8nsyJpiOj7ohEnPzWEuCg7OnFdCIOENwCcwuRmIi
	sxguPxyUCVIqr540DTOfH5DkbnYg==
X-Received: by 2002:a05:6402:1d4c:b0:6b9:c43e:19df with SMTP id
 4fb4d7f45d1cf-6b9c43e2326mr963366a12.41.1795050710871; Wed, 18 Nov 2026
 17:11:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118013729.576325-1-xiyou.wangcong@gmail.com> <av3Q8pAVt6nb-RBc@kernel.org>
In-Reply-To: <av3Q8pAVt6nb-RBc@kernel.org>
From: Cong Wang <cwang@multikernel.io>
Date: Wed, 18 Nov 2026 17:11:38 -0800
X-Gm-Features: AclHuK87b_shKwat8_ZEwNyuTNtkbEeG4EoWTL7eT71aa9I3nE0EPfXoTHuPeag
Message-ID: <CAGHCLaTb1HhPXMqakdErKhrCTWcQ0arqKDbo++vp5jOkmjQ93w@mail.gmail.com>
Subject: Re: [PATCH] riscv: kexec_file: Verify the signature of Image files
To: Mike Rapoport <rppt@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_171153_820010_E624F0FE 
X-CRM114-Status: UNSURE (   7.52  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 8:23=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hmm, looks like we already have plenty of those. I believe before enablin=
g
> those on riscv we need something like this:

Yes, that is a good cleanup. I am happy to rebase my patch on top
of yours.

Regards,
Cong

