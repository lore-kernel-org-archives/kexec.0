Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E6C8303C
	for <kexec@archiver.kernel.org>; Mon,  7 Jul 2025 04:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7NYJmsiSSyFYzFMtw7fkGx1JMolDzXOUBR2sLYUJX8=; b=cWreaiQsz7pkv8ZqAhFdjS1gub
	1iipjj1xXdZflid4fLFGFc94ZmDCX0L3OoyeZv0KKs4tm881It1RVbuW5WN25JvArPg37NylMwRYj
	zHVe2GCLGfM1IFATp5gEvIm/Sxrv80WvofoT3W/afF0lRiQ4EGdTAsUurTlxYgKjq3vMvFKOUA9wJ
	f6ifIcYuBRmf8cCTjm7D4SMUk1tx6JGytGP75E+C6tbwfNBK/2ln0U82sO7dQdKRL35t5Za2SxpNi
	ZDezXF8nM/UfeeuD/subsUE1vVXKnpjmNt8JQnCVl7lEw4CSc9gLCXf5XQVjSVxqXwA5yWKlrkK4u
	rMOyWorw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYdsY-00000001Oyh-3mZ1;
	Mon, 07 Jul 2025 04:54:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYdsT-00000001OxO-0KVq
	for kexec@lists.infradead.org;
	Mon, 07 Jul 2025 04:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751864085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7NYJmsiSSyFYzFMtw7fkGx1JMolDzXOUBR2sLYUJX8=;
	b=eGM2zrKf5FTJqfLlAEW2PAZ7MUHNlqxVL6/Q4aD9h6xiybVu9i2beC8Y8fRgJwzDbZvjJQ
	inpSERltiEII0Q6KWkfSobfnwItP9U8jYZG+z/RVy2bqcmqlW998bHWOWNIjOFnILstNvj
	Sz98uR783M9qZ874DCMe9digYe5hVnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-1-_4s55OO7-7V2PJq8BOdw-1; Mon,
 07 Jul 2025 00:54:42 -0400
X-MC-Unique: 1-_4s55OO7-7V2PJq8BOdw-1
X-Mimecast-MFC-AGG-ID: 1-_4s55OO7-7V2PJq8BOdw_1751864081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD2541800343;
	Mon,  7 Jul 2025 04:54:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA2F230001BC;
	Mon,  7 Jul 2025 04:54:38 +0000 (UTC)
Date: Mon, 7 Jul 2025 12:54:34 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, David Hildenbrand <dhildenb@redhat.com>,
	akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v3 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <aGtTCqT0piPDFHE0@MiWiFi-R3L-srv>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
 <Z9H4E82EslkGR7pV@dwarf.suse.cz>
 <Z9Of+RYjpcDN7+ji@MiWiFi-R3L-srv>
 <053f8c6d-0acd-465b-8d9f-a46d50ccce71@redhat.com>
 <c5495dd1-8085-4721-af1e-93f34f36d97b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5495dd1-8085-4721-af1e-93f34f36d97b@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250706_215453_540374_3B40590D 
X-CRM114-Status: GOOD (  34.43  )
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

On 06/27/25 at 02:18pm, David Hildenbrand wrote:
> On 27.06.25 14:16, David Hildenbrand wrote:
> > On 14.03.25 04:18, Baoquan He wrote:
> > > Hi Jiri,
> > > 
> > > On 03/12/25 at 10:09pm, Jiri Bohac wrote:
> > > ......
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index fb8752b42ec8..895b974dc3bb 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -987,6 +987,28 @@
> > > >    			0: to disable low allocation.
> > > >    			It will be ignored when crashkernel=X,high is not used
> > > >    			or memory reserved is below 4G.
> > > > +	crashkernel=size[KMG],cma
> > > > +			[KNL, X86] Reserve additional crash kernel memory from
> > > > +			CMA. This reservation is usable by the first system's
> > > > +			userspace memory and kernel movable allocations (memory
> > > > +			balloon, zswap). Pages allocated from this memory range
> > > > +			will not be included in the vmcore so this should not
> > > > +			be used if dumping of userspace memory is intended and
> > > > +			it has to be expected that some movable kernel pages
> > > > +			may be missing from the dump.
> > > 
> > > Since David and Don expressed concern about the missing kernel pages
> > > allocated from CMA area in v2, and you argued this is still useful for
> > > VM system, I would like to invite David to help evaluate the whole
> > > series if it's worth from the VM and MM point of view.
> > 
> > Balloon pages will not be dumped either way (PageOffline), so that is
> > not a convern.
> > 
> > Zsmalloc pages ... are probably fine right now. They should likely only
> > be storing compressed user data. (not sure if they also store some other
> > datastructures, I think no, but might be wrong)
> > 
> > My comment was rather forward-looking: that CMA memory only contains
> > user space memory is already not the case (but the existing cases might
> > be okay). In the future, as we support other movable allocations (as
> > raised, leaf page tables at some point, and there were discussions about
> > movable slab pages, although that might be challenging) this can change
> > (unless we find ways of not placing these allocations on CMA memory).
> > 
> > So as is, this should be fine, but it's certainly something to be aware
> > of in the future.
> > 
> 
> BTW, I realize this was a late reply, and that the series already proceeded.
> Just stumbled over that un-replied mail an thought I'd clarify my point
> here.

Thanks a lot for deliberating on this and providing these helpful
details. As you said, this feature is fine for the time being, we can
remember this and consider how to adapt in the future once those movable
allocations could happen in CMA. And the risk has been told clearly in
doc.


