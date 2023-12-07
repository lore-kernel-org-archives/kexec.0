Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C820C4167B
	for <kexec@archiver.kernel.org>; Thu,  7 Dec 2023 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S+Uy96THQiVzgqN1p2PqlUKpQF/EgqeH012GgTzec8c=; b=t/GvGNqqLlCi1H
	MLCqAoKrBzRKcywxInSGre1Cwganv2z74nkz0vwEZSf3UFcOkETMVSFzD5AH91FRT07V2aiv7Mh3U
	5BXou7E1efE1KH72WpVs/KrMGZKv24DduF9bQzmoxqjxENWPYiQDuYiSUjWmNLcHdEcLZTIdYouV6
	dNgjJIhwRL40GfleWMZ+ctrdlt1lmPVLemPWFfvA3boazY8s2welXoihrHknsO3Jt85eGUWJnD8Ik
	iYyu4c3+hqfHMSWqstbUhMN4CacJYDSa3M/1AgFwOMrkrVyGYyX5EtLBf68TqszU7LLiCzP3Kmj8L
	uM3QASxXjT//Ep6l+9/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB5v2-00BpeU-1o;
	Thu, 07 Dec 2023 04:23:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB5uz-00BpdQ-0T
	for kexec@lists.infradead.org;
	Thu, 07 Dec 2023 04:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701922999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ulgd6APR6tJoXOtI6Z0BNkxh6DNgXO1Xqt99EIAg7hA=;
	b=gGr+mrv8+MYsZgtxt4J7acAQ1K3NCvrbSxLkxlGxubGlrETZYKLn2M/A8WIBuVthQy/NY8
	dTq38LJxAsRgkJKPjObAk5ElV24BBKcp7iaejjqtOoQXDmeuAttqC6S4E0s4DLpVpoJLFo
	15lKYgSRrDVjSBj4Iq/k8aK21iIk3CA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-SiG50LfSPIKl9dSEpEVupw-1; Wed,
 06 Dec 2023 23:23:17 -0500
X-MC-Unique: SiG50LfSPIKl9dSEpEVupw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37C781C05AE8;
	Thu,  7 Dec 2023 04:23:17 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C10C8CD0;
	Thu,  7 Dec 2023 04:23:16 +0000 (UTC)
Date: Thu, 7 Dec 2023 12:23:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
References: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXCRF-bvm8ijXxr4@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_202321_258150_3F454B4E 
X-CRM114-Status: GOOD (  26.62  )
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

On 12/06/23 at 04:19pm, Michal Hocko wrote:
> On Wed 06-12-23 14:49:51, Michal Hocko wrote:
> > On Wed 06-12-23 12:08:05, Philipp Rudo wrote:
> [...]
> > > If I understand Documentation/core-api/pin_user_pages.rst correctly you
> > > missed case 1 Direct IO. In that case "short term" DMA is allowed for
> > > pages without FOLL_LONGTERM. Meaning that there is a way you can
> > > corrupt the CMA and with that the crash kernel after the production
> > > kernel has panicked.
> > 
> > Could you expand on this? How exactly direct IO request survives across
> > into the kdump kernel? I do understand the RMDA case because the IO is
> > async and out of control of the receiving end.
> 
> OK, I guess I get what you mean. You are worried that there is 
> DIO request
> program DMA controller to read into CMA memory
> <panic>
> boot into crash kernel backed by CMA
> DMA transfer is done.
> 
> DIO doesn't migrate the pinned memory because it is considered a very
> quick operation which doesn't block the movability for too long. That is
> why I have considered that a non-problem. RDMA on the other might pin
> memory for transfer for much longer but that case is handled by
> migrating the memory away.
> 
> Now I agree that there is a chance of the corruption from DIO. The
> question I am not entirely clear about right now is how big of a real
> problem that is. DMA transfers should be a very swift operation. Would
> it help to wait for a grace period before jumping into the kdump kernel?

On system with hardware IOMMU of x86_64, people finally had fixed it
after very long history of trying, arguing. Until 2014, HPE's engineer came
up with a series to copy the 1st kernel's iommu page table to kdump
kernel so that the on-flight DMA from 1st kernel can continue
transferring. Later, these attempts and discussions were converted codes
into mainline kernel. Before that, people even tried to introduce
reset_devices() before jumping to kdump kernel. But that was denied
immediately because any extra unnecessary actions could cause uncertain
failure of kdump kernel, given 1st kernel has been in an unpredictable
unstable situation.

We can't guarantee how swift the DMA transfer could be in the cma, case,
it will be a venture.

[3]
[PATCH v9 00/13] Fix the on-flight DMA issue on system with amd iommu
https://lists.openwall.net/linux-kernel/2017/08/01/399

[2]
[PATCH 00/19] Fix Intel IOMMU breakage in kdump kernel
https://lists.openwall.net/linux-kernel/2015/06/13/72

[1]
[PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy DMA/IO
https://lkml.org/lkml/2014/4/24/836

> 
> > Also if direct IO is a problem how come this is not a problem for kexec
> > in general. The new kernel usually shares all the memory with the 1st
> > kernel.
> 
> This is also more clear now. Pure kexec is shutting down all the devices
> which should terminate the in-flight DMA transfers.

Exactly. That's what I have been noticing in this thread.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
