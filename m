Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DCCC83F11
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tvaLLzV/2ydZjtRiroiA731yuz3/b6sUBSD4AUuXM8Q=; b=RDOh3DOaUUCxhk
	4+j+97TVB8+G11bvRofKyFeX1ciM+KcY6xxJPSWBjEVvTtElRiWFocsmfV2fBbY9ed4n9nf3RPVr/
	f4GJdc+aRHGUcRQD8FzjDEOR5ZRZx7XGj7Of7O4XTw/ExaAjqfafgmwjJwO9MrHBQBp2K68k8wPDb
	ByYNYrMDFcHG11EK5Vhdi4RHnHOU0QkzNYP4kV9qW01yJtBLyVICiOugXhNzy8nGF7Zou9rH2Wm0K
	H0Xv43nYEmQ0L8tfb4n88To0PBhox/99NqoRfKNMCmNCcl9iIw3F7U7pxylrFw4bx++7PYOeSLKw3
	L5vACtug3urOmJ3W/mLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYlI-009FFC-06;
	Mon, 28 Aug 2023 09:42:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYlE-009FEW-1z
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 09:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693215734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeVuz/P2oN4Br7MnWe8OFAnSOXHuM11CCRg5hX0lJGk=;
	b=aNgvuc7d5bRWJhd18gBEpU6+HLb5E+wY/wjrSo+6ocz0bA9UStiFPFxeOATtEVPzIgNAHE
	0h4om+dh8Srfq6LXByZp5IpfqSQvRlj9iysHVv2e2LkTVUzdzzIiatolLk5GTbQCLRVj7S
	IWGKMMPPNrHlGSFqH6heN+dwJYMmyEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-diKSc4fxN5OqwpQxRGC9Rg-1; Mon, 28 Aug 2023 05:42:10 -0400
X-MC-Unique: diKSc4fxN5OqwpQxRGC9Rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7381857A84;
	Mon, 28 Aug 2023 09:42:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26403C15E6A;
	Mon, 28 Aug 2023 09:42:08 +0000 (UTC)
Date: Mon, 28 Aug 2023 17:42:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Kexec-ml <kexec@lists.infradead.org>
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Message-ID: <ZOxr7VjBhBe6WW91@MiWiFi-R3L-srv>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
 <20230828074810.GY3523530@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828074810.GY3523530@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_024216_720011_B7E54543 
X-CRM114-Status: GOOD (  28.76  )
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

On 08/28/23 at 09:48am, Simon Horman wrote:
> On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
> > Any comments on this, please..
> 
> Hi Hari,
> 
> Sorry, I had missed this.
> 
> > On 07/07/23 10:59 am, Hari Bathini wrote:
> > > While the manpage does mention about kexec boot with a clean shutdown,
> > > it is not explicit about it. Make it explicit.
> > > 
> > > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > > ---
> > >   kexec/kexec.8 | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > > index 3a344c5..87e4ab5 100644
> > > --- a/kexec/kexec.8
> > > +++ b/kexec/kexec.8
> > > @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
> > >   .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
> > >   .RE
> > >   .PP
> > > -After this kernel is loaded, it can be booted to at any time using the
> > > -command:
> > > +After this kernel is loaded, assuming your Linux distribution supports
> > > +kexec-based rebooting, it can be booted to, with a clean shutdown, using
> > > +the command:
> 
> Perhaps user-space would be better than "your Linux distribution".
> But perhaps that is just kernel developer speak and makes less
> sense to others.

Agree, linux distrobution doesn't make sense here. And since this is a
kexec man page, does it really need to make this change? We know
kexec-tools loaded a kernel, we will use kexec-tools to trigger the
reboot. Wondering why we need to stress distros or kernel or kexec-tools
supports the kexec-based rebooting. 'with a clean shutdown' seems a
little helpful though.

> 
> > > +
> > > +.RS
> > > +.BR reboot
> > > +.RE
> > > +.PP
> > > +Alternatively, it can also be booted to, without calling shutdown(8), with
> > > +the command:
> > > 
> > >   .RS
> > >   .BR kexec \ \-e
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
