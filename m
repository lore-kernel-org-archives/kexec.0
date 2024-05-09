Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1652C10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=574nJBK9z7dCiAzOWHwVN3JwEsDjGTgPAsi8wwtsKCI=; b=LKVWg4apWmIhuW
	UwqScX6uwnf2sfoK1sKT5npNK+m61ku8Ih4efA897rQyCu6YsgIfwHAbkCFy4KmRBMNYiQMzQXMB+
	WjAANDLoBl6vL7Zq8cdhQl5MD+QX3NttZiz58BuEWju03NnOzvABseTUBQmrEakHS1dtWdNGV7zHx
	NUL8fOrmJaRT+vM8/QwqI8fNliLRFyY/w+wWjGYAc6Zv0+fNiGj72jGiST/TpA4w6OVT2A/8Nr9kN
	hyzXU6+LpCUAL9liDDB0Atj/hTI1n9BOeDyChbFbm9fmGDHwVjTFKv6ZyLVghpUigLP2YC4c/Gvm0
	JXs7EZ89+HNHcEYs2sbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s55j6-00000001tf1-3NvA;
	Thu, 09 May 2024 15:30:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s55j3-00000001teY-0dqd
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 15:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715268627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy/b3d3gFNZGN9o/TMf1nXsT/S7nrlG2+f6fAjptoCk=;
	b=e63c5sAnrNGZAXIyH3b6Bp3tIWoBxLeYeo3t8rq5HzjIjalPquMK6roIpEWfOx/jtSgdGQ
	yU8i4aq5ichbi+bHQX15uZ7zT7x7O2N6RkzDTOI+Y7D96CUAz1u1P7C0Ocuy4qYRlbklo5
	nESYRKbY6QZk6zQYapmPxCUxvYgh0ok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-lBH72HkKPEu-T6_GN-WWuA-1; Thu, 09 May 2024 11:30:24 -0400
X-MC-Unique: lBH72HkKPEu-T6_GN-WWuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 562671816ED2;
	Thu,  9 May 2024 15:30:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 48D5220C5662;
	Thu,  9 May 2024 15:30:21 +0000 (UTC)
Date: Thu, 9 May 2024 23:30:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Rik van Riel <riel@surriel.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
Message-ID: <ZjzsC8KwEoDzAZBt@fedora>
References: <20240507091858.36ff767f@imladris.surriel.com>
 <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
 <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_083029_495996_5C17884D 
X-CRM114-Status: GOOD (  22.12  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 05/09/24 at 09:41am, Rik van Riel wrote:
> On Thu, 2024-05-09 at 11:52 +0800, Baoquan He wrote:
> > Hi,
> > =

> > On 05/07/24 at 09:18am, Rik van Riel wrote:
> > > While taking a kernel core dump with makedumpfile on a larger
> > > system,
> > > softlockup messages often appear.
> > > =

> > > While softlockup warnings can be harmless, they can also interfere
> > > with things like RCU freeing memory, which can be problematic when
> > > the kdump kexec image is configured with as little memory as
> > > possible.
> > > =

> > > Avoid the softlockup, and give things like work items and RCU a
> > > chance to do their thing during __read_vmcore by adding a
> > > cond_resched.
> > =

> > Thanks for fixing this.
> > =

> > By the way, is it easy to reproduce? And should we add some trace of
> > the
> > softlockup into log so that people can search for it and confirm when
> > encountering it?
> =

> It is pretty easy to reproduce, but it does not happen all the time.
> With millions of systems, even rare errors are common :)
> =

> However, we have been running with this fix for long enough (we
> deployed it in order to test it) that I don't think we have the=A0
> warning stored any more. Those logs were rotated out long ago.

OK, thanks for the explanation.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
