Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22894C4167B
	for <kexec@archiver.kernel.org>; Thu,  7 Dec 2023 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hMu3kdKypjB8QC0Gcxj2gMzFlXn4WaGWUHSK7qqViSk=; b=fqVgGbb1OZjcaX
	KZyOST1wiIGuyJ0283s9oiSKAiRipOxB8MEJJBFn/otIwE6LdjUBo+6KHm9ph28j8p2zIsKSCAN3M
	ieOa/cxcnnZudXoxMOYnG+DlmFTSCGAWPuayxDZ7/tutwHPK82b/Sl2toWdhytpJo6j+RS9boO5W9
	xJoJwehOWVIID9tFxjG5F38jzhM3TX4yILyyOJj6qQlv3puE4h9MQymTGCN9UUfYXjztIKKSpRy+u
	n6Wcj7RYOh7rhheEG//q/5+LSH+JT5bmuKblLbJjVt9TpfSiCnNFhufZ6sjBaX7M9dBscs6xUewJt
	iaHULAuDDHNwig0CYSxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBCJq-00CXjf-1A;
	Thu, 07 Dec 2023 11:13:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBCJn-00CXjC-0p
	for kexec@lists.infradead.org;
	Thu, 07 Dec 2023 11:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701947601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9AlbuKp6i4vZhZFTL2Nt/u/GlI5HW0Gg0C26t4Adtk=;
	b=Pk8wM+NRTLszGRGgB9SHfhz6e9j+3ct82ASVEIUj5Dtbs/eU6USvEqGjKNuVBpqF0NWRAB
	VeRWPuctEQQwtB/KuVt/9ujs8Hn1kQU5cylIjGOA26oUmC5MsywRTrfvoUoBH6ox3mz+C0
	NAasApB1QO+mWBj7HG5kLpdyN9b2+kU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-LyxVm7zXOSSDw9WNAilHjQ-1; Thu,
 07 Dec 2023 06:13:18 -0500
X-MC-Unique: LyxVm7zXOSSDw9WNAilHjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A7B23C2A1C5;
	Thu,  7 Dec 2023 11:13:17 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15F0A2026D66;
	Thu,  7 Dec 2023 11:13:15 +0000 (UTC)
Date: Thu, 7 Dec 2023 12:13:14 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>, Jiri
 Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>, Tao Liu
 <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231207121314.50b8e4c4@rotkaeppchen>
In-Reply-To: <ZXGIeAgCcatUDa2h@tiehlicka>
References: <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
	<ZWiQ-II9CvGv8EWK@tiehlicka>
	<20231201123353.2b3db7fa@rotkaeppchen>
	<ZWnJyArAmFo_uYPA@tiehlicka>
	<20231201165113.43211a48@rotkaeppchen>
	<ZWoQ1k2AikSiMjys@tiehlicka>
	<20231206120805.4fdcb8ab@rotkaeppchen>
	<ZXB7_rbC0GAkIp7p@tiehlicka>
	<ZXCRF-bvm8ijXxr4@tiehlicka>
	<ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
	<ZXGIeAgCcatUDa2h@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_031323_381627_77D1F69B 
X-CRM114-Status: GOOD (  27.89  )
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

On Thu, 7 Dec 2023 09:55:20 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Thu 07-12-23 12:23:13, Baoquan He wrote:
> [...]
> > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > it will be a venture.  
> 
> We can't guarantee this of course but AFAIK the DMA shouldn't take
> minutes, right? While not perfect, waiting for some time before jumping
> into the crash kernel should be acceptable from user POV and it should
> work around most of those potential lingering programmed DMA transfers.

I don't think that simply waiting is acceptable. For one it doesn't
guarantee that there is no corruption (please also see below) but only
reduces its probability. Furthermore, how long would you wait?
Thing is that users don't only want to reduce the memory usage but also
the downtime of kdump. In the end I'm afraid that "simply waiting" will
make things unnecessarily more complex without really solving any issue.

> So I guess what we would like to hear from you as kdump maintainers is
> this. Is it absolutely imperative that these issue must be proven
> impossible or is a best effort approach something worth investing time
> into? Because if the requirement is an absolute guarantee then I simply
> do not see any feasible way to achieve the goal of reusable memory.
> 
> Let me reiterate that the existing reservation mechanism is showing its
> limits for production systems and I strongly believe this is something
> that needs addressing because crash dumps are very often the only tool
> to investigate complex issues.

Because having a crash dump is so important I want a prove that no
legal operation can corrupt the crashkernel memory. The easiest way to
achieve this is by simply keeping the two memory regions fully
separated like it is today. In theory it should also be possible to
prevent any kind of page pinning in the shared crashkernel memory. But
I don't know which side effect this has for mm. Such an idea needs to
be discussed on the mm mailing list first.

Finally, let me question whether the whole approach actually solves
anything. For me the difficulty in determining the correct crashkernel
memory is only a symptom. The real problem is that most developers
don't expect their code to run outside their typical environment.
Especially not in an memory constraint environment like kdump. But that
problem won't be solved by throwing more memory at it as this
additional memory will eventually run out as well. In the end we are
back at the point where we are today but with more memory.

Finally finally, one tip. Next time a customer complaints about how
much memory the crashkernel "wastes" ask them how much one day of down
time for one machine costs them and how much memory they could buy for
that money. After that calculation I'm pretty sure that an additional
100M of crashkernel memory becomes much more tempting.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
