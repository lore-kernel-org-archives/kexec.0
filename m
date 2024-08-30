Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C76CA0EE1
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 06:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fg2WDSGwp2SC5e6fQjziQnPMesORdEFJuwuFz6W4Nnc=; b=NnTTJhWFwwetjn
	wOXSS7iFa4kIGM91BY9n6Es8PvFWeWZrAEc2T89xwd/85cJ2+rNaJyV+XXN8NrNsVTYlCcs+Lj1sg
	JHxpqV7aegF4SspvNw5fkcQKKOKJuRWP0rI44QMShWGNGmbrmmvOxDS0zB1ROGWBb1CXdiFJAEeJ5
	516WxyRmBHuvZPqaMmJwBcmZNMBCjnTkcf0GDPdvZZ7fH2kojrGmGQQddrUkVA1dea8v/3ZfbFH7C
	+ddqVihEuOLuUGu40apRRn3B0TzR/T6A0jOF8OQ+j+l+tNXrHZxFZNoDTfLsvA8oQIrLwIBu5X646
	YUY7rP8Hi/u9WR/IogUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjv9z-00000004xi1-3DRr;
	Fri, 30 Aug 2024 06:31:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjv9x-00000004xha-09e2
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 06:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724999458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rxQOV0U9jos/ewQUlBldN7ZSJbrE3k5eVCijlLXnUk=;
	b=bpN9Li1t7xMvRTpMqP0BBSRWa7VgakCU1hfgKDVxKX0pieF6T9H3Nu94NJYvvFRPI0CZq4
	O8tHQXfFIwpmLUDcVAz5MCWnMB7rJUHFLtTNq0wAQUbRVtNFeRv51tr6bz0ZS73eM3MPGE
	ERr2YW4NiWvjRLCg2arRkJJRJgPPr3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-u30SmAoyMdqFmu6gfgZuwQ-1; Fri,
 30 Aug 2024 02:30:53 -0400
X-MC-Unique: u30SmAoyMdqFmu6gfgZuwQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AC2E19560B1;
	Fri, 30 Aug 2024 06:30:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3990E1955F35;
	Fri, 30 Aug 2024 06:30:48 +0000 (UTC)
Date: Fri, 30 Aug 2024 14:30:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
Message-ID: <ZtFnFaHfh09wOw6o@MiWiFi-R3L-srv>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
 <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_233101_165147_30592EF4 
X-CRM114-Status: GOOD (  12.50  )
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

On 08/29/24 at 11:37pm, Dave Vasilevsky wrote:
> On 2024-08-29 23:15, Baoquan He wrote:
> >> +config ARCH_DEFAULT_CRASH_DUMP
> >> +	def_bool n
> > 
> > If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
> > CRASH_DUMP will be off by default according to the below new definition
> > of CRASH_DUMP?
> 
> Yes, that's true. But if we don't add it at all in sh arch, it looks confusing
> in the search feature of menuconfig:
> 
> > Symbol: ARCH_DEFAULT_CRASH_DUMP [=ARCH_DEFAULT_CRASH_DUMP]
> > Type  : unknown
> 
> So I thought it was better to explicitly set it to 'n'. What do you think?

If so, better adding it. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
