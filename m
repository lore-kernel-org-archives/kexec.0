Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CCC4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aMvoTPfIK0bdm1EopgF5thkKcvZjiuhDI5eiKwUoMtg=; b=kY+1wLKtPhIyVs
	Ro1TA3ERR3rMe86jx61yTPkuWIMAbiK5TNg5/wSpEgvd5gjDGl4CUC9eOS1YiMY+KSxCbpJfkYzBI
	4TO+cz2uoEKp4nR+UbO9iiSzWd3A2doGhdQo5gDoz2oJs1bO8a5ne9a/heHyOA9aE6yxPU3f6JYlt
	MOQkUbU9tKgoFo5dQJNgg0hC4BjzPGouOLR+i7796Q6haoiTl3djhWmYsreeMloDR7FMkkQlWdZq2
	RRuSIEG7wUyiYoyTLoE3VqI8TZnmfTI043oMPUHn4u6cEUodvpGoqGwVTS3g1cZtUhqHlMoxwgNUf
	bl+ivAmLDkGCzp/a0qtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Ff7-007QgP-02;
	Wed, 29 Nov 2023 08:11:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Ff0-007Qg2-11
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 08:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701245465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BC4uggJfBcsQ9J288hcUReQwagRBB7yxUyX9PfI8YC4=;
	b=Zbo9zvev7oFvm294f+v4IH86pHHhCvESUodlMtyx5pEhNBXk1VK8ZqETc0UPbpYMRK/WIT
	MPaQvzxPUSlLTvxrznQa9kk9XB9pFthmSPTg/mMx9/12n/tLu8Rghb6guxnh8oZC39k1eh
	cq81ZhPAl+Bp2WASZQ1yuRtMRI3AwdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-Di-Svtm0OSiYAyIeYfDUdQ-1; Wed, 29 Nov 2023 03:11:00 -0500
X-MC-Unique: Di-Svtm0OSiYAyIeYfDUdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 103B18058EE;
	Wed, 29 Nov 2023 08:11:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5857D1C060AE;
	Wed, 29 Nov 2023 08:10:59 +0000 (UTC)
Date: Wed, 29 Nov 2023 16:10:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>, ddutile@redhat.com
Cc: Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWWuBSiZZdF2W12j@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_001106_448663_C8B7B79B 
X-CRM114-Status: GOOD (  32.57  )
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

On 11/28/23 at 10:08am, Michal Hocko wrote:
> On Tue 28-11-23 10:11:31, Baoquan He wrote:
> > On 11/28/23 at 09:12am, Tao Liu wrote:
> [...]
> > Thanks for the effort to bring this up, Jiri.
> > 
> > I am wondering how you will use this crashkernel=,cma parameter. I mean
> > the scenario of crashkernel=,cma. Asking this because I don't know how
> > SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> > driver will be filter out? If latter case, It's possibly having the
> > on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> > reset during kdump bootup because the NIC driver is not loaded in to
> > initialize. Not sure if this is 100%, possible in theory?
> 
> NIC drivers do not allocation from movable zones (that includes CMA
> zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
> RDMA drivers might and do transfer from user backed memory but for that
> purpose they should be pinning memory (have a look at
> __gup_longterm_locked and its callers) and that will migrate away from
> the any zone.

Add Don in this thread.

I am not familiar with RDMA. If we reserve a range of 1G meory as cma in
1st kernel, and RDMA or any other user space tools could use it. When
corruption happened with any cause, that 1G cma memory will be reused as
available MOVABLE memory of kdump kernel. If no risk at all, I mean 100%
safe from RDMA, that would be great.

>  
> [...]
> > The crashkernel=,cma requires no userspace data dumping, from our
> > support engineers' feedback, customer never express they don't need to
> > dump user space data. Assume a server with huge databse deployed, and
> > the database often collapsed recently and database provider claimed that
> > it's not database's fault, OS need prove their innocence. What will you
> > do?
> 
> Don't use CMA backed crash memory then? This is an optional feature.
>  
> > So this looks like a nice to have to me. At least in fedora/rhel's
> > usage, we may only back port this patch, and add one sentence in our
> > user guide saying "there's a crashkernel=,cma added, can be used with
> > crashkernel= to save memory. Please feel free to try if you like".
> > Unless SUSE or other distros decides to use it as default config or
> > something like that. Please correct me if I missed anything or took
> > anything wrong.
> 
> Jiri will know better than me but for us a proper crash memory
> configuration has become a real nut. You do not want to reserve too much
> because it is effectively cutting of the usable memory and we regularly
> hit into "not enough memory" if we tried to be savvy. The more tight you
> try to configure the easier to fail that is. Even worse any in kernel
> memory consumer can increase its memory demand and get the overall
> consumption off the cliff. So this is not an easy to maintain solution.
> CMA backed crash memory can be much more generous while still usable.
> -- 
> Michal Hocko
> SUSE Labs
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
