Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D00C54E67
	for <kexec@archiver.kernel.org>; Thu, 14 Mar 2024 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+JFIou/xEoOtkaWvxLK84xmVg3SgwHV05UTLFHQ0OKg=; b=DjCijE/+CtszJW
	jmrMyHSbeGWbRJ5geWnMQWVSszVU511xtNbLLkP4nC52UerGBIJe8jwCULy2xTiHn8x1ZTvnm3spg
	Trvxfd8sxS+8jl1ZRTU/yRNbbI3kk5zqYgVtGv8G+j6o7yulGZxezemT1xTyqxjBoWTk4hoiDH/ax
	mpXOYsnRJG7KpmkoeCFrv0iz8gUI3znTQtiXNwbnqu6Q6Rriwy6kpl6wAYDVvLbcZjnmZFWGqh6Au
	QEFgAmEiDL1tixdZTAk0JRguNRVJCINj7gSLaPwJbgTh1kMPX32Up1HrILGDlkA2zibsKq84mMWFP
	wAorr2jdcSc1I7IzTsNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkhLV-0000000Diau-1ECH;
	Thu, 14 Mar 2024 09:25:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkhLQ-0000000DiZF-0R1w
	for kexec@lists.infradead.org;
	Thu, 14 Mar 2024 09:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710408344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl/H4MWGLgmEqfgbk+kWHokXGlfem4Ht/IF+GTQnQp4=;
	b=d8Ddl84k5J1BmnlY2kK1d+OX4izryqGA8auStABY7L50u9XL2kVbhiumAmuUGnwsxN17Up
	h7N2ecnkj1B50G6iPamC1ZeP03wKgWcv0TXVNnaiddO2Dd0KTztqV0j+0h8oxQOdV1Rse6
	gPnv0wmtS4TN3JpiQpdNv+2ISjDEFkc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-IWJRlbBuNzeBO9smnkkSRQ-1; Thu, 14 Mar 2024 05:25:42 -0400
X-MC-Unique: IWJRlbBuNzeBO9smnkkSRQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3665480799bso2507915ab.0
        for <kexec@lists.infradead.org>; Thu, 14 Mar 2024 02:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408342; x=1711013142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl/H4MWGLgmEqfgbk+kWHokXGlfem4Ht/IF+GTQnQp4=;
        b=tNNfZiAtmpJHWOIJvawXtGTph2CfmGx5BNMV/tZ14ziHpp/N1uBZ6cVY0sBVtLB8Yc
         aPYOJ87/srwC+JUkNC0cnZBNgXj+EJtO/m53UKYIUrCLXx2Qq922GAOVyshJQhuJi8zW
         qWgx6CI88Ez25sf1Sp/ZaxAVr6aI59tgIpjxLTbQrNubxnj+l+8Y/1f2lobgi6mjvR+n
         xiMCZtbcpNyMhDSXf8scsi0kB61Pqu8oE5VH+nivtZxfIj8rZsUZFTdmcejhEZGhwqUG
         sWRl7xHv5JRLAO05dBc/G/D+gT3dIJ0JfTJeIlEqI34m7jL17v+k+Kx9SmqZQW84lo3/
         BJhg==
X-Forwarded-Encrypted: i=1; AJvYcCVq76nyu+w1kPH57182TI25q+BnG+dr937F15psa4vSUWT773mnCeQ92WyC5rdPhl7PBPchlB+psIHG2tzNzDAfPiAVJq0Gnhfd
X-Gm-Message-State: AOJu0Yz7LDMtPrveoDmexfvnigBCoBOmISG+a46XIblU1tWQtZJ9iU4S
	5lWbDuuxtipRV8XmCf6VRNtB9C3B9LXouT2kjtI7/6+YgXNMBYJpJ7T6xyGIDCb9Z0xZwtoUCJq
	QOG++9D5LwdhlrCPsDHtT69d902Ylisn+eobjsbDu1J+w7r21l0HqLiUmJWwTwhE2vCzdv2vg4W
	R3i0dl92iIGHgscTPEnJuetWi3nnFMz9v0DH/noP951yo=
X-Received: by 2002:a92:de44:0:b0:365:4e45:33ad with SMTP id e4-20020a92de44000000b003654e4533admr935895ilr.1.1710408342156;
        Thu, 14 Mar 2024 02:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8ilRYhJOkTU999SkD7mYGv+S2pTq79uG4Gtss8uUESu2wfnl2F8tti+O0WDSOfuRxxW4k70RHgq5g5PMV/g=
X-Received: by 2002:a92:de44:0:b0:365:4e45:33ad with SMTP id
 e4-20020a92de44000000b003654e4533admr935892ilr.1.1710408341845; Thu, 14 Mar
 2024 02:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com> <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com> <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com> <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
In-Reply-To: <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 14 Mar 2024 17:25:52 +0800
Message-ID: <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
To: Steve Wahl <steve.wahl@hpe.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>, 
	Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com, 
	regressions@lists.linux.dev, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_022548_373846_01D91566 
X-CRM114-Status: GOOD (  33.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 14 Mar 2024 at 00:18, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> On Wed, Mar 13, 2024 at 07:16:23AM -0500, Eric W. Biederman wrote:
> >
> > Kexec happens on identity mapped page tables.
> >
> > The files of interest are machine_kexec_64.c and relocate_kernel_64.S
> >
> > I suspect either the building of the identity mappged page table in
> > machine_kexec_prepare, or the switching to the page table in
> > identity_mapped in relocate_kernel_64.S is where something goes wrong.
> >
> > Probably in kernel_ident_mapping_init as that code is directly used
> > to build the identity mapped page tables.
> >
> > Hmm.
> >
> > Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
> > where full GB page should be mapped.")
>
> Yeah, sorry, I accidentally used the stable cherry-pick commit id that
> Pavin Joseph found with his bisect results.
>
> > Given the simplicity of that change itself my guess is that somewhere in
> > the first 1Gb there are pages that needed to be mapped like the idt at 0
> > that are not getting mapped.
>
> ...
>
> > It might be worth setting up early printk on some of these systems
> > and seeing if the failure is in early boot up of the new kernel (that is
> > using kexec supplied identity mapped pages) rather than in kexec per-se.
> >
> > But that is just my guess at the moment.
>
> Thanks for the input.  I was thinking in terms of running out of
> memory somewhere because we're using more page table entries than we
> used to.  But you've got me thinking that maybe some necessary region
> is not explicitly requested to be placed in the identity map, but is
> by luck included in the rounding errors when we use gbpages.

Yes, it is possible. Here is an example case:
http://lists.infradead.org/pipermail/kexec/2023-June/027301.html
Final change was to avoid doing AMD things on Intel platform, but the
mapping code is still not fixed in a good way.

>
> At any rate, since I am still unable to reproduce this for myself, I
> am going to contact Pavin Joseph off-list and see if he's willing to
> do a few debugging kernel steps for me and send me the results, to see
> if I can get this figured out.  (I believe trimming the CC list and/or
> going private is usually frowned upon for the LKML, but I think this
> is appropriate as it only adds noise for the rest.  Let me know if I'm
> wrong.)
>
> Thank you.
>
> --> Steve Wahl
>
> --
> Steve Wahl, Hewlett Packard Enterprise
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
