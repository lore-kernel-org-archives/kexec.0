Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DD3EEAA62
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b6j7GRp05MSPMGmiRbKHHEfRUvEdW59kPe0H/6LltE8=; b=s6bCYhSbundvPB
	YZAS9EqnaGwVJdM2c7AZNfGOtecQtnFrO7KK6wEc+zEFjDv5wg8UgGGbCQ71OaVlo6LhNVIVriAv9
	FKKqHlLZ1+Alu/LMYNbi7YNNuLhZ1ouXozQZOX7klVgWNlisea+4tUjaN+jt3IHi5nJah3GNR6JLD
	CRGZWbCHARqIRjgXOPqlL8dLqgDjwbm9qC/4C9PaJW8X9YSU9ola7VYnvEuWK9C38v413yBfGf7rT
	kQ2tLRV32PFVN66MGd6GWkcToilcoydX5JDWtZSBtVqg3ue1KiEfc1F5np+isnBCnYcimX1cy6Gif
	MoIF2vLPAvbHR5U7IlDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgrj1-0098jj-1n;
	Thu, 14 Sep 2023 19:10:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgrix-0098iV-0n
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 19:10:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694718597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G30aDEjWsGwHEBcRnJQg8/XZtFrP1rxiHjsXrhoF9jc=;
	b=WYkmW0EXxGNrGD9sxpdcDwUUj+UIImoG+n1FHqOSOp4IriS+EteApfZZlOukbau2Qd5HQl
	dS2CMgkg4OLXAZAmvNUMLxoOqCVHjOkmP4ihvcXqirnqcwmkz0bsyyNdA9AbU/y3KHlXvM
	xR0Uy1tMyoXTMTJDfefLSfA43X9SCwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-5-Yls00iPaSiIW2Kk2t_Kw-1; Thu, 14 Sep 2023 15:09:55 -0400
X-MC-Unique: 5-Yls00iPaSiIW2Kk2t_Kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84833185A79B;
	Thu, 14 Sep 2023 19:09:54 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E22421B2413;
	Thu, 14 Sep 2023 19:09:51 +0000 (UTC)
Date: Thu, 14 Sep 2023 21:09:46 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org, "Baoquan He"
 <bhe@redhat.com>, bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>,
 lennart@poettering.net
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230914210946.25730571@rotkaeppchen>
In-Reply-To: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
References: <20230911052535.335770-1-kernel@jfarr.cc>
	<20230913160045.40d377f9@rotkaeppchen>
	<63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_120959_377558_B317A76A 
X-CRM114-Status: GOOD (  22.62  )
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

Hi Jan,

On Wed, 13 Sep 2023 16:42:33 +0200
"Jan Hendrik Farr" <kernel@jfarr.cc> wrote:

> On Wed, Sep 13, 2023, at 4:00 PM, Philipp Rudo wrote:

[...]

> In [5] Luca writes:
> > [...] we fully intend for the UKI format to be an open and stable
> > specification, that anybody can support and rely on.  
> But that is unfortunately not where the format is at this point.
> 
> What is annoying though is where this leaves a user that actually
> wants this feature. They can carry a patch or they might have to wait
> a long time.
> 
> Can you indicate what it would take for the kernel community to consider
> this spec as stable enough?

I don't think there is a good answer to that question. In fact I
believe if you ask 10 people from the community you will get 20+
different answers.

My guess is that either (1) the spec is moved to some official standard
committee where people spend decades to polish it before it makes it
into the kernel or (2) there's a big flamewar on LKML until Linus had
enough and passes his judgment on it. So definitely (2) ;-)

Thanks
Philipp

> 
> 
> > In the end the only benefit this series brings is to extend the
> > signature checking on the whole UKI except of just the kernel image.
> > Everything else can also be done in user space. Compared to the
> > problems described above this is a very small gain for me.  
> 
> Correct. That is the benefit of pulling the UKI apart in the
> kernel. However having to sign the kernel inside the UKI defeats
> the whole point.
> 
> 
> [1] https://uapi-group.org/specifications/specs/unified_kernel_image/
> [2] https://github.com/uapi-group/specifications/pull/72
> [3] https://github.com/uapi-group/specifications/pull/73
> [4] https://github.com/uapi-group/specifications/issues/74
> [5] https://github.com/systemd/systemd/issues/28538
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
