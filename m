Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8217C77B7D
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36q8x+FwQFy78PzBCV7wgwRx1p48RZytyIHjtmdMT60=; b=SsPX4F32iZP2dxOdiud9GRAmRj
	ZVKBqxDPcEbu6GTuaSaUET0N4ST7sHgt3i024SHhi6oy1gF3YaiXbojMXoBwFKb66MADraT/xMDsS
	NjEKQQ5y0IQGy9bLlHyAI/9+Qu7l8faLW3SeTvcxtNiiMp3o5MCFahWI6fnn4HZODIGuMgLtE3Os4
	Gxmw0+4JCghKSJau47pqgp6Nj86ih6gDA0Cvzf+KFUPaZp2jdOqQzOCkrOvR90fU3lljnB0PX353c
	gty6kPYIOG/eYLRwfQeh8uSPacDYABm9HzPuPIMxjV6Fk1NtfEiuT9nQhaaoWZ/UI74YqbzBipLH0
	tBWp+O5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwiGo-0064Ij-0a;
	Wed, 10 May 2023 11:46:10 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puqyn-00A2ja-15
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 08:39:54 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so1292774a12.3
        for <kexec@lists.infradead.org>; Fri, 05 May 2023 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275990; x=1685867990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aRZSqqSGHolTlh1jtoDKdcPZUN/607EWF6b0DkrsH0=;
        b=AZK4dSGaMIFsre3ab92ohSTLZERw1D4UVGxEBRjOtKP6UhdmDSBcr8z0sm901npXrG
         mWUooB0uHfaLjnmx7bfX1yx+wRSHgQsx4tLIA4huIQrbAiarI6jvfGE1nfn/xSB0A89l
         t6mKGCVygg6b2/gLC4N6mWNU39w8dUQLO8K6lLO/j9eruFTh/Hmbg6SLuwv+pb6ySicp
         eexkrTwLz8PrhTPSZnAE48CBGL3lK5qeCNmkq0OLRWpZauERfD7pcXFXqLVgeGbx5j67
         3rLwWjyGlmZROMsmlX0gAsAHyAM1A+F83Nn4OTesBSFWvjv2aYpVxpSm78AGf0YEnIta
         b7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275990; x=1685867990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRZSqqSGHolTlh1jtoDKdcPZUN/607EWF6b0DkrsH0=;
        b=D3h+rSSfjw7q6c0jMPEh2qQms9WUD1Q269XCZGK4T1FfZcwT1uc2IaM8j2VlJSIm2o
         iixelrPuVRPgcS7E721smLElzkzC4KPigQ0P58IoaFr1VUdzt5Vkg3X2SFOyxasPP2iz
         6t/RyBjQGof/R4KoolrW6lPlKAr4R2vzaDaXfP7pQdTYJ7V889o5FGa8quGKTsxegdaX
         Wu2kYWnfKOsw2RGZPt5CZ9YzIwgPrS41URt2my1t/xkbv33kO/pz2I/RqwkCCELjn23U
         bIwZvUpOek6Qr8eWMzDNrUGxLBBdSogydpI9iFyFFER7w79fyB5TuJ6lkFLNefzWofVU
         cUEg==
X-Gm-Message-State: AC+VfDxUeHf6Ips5bVHE7HLRIkZw7k/YEOru8SoHskA+nz1uIjOmLbRN
	KcoIFCvqEnG3otS9EnmtxH0=
X-Google-Smtp-Source: ACHHUZ4UH5k0im9tHcDD0dnFM8xRvkntB8xfaghRqc4oSAV95zeDV+5tHiAc0U5MZUzLoIsVrIWOYA==
X-Received: by 2002:a17:90a:e645:b0:247:35f8:81d2 with SMTP id ep5-20020a17090ae64500b0024735f881d2mr699164pjb.29.1683275990015;
        Fri, 05 May 2023 01:39:50 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a0c8d00b00246b1b4a3ffsm12895140pja.0.2023.05.05.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:39:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 9BAC3106281; Fri,  5 May 2023 15:39:46 +0700 (WIB)
Date: Fri, 5 May 2023 15:39:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <ZFTA0kg98XxeP2Hh@debian.me>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_013953_370975_29F98C98 
X-CRM114-Status: GOOD (  11.77  )
X-Mailman-Approved-At: Wed, 10 May 2023 04:46:08 -0700
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
Content-Type: multipart/mixed; boundary="===============0357280798906787794=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============0357280798906787794==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8WmKHbH6zHIoE+UF"
Content-Disposition: inline


--8WmKHbH6zHIoE+UF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 02:50:09PM +0000, Ross Philipson wrote:
> This patchset provides detailed documentation of DRTM, the approach used =
for
> adding the capbility, and relevant API/ABI documentation. In addition to =
the
> documentation the patch set introduces Intel TXT support as the first pla=
tform
> for Linux Secure Launch.

I'd like to apply this series, but on what commit it is based on? I
don't see any branch containing this series version in trenchboot tree
[1].

Thanks.

[1]: https://github.com/TrenchBoot/linux

--=20
An old man doll... just what I always wanted! - Clara

--8WmKHbH6zHIoE+UF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFTA0gAKCRD2uYlJVVFO
o32tAQDw4tpfR8Ba+q25skoHxrAI3+hK4yJ0HkwQNobWGCAvRQD/Yq0tZ28KagpK
QjB72gS5Kql0kR9GkjUSvUZRkt138ws=
=ApTD
-----END PGP SIGNATURE-----

--8WmKHbH6zHIoE+UF--


--===============0357280798906787794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0357280798906787794==--

