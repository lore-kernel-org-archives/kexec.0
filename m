Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C86C4332F
	for <kexec@archiver.kernel.org>; Fri, 11 Nov 2022 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+bQsIzAGwl8yGlGOIKU1pVlJDPZtezFG9hqdDrh6Kg=; b=SGAIwfvPUcvWTG
	BI7xwJ8DjrWkWaCZNDwJg0gejtExth0sk6NEe9/TrHZms3PECGaGg5ko3t6KRXCFwJdO4Q66uuLDS
	ZAzuLRkFymampS0LeN9jNsP31E6ImjVqYAJigqDCk+BKtXeXbexpRw4rGtb/dtKzChxgvxSENxdgu
	Yw4pp7bQUcyanbirxgJhZWUNNdHQyufEcbsOcIV0Z3MyZsckk7vmATcinAUce7pvIyBauP4oqaSaI
	M/4f80th9Zdz4K7AxDxx9DdqoToQGN6qUVjU05S8As1oBVMGRHfgy3DZnAask5QUJRB9jTOKhYBNm
	1Y1PbuEAmZu77XJmXq/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otco3-001g3v-Jc; Fri, 11 Nov 2022 22:47:27 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otcnx-001g1e-T5
	for kexec@lists.infradead.org; Fri, 11 Nov 2022 22:47:23 +0000
Received: by mail-wr1-f47.google.com with SMTP id v1so8108753wrt.11
        for <kexec@lists.infradead.org>; Fri, 11 Nov 2022 14:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI4P7tfn9C8Un92zwS2OcYROGExNgeJbwEJVmkULolM=;
        b=CwZx4mC9uizhxJcRNsxMzlKfxve72A6p6KH8SYiJZB3YagJVXE2vpwjr9yV44cVCgO
         eoN8n/pktRv/3d46bHiUcVVvCWZ2WNgFWKizcyK+uj/yq9FTGjc8s21uWJxT+TuLOmZx
         a86fXHJ1nVC+1aTyStC7H2yVzz9qPfWSzYmYIt5SxCKnpfPie18uH/yV3QPFWHdzPuwt
         vo5oS1JjF2jB7Ufp2MNqoSbr5+AUhTkOYedLEx7G9TY2XJKZ693m+OHUfuPLG3hmUyvn
         Ftx8NF5VKCkHCTUde9LuG2aZUTWvXtAke4QhOy9tTHy/yd4ZMfHOvyaWLxatmThtLL69
         A6TQ==
X-Gm-Message-State: ANoB5pnhM66InBz4n5xRvNbUzUQGhdE0fv6Kn09n9QwSDfpXlsH4doEJ
	h6OoBiGpnmYBj4VFKZ/KK1U=
X-Google-Smtp-Source: AA0mqf6jNKhQiD8pjAi1gZTWIGN2qsj7oY8uWm+3nogLtkHYw6XIWtDQu8FwrItLC8AxrYbf6gCIKw==
X-Received: by 2002:adf:f3d0:0:b0:22e:37c1:b225 with SMTP id g16-20020adff3d0000000b0022e37c1b225mr2221431wrp.428.1668206840092;
        Fri, 11 Nov 2022 14:47:20 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003a6a3595edasm4191067wmc.27.2022.11.11.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:47:19 -0800 (PST)
Date: Fri, 11 Nov 2022 22:47:17 +0000
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
Message-ID: <Y27Q9SSM6WkGFwf5@liuwe-devbox-debian-v2>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-11-gpiccoli@igalia.com>
 <BYAPR21MB16880251FC59B60542D2D996D75A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ae0a1017-7ec6-9615-7154-ea34c7bd2248@igalia.com>
 <SN6PR2101MB1693BC627B22432BA42EEBC2D7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <efdaf27e-753e-e84f-dd7d-965101563679@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efdaf27e-753e-e84f-dd7d-965101563679@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221111_144721_979250_D4C709D0 
X-CRM114-Status: GOOD (  17.27  )
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

On Thu, Nov 10, 2022 at 06:32:54PM -0300, Guilherme G. Piccoli wrote:
> [Trimming long CC list]
> 
> Hi Wei / Michael, just out of curiosity, did this (and patch 9) ended-up
> being queued in hyperv-next?
> 

No. They are not queued.

I didn't notice Michael's email and thought they would be picked up by
someone else while dealing with the whole series.

I will pick them up later.

Thanks,
Wei.

> Thanks in advance,
> 
> 
> Guilherme
> 
> On 17/10/2022 12:26, Michael Kelley (LINUX) wrote:
> > From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Tuesday, October 4, 2022 10:20 AM
> >>
> >> On 04/10/2022 13:24, Michael Kelley (LINUX) wrote:
> >>> [...]
> >>>
> >>> Tested this patch in combination with Patch 9 in this series.  Verified
> >>> that both the panic and die paths work correctly with notification to
> >>> Hyper-V via hyperv_report_panic() or via hv_kmsg_dump().  Hyper-V
> >>> framebuffer is updated as expected, though I did not reproduce
> >>> a case where the ring buffer lock is held.  vmbus_initiate_unload() runs
> >>> as expected.
> >>>
> >>> Tested-by: Michael Kelley <mikelley@microsoft.com>
> >>>
> >>
> >> Thanks a lot for the tests/review Michael!
> >>
> >> Do you think Hyper-V folks could add both patches in hv tree? If you
> >> prefer, I can re-send them individually.
> >>
> > 
> > Wei Liu:  Could you pick up Patch 9 and Patch 10 from this series in the
> > hyperv-next tree?
> > 
> > Michael
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
