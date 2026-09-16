Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77965C982C4
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=; b=OLW7FAqfXKR6bfVsJBx81IQC6K
	85zGQoZ0W2RRW+QLhmp/t2KkpM+Kn5j2F7z5Hq7leR1rW5N190D18VuqHspX6SO0G5g8vAyq+8Gw3
	eW1eUjfgQtHKVzAaB5AmhY75iys8ooGKrkYOapwSBrgs6+95AbRrT9DjLkCRtqmxoda4/N3sdqc3t
	nNos3LSD6SnviJvRe3jmMdRR2LPgyrJB1rgUWYdiPRf6mNLnMf2/KDjI6PRh/ZV/6hFigLhP/W0vJ
	AiMo3HI0qMA5sWidiVaySvevfvt9X7r75V+GkUwjzBTf9yDnAMGGtgfKmaJtaO2YxIcGxbQurkbOA
	h+wwOsQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6r6B-00000009U7B-0hW1;
	Wed, 16 Sep 2026 14:58:59 +0000
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6r67-00000009U6l-1SYa
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 14:58:56 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c264788fd58so178170766b.1
        for <kexec@lists.infradead.org>; Wed, 16 Sep 2026 07:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789570732; cv=none;
        d=google.com; s=arc-20260327;
        b=nzByuNaR2WFsDgqU2FvqfpXaTNkDCE0VljWmOvm68eL+bQzMsLGU6bxdstH7Ah0Da1
         lrEfQgfTjXtE2cUoGroapafuO72LhSlZWiwoEFNOsuQWzd3ERR4BYoYfuKLYyYEG2sMj
         rZL44+gxb2ZpZbwomc9sBwZ/CNZ1naBMItS5m50/Pm0UuMjIlBnsldGB70xFiTDndNk7
         +Yke5Tlhjp6RtREZGaWoShBclCb1lnn+8ScaXxhkQ5++A13XYbsa4Uv7QapTj8ntdRF/
         vzlmaZTfdLy17EZmbIn0G0c64OS0s3ONQLCHvIUloGcqpBkv+xwd0G5JWYNou7x+JG/O
         4L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        fh=qrurRsB6tpOKG7UgO4S4127AKWFozT3W5QrkFxhFbC4=;
        b=bj7Pe86LHXHY/R4WNs2ZOYpKdF/6eVICKxpSk+o7sDKC0nuLMaFjo1MqUmS98I8coN
         iAm9UMScIfgit2+XJoXBALYE8kiVjutLuC8lBzHPdinXKmgxX0uvvwGOIaMwsVND4aMO
         FwZku0MmczlN4neA5y5j3414T6BuGrC3pbMTlxdi35LAHHl97wEQptmRfs7B5AUdRmiP
         P4WF+QMkvqYi1qTnvSmrElJ6ktsNMVRyl346mGdmHui84B+W/AK8hwv6kCrtboOneThc
         xUrQAE5ILmWA1r2H5OYTXCAFXfZB2Zshnb0bA4kL+YPvDGolXvpomiAzCe/xyVLh6aF9
         Jr4A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789570732; x=1790175532; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        b=D7MvrXjfuS1RrVaw5bR5+S14KsOolrKqeDsEiA6cziv7P/xaip7IJfpn7rdauyzw72
         AuE52HIwc8JbSWpmjCrOxlMP5H4H2+XCCH5nJSjGG4fLF3Q/dmkDZhLDuSCd6s9xtYw7
         cBcBHSzLmp4IVHsIlpOuMiS4qJik1wFxNceJl0o5gEJhrE786Gw+O3XC34FxIgSj31Xh
         Aua4h9y3my10jDH50YK5i2yows4atEMmTUQ96nhcUB6cjuRCMDGSCTbyR8VXSirX+PVt
         s+/Qjf3vEkh2oRBfEI/BhTVnaao6mNMlSwHkonskgdAUBz7k/dG4GOAe/o3gpDtRL+pB
         J5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570732; x=1790175532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        b=QKfYD/ZmkyKEyvRdLzodIJbVwMNQ6MZB9j5QDgByKY7kMYXRR96C5fqRJCl7nRRluC
         4V7mcf+nnnR076vC2cexcY1izOz88V1iWVcDwuspGoWKdeP7S/CQ8luB85UMjugKDRXO
         NgOjDJOwEp7lI4xV1jEfuz7NY1aB2UXfM+/OCtc77pe/PvnwHcZZO2xWgd9hSEB2kk7N
         SSTz3QxewPPsOfoxhWFAmKhujiebvMfKYTA8KEUEZgcILYYs0t8wZWm87PPdpvpg9qEd
         /bUGa/abCGIjfdto5BeVG1JskzoLqGK2sNH8Oyvyr4GOSDSzXc6G4CbYc2UXOIZD0R1P
         6FbQ==
