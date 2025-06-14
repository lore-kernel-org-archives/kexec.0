Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3A0C71135
	for <kexec@archiver.kernel.org>; Sat, 14 Jun 2025 02:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fot5AeEWiVU6mEehA0HZNADyzIBvWxOueVJ+HmCquDQ=; b=hgNJqx4EmUi0wYSDEbDVKAcdIU
	fZrxeRtTi2eT0ypdRAFlJ4XJi/52rVW3+J8ldIKOSI9hgyBRlUQFd/9D+jlY5jnl721XuHNt4VvrE
	geoLaJV+U11XJaU3VmWCD0bEhSXcYxNx5ntqLT6DX6qPuqox6ZFScA6UjDwOTK6oVkn01B9lqHh/1
	Jdxk/1FV05mDLEUIvzfsZvbDP88gNajLUROa2NmHalXPMW/ZzD25Y2PhW7WFZRqeZNcUogk/5Qhag
	H3VE+7R5cog0YDUyS6g59+JbG3qL1fWlBXcbZ/ccFmWMJnouysboeezDxsqeKqZLYE9WCLzjEn/aD
	W2IF/sWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQGqN-00000000YG3-1S2s;
	Sat, 14 Jun 2025 02:42:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQGqK-00000000YFG-3daH
	for kexec@lists.infradead.org;
	Sat, 14 Jun 2025 02:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749868923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fot5AeEWiVU6mEehA0HZNADyzIBvWxOueVJ+HmCquDQ=;
	b=bpQy4776cymXAZQGJ4KBTM0JWDqdfmqrToc9QaWFYJcpoUVWCpuEp1sDnKI7jzWAGNbldt
	ue6/G8QQk+jbiycfMjhYcShPPDGlle+2jkj78wIkOWHXerAtvRLbilTnBGiKQskLnjFZXk
	NVuISaFPEm7LpmQVxHiDONCYaBBlNT8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-aAiGCthtNGKAS6LSTCSzKA-1; Fri,
 13 Jun 2025 22:42:01 -0400
X-MC-Unique: aAiGCthtNGKAS6LSTCSzKA-1
X-Mimecast-MFC-AGG-ID: aAiGCthtNGKAS6LSTCSzKA_1749868920
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E2FB19560B2;
	Sat, 14 Jun 2025 02:41:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F9EA1956094;
	Sat, 14 Jun 2025 02:41:56 +0000 (UTC)
Date: Sat, 14 Jun 2025 10:41:52 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Bohac <jbohac@suse.cz>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aEzhcIouq6OfJAF6@MiWiFi-R3L-srv>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <aEqpgDIBndZ5LXSo@dwarf.suse.cz>
 <20250612164735.76a1ea9a156cd254331ffdc4@linux-foundation.org>
 <925cdfc4-7878-4572-9a4d-9b99d149a652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925cdfc4-7878-4572-9a4d-9b99d149a652@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_194204_979226_21649044 
X-CRM114-Status: GOOD (  30.07  )
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

On 06/13/25 at 11:19am, David Hildenbrand wrote:
> On 13.06.25 01:47, Andrew Morton wrote:
> > On Thu, 12 Jun 2025 12:18:40 +0200 Jiri Bohac <jbohac@suse.cz> wrote:
> > 
> > > When re-using the CMA area for kdump there is a risk of pending DMA
> > > into pinned user pages in the CMA area.
> > > 
> > > Pages residing in CMA areas can usually not get long-term pinned and
> > > are instead migrated away from the CMA area, so long-term pinning is
> > > typically not a concern. (BUGs in the kernel might still lead to
> > > long-term pinning of such pages if everything goes wrong.)
> > > 
> > > Pages pinned without FOLL_LONGTERM remain in the CMA and may possibly
> > > be the source or destination of a pending DMA transfer.
> > > 
> > > Although there is no clear specification how long a page may be pinned
> > > without FOLL_LONGTERM, pinning without the flag shows an intent of the
> > > caller to only use the memory for short-lived DMA transfers, not a transfer
> > > initiated by a device asynchronously at a random time in the future.
> > > 
> > > Add a delay of CMA_DMA_TIMEOUT_SEC seconds before starting the kdump
> > > kernel, giving such short-lived DMA transfers time to finish before
> > > the CMA memory is re-used by the kdump kernel.
> > > 
> > > Set CMA_DMA_TIMEOUT_SEC to 10 seconds - chosen arbitrarily as both
> > > a huge margin for a DMA transfer, yet not increasing the kdump time
> > > too significantly.
> > 
> > Oh.  10s sounds a lot.  How long does this process typically take?
> > 
> > It's sad to add a 10s delay for something which some systems will never
> > do.  I wonder if there's some simple hack we can add.  Like having a
> > global flag which gets set the first time someone pins a CMA page

I have the same worry as Andrew. One system run off rails, we don't try
to slam the brake, but wait 10 seconds instead to do that. Lucky we have
noticed people the risk.

> 
> We would likely have to do that for any GUP on such a page (FOLL_GET |
> FOLL_PIN), both from gup-fast and gup-slow.

There could be such GUP page, not always? This feature is an opt-in for
users, they can decide or tune the waiting time too?

My personal opinion. I will not suggest people to use it in RHEL, while
other people feel free to try it as the risk has been warned.

> 
> Should work, but IMHO can be optimized later, on top of this series.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


