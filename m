Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9DC83F27
	for <kexec@archiver.kernel.org>; Tue, 15 Jul 2025 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJNrGnddCS+K+I/ghI3UvfktypplC8pV6M7MGR0tlpY=; b=SvLqNeyrgovxxYNHKTffYiRMMi
	YZiT2GG8AxThaln2NuAzTQq/Fr7h4hjgW/UOK+IYPHb1YLHhmO+Yky82yhRCd7IrpwELQ/lYpjXLT
	4yxvkTNoIdrPQvhnL9Phhta1NLP9Uejg0/wMuNNq/Wnl2Ke63RqUzo3/WhTYT1SoSJyrHvwDdmdHa
	KHeJ+2u7bxfkn4hPUzwiFZqeehFUunkb/p/z2lnAR3/+d5m4AGoLTauqMqKG+XkWczhFCbUNKT8XV
	cZVlE+dMXxnxzMYKNjV3vPrj6YoHXBNjLFI+lZ8rperbYlbTrOR4wC2NFR+2roESuDizqDKEF+wZC
	inJhFndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubZLX-00000004Eg0-3sZa;
	Tue, 15 Jul 2025 06:40:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubZI5-00000004EBw-2I8G
	for kexec@lists.infradead.org;
	Tue, 15 Jul 2025 06:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752561443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJNrGnddCS+K+I/ghI3UvfktypplC8pV6M7MGR0tlpY=;
	b=dZ4xaHNYWHNTYGYvUbIOiZWKKiRqjEFseBX1lAcJbqX/9XmYQeox2Gga2pkezlIPuVn6mJ
	OhegEzZp4LnYgWklDD1pEsCIT5dh4KDf35NEOzzha/V5TIHWm47KgxoOPPzuYTUZrSIDkg
	9U15Yeab6oBGc3rT7NC3T4NayOwmFmg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-Y2ABCGivMxinmS1AsXatdQ-1; Tue,
 15 Jul 2025 02:37:19 -0400
X-MC-Unique: Y2ABCGivMxinmS1AsXatdQ-1
X-Mimecast-MFC-AGG-ID: Y2ABCGivMxinmS1AsXatdQ_1752561437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D71671801233;
	Tue, 15 Jul 2025 06:37:16 +0000 (UTC)
Received: from localhost (unknown [10.72.112.210])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62AE2180174E;
	Tue, 15 Jul 2025 06:37:13 +0000 (UTC)
Date: Tue, 15 Jul 2025 14:37:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Askar Safin <safinaskar@zohomail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: regressions <regressions@lists.linux.dev>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	kexec <kexec@lists.infradead.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	iommu <iommu@lists.linux.dev>, Ben Hutchings <benh@debian.org>,
	anushasrivatsa <anusha.srivatsa@intel.com>,
	joonaslahtinen <joonas.lahtinen@linux.intel.com>,
	tvrtkoursulin <tvrtko.ursulin@linux.intel.com>,
	josesouza <jose.souza@intel.com>,
	davehansen <dave.hansen@linux.intel.com>
Subject: Re: Second kexec_file_load (but not kexec_load) fails on i915 if
 CONFIG_INTEL_IOMMU_DEFAULT_ON=n
Message-ID: <aHX3FSMif/LDmTtq@MiWiFi-R3L-srv>
References: <197d1dc3bff.c01ddb9024897.1898328361232711826@zohomail.com>
 <cd3ca680ac5751368941713c1071e04d69544d47@intel.com>
MIME-Version: 1.0
In-Reply-To: <cd3ca680ac5751368941713c1071e04d69544d47@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x5wApntfM29U2gDwRGLedYYu-dRc7JfyEqttes2_lYA_1752561437
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_233725_721160_3289E8F8 
X-CRM114-Status: GOOD (  16.06  )
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

On 07/04/25 at 11:29am, Jani Nikula wrote:
> On Thu, 03 Jul 2025, Askar Safin <safinaskar@zohomail.com> wrote:
> > TL;DR: I found a bug in strange interaction in kexec_file_load (but not kexec_load) and i915
> > TL;DR#2: Second (sometimes third or forth) kexec (using kexec_file_load) fails on my particular hardware
> > TL;DR#3: I did 55 expirements, each of them required a lot of boots, in total I did 1908 boots
> 
> Thanks for the detailed debug info. I'm afraid all I can say at this
> point is, please file all of this in a bug report as described in
> [1]. Please add the drm.debug related options, and attach the dmesgs and
> configs in the bug instead of pointing at external sites.

Yeah, that's very great example people can refer to when reporting
issues to upstream, thanks for the details.

For the bug itself, I would hope Intel GPU people can have a look, see
what's happened and how to fix. For kexec reboot, we have got problems
on Nvidia GPU and amdgpu which makes kexec reboot hard to do continuous
switching to 2nd kernel. In Redhat, we have met this several years ago,
and we tried to contact GPU dev, while there's no way to fix it. Finaly
we have to declare not supporting kexec reboot formally. This Intel GPU
issue could be a different one, I still hope GPU dev can have a look.

Currently, many people are investing much effort on KHO, K-state, etc
in upstream to make kexec reboot versatile and flexible. I am very glad
to see that. And I guess people possiblly have met the same GPU issues on
Nvidia and AMD gpu as I mentioned, and trying to solve them. Otherwise,
no matter how wonderful KHO, K-state or K-anything are, they are just sky
scraper on sand.

Personal opinion.

Thanks
Baoquan


