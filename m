Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B46606A32A
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kd5T6AaG;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NdhLc77M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=; b=Kd5T6AaGnp3b4O
	ymZGqUTV3rqfksDwl0p3gQJnI52EX/MLCOlA6w+MPgndb8Sy4tUSFfzI0lKLVSHdlyupvzTRv4GDx
	g1GFqHM7Kj6rggBTWQHfBI13RxNedie1IEq6cPk4jaOYnbiJci4UsBcRyIoWq4Y3NpvXMPO6C9+6T
	2L6K05rvAZlhr5e3X5tAY1oP7nvhR9ETM5LoGFTlgX6BdOd+dIfd1hZbZaDpQnkgJyClt89NWwCxS
	6MjHOU3QEY1n8C92vZKgNVizFe4RZk+BxcW6qfTOzJU+dFy8Sebei2yjknS2qayLH/vRvBq7EiI86
	hep1z8II9e1cYTjkOgdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzqZ-00000003Jfi-099O;
	Mon, 16 Nov 2026 16:46:23 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzqN-00000003JWk-0dQ5
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 16:46:18 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c4322d310e7so677217766b.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 08:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794847564; cv=none;
        d=google.com; s=arc-20260327;
        b=CjUVcSu7t/3i4UlaiwCdSRny38mvauX/HwlXK88L2RXU2gW7VhI/iyeYorRJHBEByG
         nuGaZdz/waWlEpOHIsEleeGzp73XTUiM+wGinWGRI1w9SWYajU7vsoaFk+ofYCJoBD88
         +gadH9v8jDEGEK7dH8g9mHEDI89zhjgMavSvsXbQpH4RKnmv2pMm4HBer2ELUya8hISL
         bVN01mFWMhv5wRBiNnDp9NqlbVe5H6xXmVsgTP2Xt8+P85mMeiYPYb3GuLfZv8XvuxHu
         GrGNB2z4YsBNFeYwqhrCtWD0EBALSdcFLDvZBrR8x5JkciwUWCBZJn5KIiuGdCn2c5U/
         EJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        fh=KbMNeGTAT/oBzDW2Z86u+sqDi+zm0PNJ/lHtQTbnsnQ=;
        b=qkYf0t5kd/016LgEzTxj7Q9y2nIk9zXX59nA/C5XwzVtkjL2wvr7bP4gIBSKMZZaYV
         WaRxPzjAkkfD9+NniWLs2BcGH9zSs20pxYbvNxcAGBWmoGwDU3/VKTZPkZIRFw+QOP+m
         I4aD1nWWGDO/f2rFiDGXsDWakV3RvUzrcKcrobxIk88KY7ATkBAkKwht7kjXd2JD5mnw
         d8OVhVrzTJxBTaQhsOzETYNrS66KG7m09Lpzl4r03c7Tf4sJlC9h5et/pG77pUr3F6Ky
         cu6GJ5HqpW8MCpg879oD9LvhK0SEaVYgQaH0CtrLitlUZMMiwdumvVYvvfcuq1G0oG/S
         jnNQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794847564; x=1795452364; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        b=NdhLc77M76v0npqvLA4In1EN75Oz3mYF9Rfl3KZVx1/HYBFcnLu8vPFwUMURL8YMOM
         h00BXQu0rtHEYet6v0YI2xzKvr03pWZXOb+ZT6oFaCIjChH3f/0+fBf6rb4WvKhYLmfr
         Hqyv2gxkRSPWaRWPRKFrLcVo7MnUl4oqOgTFPBeodbBUr84WAzZrH1jDR09d6dj3Dx4c
         hA+MUM1HGUByDT+2M0xG3CAJgg5WDGQ5qMzXp7Trjzqqh8xWoz97sY04tYZR8T/uIfsI
         ZsBU9dHNEhqsXYtOTv/lwjPZdcB1HJO4wYlrVVG1ma+5fgT02e+UJDiThnGh+Ucev8kS
         hSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847564; x=1795452364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        b=ArUrNZnwQun3+LuDEHckvDbiOPfgH7i3bInXXBA+HMhzsg69WngFRytXVCE9k3J3HM
         GayxCdzo9ncSPiCGM+mCmFdojeKjloTLpz87Dkw7m3f0V6wbtO0wxGHp4Uo01WLJiTTa
         sOgmqm+qMFDYQyZtX0qhTFkODzux3P7jTsFcHyivcHzyR/qRzfwcqKT/+lu4Njo61KMB
         7UHYNenBWJD11lpm6BBJozCnQRcdtd+1OYNoguW/PtLtFNas/wpySdDFryHLhTSszjt0
         addn4QtkS1Zv8I2OlcPACVKCvblHQauOuPALiDEJvA407tHyXdETb1u8PZJU1+IaBL5s
         2iwA==