X-Gm-Message-State: AFuF++nTlutQIgREsCq62VxlqxqN+pn4dQ4ul7LLVDyyzPwb6UyZm5yn
	cA3aA3hvZFTV1r0pgpLqwTC1BSjfVLmYas/zFEM2PoyihDI0W0bjYNvbomQiWFfOfOIP6gP0Lli
	zbGxN0C+pmGm4cMzSuZWJlkY1cvs3bHdzWMcYLv8o
X-Gm-Gg: AYBFou1hr743DDCJaQ7UGjfYRR9yzEmfJq8sQOJIBLm84JN8YpWlvfAzfUcKgWMtbQF
	2IKbewq24kEa00wTXZVj/Q2E7izzw90CViQ9pVqgzFxn6QsAQNI4zODY54YzhTbX6/zOQ9zMUty
	+BW9kGUUDG12H6UrUNkc4zUs14EvLlgDdraaZ39ZGM4FpjxvJLIiNKV1u4ki7P0gVmhjnlNMes9
	YGAe+n2ygBG+wRkOhls4HYRUX4ef734fyaH9O/XNABepvBUD9b4VVlzeFz+M4s9LEC4gCo9hWEC
	q5V8ul6kOHW7PF2ZFg8nKAyDoYz9tUp1HdeNl/RLrD5HUSwsXCA5CLY=
X-Received: by 2002:a17:907:c49a:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c29e52c71e0mr199279166b.30.1789570731516; Wed, 16 Sep 2026
 07:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-3-dmatlack@google.com>
 <9211b2b6-9fca-4ef7-a141-84636d56e67e@linux.dev>
In-Reply-To: <9211b2b6-9fca-4ef7-a141-84636d56e67e@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 07:58:23 -0700
X-Gm-Features: AcwNN1V694h9Klbei55CjXCXrLccfSPzJ9ZF9qWXraB-n35v9TC4KupB_2aeuGo
Message-ID: <CALzav=dJUiZe+Hxck9X+kKVXoRn-Ks2WxV7B5i0RHRFGy7-Mpw@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_075855_480294_779B20BB 
X-CRM114-Status: GOOD (  19.92  )
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

On Tue, Sep 15, 2026 at 8:10=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> > Add APIs to allow drivers to notify the PCI core of which devices are
> > being preserved across a Live Update for the next kernel, i.e.
> > "outgoing" devices.
> >
> > Drivers must notify the PCI core when devices are preserved so that the
> > PCI core can update its FLB data (struct pci_ser) and track the list of
> > outgoing devices. pci_liveupdate_preserve() notifies the PCI core that =
a
> > device must be preserved across Live Update. pci_liveupdate_unpreserve(=
)
> > reverses this (cancels the preservation of the device).
>
> Hi David,
>
> I have a question about the pci_liveupdate_preserve() and
> pci_liveupdate_unpreserve() APIs.
>
> Is it supported to call these APIs multiple times for the same PCI
> device? For example, a driver could do:
>
> pci_liveupdate_preserve(pdev) -- > pci_liveupdate_unpreserve(pdev) -- >
> perform some operations -- > pci_liveupdate_preserve(pdev) again, before
> the actual Live Update starts.
>
>  From the implementation, it looks like an unpreserved pci_dev_ser entry
> can be reused, so I wanted to confirm whether this preserve -- >
> unpreserve -- > preserve sequence is an intended and supported usage.

Yes that is a completely supported use-case. A device can be preserved
and unpreserved any number of times up until pci_device_shutdown(),
where the preservation status of the device is frozen (see patch 10).

