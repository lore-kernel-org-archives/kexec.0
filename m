Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C85FC4167B
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bCQARXf3EAzJWtyQGUrNXAh+IowpbOuXYyjT0mVSyD0=; b=2SH+FGVM9Q5KZ9
	rEeMYsQbziCWaycyB1jkj5MYiMMKcZnzqsCzDwlE5tShdBnGe1D2ss5v121xqqrpOdMG/ZGYLTWp2
	qlQ8V4UuvZ0cj2J1DaUruLsEM7bDev2v+9PR7klSvZVXWBpcsG3XyYUvnk4fxU0NwwuPIJ4YPkKUI
	sYqaY9xFARrMx0pffX0qdUhIhgdyrn5echXmS4UT//BYgzXcxS1avFaRi5XTzcrD04DKKg0cDoWY+
	O9cQtDGxxS22z6jxfG+rn/If34BwCOXyFy9AuSGKYpygDPyV3HjnjRG8DxAjwCHlbjpQMabiugg97
	W2d6cdM7FZnognXrMiCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAplJ-009sFv-0q;
	Wed, 06 Dec 2023 11:08:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAplG-009sDv-0y
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 11:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701860892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu1oMLC/dT4Tav3HkAUGVB3bgKWopFUqSwZfN78dtKE=;
	b=cNAhO8uKpwMuK3VMODcZtynxE0fMA0/1OwMw/ZS7Fab3ViMtn00MhQQ6gbJiKTNuddUq1t
	fG9wDDJhKg3FC8+YAjiOGIkekswh9SboiAX4nGIvgFFQoKjnLLYQafa05Kmcubq3CBBFqU
	oJK3AKtQVgrEGMQKeTvpqlD5wjTEUWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-U9vYq7uOPp-pKHmUesEtRw-1; Wed, 06 Dec 2023 06:08:10 -0500
X-MC-Unique: U9vYq7uOPp-pKHmUesEtRw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4F80185A780;
	Wed,  6 Dec 2023 11:08:09 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A415492BC6;
	Wed,  6 Dec 2023 11:08:08 +0000 (UTC)
Date: Wed, 6 Dec 2023 12:08:05 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>, Jiri
 Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>, Tao Liu
 <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231206120805.4fdcb8ab@rotkaeppchen>
In-Reply-To: <ZWoQ1k2AikSiMjys@tiehlicka>
References: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_030814_431422_12A0D95C 
X-CRM114-Status: GOOD (  41.41  )
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

On Fri, 1 Dec 2023 17:59:02 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Fri 01-12-23 16:51:13, Philipp Rudo wrote:
> > On Fri, 1 Dec 2023 12:55:52 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> >   
> > > On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> > > [...]  
> > > > And yes, those are all what-if concerns but unfortunately that is all
> > > > we have right now.    
> > > 
> > > Should theoretical concerns without an actual evidence (e.g. multiple
> > > drivers known to be broken) become a roadblock for this otherwise useful
> > > feature?   
> > 
> > Those concerns aren't just theoretical. They are experiences we have
> > from a related feature that suffers exactly the same problem regularly
> > which wouldn't exist if everybody would simply work "properly".  
> 
> What is the related feature?

kexec

> > And yes, even purely theoretical concerns can become a roadblock for a
> > feature when the cost of those theoretical concerns exceed the benefit
> > of the feature. The thing is that bugs will be reported against kexec.
> > So _we_ need to figure out which of the shitty drivers caused the
> > problem. That puts additional burden on _us_. What we are trying to
> > evaluate at the moment is if the benefit outweighs the extra burden
> > with the information we have at the moment.  
> 
> I do understand your concerns! But I am pretty sure you do realize that
> it is really hard to argue theoreticals.  Let me restate what I consider
> facts. Hopefully we can agree on these points
> 	- the CMA region can be used by user space memory which is a
> 	  great advantage because the memory is not wasted and our
> 	  experience has shown that users do care about this a lot. We
> 	  _know_ that pressure on making those reservations smaller
> 	  results in a less reliable crashdump and more resources spent
> 	  on tuning and testing (especially after major upgrades).  A
> 	  larger reservation which is not completely wasted for the
> 	  normal runtime is addressing that concern.
> 	- There is no other known mechanism to achieve the reusability
> 	  of the crash kernel memory to stop the wastage without much
> 	  more intrusive code/api impact (e.g. a separate zone or
> 	  dedicated interface to prevent any hazardous usage like RDMA).
> 	- implementation wise the patch has a very small footprint. It
> 	  is using an existing infrastructure (CMA) and it adds a
> 	  minimal hooking into crashkernel configuration.
> 	- The only identified risk so far is RDMA acting on this memory
> 	  without using proper pinning interface. If it helps to have a
> 	  statement from RDMA maintainers/developers then we can pull
> 	  them in for a further discussion of course.
> 	- The feature requires an explicit opt-in so this doesn't bring
> 	  any new risk to existing crash kernel users until they decide
> 	  to use it. AFAIU there is no way to tell that the crash kernel
> 	  memory used to be CMA based in the primary kernel. If you
> 	  believe that having that information available for
> 	  debugability would help then I believe this shouldn't be hard
> 	  to add.  I think it would even make sense to mark this feature
> 	  experimental to make it clear to users that this needs some
> 	  time before it can be marked production ready.
> 
> I hope I haven't really missed anything important. The final

If I understand Documentation/core-api/pin_user_pages.rst correctly you
missed case 1 Direct IO. In that case "short term" DMA is allowed for
pages without FOLL_LONGTERM. Meaning that there is a way you can
corrupt the CMA and with that the crash kernel after the production
kernel has panicked.

With that I don't see a chance this series can be included unless
someone can explain me that that the documentation is wrong or I
understood it wrong.

Having that said
NAcked-by: Philipp Rudo <prudo@redhat.com>

> cost/benefit judgment is up to you, maintainers, of course but I would
> like to remind that we are dealing with a _real_ problem that many
> production systems are struggling with and that we don't really have any
> other solution available.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
