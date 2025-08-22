Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F46CA0EE4
	for <kexec@archiver.kernel.org>; Sat, 23 Aug 2025 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PITLW052mM/0cTmEK1pA04kvx4snzr0G0rUt4eAAeA=; b=S4XDbdSX+Cpenoon5XXnQ/pmil
	ZrEhBHyfs7WbajOJ2WEoKudc/Ld/fkGnm/G88QHvz7PPZmIlymDp2Z/71ehirdciErE67ARslsE98
	nQefFdKHa3WYCfL5pWMvyL/pReWecM/4NVoCta3mOecdRZeusr7ySXoRTunF8bLgA7//NfJmvBnzA
	hYEvIqZGT/jtS3VHZ0TRAH6qqmARgGOIOwxJtBMHhs9niocQL3Isq/UL7ErLkGZ6XiSZUPbHFyJuH
	Cu3IEMmLiEEySOPQW2KDk+Lr+7JLUJiOsXsuntn9VxowIDlUV/bp9TvUYSV+OajzHhFIqMijNh4ce
	WrTXEIdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upkdr-00000004SEg-0tif;
	Sat, 23 Aug 2025 09:34:31 +0000
Received: from mout-p-201.mailbox.org ([2001:67c:2050:0:465::201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRlx-00000002cOq-3rvi
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 13:25:39 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c7gsy4jskz9tWT;
	Fri, 22 Aug 2025 15:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755869126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PITLW052mM/0cTmEK1pA04kvx4snzr0G0rUt4eAAeA=;
	b=I3zETg6dE36v3QvGTZ3phKvzINWZlRKxEzPAs7CFP1An8HwSYV2kTCd8itbvhNqikX7vEk
	3KtKU9dg7Uf9E4qUJN14JMgWtxAdZfccmQzvbnO3DTXFKaFAlCkAG9qg1u9kdLmIXjkJ28
	tSz/v97+0NM5GNQldHJwrCVCj70wqkbXzDcHxfAq767C9uPAznFr0uiSjU2dGAZPAtfZBC
	bKyjtANVWfFvJzM/Nc+5IwK8gpHBlYC4H0/XxLePVeIF+JOvaOZ+FlIYF8i18KE8xDVziT
	OEyAs7UzBoXMSajx60azDdDu2qU83QWM/iAaxLIVVgLrKdjWsFsUu3ChEJEBeA==
Date: Fri, 22 Aug 2025 23:25:11 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Rob Landley <rob@landley.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Lichen Liu <lichliu@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, weilongchen@huawei.com, 
	linux-api@vger.kernel.org, zohar@linux.ibm.com, stefanb@linux.ibm.com, 
	initramfs@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Message-ID: <2025-08-22-witty-worthy-wink-sitcom-T5L8wA@cyphar.com>
References: <20250815121459.3391223-1-lichliu@redhat.com>
 <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
 <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rvitifl7wogvg7j"
Content-Disposition: inline
In-Reply-To: <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_062538_107969_3B2387C2 
X-CRM114-Status: GOOD (  13.95  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--6rvitifl7wogvg7j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
MIME-Version: 1.0

On 2025-08-21, Rob Landley <rob@landley.net> wrote:
> P.S. It's a pity lkml.iu.edu and spinics.net are both down right now, but
> after vger.kernel.org deleted all reference to them I can't say I'm
> surprised. Neither lkml.org nor lore.kernel.org have an obvious threaded
> interface allowing you to find stuff without a keyword search, and

I'm not sure what issue you're gesturing to exactly, but if you have the
Message-ID you can link to it directly with
<https://lore.kernel.org/lkml/$MESSAGE_ID>. For instance, this email
will be available at
<https://lore.kernel.org/lkml/2025-08-22-witty-worthy-wink-sitcom-T5L8wA@cy=
phar.com>.

To be honest, I much prefer that to lkml.org's completely opaque
mappings based on arrival order and date (and in my experience it seems
to miss messages). The same goes for lkml.iu.edu, spinics and gmane.

One of the biggest losses when gmane disappeared was that all of the
URLs that referenced it were rendered unusable because the mapping from
their numbering to Message-IDs was not maintained. If lkml.org goes down
10 years from now, every reference to it will also be unusable, but
lore.kernel.org addresses will still be usable even if it goes down (you
can even search your local archives for the mails).

(It would be nice if more people spent a bit of time configuring their
Message-ID generation to be more friendly for this usecase -- mutt
changed their default Message-ID generation to be completely random
characters a few years ago, which made Message-IDs less recognisable
until folks adjusted their configs. Gmail is even worse, obviously.)

Also, lore.kernel.org has threading on the main page and on individual
thread pages? Maybe I don't understand what you're referring to?

> lore.kernel.org somehow manages not to list "linux-kernel" in its top lev=
el
> list of "inboxes" at all. The wagons are circled pretty tightly...

No it's definitely there, it's just labeled as "lkml" (they're sorted by
latest message timestamp so LKML will usually be near the top).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--6rvitifl7wogvg7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKhvtxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+QSwD7BO+PtnsXEDae0r97BHM6
PkIHOEXbXJqq1URgT+54x98A+wSeZX6FvxMSF0Ghiw07nuOnRO3d0pW2Lpww9iVW
T0UE
=YHVJ
-----END PGP SIGNATURE-----

--6rvitifl7wogvg7j--

