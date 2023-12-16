Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2265C4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zFxsr/0FPSiby/7PZlPBnH9lSrhDSAOaOVCbztLhxkQ=; b=Ai7ltuXAcWIsDS
	iRwYoiZoiy8eQEaJf32zqHkhWPuqQ0JTf29jsZRFny48/6UjA+2B6Lmy2cQv/xKHGBObSv6KAthSe
	v9o6uyRnGm9IKuD7kUuA4doJdZYe4NrX7enfGdSqvRf/p4AuNSg9+IjG4c9vILLZ/AIrbtkDIkPRB
	dk+62DW6fY0FCCC466lZHTw1zU1jCP7kL5q47g3hKWYNAKf/MsKppjJJsgxq1vRp2holPFMXQ60nW
	QaiX3dhOpwGCMooBz6iJcX65UD6y/7wLioMLEhSxOem7S99FKC3KNLgMwCPDSel34Rc7dp/+9XY5Y
	2Siq3GFDL6POTZxGIbSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEKJc-005A4E-04;
	Sat, 16 Dec 2023 02:22:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEKJY-005A3m-1f
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 02:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702693323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDbMrrJMxJaNaZxmdjaWs9yxNCXUr/R3B3gdWPDjk0k=;
	b=R1ECmBaRiROxesXKQm0MxLJjK349+XN+rDopV/IzPY8ZZOgQC3zd3KRxDW0xFAxrp3PwZ7
	hSmPweuqyaA6BX9Rie41qbxjtlwxiHrJRuhO4X3LgEV/U7TnkflWIYPtHrhV+3kBBxTE9B
	uLkBk+TdHTZBJwykq2fOct3HTtQwReA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-VuBV7y_tPXOverfdkz6vmw-1; Fri,
 15 Dec 2023 21:21:59 -0500
X-MC-Unique: VuBV7y_tPXOverfdkz6vmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427523C025BD;
	Sat, 16 Dec 2023 02:21:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F871C060B1;
	Sat, 16 Dec 2023 02:21:56 +0000 (UTC)
Date: Sat, 16 Dec 2023 10:21:53 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yuntao Wang <ytcoode@gmail.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] kexec_file: fix incorrect end value passed to
 kimage_is_destination_range()
Message-ID: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
References: <20231215080910.173338-1-ytcoode@gmail.com>
 <20231215080910.173338-2-ytcoode@gmail.com>
 <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_182204_630409_C8C0E7F2 
X-CRM114-Status: GOOD (  26.78  )
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

On 12/15/23 at 11:46am, Eric W. Biederman wrote:
> Yuntao Wang <ytcoode@gmail.com> writes:
> 
> > The end parameter received by kimage_is_destination_range() should be the
> > last valid byte address of the target memory segment plus 1. However, in
> > the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> > the corresponding value passed to kimage_is_destination_range() is the last
> > valid byte address of the target memory segment, which is 1 less. Fix
> > it.
> 
> If that is true we I think we should rather fix
> kimage_is_destination_range.

It's true wit the current implementation of
kimage_is_destination_range(). Its callers pass the start/end+1
pair. Agree we should fix kimage_is_destination_range() instead and
adjust callers, such as kimage_alloc_normal_control_pages(), and
kimage_alloc_page().


> 
> Otherwise we run the risk of having areas whose end is not
> representable, epecially on 32bit.
> 
> 
> Eric
> 
> 
> > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > ---
> >  kernel/kexec_file.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f9a419cd22d4..26be070d3bdd 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
> >  		if (temp_start < start || temp_start < kbuf->buf_min)
> >  			return 0;
> >  
> > -		temp_end = temp_start + kbuf->memsz - 1;
> > -
> >  		/*
> >  		 * Make sure this does not conflict with any of existing
> >  		 * segments
> >  		 */
> > -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> > +		if (kimage_is_destination_range(image, temp_start,
> > +						temp_start + kbuf->memsz)) {
> >  			temp_start = temp_start - PAGE_SIZE;
> >  			continue;
> >  		}
> > @@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
> >  		 * Make sure this does not conflict with any of existing
> >  		 * segments
> >  		 */
> > -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> > +		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
> >  			temp_start = temp_start + PAGE_SIZE;
> >  			continue;
> >  		}
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