X-Forwarded-Encrypted: i=1; AL+hErF7wJJFyqeZRiTYcwJORSjK67723VHinSHQvPGuZqLsKXzqLLW34/HKyndzuf1qVoqx9uCzDg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8ZSBtpI0M++fFS9ntn+tu2KSiNrx/W/5/fjhfbeEH6AKVx06se
	UPwR88Po5zAhlGdsn1wZYzJ4jdXmEq73ZK8G0n4tMklLGl6qNUWA9F7U9ppaKXOuYjiuqrRBQEs
	JseZlaD8zJNpU5B9/ab8thX63gBfAOImuZG02hwSdO3SRZ/xJWxiWtAHr
X-Gm-Gg: AYBFou2I7B9+iqDfY2gxzgBhZaJQKcBSoBpQbzhftcpV1nGat8VW3sAfpu2orhaaQLR
	5GXhkGxcT0KpCGZpzy3tN5QJxRoE4YyhzwGf24kwlpC2rcYQUs7Z1ExGvaRH6vC0W/TiefK2TwW
	xw3pybzo4zvgZAX61bEyXOY9bW1DAL9zB0LzNxzoWaxtP90Ab7tageR6UDT5C3npOwOzBeuw5Mu
	hCa33M/aJ6mYV80vDtl1u3OTghTIEDWHfh0I25yu3YILtaDooie+UHwuFlplBGs0MFF42TrtGDi
	voPQPRf6GPUuzm7q0LMUNtczKXAyHyNIgxDp3cpsWu9XLY8XzIzErsbpW0oW2TWgldUJP1LsUjb
	w8W91Pg5yJc4caNGKQtilkL2I3MGOM3HQ2vXsBA==
X-Received: by 2002:a17:906:c14e:b0:c34:83c0:b92b with SMTP id
 a640c23a62f3a-c509631747amr801733166b.23.1794847563720; Mon, 16 Nov 2026
 08:46:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com> <autxCZPJ9yiE2ucq@google.com>
 <aut0H65XKAHUqPR9@google.com>
In-Reply-To: <aut0H65XKAHUqPR9@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 08:45:36 -0800
X-Gm-Features: AclHuK91dkLFtARHO_doZgjfYRJFT_5pDlpQ_hxt-2ez4dAgAMEfCzexcKbTDgA
Message-ID: <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261116_084615_912779_B2C848FD 
X-CRM114-Status: GOOD (  24.07  )
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

On Wed, Nov 4, 2026 at 10:06=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> > On 10-13 16:25, David Matlack wrote:
> > > v10:
> > >  - Save and restore the ACS Egress Control Vector along with the ACS
> > >    Control register, sizing the save buffer from the HwInit Egress
> > >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> > >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> > >    rather than adding the dependency later in the series (Pratyush,
> > >    Mike)
> > >  - Reword kernel-doc comments to read better in the HTML docs and
> > >    spell out "reference count" (Mike)
> > >  - Replace the version number at the start of struct pci_ser with
> > >    required_flags and optional_flags, and record the size of struct
> > >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> >
> > Hi Bjorn,
> >
> > I am planning to target this series for the 7.5 merge window through th=
e
> > liveupdate tree, as we previously agreed. However, there are still 6
> > patches that lack an Acked-by from you. I believe you might have
> > reviewed some of them before, but the tags were lost during subsequent
> > refactoring. Could you please take another look at the following to mak=
e
> > sure everything is in order for us to merge the series:
> >
> > PCI: liveupdate: Set up FLB handler for the PCI core
> > PCI: liveupdate: Track incoming preserved PCI devices
> > PCI: liveupdate: Document driver binding responsibilities
> > PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> > PCI: Save and restore the ACS Control register and Egress Control Vecto=
r
> > PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>
> Thanks Pasha. One more for Bjorn's list:
>
>   [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dmat=
lack@google.com/
>
> Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
> (albeit based on his feedback).
>
> Alex, could you also take a look at the two ACS patches? 08 includes the
> Egress Control Vector save/restore you asked for in v9.
>
>   [08/13] PCI: Save and restore the ACS Control register and Egress Contr=
ol Vector
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dmat=
lack@google.com/
>   [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devic=
es
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-10-dma=
tlack@google.com/

Bjorn and Alex, these 2 patches still need your R-b or A-b tags, and
then this series will be all ready for 7.5.

