Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA51CC4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DiftojRTF6CRKf7HN0ZFV6BhZIzSTIs8hICaHSZSu74=; b=R81Cvv/Z8p+Nna
	wcs2hBAvWGb1e+TgZxZwyQNoG42Em5vG8KB0xQOdwiH4dUS9joKO5N78tRZgtAt0Ppr5Zxo4ICfLN
	HDcWk7Dp0bJnxlyE6ouCWdCf6YjKeDrjHLRs5kx1zW9ZNvUhQsVyKq65MhykJeWfviE2yCUaDpDzT
	dDZHbadJBiwQRhQCvAJmzEZN0dbmLpZGEHC+vMRpw8dbtIyb3l2dBKUAe3XRuiazsgerabbdwnBaL
	dfokrQ5jjGc4f5LUAZCM1kwZrXh+YrBtmu1zVIO4QA3poQoUuLLUTb2rDcxB3VQpfh8InaXyBwvXT
	7hq+0in7tUEFxz+BcYkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r95nc-00E5VQ-26;
	Fri, 01 Dec 2023 15:51:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r95na-00E5Uc-0D
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 15:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701445885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7QbH72MaN7zgPPC836wmmvKLt2x8/XmeGRsr2itGo8=;
	b=EukU37ngN6hwkgbaruOAklX5q5/XIxUPY+uJ5qpQ2HkPjXE1vvzCo0lrZZOo9abexW4hnZ
	WQfGZMFu982EyIIdCyRHHbgu6HbKh/HAdISDgyMEi5x6aUDFog8fL0PktSqWnPMu+lk7UJ
	mcjVJ7cyfFiR8yoWH1TZg6HIpqSnasc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-fGVmDC1vNfGhqLF9iG1lZQ-1; Fri, 01 Dec 2023 10:51:20 -0500
X-MC-Unique: fGVmDC1vNfGhqLF9iG1lZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D5F3831524;
	Fri,  1 Dec 2023 15:51:17 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4787492BEF;
	Fri,  1 Dec 2023 15:51:15 +0000 (UTC)
Date: Fri, 1 Dec 2023 16:51:13 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>, Jiri
 Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>, Tao Liu
 <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <20231201165113.43211a48@rotkaeppchen>
In-Reply-To: <ZWnJyArAmFo_uYPA@tiehlicka>
References: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
	<ZWWuBSiZZdF2W12j@tiehlicka>
	<ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
	<91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
	<ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
	<ZWhg_b3O6piZtkQ-@tiehlicka>
	<ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
	<ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
	<ZWiQ-II9CvGv8EWK@tiehlicka>
	<20231201123353.2b3db7fa@rotkaeppchen>
	<ZWnJyArAmFo_uYPA@tiehlicka>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_075126_185381_8F614CE1 
X-CRM114-Status: GOOD (  19.25  )
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

On Fri, 1 Dec 2023 12:55:52 +0100
Michal Hocko <mhocko@suse.com> wrote:

> On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> [...]
> > And yes, those are all what-if concerns but unfortunately that is all
> > we have right now.  
> 
> Should theoretical concerns without an actual evidence (e.g. multiple
> drivers known to be broken) become a roadblock for this otherwise useful
> feature? 

Those concerns aren't just theoretical. They are experiences we have
from a related feature that suffers exactly the same problem regularly
which wouldn't exist if everybody would simply work "properly".

And yes, even purely theoretical concerns can become a roadblock for a
feature when the cost of those theoretical concerns exceed the benefit
of the feature. The thing is that bugs will be reported against kexec.
So _we_ need to figure out which of the shitty drivers caused the
problem. That puts additional burden on _us_. What we are trying to
evaluate at the moment is if the benefit outweighs the extra burden
with the information we have at the moment.

> > Only alternative would be to run extended tests in
> > the field. Which means this user facing change needs to be included.
> > Which also means that we are stuck with it as once a user facing change
> > is in it's extremely hard to get rid of it again...  
> 
> I am not really sure I follow you here. Are you suggesting once
> crashkernel=cma is added it would become a user api and therefore
> impossible to get rid of?

Yes, sort of. I wouldn't rank a command line parameter as user api. So
we still can get rid of it. But there will be long discussions I'd like
to avoid if possible.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
