Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4FFC47258
	for <kexec@archiver.kernel.org>; Fri,  2 Feb 2024 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRItoDAX6s+VWKl8RwEGeS8HFBVn5ZjvpARiFs2GX2k=; b=nHcsrTmXf3NO4q
	UAEbbo+Vr5b+CW7A3DuGQnHFZ+q6Js5DT/c7ny8zN53dprz7+OzKxtDCssWwZFlo3uscLED9mP+Dr
	wVh1/51yuSmt1C+/x/qtQnuqrxENljpH9r56j48Zl2uUhw4lfpW0bNhHC/qzSQbVWpP1BVKieyx7o
	9rANNhDemRXBtwPWXdqubsjVXkj8UcMJ8cd+ys9+p+ZMxx12X1+TigABB/gufmLTEd7WG5RLfkQTO
	MMIuxBNDNXHe97qZXwMD8uiooNiwOamFdbcJus1bSopegpsw58F8IEg24f7/g3w7H1mU9FPZhMHDv
	DMP/rosAQn393lFPaCAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVkz5-0000000A7Pp-0qdb;
	Fri, 02 Feb 2024 04:16:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVkz1-0000000A7Oq-4Apt
	for kexec@lists.infradead.org;
	Fri, 02 Feb 2024 04:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706847410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+slSgoBcP2tVKnNLAuHC8kZwZA7y1MjcUiLxFXRkG8=;
	b=Tc5RJhAk4o2+3aeFAiQzQI3Ue5AUFvTel89LYv8gx0eZTcmXjJId7kBum2r94DOT+8IBgx
	pFrcuenJy1vmlGnw4tGKt1k0TM+YgUXAiFrqzVAagco4xYljgcHg0h3ZC2aQ6tAx74qaz3
	VobOa1mNqp/fuZTOIG5jdC8UsvGLZuA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-0unjhKybNSehk49_wI7WOQ-1; Thu,
 01 Feb 2024 23:16:46 -0500
X-MC-Unique: 0unjhKybNSehk49_wI7WOQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 819EF3C0BE48;
	Fri,  2 Feb 2024 04:16:46 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CFBE3492BE2;
	Fri,  2 Feb 2024 04:16:45 +0000 (UTC)
Date: Fri, 2 Feb 2024 12:16:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Michel Lind <salimma@fedoraproject.org>, horms@kernel.org,
	Sergei Trofimovich <slyich@gmail.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Message-ID: <ZbxspulHDxpmHs0W@MiWiFi-R3L-srv>
References: <20240131100508.2013016-1-slyich@gmail.com>
 <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
 <ok66kbhzu2xczopdsjhjuedt2h3snt3omjc3jlzbs3ujo6ra75@bu3mvwtuveck>
MIME-Version: 1.0
In-Reply-To: <ok66kbhzu2xczopdsjhjuedt2h3snt3omjc3jlzbs3ujo6ra75@bu3mvwtuveck>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_201656_136229_E8DDC2D1 
X-CRM114-Status: GOOD (  25.89  )
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

On 02/02/24 at 11:01am, Coiby Xu wrote:
> Hi,
> 
> FYI, before this patch, Michel already sent "[PATCH] Fix building on x86_64
> with binutils 2.41" to address the same issue. Currently I almost know
> nothing about
> assembly but Michel's patch seems to be more complete because two more
> files are touched.

Thanks for telling, I didn't notice that one. I didn't know these
either, leave them to Sergei and Michel to decide what is the
appropriate solution.

> 
> On Wed, Jan 31, 2024 at 07:04:57PM +0800, Baoquan He wrote:
> > On 01/31/24 at 10:05am, Sergei Trofimovich wrote:
> > > `binutils-2.42` introduced stricter checks on what `.arch` can be used
> > > in 64-bit mode and started failing the build as:
> > > 
> > >     $ as-2.42 --64 -o entry32-16-debug.o entry32-16-debug.s
> > >     purgatory/arch/i386/entry32-16-debug.S: Assembler messages:
> > >     purgatory/arch/i386/entry32-16-debug.S:28: Error: 64bit mode not supported on `i386'.
> > > 
> > > The change moves `.code32` before `.arch 386` as suggested in
> > > https://sourceware.org/PR31319
> > 
> > I am not familiar with the gas behaviour, the fix sounds good from
> > discussion in above link.
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > 
> > > 
> > > Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> > > ---
> > >  purgatory/arch/i386/entry32-16-debug.S | 2 +-
> > >  purgatory/arch/i386/entry32-16.S       | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/purgatory/arch/i386/entry32-16-debug.S b/purgatory/arch/i386/entry32-16-debug.S
> > > index 5167944..297d6f5 100644
> > > --- a/purgatory/arch/i386/entry32-16-debug.S
> > > +++ b/purgatory/arch/i386/entry32-16-debug.S
> > > @@ -25,10 +25,10 @@
> > >  	.globl entry16_debug_pre32
> > >  	.globl entry16_debug_first32
> > >  	.globl entry16_debug_old_first32
> > > +	.code32
> > >  	.arch i386
> > >  	.balign 16
> > >  entry16_debug:
> > > -	.code32
> > >  	/* Compute where I am running at (assumes esp valid) */
> > >  	call	1f
> > >  1:	popl	%ebx
> > > diff --git a/purgatory/arch/i386/entry32-16.S b/purgatory/arch/i386/entry32-16.S
> > > index c051aab..7a84565 100644
> > > --- a/purgatory/arch/i386/entry32-16.S
> > > +++ b/purgatory/arch/i386/entry32-16.S
> > > @@ -20,10 +20,10 @@
> > >  #undef i386	
> > >  	.text
> > >  	.globl entry16, entry16_regs
> > > +	.code32
> > >  	.arch i386
> > >  	.balign 16
> > >  entry16:
> > > -	.code32
> > >  	/* Compute where I am running at (assumes esp valid) */
> > >  	call	1f
> > >  1:	popl	%ebx
> > > --
> > > 2.43.0
> > > 
> > 
> 
> -- 
> Best regards,
> Coiby
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
