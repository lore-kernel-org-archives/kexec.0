Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A78606A334
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4lsvok0+;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qHP3oCgQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=; b=4lsvok0+knPMVi
	hiHc98l65QpUzIOg++N6NMJ05VlBb6sJMRss4F35Ifc8kVOS5UT9YzUivp+oP5boO1syG5jp9tCjb
	sW9lM+sYMf0JWvJfqyd7QVOongBULRbBiR+x1j1iSLuA+vsp31v9rVCoGPpUJufPUZ1DUl0wQZxLH
	Q38eLRJxb/6Dnu/2CbOooX/0AW/VNUhw+anIf7mO1UaEGTJsO6MHWhWOuUbsTyeq02OPRen15SrUw
	QFzOQa1IpBQvE59sl0vwIxerjWyvQVxZBbofqwd57CVkKG98h3kwKTXtexuuV+vybX9F8IT0qcp9d
	Q3VOV7IPGKTHL1E5cz2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToun-0000000ATCL-48u2;
	Wed, 18 Nov 2026 23:18:09 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTouk-0000000ATB8-2qn8
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 23:18:08 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso90816766b.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 15:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043884; cv=none;
        d=google.com; s=arc-20260327;
        b=IE1MK0QEujDxMPv5OwlwwtL6ORPKcuNEST93wrAraFQ5sQnzojyP7HYU7YaG2XfNyD
         izu6VgFVTpUrPyH/wOIL9KR8McfEsGLnVLZ+mtbhgmblHRmfj7dehtLINMnTBlGV/YNC
         M/m/Ui46SpUxercVHP22jVEw6CvQmeAgkYbbU0oNCs9p5rkJ9yUu8JUQ5TDNLHwbJ9BN
         dSH+B7tIkthxFS2/FjY2hkLdOuDIsEU+6bZMHSE66b78AyiSEHj8Zxbdx1V4lRz8OE+T
         eNVLgQISSfxfGDYHm01rPALS8DSr4TFz59r0XOBa3a3UCeXXdj/nHJs+gYKDDCRMQ42j
         M7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        fh=8Kj42eixH0KsdmyjSGX14cGPxA+m/Z8m7pLr6RiuaTE=;
        b=HTVLzeZ3jeLSuUK5VJxefu2IQRtEEw2G3AGIfnFBfROS+jASdaHyCr8Oc9mSPtdcMD
         iNXD15CL5Hb8VYgSH4K/Ybmpuk4FewnH8Ll7O1iuv7UyYMjQ5FwNCMqQcC4MO6NtHt+/
         91vzuJjBCnv1PTGjoeTjrf8uid1xlXhKm4OipakWv4pGxIBrG+pXz9W88PlpAmLqXeCn
         Kfjn/I2LKj66KXmV/trfv39QZyUyV+WQG1TpPiIwDvp/msqwhzm08dHfuslBATx8Y9SH
         DLcc/gy5JqodS357cv26EnBvdiKvab9ygyS9js8Bt7/+Rp2QyjOoi0W8NAKD9xtroIer
         Hlrw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795043884; x=1795648684; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        b=qHP3oCgQ9YPpmS3JXl1SfdYFudRJrQvWFDzeZgp8nxb7ST7Md4dA4hArnarJls2Lnf
         IxOVGGg7BNI6wQTa4+AZpGhqL1IMrKZLtO6+45Q/GeqWykGLJNu4sWppcWRckgNxmQWf
         K1p414chxjiK7QI6jCNR3cDmW6KULcO3cwQDmtDatplF+33dU0j1HfEzN3IW97atscnU
         ntjSX36uw5HRdnBGSGE3YQ2kG7b20b4MWLN3yF8m9rpRk9iJVUkyWcDjWSX4KXcwyWlV
         jMOj84cx5rPEAbk0VXByI0+mawBSbatE80fPgEI7eZU/f1batfcahf2NijOeFWTnLspR
         E9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043884; x=1795648684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPC1RAeyqbYuGOqMmGUi58uvgG+tJSEuOdphvL+a1Uw=;
        b=0t+oznYJMDTDjtVJdJXYGqj1mYwOdQZgoNuANa5NieZdUqDdyUGIq5ydR/XITQM85y
         bYYg8xTdxRHGyN067BM4qGm+RrNOOMaUzpLbbks+Pegrea53nx0eDMeZoJP7oFxjdEWc
         xT2u3FcFmLRS4Q7qhXP06NiLdB4r57dG60FbrFwEEq6xNT2TwBy7iZ90rJJQYhU9CrCs
         MXY/YdINvkqnK5OT6qizOyxY9uYHNkW8Z7s11rI7Mgk1tK+7Ic+QwQOy33KAzM/srRBT
         wVBBA5mZ7VrRe/ASRBBRplw4GUQojm4O54Act2MZmTbPYdca7Bj1LSQXPh9k8R+LqVwl
         jvMA==
