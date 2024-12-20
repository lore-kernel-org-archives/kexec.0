Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ABFE77188
	for <kexec@archiver.kernel.org>; Fri, 20 Dec 2024 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VV1GAbU6vs/Ml1xhCadOL44dM9zTf3oC8kpgBVJ9ouw=; b=wBlrbMOZz48H3gNixSQxnb6VJ2
	nPaWAWJlV9gBu359rt0+piUL2bBtb9/7/+OGZoEd+heqC5efeTDMCVis6WMU3kE5EZBEnfE1IGx4e
	OccAzXpt8ygg1uydZUBrPwRrPQBGbvmE3ct169068Wg8O8egt4yTsVSQWwZ58WIcisHR+KAr1Ktp1
	NcluRwM4/H0XvbPCTIPbsixUtLqVqL2kd8hAsLxa6luAwod4eOn7lIBOTg7u+LajL3U9t0rB8b2UP
	Obla3bzZCUhSDAN7qRiBzsuRefdGQVCPVO2BSY3n7miuTWlqc/BR6eEXEOy12m6fE2nJytAhd+Xpy
	MioRDZnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOXLH-000000049bf-0dUB;
	Fri, 20 Dec 2024 07:22:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOXLE-000000049bF-3ztU
	for kexec@lists.infradead.org;
	Fri, 20 Dec 2024 07:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734679350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VV1GAbU6vs/Ml1xhCadOL44dM9zTf3oC8kpgBVJ9ouw=;
	b=bRcQGZ3vEO8upouDA2q+oT8Ehz2tdfdn1fM4brJ9BSdeVi2TfuuQgPDEbLmr7Gao2e0cuN
	6makcYIfy5xglsaDxF2lXVUzhzA3DmFoo8fefCqEXZJFyXNGKU6m+oGs2yD8bNC6QI3Qh8
	TpMPYFQX35EliK/39p4KZxtTGfl7NZQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-r-LCiKK2MmeyGdwoo16F7g-1; Fri,
 20 Dec 2024 02:22:25 -0500
X-MC-Unique: r-LCiKK2MmeyGdwoo16F7g-1
X-Mimecast-MFC-AGG-ID: r-LCiKK2MmeyGdwoo16F7g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BD7B195608C;
	Fri, 20 Dec 2024 07:22:24 +0000 (UTC)
Received: from localhost (unknown [10.66.37.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A1B719560A2;
	Fri, 20 Dec 2024 07:22:21 +0000 (UTC)
Date: Fri, 20 Dec 2024 15:22:17 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: Does anyone actually use KEXEC_JUMP?
Message-ID: <Z2UbKdmmgd/IzMoz@MiWiFi-R3L-srv>
References: <4968818.GXAFRqVoOG@rjwysocki.net>
 <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
 <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
 <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
 <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_232233_086427_1CC88BBD 
X-CRM114-Status: GOOD (  22.96  )
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

On 12/16/24 at 12:21pm, Eric W. Biederman wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > It isn't broken. I know of it being used a few million times a week.
> >
> > There are corner cases which have never worked right, like the callee
> > putting a different return address for its next invocation, on the
> > stack *above* the address it 'ret's to. Which since the first kjump
> > patch has been the first word of the page *after* the swap page (and
> > is now fixed in my tree). But fundamentally it *does* work.
> >
> > I only started messing with it because I was working on
> > relocate_kernel() and needed to write a test case for it; the fact
> > that I know of it being used in production is actually just a
> > coincidence.
> 
> Cool.  I had the sense that the original developer never got around
> to using it, so I figured I should check.
> 
> Mind if I ask what you know of it being used for?

I am also very curious about the use case and asked David in other
thread, while David didn't tell. Not sure if it's one company's
confidential information. We may want to know what it's used for to
evaluate if it's a generally useful use case, or an unintentional
testing.

> 
> I had imagined it might be a way to call firmware code preventing the
> need to code of a specific interface for each type of firmware.
> 
> Eric
> 
> 


