Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D562FC636CC
	for <kexec@archiver.kernel.org>; Tue,  7 Feb 2023 03:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6nvzagra8B8AE21x9bRWxJk3tXSDWms+OlqrjydiKs=; b=mF4cA7mnPD4Cv1
	vSHeSnZmq4/xLBp5jxt8M62XuQ676iYnANwfqww1cEoJHmWLJPAfdHPQ2OQTtQORTSRRj8YhghfiS
	huX9uotSdJ+zSapivLf9G86HrkP8osj/SMzkjXxQRERqd0FOi2uQXRH2ujrRwS8UF1+QEbbwFkcLO
	x84/HRptpHYW9Z+CsxenBbaeBqQdMmOloKNPhIdhKdasL9gZwDBCBLA4sG2YG1tQ/3BlyloVTJNM/
	z2IqokPVHycwUagHemReEeVCQKXuRXaNNJB1GuwvbEuhBFC+dH8Mxi3I9GpQozooO+tgk8MkmesXY
	Ofr/i+VVSKCcUaaZVjmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPF8w-00Ahc7-5z; Tue, 07 Feb 2023 03:59:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPF8t-00Ahaz-8w
	for kexec@lists.infradead.org; Tue, 07 Feb 2023 03:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675742374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0p27cbppODhlJwN0bXzqedqZnAVkCEQHc1O/mLg04Ro=;
	b=arBDndeclV3UNTC+pnzxJ/pKmt7Pd322hKBBl/BCAxB/ece3lRifMAd+AHERr8xxcIjwqp
	9gZnjFyphflhJ6wfGACO+DgAGFA1B4ZtA92MSVB5xgrnJ9pSVZg9UP1YXWocHs+lUwREYo
	+dBWLY6UV5W1a6rGQdi/PZCsq9n0CQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-lo_UqUuCNx6qqsXgSxrnPw-1; Mon, 06 Feb 2023 22:59:30 -0500
X-MC-Unique: lo_UqUuCNx6qqsXgSxrnPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AC6685CBE0;
	Tue,  7 Feb 2023 03:59:30 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C7CE1121314;
	Tue,  7 Feb 2023 03:59:28 +0000 (UTC)
Date: Tue, 7 Feb 2023 11:59:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org
Subject: Re: [PATCH v2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y+HMnP9Yxi4C7KzF@MiWiFi-R3L-srv>
References: <20230203075723.114538-1-bhe@redhat.com>
 <Y91JV7wNu1QQh1Ag@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y91JV7wNu1QQh1Ag@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_195939_596995_A8B4B053 
X-CRM114-Status: GOOD (  30.19  )
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

On 02/03/23 at 05:50pm, Catalin Marinas wrote:
> On Fri, Feb 03, 2023 at 03:57:23PM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> > 
> > While we observed an unexpected case where a reserved region crosses the
> > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > The crossing 4G boudary of crashkernel high region will bring issues:
> > 
> > 1) For crashkernel=x,high, if getting crashkernel high region across
> > 4G boudary, then user will see two memory regions under 4G, and one
> > memory region above 4G. The two crashkernel low memory regions are
> > confusing.
> 
> Looking at your patch, I just realised that the 4G boundary between
> 'low' and 'high' reservations is not always true. On RPi4, that would be
> 1GB, the limit of ZONE_DMA. Are there user-space tools that rely on this
> 32-bit boundary? If they do, they'd get confused on RPi4, not sure they
> have the notion of the actual ZONE_DMA that the kernel has enabled. If
> we do want ,high to mean always 4G or higher, we'd need to change the
> logic a bit so that the search_base starts from 4G rather than
> CRASH_ADDR_LOW_MAX. We could leave the latter when ,high was not
> specified.

Oh, there could be misunderstanding here. In the current arm64, the
boundary of high memory and low memory is CRASH_ADDR_LOW_MAX. It means
on RPi4, it's 1G. While on all other systems, it's 4G. I use 4G as
boundary in patch log, because systems I know and kdump need support are
all product systems at work, e.g system in baremetal server, or guest
instance in cloud. Sorry for that, with the current crashkernel handling
code in arm64, we should cover RPi4 too so that any description is kept
consistent with code implementation.

I took 4G mainly because I took it as an example people can easily
understand. I should use a generic term. So RPi4 still uses 1G as
boundary of high and low memory.

Talking about RPi4, how do you think about my below patchset? I replied
to you in another mail to ask you for help to check below patchset, and
decide which solution we should take to address the base page mapping
for the whole system when crashkernel is set. That mail could be missed.

https://lore.kernel.org/all/Y9zaJim2oGgXMiOS@MiWiFi-R3L-srv/T/#u
==
arm64, kdump: enforce to take 4G as the crashkernel low memory end
https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u


> 
> > 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> > and y <= 128M, when crashkernel high region crosses 4G boudary and the
> > part below 4G of crashkernel high reservation is bigger than y, the
> > expected crahskernel low reservation will be skipped. But the expected
> > crashkernel high reservation is shrank and could not satisfy user space
> > requirement.
> 
> I guess if the user passes both high and low, we should honour that and
> ignore any y <= 128M checks.

Yes, agree. In this v2 patch and the earlier v1, the 'y<=128M' checking
has been removed.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
