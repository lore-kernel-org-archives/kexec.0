Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85248C52D7C
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BDdSMyMaRnyeIyDmDpBPBwovKTeal1X272EVDgS+0Sc=; b=BM5kS0/wUSEG5Q
	DCslR4knuUdV6w5d00NWlEFf+rGAYF6hXQrHja++HiCQTBje8uv74TkdFtfcp5bFsO7M70H20RbiM
	sfE7lw+D3Po9oscsUaT9ozY5usQW5Ip+utY0SrRD5hyQwtm+aXNNo65DiXV9hIyVK0eBUcIyIGQ+Q
	MNluujW7flOaI2trk8vWnKKm60BXpaR2TBJ4eYWF5ZqHr6OVFqHiVQgGsSAq9LXdUZPrOH2PHhs+S
	RcNHtJTjCxyGKeZDWRzdAqYF0lRKyl/2sJFCHRFC6QpEXPmWnEu1PBQToAqLJdSECwkm50khlDZO6
	7DkBSCqi1DUQasvZ0aqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdnea-000000036pg-0RBz;
	Tue, 13 Aug 2024 09:17:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdneX-000000036oy-3A7N
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 09:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723540636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3dzzkihmU0oWgDbdzaqrXfn8l2l+YCCSlKhwcKDVXU=;
	b=VxRZdvA2CXqkWBo8pp70yYwlB7Z8iD7SAk62UkAcwpaMaW8qiynwD/WRElHvcFn3D3wzdj
	h2ZMjfdPEI5Y6CONH+J4OTmtzRzQiRzkECgWa62WmedzWQ3m9Zg986gVi8smDB1BxdlS9t
	omBHeCf7O4Kg3Q7w7/deWuCt4yOnBDQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-tGbMoIq-NCG48YYwgfgsAA-1; Tue,
 13 Aug 2024 05:17:13 -0400
X-MC-Unique: tGbMoIq-NCG48YYwgfgsAA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0EB11954B0E;
	Tue, 13 Aug 2024 09:17:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BB43001FC3;
	Tue, 13 Aug 2024 09:17:08 +0000 (UTC)
Date: Tue, 13 Aug 2024 17:17:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
Message-ID: <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
 <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_021717_885735_0C28821A 
X-CRM114-Status: GOOD (  14.43  )
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

On 08/13/24 at 10:58am, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 13/08/24 10:34, Baoquan He wrote:
> > On 08/12/24 at 09:46am, Sourabh Jain wrote:
> > ......
> > > ---
> > > 
> > > Changelog:
> > > 
> > > Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
> > >    - Update crash_hotplug sysfs document as suggested by Petr T
> > >    - Update an error message in crash_handle_hotplug_event and
> > >      crash_check_hotplug_support function.
> > > 
> > > ---
> > ......
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 63cf89393c6e..c1048893f4b6 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
> > >   	crash_hotplug_lock();
> > >   	/* Obtain lock while reading crash information */
> > >   	if (!kexec_trylock()) {
> > > -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > > +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> > Wondering why this need be updated.
> 
> In some architectures, additional kexec segments become obsolete during a
> hotplug event,
> so simply calling out the `elfcorehdr may be inaccurate` may not be
> sufficient.
> Therefore, it has been generalized with the kdump image.

OK, I forgot the case in ppc, makes sense to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