X-Forwarded-Encrypted: i=1; AL+hErEwKLzfblEG5hR91RB3JibckZtvP4EOh/kzEkNLtiil3+CSlth6gz6TF1ABuDsgCJZn8uTpcA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/EefhcuGkCQFCmMOBbjGMavFDwn01bxM4Nl4K8mgT6MrFFaREI
	/ZgND0F5WgW3ZxxbKEva3MFuruZfzzQ05nOPGt2twgDqiVSOWO28p0aI2nPnAfw3/u1JbjBwD4t
	HXViVEXA/1Ov18BkcFeP68faZXgWqsQgsTGOgO9lF
X-Gm-Gg: AYBFou2HeTfFCMz/v1Xt2IKB3kyqbvE7TjH8t7Jf5m61Rv2kaWx0itaYtED0XFg4Wei
	M+WmJq4t5pGkPYxk1hs+CJlsKsUFN8g4/KhNtvoyIMHwTZ0+M+XGtsw7BjNUU+PwcQOwqQ/EUH0
	p203i5WCFqzMdPP/47b1pRfMaBygvFPOlBKJkyYaCaF6G4xFWgOdwM0eaJ9w0dtrRk4f9L117J7
	K72zIoOHSCJGGDXRfsZdTxJrW4Oa3QZrryZk/0nc5mD5cj1zu+LovRTtPYusDyxrto+CwDt4Eue
	se+9Uc5J6uk+Evqnc73mYinEfIxPhxdA5loSEk3dDrzaDeE0aQfr+H+dDY6CRLS0vb+O62rpwLQ
	9XT/sW+jvzL+LzSXHCslZPn/tSSsakXANfaN2GA==
X-Received: by 2002:a17:906:f58f:b0:c51:2e3:f426 with SMTP id
 a640c23a62f3a-c512b79e2demr9058066b.18.1795043883126; Wed, 18 Nov 2026
 15:18:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com> <autxCZPJ9yiE2ucq@google.com>
 <aut0H65XKAHUqPR9@google.com> <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
In-Reply-To: <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 18 Nov 2026 15:17:35 -0800
X-Gm-Features: AclHuK_BmYZZLmsTICieOxQ9QtDw0U6EdYtEs__fOCufTHy2p7TcHAXRToh2pGA
Message-ID: <CALzav=cj3GuYU3wmW5GPSy8Rp+4xYjm3vonDBdi8TTyWSgxPCw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_151806_758842_5D94B161 
X-CRM114-Status: GOOD (  27.86  )
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

On Mon, Nov 16, 2026 at 8:45=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Nov 4, 2026 at 10:06=E2=80=AFAM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> > > On 10-13 16:25, David Matlack wrote:
> > > > v10:
> > > >  - Save and restore the ACS Egress Control Vector along with the AC=
S
> > > >    Control register, sizing the save buffer from the HwInit Egress
> > > >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> > > >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> > > >    rather than adding the dependency later in the series (Pratyush,
> > > >    Mike)
> > > >  - Reword kernel-doc comments to read better in the HTML docs and
> > > >    spell out "reference count" (Mike)
> > > >  - Replace the version number at the start of struct pci_ser with
> > > >    required_flags and optional_flags, and record the size of struct
> > > >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> > >
> > > Hi Bjorn,
> > >
> > > I am planning to target this series for the 7.5 merge window through =
the
> > > liveupdate tree, as we previously agreed. However, there are still 6
> > > patches that lack an Acked-by from you. I believe you might have
> > > reviewed some of them before, but the tags were lost during subsequen=
t
> > > refactoring. Could you please take another look at the following to m=
ake
> > > sure everything is in order for us to merge the series:
> > >
> > > PCI: liveupdate: Set up FLB handler for the PCI core
> > > PCI: liveupdate: Track incoming preserved PCI devices
> > > PCI: liveupdate: Document driver binding responsibilities
> > > PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> > > PCI: Save and restore the ACS Control register and Egress Control Vec=
tor
> > > PCI: liveupdate: Adopt ACS controls in incoming preserved devices
> >
> > Thanks Pasha. One more for Bjorn's list:
> >
> >   [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dm=
atlack@google.com/
> >
> > Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
> > (albeit based on his feedback).
> >
> > Alex, could you also take a look at the two ACS patches? 08 includes th=
e
> > Egress Control Vector save/restore you asked for in v9.
> >
> >   [08/13] PCI: Save and restore the ACS Control register and Egress Con=
trol Vector
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dm=
atlack@google.com/
> >   [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved dev=
ices
> >           https://lore.kernel.org/linux-pci/20261013162529.1928093-10-d=
matlack@google.com/
>
> Bjorn and Alex, these 2 patches still need your R-b or A-b tags, and
> then this series will be all ready for 7.5.

Thanks for the reviews on v10, Alex. I've pushed v11 addressing your
feedback. Patch 09 on v11 is now the last commit that needs a tag.

  https://lore.kernel.org/linux-pci/20261118223704.3286085-10-dmatlack@goog=
le.com/

