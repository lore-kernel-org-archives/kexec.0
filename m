Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEB9C44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHR4CbJ8loVD9XIgadhowB6w5bW/rYJvdw1lbbqKWNI=; b=xZxC/JB1p66i99jEslV6hTFBeY
	qojIMu49pOjrLQMQGJN/J9DpvdteVjMWJIPgYbz4484NWbmgwB5E93RnuuHI7mCakhvAQ6Q0Ligjw
	TAWhW5O/fGvc2uhoUbxnUMZpZl8KQntArc4o3Sr+9wPB54iyDFSyOD+C4wO6FyTvzLWW8D7u73d0C
	I/CqEIgy+4AJDzszLA/2gxghLNKmyT3Peq9JA+HjyCzX1us+OQ2DHAyKWDDxfg99CLMMr1JYS+++u
	bL0eFSXPqGbWIu9/tMbU7qIXKeG2ouYhn8e6kTTrHgYElx3oF3ZlFinnxV/jDLF/YdM1tP54DVD3Z
	EBozc0cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlwj0-000000083Ht-3Yar;
	Mon, 20 Jul 2026 22:44:38 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlwiy-000000083HA-2Eqb
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 22:44:38 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-51c10ed63c0so1053721cf.1
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 15:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784587474; cv=none;
        d=google.com; s=arc-20260327;
        b=DhyolS78Lc6box+0bF4t8omqK46JdSbWUmEdmruCM5ZOZBWAxHzGLwM6voqlBgaF6R
         XHVo2y8Hs1MwhxY4X3X2xEwN3DVraYCkrmvoSqZsxYrWA6hJg+v0Z14Pnz26oYer4RJS
         2tHrWJ1ew6ExQMQuaRDyLL39P1ZssurYf8hd48WXuIo66ziA5bTwrA/pnDuh5JIrtnfA
         9cVKK+luf/Ljxj5ydfgMniuXypTsv7KMv97qTKbZqbbYOAuDFwPy+wEIfKVKHKRY+XOL
         vegtRqpnpGtCPV9AbRj2FNGukaQh3iDbowOPISJT43lgoejTWqVT+409cTSDODpE66AL
         t/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GHR4CbJ8loVD9XIgadhowB6w5bW/rYJvdw1lbbqKWNI=;
        fh=uLk/K92DVXOZDMdbxHE2S2aKObFIaPogd1tKH2zyIBk=;
        b=sXM4Emm7MUlunQYdqTZ47QP5xIzW7PPj4vDM3g500oeW6xjl1HXiZbl0LCVBhP6twC
         Je9VKg//k2/s137K7+AeyHS2K2KzhnUJx1KsZtj8ZvJv+HHWhZ5xyIOFfnvmrVAjBSmd
         LrAb/NBg2xmxKqq2tdcODiKtKo6DsWziwb/ahAekYYwoPQam50goMCy0qK5lJb41GDHr
         dLBjWtbfoVV73y6eKxWDP8vFzd019vfbzwuH2RR3ZAtrKqmGqAuzaZxjni+zeYF6076W
         G4p2noX25t6VLbrxjZbp3TZEMpUq53L8Fux/eSfbXZBGOmYmsRYDFE+VqW/3z2tk1bLB
         eWhg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587474; x=1785192274; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GHR4CbJ8loVD9XIgadhowB6w5bW/rYJvdw1lbbqKWNI=;
        b=mv3pxZg4UJlNCdW6/e6PIM3WdAHg1G2hPw2JVkK+6VxFtyu2kqbD+YlnO89jHIbpzt
         koUIXlkqBOUjDK8mrxtR/P6D8WpnM5SSAtTu7EKm57MZu/21YmYRF0aYh1Tdm55vakn1
         aFL6jueiIUpa2MtNKq1M5hyboemtwIUNOQXAJ79jZsRHgEUFZica2DIbqB1c7Bw5MXgf
         KUxVe936NDQIscQ3dEMqiPiphhFrHxP6VIrsE3jx+x1jLSsWSfNVdoFlBbtJ0zXNv3oK
         0XVcOn96JkkGUgxHWDqPQfOCDyDaqvPyUfi6zjBwZDGaRNVQq5AmaVPPIvrl1KxiUO0t
         Mqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587474; x=1785192274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHR4CbJ8loVD9XIgadhowB6w5bW/rYJvdw1lbbqKWNI=;
        b=mJt+06ZDDmSCJbZnv85u91xPLq1mS1DEYLtfWADORSVdKNxrvW2Mfg8fl7AANW9sS4
         4O9JuQa6THEow850K+V6STENFIilWQV+sVG6aCxv2O8cudi8s6BW89HLo9rPmU8hqm0d
         zo7vQMl0zIymlVenMsAKveZXq1Rxpoiv4euedeRywFGdsRIxBOnc6G9wDV/G+Ypojx2D
         Fjberf701d4asSFabSBTP+fmT7Dtfk41KAy8TUTFO09xwWswhqfepkHY2fza5tzhF2wu
         BzRIdNKrGsG1weHkN3MsT1BzMJMzEUWYVj632xP90dshRH8VaOkAYs+Tf3nYI9oNBX0a
         P8Rg==
