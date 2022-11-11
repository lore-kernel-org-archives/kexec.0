Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F687C433FE
	for <kexec@archiver.kernel.org>; Fri, 11 Nov 2022 23:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvakuskXaGZ5SvibU8ISLalw3GSPtCzsVb/RHDYrwTU=; b=JmxWYMNdmQLaie
	q60xbEtOqeQ7wnDUF8hgy8hjE5TbkgAgzueBUguh1A/iD2AYlD4c+Jk57Xpfhk0+jAATQEwoq8Tul
	oo8aDe9+ENsi373ZRGmS0ahQvTBV3PlcnxDkVx62TFIt+jyY8Z4M5cNemQiYujGAxjazoh+aRXApp
	R3zKd5MI42VBQ+4n5E5JtzB/YGBliJZ/tl556bKgPFbaySKVrnp8DLjv55uIpS/pdywKdXNwzdnW1
	dQmF2ARU8ArPGRIn3BGTPhlipYATL7NsbWzLpVc44tk+PKQOm2b358xZzLDs3X/oN9h5G+j4q2NkM
	0jTmjMCDXvDM3PrAtOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otdFr-001mlV-PA; Fri, 11 Nov 2022 23:16:11 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otdFo-001mjp-Iu
	for kexec@lists.infradead.org; Fri, 11 Nov 2022 23:16:09 +0000
Received: by mail-wr1-f45.google.com with SMTP id o4so8206960wrq.6
        for <kexec@lists.infradead.org>; Fri, 11 Nov 2022 15:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML0RbCqbrCyj8dh7iybZeA9vXEsm9tqKolIzFc77JSI=;
        b=DQPFAjEGOvTKm7L8sGCC12AW50nQP3UyUI38xLr6xo5w9h6R8nrSxFNoQCPbIf/Fm6
         YaF3IBjIl/S+zljlX7LrY1BiVNSU9YzcSPvlqsrhG2pEzBx1Auf+6CUpybaXGZ3D64Xg
         FfgveIt2CxMogtlPjPBvoR13xFXAbsSk5rT9roBorFWYByoBWMqH/xUn8NH0zIZtcMeU
         XjPNyxhA+zGGAZtTEG4KSiAGhMxERMPraQw+2kRgMdLz7tDHlIWOov1AqgmGUG+1sljw
         gV7T1q7dnqsIBmmQa9GqB/8RdcXUgXu9jFm7Tu5f6NhIMHVp9yX4dxWaYqZ189Hv40kB
         FRzA==
X-Gm-Message-State: ANoB5pnDGI64LqGlPJEXeaKRlhmtteE6qmwhOwV3LebWawJWZWc/oRkj
	LnBqen6tCh9cCQ2kMUkArzM=
X-Google-Smtp-Source: AA0mqf7ZPoTb7TZ7vc2ApkuO6Q5VrxJgANuw8sRi7qmBR1m0pF2mXHBjTNBZVzTEOEMmWntExjnjlQ==
X-Received: by 2002:adf:f952:0:b0:241:71fc:3b3d with SMTP id q18-20020adff952000000b0024171fc3b3dmr2317948wrr.268.1668208566495;
        Fri, 11 Nov 2022 15:16:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5001000000b002368424f89esm2900908wrt.67.2022.11.11.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:16:06 -0800 (PST)
Date: Fri, 11 Nov 2022 23:16:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"pmladek@suse.com" <pmladek@suse.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>,
	"kernel@gpiccoli.net" <kernel@gpiccoli.net>,
	Andrea Parri <parri.andrea@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH V3 10/11] drivers/hv/vmbus, video/hyperv_fb: Untangle and
 refactor Hyper-V panic notifiers
Message-ID: <Y27XsybzcgCQ3fzD@liuwe-devbox-debian-v2>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-11-gpiccoli@igalia.com>
 <BYAPR21MB16880251FC59B60542D2D996D75A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ae0a1017-7ec6-9615-7154-ea34c7bd2248@igalia.com>
 <SN6PR2101MB1693BC627B22432BA42EEBC2D7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <efdaf27e-753e-e84f-dd7d-965101563679@igalia.com>
 <Y27Q9SSM6WkGFwf5@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y27Q9SSM6WkGFwf5@liuwe-devbox-debian-v2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221111_151608_638508_B5D89406 
X-CRM114-Status: GOOD (  10.41  )
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

On Fri, Nov 11, 2022 at 10:47:17PM +0000, Wei Liu wrote:
> On Thu, Nov 10, 2022 at 06:32:54PM -0300, Guilherme G. Piccoli wrote:
> > [Trimming long CC list]
> > 
> > Hi Wei / Michael, just out of curiosity, did this (and patch 9) ended-up
> > being queued in hyperv-next?
> > 
> 
> No. They are not queued.
> 
> I didn't notice Michael's email and thought they would be picked up by
> someone else while dealing with the whole series.
> 
> I will pick them up later.

They are now queued to hyperv-next. Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
