Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FBCC5320E
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sKvftfLFRaZwk+YQU4sDQORdfT1X2ZR9FNbreSVJ8T0=; b=Tr+I8y3FYwyn8x
	2JEGGY2v6zYg5tqytsXPN8IOUsUXEJwhWwzWvA5LI/M10k/yfuH209qtfBcUZJf8oyAH0m0JQusYF
	3aaGFhcPShJOhZZjleAbguA0flUq67AJrjK7vP0fqo8dZsvnyttgVDeSFDFe69t+fSxE6eW2hLWDG
	rD0ZY5aiKNoCcxa13e58TqZOYGLuF02gKYseqJjssKqpVbCtwkgTQOsTYGGvOUouOwYihXmIboL6n
	RoT5OyUdyeMcYtIHMSqMTYDki2tJMzWvLOWQbC0Ne5yLJGsZyy6k7mUl31NBiiSXv0XdrzWDdRLiy
	u+5kghlPlEaLpPOYJ7eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sisao-0000000AbA8-1y8w;
	Tue, 27 Aug 2024 09:34:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sisa5-0000000Ab1N-0fkh
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 09:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724751220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xioG04ypc2y3mzfncp7R682Hre9B7EvlJbcD2gyIjIg=;
	b=XGPZdbQr+jVQyOGT0rgusbFWYD0jJibEBLKxieJO7lUnk7oXvwBSUPgcGrv+5Nn/OJhd9a
	vxGZM4vrrmZniWHe6Z6kypWSafaq2UJzDR6Q5KI/4QivbWS6gy2AK5DpC+61O/9Ddj0uYU
	Y1iyXmE9FAPqntvqzoVvNvfe/lnxT90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-EbzGIH8aMEaTI4cZ3J3YLg-1; Tue,
 27 Aug 2024 05:33:36 -0400
X-MC-Unique: EbzGIH8aMEaTI4cZ3J3YLg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B906D1954B05;
	Tue, 27 Aug 2024 09:33:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700031956056;
	Tue, 27 Aug 2024 09:33:32 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:33:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	noodles@fb.com, x86@kernel.org, lijiang@redhat.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs2daJ9FHA8vPkPP@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
 <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_023341_299503_B69F1F92 
X-CRM114-Status: GOOD (  27.47  )
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

On 08/27/24 at 01:41pm, Dave Young wrote:
> On Tue, 27 Aug 2024 at 13:28, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 08/26/24 at 09:24am, Tom Lendacky wrote:
> > > On 8/25/24 21:44, Baoquan He wrote:
......
> > > > ---
> > > >  arch/x86/mm/ioremap.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > > index aa7d279321ea..7953c4a1d28d 100644
> > > > --- a/arch/x86/mm/ioremap.c
> > > > +++ b/arch/x86/mm/ioremap.c
> > > > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> > > >             paddr_next = data->next;
> > > >             len = data->len;
> > > >
> > > > -           if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > > > +           if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> > >
> > > I don't think this is correct. You are adding the requested size to the
> > > length of the setup data element. The length is the true length of the
> > > setup data and should not be increased.
> >
> > I talked to Dave, he reminded me that people could mix the passed in
> > parameter 'size' and the local variable 'size' defined inside the while
> > loop, not sure which 'size' you are referring to.
> >
> Baoquan, you are right, but I think I mistakenly read the code in
> memremap_is_setup_data instead of early_memremap_is_setup_data.  You
> can check the memremap_is_setup_data, no "size = sizeof (*data)",  so
> these two functions could both need fixes.

Agree, memremap_is_setup_data() has the same drawback in code.

> 
> Otherwise it would be better to change the function internal variable
> name, it could cause confusion even if the actual result is correct.

Ok, will consider to change when spinning v2.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
