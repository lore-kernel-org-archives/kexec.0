Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF21C25B74
	for <kexec@archiver.kernel.org>; Thu, 16 May 2024 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+ZiIrf+69CyqEmZ0Lwg/1LEVzqCvRz1DuXi7FbiJS28=; b=sOs
	EPZwWfWWQzHuw0IUrKHU0aMKGYH8Wyo3Nfqlb7UbVBWHYB4FmnQ4fzIZPJJuxtaF1PEFIuLaX/VHV
	5XYe46cqL7kF8bZyyA6aVgM3sEcYQcjQD/EztZq70pkEtw9DR24ledMUwWHufEGSD2RyxgYuTsm71
	xMMIUennHeCR8ERvw7vV2WFdStbb1HWl8q/CE7CKEsu33oghsRkK9vl/OXPU7esY9uVmXYfhcl7kN
	49mYopmPiSVW/hjUJOiFLIbZuiBRLb6rIo/voKhXWgPODMHL06RmEUyi8wVqIVRwjhaldPUYEu7cM
	p141/4DywyXUCQGC5KJ+CYParahFZaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7csY-00000005HoI-3M0T;
	Thu, 16 May 2024 15:18:46 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7csV-00000005Hmd-32Ss
	for kexec@lists.infradead.org;
	Thu, 16 May 2024 15:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1715872712; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mU1hJTI1DzvPK88Xs+GpjyMvYVOixVK4JvLbtzgMhLcwMT4EZHJGASLdFcjO03hGWjdEY/9PRCkqHphJQ2wdygKpD89opxUX7zKpCpZJzUD0WOOAk2z48FoXFQIUyj5jn6UoYqeKJQslXnvvRihEB3ihdqpIgvmrg9Lm6FznH1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1715872712; h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=AT7QVvhP5mu6Pto0G9h58yJl7af+VD8O6cvRSs7oabE=; 
	b=ATJ2kkEFbOumpgtlZK2vrX+amRpUcjkevkq71k1QAh1mNUCkZn3YiYe14wtQ6xYDbH9A/YcjnMFsCCtH5fxexOhDpWDyDfjGNotEuWfiWB0D1QdsMkWKOGk4s+tBJaX/KNKDRn2sLuvq2IQExmU56SBR1swMaLtnCrpd1aEYp7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=dlcusa.net;
	spf=pass  smtp.mailfrom=dlc.usa@dlcusa.net;
	dmarc=pass header.from=<dlc.usa@dlcusa.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715872712;
	s=zoho2048; d=dlcusa.net; i=dlc.usa@dlcusa.net;
	h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=AT7QVvhP5mu6Pto0G9h58yJl7af+VD8O6cvRSs7oabE=;
	b=Lc6MUbqQclBc6BklkT+VzaAs+2+pENzxEVbIif1yvwRdVM5eAlbfd9ruYjYwe+fK
	HNW/uYPK4B79iDHihGUsAncgpk8Od475C/ot6Lc1RrwrLjl+PgB8UVBOYFHeSZBjKkm
	YteW7d/7+E4K5+wKo2BpZlX4HMJgngClp6j7Ll8sUgWowrwf6m2KxkE7D1S5Yzr+ig+
	PtAh+135mFdWzj1v5r2RCdYj32bj0ntI7wad2FHsZMBXdG1ooFR/as4zGPJ30C7G8C2
	dV69PUNihchQP+Mg1a8CD7GlwHDzM4sn/J0oit97mkJgVZwjA8Z/PdEmtQlWDe0Xz0D
	hOqr9+xHPA==
Received: by mx.zohomail.com with SMTPS id 1715872711109500.26175413375995;
	Thu, 16 May 2024 08:18:31 -0700 (PDT)
Received: from dlc by able.home with local (Exim 4.94.2)
	(envelope-from <dlc@able.home>)
	id 1s7csH-0003ed-9S; Thu, 16 May 2024 15:18:29 +0000
Date: Thu, 16 May 2024 15:18:29 +0000
From: "David L. Craig" <dlc.usa@dlcusa.net>
To: kexec@lists.infradead.org
Subject: What About the Root Filesystem?
Message-ID: <ZkYjxbfhM+VJP392@able.home>
MIME-Version: 1.0
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.1.0/215.304.49
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_081843_936347_C9CCA863 
X-CRM114-Status: UNSURE (   7.77  )
X-CRM114-Notice: Please train this message.
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
Content-Type: multipart/mixed; boundary="===============5324752462167553843=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============5324752462167553843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eIywF1Kfajxzkc9V"
Content-Disposition: inline


--eIywF1Kfajxzkc9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The kernel kdump doc only points to this mailing list for
further information, so here I am.

I've been experiencing freezing of an AMD FX-9590 8-core
box that has become much more predictable with time.  Are
these disabled CPU-halt states?  I am seeking to get the
box to spill its guts via NMI->fdump processing.  I finally
got AltRq-C to do something different but inscrutable,
causing the light to go on about the inadvisiblilty of
using the same root filesystem for the dumping kernel as
the freezing kernel.  Surely there is discussion of this
somewhere in the past two decades of such capability.
Can someone please point me to it?
--=20
<not cent from sell>
May the LORD God bless you exceedingly abundantly!

Dave_Craig______________________________________________
"So the universe is not quite as you thought it was.
 You'd better rearrange your beliefs, then.
 Because you certainly can't rearrange the universe."
__--from_Nightfall_by_Asimov/Silverberg_________________

--eIywF1Kfajxzkc9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzznPlL889oqhgLrSyTO4LU+DcwwFAmZGI7UACgkQyTO4LU+D
cwxHig/9HHWvuHVIudEORDPd69f+6K1zPpFzL0jXLrhmgGjxPLHJM8cXcb4G/wN0
kph8llqp24AAt7qeVdCnPazMCBvc/RHg8qdU4zb67rtoAh/TLCJ+8o+AgfJwCmje
w7P16t3TYRXbt7Ln8oSRqXUkMx7Fgh9r6aB9KTDe2LQhZyUwHwrLON2Apbf51As5
KHLRjGVKCEgkNmGV4J6jjzM7/QRCjlU95VyWVjrCOytawbnTSZGK80rczTcxFK4e
mKEQXkaUR0f1on1CbfY0PbSysZWgwJIcrEeQ1U+tsKpYgktS7jE2HVGlSd6xBZWM
QFdSJ/31GMy5HYbHYqB0WFm3ooAicPnW2JQldq7kBCqoD+e68jjh6bDmYqvOH6CE
hzokrlK7+sxNFftj5omQuFfsGr2tqZ0+QW/snQTBmGy3mAHcxaWsYPNgGEgOBZ8M
Nd3dyFle/JFUvi8kJoiW+Cb/iJnpV8S0bZXVfsHlij+eGgbBzq+bJSJImVkrpJUu
dsTBz3ZSOS8ZJOT2O/30jufnwvDCNh6rnJ24oEwr8Zo7+2k4Yw//zTkvaQcK3OJm
MbzYB2xnL8gccH2ZopB8V6fr/HLyyKjrJhA50smtZze+mEkybzIFGwRYWhjjJRNk
Zqnp/bv5ZsW6ibKrbJTYujt1+Hp7fWMretVg+xBAUsddmM1/NH0=
=Rxzg
-----END PGP SIGNATURE-----

--eIywF1Kfajxzkc9V--


--===============5324752462167553843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5324752462167553843==--

