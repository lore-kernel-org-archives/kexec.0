Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6C606A33F
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lrB84jTO;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WpEplBVu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=; b=lrB84jTOLzjjm3
	nhnCF9ekkFjxv5Mb1LVlmD4TcFKW4YBMNbANZz1bVcP/+yAD5lql1Gsb+Q0nDCCPS1+3CoZD55yoy
	EwGjnJl8EqqaovYtXaGBlxnPaZibv4aQ7oRqI5qd7hqluKGo/rMtG73cVV+B4EYFwCPVpY6QZUGM+
	zzTbarwVgdvvX4UckcrrxpT76QhR6uatW+bMFOKsVW3Q1onUVbpRQsUuHjBDkA92znjawzvrmKx18
	dA1fYX2nXoO6uewso/JfmgfQHqH/Wj2AaEhsd8K3zN0nfPHiZd+gtQDIl54KQdonhWmBmr7hChG7u
	X+KqL2WB5Lt+AXHPHvHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP877-0000000Awaa-2MRU;
	Fri, 06 Nov 2026 00:47:29 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP875-0000000Awa7-1Jsd
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:47:28 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c4550d8ab15so12259566b.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926045; cv=none;
        d=google.com; s=arc-20260327;
        b=TgnVTeakV0UtRs0nFuQvFYo3vOoCsfBKqKpNVoufVWgetbKiWZt0dVCwmKiZaXKtEm
         Bzj3wIJ+NM2T6fdufPtvtbXFkW77i8rBPmaMvIWXf4NbammRM9VRlxuz0ioCZ/lalgz1
         xXoJDy41kQ1l7713BHkXX5hrvD8VyTBO9bA5I8C/6Qe3lYFTgWrpEyErQi6+5CP350mK
         UfqUlacBqMb+XH8fSAOo8LNHX77k6/Kfe+lrn8+jFmBn6/JpeIP9uEVZn7RD6Rdf+7CN
         xwiDSrpEss1SNacvpGayHZa3oefIVBtMwQk9LhKRrOnoLaRKORqe9YZyjd5Drz0ss5AX
         SMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        fh=jAeegDHH2Y/plIB50mNA8JUFMbxUlL6MbxIBK9hSRnQ=;
        b=LuEz9qCbg+WVgzmnvwitUZY2otYCeVJyk+00r+2SiEUYn2UDyb/6sVBmiG7MFPxHwD
         ssDjvwv0Mxt7koXsGtnP1KEMZ8avHOE3C2yWuYrZYBTXRDWP/scFiX80LaFdt9Rmzi28
         YkvBi3wEmVHLrkDGgzOZ7QIfPbLwDavljCY0EynhmKKNYxNFSOyS2AoXdERVYv2Bp4HZ
         nwD3c9ySLUSy/dRQff90uI6WzzUk0/z+DhZR4jrKhdkkGdOzPCJAC7sADrU8LUfMjXPY
         s3+Ah4Q9vR57gdPRbaynUHFjNECxVY25EXO0p4bwYOQW9eAgyWA3imtjv07X9GlnXve4
         hdDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926045; x=1794530845; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=WpEplBVuVKW0R3knYmsewK6dMzkLoO5lJu5kjIKYBhT7hjihzY8+E040gUruuT5LeY
         b1Z2SfDMnVKkx3hI2z4rvpvnZWvm/LvCSUuLs3lcRVyzk0nAy+mx1grv4yFTLshy3YBT
         HCvAVthlrmKVHEWCorInXFLffPjuait4UsEDNsXeGx2xuWWbdKaj6qf72EZwmcNCQYRO
         2HRCyeuB3leyN8iKJ9K4dRzz2GtwLV1F/CDBm0dQJVxmqaITKXcnOz5JrTz0QXCLIqui
         qDWPn9+H1xyuq0LhO/W6JpPqmIFu4lzwxoYs9GuIiDYYt0LPrADCF4yz+XtVeWuVHltV
         w3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926045; x=1794530845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=A7YtDilRPq//4jLgn2e20J6qJLf1hNrdGlNR5HeBCcdi06scPCFJHPGLiDcC7rZWTs
         hmvBoQQVcgy/fTc8L8XKd636Fd7vSuU6iI5cF/+QQviroSgrI0oFtNoIzYlGNvHG1/Yd
         HrPzUbmNYqcRVr2zUhjWxf9zIDbKY2t236V5/pUJzYjKfNTnIBRV05jRxUfYGXfm3Ynr
         kCyJiAriv1MuBjw1pjWq7yr1jvs6uNSOWdIVzGSxo/qI2us3oXbgtApfjUKsYIIp06Lt
         OkM5aBn2mBID1X+S3l8H5UuNUHrmcCPIZJuZg8vFvfdOqPTeVi6V+48+yoP0AhzymZUX
         rWWA==
X-Gm-Message-State: APuU4Z98mo2B69et8J5oc/KZncJx5euUSGO2z33Kx/v2j6YXgzXh55pZ
	TK8j90mAma37OmABHK55lmfs5ytdtF8dKPh4ywo/OOS4bsPyYMEhirQ9vryN6clCF28ltMNKIHL
	A6r1k0+Qbu0bmTnIkgU3s+NyvJwHvz/JwBXl7ppMNB3/7ZkjvJfzpVmWB/SQ=
X-Gm-Gg: AYBFou3Zf1l3YUF+1KNypk4QU2nU6kW64JM5XLPLkPxIPwb5s2ATEHOeZx4ntsCRXcR
	uBBsCp54UmBe3toGxr1mC3s82h8HVhTjcAeZcnvcsWGMoujuzRG37XBNvl/u5VWCBBQK8g334hy
	b1LtSIryrZTZV5WvA2fhNAEuAc1jwr1ojdmzy5xlU1ZGh0W+yTjSpztsr6+XKjVqTWx7Xsz7I2h
	bXJQL5UYDGEiLD96wtlNsTxTb/pHhzos7I9vMfbihMvvjGmppl4kJycsglAYShXpFzfDw4PB0dl
	GeKH9fPD+/fJyBFozPx3PBeCPBjbrgPbuJHKexBrw9gzHI4agkHwCW2vKomN7M6hH03Z59VJuNP
	p3ez5nSof6iVWe22JSgLPE5+Asxol6Bjgo6ZZpw==
X-Received: by 2002:a17:907:8687:b0:c48:a838:c16d with SMTP id
 a640c23a62f3a-c4d34c333bdmr88685166b.30.1793926044754; Thu, 05 Nov 2026
 16:47:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Nov 2026 16:46:58 -0800
X-Gm-Features: AclHuK-6t-LHK5FESHi0261vrVlL_qd-J_ZV2n6hQwmFkPQFVA0JTaSgUA12BTs
Message-ID: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_164727_373980_C7D9B2E8 
X-CRM114-Status: GOOD (  11.04  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:

> Merge Plan
> ----------
>
> This series applies on top of v10 of the PCI core support for Live
> Update series [2], which is targeting Linux 7.5. This series is
> targeting Linux 7.5 as well.
>
> Both series will be merged through liveupdate.git, matching the
> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Apologies, an update I made here got lost. The PCI core support for
Live Update is targeting 7.5, via liveupdate.git. _This_ series should
probably target 7.6. I doubt we can get reviews in time for 7.5. And
as for which tree, I am not sure. This series is mostly PCI core
changes, so I lean towards merging through the PCI tree. Only the last
commit touches drivers/pci/liveupdate.c.

