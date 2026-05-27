Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E2CD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbYyflbi1csVccgC7xokEK3x+MW2cvMKopZtfNHzrQY=; b=lcf2kHNyXvNAx8dagAmbNYhat1
	zGLKky7WBwpaOf0FLcgoAdm5DAhPakOGqdd/egQfClYxN+jHDvLRjdGWFdhMAu8ohv7qtALHBBBcN
	GeYHFkd3YIehxAiOeSJcMvmd34pxBRNbbDepry59JawWeyon1h9GpKwIXvXmEIC8RpPnPhDNfwpCh
	xyxqUo9uYVC+zH1QIvq1m5wzSPdpxrJiM7fhf3MflljZ7FQFOC6hrHmMczUPAN3zde1U4Sl7POUN4
	Um2FUyTep4d8Z1swRuEFLP1B/aEYxNjD+m7MDlrHk+Jxagv7LwG2tMFeuGFYN1CL8bkYONSledqMY
	rTRAOZrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFS3-00000004Ja4-2XQz;
	Wed, 27 May 2026 14:41:43 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFS0-00000004JZX-3oze
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 14:41:42 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-913cc4d7c71so1282730385a.2
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779892899; x=1780497699; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbYyflbi1csVccgC7xokEK3x+MW2cvMKopZtfNHzrQY=;
        b=J3Gw37W9gtxaj3gsHTuOmotHuAkCjEoCJEp2f2SnvXh8skw4kzAEvRZPcAqKMkgXq1
         RWxskOZ6pPJ/7cwV8PvkBlI5c9YbUAS8Ger7cC+te3vpo+MoD2jebpKCNI+HcjJuJoOz
         bd9Ae8enneoofhl+qAIUsIlJYs6ac0e6sDGiG0pt6jHDkNeUvbQrcP+bVBIxx7ElRyKt
         IEUlKR7rz/6BmLRkwMb1I98QVE9Fm696BktYDUP1dbl4dqLRxE4MIYjN2pfKxBou9QcL
         sGoORj08jvXo6SHvhf3BAa58o5UxajPQDLCH0niMt/yoP1yX7WXSLekqlEqPKidQKpUg
         4zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892899; x=1780497699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbYyflbi1csVccgC7xokEK3x+MW2cvMKopZtfNHzrQY=;
        b=VYbMhcmmFu9YjShUjxcxkZcugT39uhtNlMQipgGX/dgg4CqSDIR86QD88nUEq3aSOr
         evZ4rMMqExRBgtD+CFivemJRsI5OcHyO4olya8PpLSYc+alHt+WLUsHGJemykao7gIM0
         QeQenu8B7uNIXU6sPxy/RsKUVFCfkThQt0VPMQqTKl79eM1M39T/GZPEUYcLEXhL+YMD
         jCFrGXV6d1Pm3+RMG6S3N6Zu8Rx02hsOalbWSFkTXJced15Z8lRfMIOqHzIlnEcw/NYm
         fY3hIaIzzyUNS2TEwT4tCbznvqoBs5/ZcNIHMcnydUsZiuAdK9uaHLyZpipO+6qhgwxI
         dCQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vIojZPjYIZcbMMgw+w4GcIizXIkkJ5KY6+6qQrtCpj1u4F9SsmTehcGH5eu9YkmCJP9bN0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwR9EPhpx0a9b7BVGfPmaVOaQVLgS7auxfuHk0wb0mc0edWw1AJ
	eXCTbCNh/e1+uGvx/pcxz4X4t+dgVMD8whLftA5DhoahOWvAc1johprEc5oJgIrm56E=
X-Gm-Gg: Acq92OHFMfhmcsDjfq34Aoky9uF+BeyUbzq8Ja+dsAtUkW1XvZMMcKWHTRhvQTZQ5Jv
	Ij6l0jbxODrMYRbNxCa2kFXpyaRjOXYX+lIHhNgu2O4v3XLPatooX+MkAog975W7ols6VJyZ9tt
	cETsvqeMav71NJzNltDsyw4Nq/fl/17DzGfE1koTJ97E8B3KoI7Ib9ntxFvTRGlRka5WP0zOvew
	VV7kRd9xKVVPZPjK0UBGxGXus2TnPJix3yIgsChADVrk8egt2CDr+zzH9f6x/E4Gj1nrRiTouey
	KTGn8cKHaAto1MEklNc4pdq6u4EzuJ5kLDgnnYpEWvRu36iKtGWb8+OQOirCmveLgWLX/FLs5qL
	eZ3Lw+OrqunwyocU/merbrhBnxaodFAcmaFLcSYfyF9stY0WGWxx9ObSi9B1r0hDlDEZggNosqK
	/1a4cBp1MD5dDARNhdcpcuzFY0qg9Q1YuhYucVtZ3z5jCcKbG0Lt24ZOm0kn29AVl1mxcQ7eSP
X-Received: by 2002:a05:620a:45a4:b0:913:7bc8:79b4 with SMTP id af79cd13be357-914b49f711dmr3312535085a.51.1779892899207;
        Wed, 27 May 2026 07:41:39 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86fbce3sm487939485a.11.2026.05.27.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:41:38 -0700 (PDT)
Date: Wed, 27 May 2026 14:41:37 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, "Heyne, Maximillian" <mheyne@amazon.de>, 
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Praveen Kumar <kpraveen.lkml@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"Woodhouse, David" <dwmw@amazon.co.uk>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Jork Loeser <jloeser@linux.microsoft.com>, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [Hypervisor Live Update] Notes from May 18, 2026
Message-ID: <ahcCXlbbnsxUAfeb@plex>
References: <ahXiYGo-IWI94IVP@google.com>
 <CALzav=dkVWYmbWCO6wDuQrxetAcqYkitJiRF_BhDDGqn2_-RKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dkVWYmbWCO6wDuQrxetAcqYkitJiRF_BhDDGqn2_-RKA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_074140_980050_C686D9E1 
X-CRM114-Status: GOOD (  15.11  )
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

On 05-26 11:53, David Matlack wrote:
> On Tue, May 26, 2026 at 11:37 AM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> 
> > Next meeting will be on Monday, June 1 at 8am PDT (UTC-7), everybody is
> > welcome: https://meet.google.com/rjn-dmzu-hgq
> >
> > Topics for the next meeting:
> > - Vipin and David Matlack roadmap for PCI and VFIO changes to solicit
> >   upstream feedback
> 
> Hey Pasha,
> 
> We'll need to push this back by one meeting (June 15th) due to the US
> holiday and some out-of-office leave we didn't account for.

Understood. We will address this on June 15th.

Thank you,
Pasha

> 
> > - Status of I/O freezing implementations and HugeTLB fallback allocation
> >   patches
> > - PCI core changes v6 review and next steps
> > - IOMMU persistence v3 and roadmap progress
> > - Updates on vm_splice investigations for CRIU memory preservation
> > - later: KHO support for Confidential VMs including page table
> >   preservation and pinning
> > - later: versioning support for luo to negotiate
> > - later: KHO enlightenment for ASI
> > - later: testing methodology to allow downstream consumers to qualify
> >   that live update works from one version to another
> > - later: reducing blackout window during live update

