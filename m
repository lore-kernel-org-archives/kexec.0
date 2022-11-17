Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8853C433FE
	for <kexec@archiver.kernel.org>; Thu, 17 Nov 2022 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95hXijphoTKhwet1NnM2XqwXdSvwhqojZyeDhUt1x3I=; b=KnsOBjrsllDMfd
	KBdp8VJqsP1WxKjKOXaj14G8fivguc2UNtKKrw5Mczlnms2IQMcK1r5DD4CPGEY2cfnKPhbpRM60n
	Bm/JBlaOjiW0lE9Pmx7rSm5mtbIJB7GJ9iLb4UEj/G3he9c9Oqr0+BPJyA7PPKDO/5YFbMicb4D2b
	g6NBqaFMKyhR4YF9QW7d1Mhcu/n8MCLmKMIbgjzsQo7Lg/nV1hy/qagimsO7d40PqtbXo7yMV3BcK
	lbVbaiQ7Or1RUtclx1bxk8Er0tzJN3SsDPTlTuvTjjYxUEloOoqIyk900QugvunD5HkV1lgO3/dMZ
	Mthq7MwaZj58mKODuF1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovh6P-00FVc7-PB; Thu, 17 Nov 2022 15:46:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovh6C-00FVTp-6M
	for kexec@lists.infradead.org; Thu, 17 Nov 2022 15:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668700000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5HKEB3fHlBEv/KV0IugSFogCrFrsWVhqrP69OBbPPg=;
	b=McEvdY8OOFdxsXMXOuqfUmLD9L6lcKST+CeMwCYcmUQXNnfNYKauGd4A7Vk3CXBHXgwnyC
	gcuIB7kgaFvLqlEvFJKjGeF2dlue/oO8js/TLg1n87P1xAxUVbNd7TFJczCWLC0L4v6d2O
	OQTfXTxYLL9Oj9F0bq4ZfY4KqGjZrqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-1Rth89DTNc6P3eYwTF55Pg-1; Thu, 17 Nov 2022 10:46:30 -0500
X-MC-Unique: 1Rth89DTNc6P3eYwTF55Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F1A4101A528;
	Thu, 17 Nov 2022 15:46:29 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 150ED40C83EB;
	Thu, 17 Nov 2022 15:46:26 +0000 (UTC)
Date: Thu, 17 Nov 2022 16:46:12 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, ribalda@google.com, zwisler@google.com,
 robdclark@gmail.com, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
Message-ID: <20221117164612.65832e37@rotkaeppchen>
In-Reply-To: <20221116151610.7294a9e8@gandalf.local.home>
References: <20221116195624.124092-1-joel@joelfernandes.org>
	<20221116151610.7294a9e8@gandalf.local.home>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_074644_370673_70BB6059 
X-CRM114-Status: GOOD (  16.71  )
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

Hi Steve,

On Wed, 16 Nov 2022 15:16:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Nov 2022 19:56:24 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> >  	} else
> >  #endif
> >  	{
> > +		error = freeze_processes();
> > +		if (error) {
> > +			error = -EBUSY;
> > +			goto Unlock;
> > +		}  
> 
> If this is the path of a kernel panic, do we really want to check the
> return error of freeze_processes()? We are panicing, there's not much more
> we can do.

kernel_kexec isn't called during panic. We don't need to worry about it
here.

Having that said I think this is a problem in the device driver _not_
in kexec. In my opinion it's the job of the driver to prevent such
races during shutdown.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