X-Forwarded-Encrypted: i=1; AHgh+RreSd4q8QpPwJFoLguWW+MXIkluXCG5L5LJDJAuc2AfstB9Gfhaor99YG9n76fnPqoiClUeXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDr8blDm4J0MgQI3fc4597iKu1ebznGvMTTFPnmJorPzuZ78Ka
	66aQPTrdrIMAykuzZXtwQNiyXOq0SU7YBlyi4FNex00H+CNOKb8cw9eQ9pYOgBIRmW3XVNWMEsE
	t5NKvz94p6zAk26k3Qbnlr/OK8hOtRnBMbfocvMYO
X-Gm-Gg: AfdE7cngOzB4W2XliHkIQLRV7qNEs0dLGu22kz1U6WcCTcW1SB6O6Hu10Pb62fSFRZ7
	FFRkRApmfeV4wMBP1wOngMJag6mfIipnpF3+Yj+qe0enqjNQwxQ6E/LjW0AseCEBKSWS7E2CncL
	CDKVcdSZpYZPYf/SqtkNIXhz1DUsjVpzsi18FiHNJcCbDLUaoaOa/L2oAoIGv3TyAu5mePBlx/A
	d5Pvzo5H28XyztvadX6MxV/dBqx+zwRwteneNhjzaulwbf4u6w/N3Haqp5mxWpBEA8y6Tv4n6yi
	QaO2+xTLQ9YgyumOFJo=
X-Received: by 2002:a05:622a:134c:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-52601ff8d4amr6884401cf.16.1784587473744; Mon, 20 Jul 2026
 15:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhR5DGpL6_ViMwQ0nKzTgOoziE_oq8JofpO-VtHBXK37uO-FA@mail.gmail.com>
 <aljw6vDaeEdhzZdy@google.com>
In-Reply-To: <aljw6vDaeEdhzZdy@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 20 Jul 2026 17:44:22 -0500
X-Gm-Features: AUfX_myYvC4BfYam-0hvA_2hmsHjyNwwCFWWIdoxNvvrsMfeD0EQ_AZrXlkgCvo
Message-ID: <CAAhR5DHNdoB7+8beLHHFOT90UrHWF3FTwMs44AwQH+-R+u=w6g@mail.gmail.com>
Subject: Re: Preserving TDX module during kexec with live update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Graf <graf@amazon.com>, "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, David Matlack <dmatlack@google.com>, 
	"Heyne, Maximillian" <mheyne@amazon.de>, James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Praveen Kumar <kpraveen.lkml@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"Woodhouse, David" <dwmw@amazon.co.uk>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Jork Loeser <jloeser@linux.microsoft.com>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_154436_591878_A4CC19E3 
X-CRM114-Status: GOOD (  38.83  )
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

On Thu, Jul 16, 2026 at 9:55=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-15 18:28, Sagi Shahar wrote:
> > Hi,
> >
> > I started looking into preserving the TDX module across live updates
> > and I'm not sure what the best approach is. I tried looking into using
> > flb as David M suggested but I don't think this approach works for the
> > TDX module.
> >
> > Right now the way that TDX supports kexec is by disabling the TDX
> > module on kexec and then reinitilizing it on the next boot [1]. This
> > approach clears the TDX module state so any TDX VM from the source
> > kernel won't be able to resume running on the destination kernel.
> >
> > In order to support live update while keeping the VMs alive we need to
> > skip the TDH_SYS_DISABLE call and instead preserve pages used by the
> > TDX module such as the TDMR pages from the source kernel.
>
> Agreed.
>
> >
> > From what I understand, using flb will tie the TDX module save/restore
> > to the lifecycle of the VMs depending on it. This means the module
> > will be restored too late during kernel boot, after the VMs are
> > restored using the live update IOCTLs.
>
> That is not correct. FLBs specifically can be restored very early in
> boot. We do that for HugeTLB preservation, for example.
>
> liveupdate_flb_get_incoming() does not require userspace to resume or
> restore VMs. You can call it super early in boot to see if there is FLB
> data present and, if so, change the way the module is initialized during
> boot.
>
Thanks Pasha, I also got a few pointers from Samiullah and think I
should be able to make it work. I'm going to be on vacation for the
next couple of weeks so I'm going to miss the next meeting but
hopefully I can start working on it once I'm back.
> >
> > I'm thinking we should preserve the TDX module during the shutdown
> > stage of the source kernel. Perhaps we can preserve the pages used by
> > the TDX module as we allocate them on the source kernel and pass
> > pointers and additional metadata during KHO. Then on the destination
> > we need to pipe this information to where the TDX module gets
> > initialized during the KVM module initialization.
>
> Please don't invent another state machine; instead, use the existing
> one.
>
> Pasha
>
> >
> > I haven't found a device that acts in a similar way so I'm not sure
> > how complicated this will be or if there's a better approach.
> >
> > I would love to hear your thoughts and if you have any pointers on
> > where this code can be implemented.
> >
> > Thanks,
> > Sagi
> >
> > [1] https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-0-=
87a36409e051@intel.com/

