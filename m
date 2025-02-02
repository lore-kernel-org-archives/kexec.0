Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BEC0218F
	for <kexec@archiver.kernel.org>; Sun,  2 Feb 2025 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOGOWUhNvwsL+/Ptr5bDnaYoGT37Wj3VkceFTYs845A=; b=Qq8yxOG82oXkAq3bMbKQBvSzuk
	nXKj/DEEXzMdkidEf44i36tmfu5BS76tUvgh/MT+jcXmNDJRm8C5UiC1l2zaNbdxU5Vd+4yCsjLYB
	94zZFBGMTOHtPRIU60rQN2zo5L9xN+/8fBePpSOe/tmwe/6UU6mTRlgIMHMGE4XdLHLK00sLwYqjx
	/UkKTzot+B0Loyr4Oau5Gvu4hghlpoydzoR7TK8HLRb7h3pByY/dMeCz3+PQgS4CJ20sggY882gj1
	ztm9GUC0IFs1UmSe9De3vSQE8ubbR2vyS4y/QE72s6eqhudqdVIrJ6ZaB5FHCcHRkvpVJ0falRf6W
	dOqeQe8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teatF-0000000DrUg-2k4w;
	Sun, 02 Feb 2025 14:24:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1teat9-0000000DrUE-2Zyv
	for kexec@lists.infradead.org;
	Sun, 02 Feb 2025 14:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738506232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOGOWUhNvwsL+/Ptr5bDnaYoGT37Wj3VkceFTYs845A=;
	b=OfXvHJONIOw2y16oPTBFf/YgyHFsVEKQU3wFdPdXMqDFv9y2zuYXmUS14TJirxlfQWfxi5
	9GcJvIqPqQGEQAdWvV7iIgO9Aa/6mH8RF1vM7l1RFRilmHi1AaqTqnHycsFx2xbACxJikB
	qWrlyAel1F7vo8jKc8UQvXduHbWCP/U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ZNBabcWKNBKGtRjoQxmBAg-1; Sun, 02 Feb 2025 09:23:51 -0500
X-MC-Unique: ZNBabcWKNBKGtRjoQxmBAg-1
X-Mimecast-MFC-AGG-ID: ZNBabcWKNBKGtRjoQxmBAg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab69e4c2563so379556866b.1
        for <kexec@lists.infradead.org>; Sun, 02 Feb 2025 06:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738506230; x=1739111030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOGOWUhNvwsL+/Ptr5bDnaYoGT37Wj3VkceFTYs845A=;
        b=k/2i5CmiZZmq4W7kbHodRTV+3bQWeb91+L5HRhVcTrDdfKHMLD0jx6pgtl0onpQnVw
         Fd9R9pqBAQdx8ZZNjZNffXWaqMYM4TjOFdaNhZ5dVVKgqvoTw6Q6/ytLq9Z/SzE2GUOE
         olfTPanyEQABD5vgUuwjow/O7rMB8pDaeFvUE7gPCKXDldtfrYw2mU3t3mXM+hSj6dH1
         RqpGedM6l7pSbQ5BICpdaE3/QdjnCmDEfN+f7jlMqKuiwwA1p+qRuOkwKdSiACx7jwDi
         rdMExJg1qnPQvegPlpdM96rJnc38Q0HTFbpz/SRcN3JWypd9/Oi1ohYyX7Vva2wBz9b9
         xsyg==
X-Forwarded-Encrypted: i=1; AJvYcCXf5GWMJeWyBRNHDxKtkAnxPawlpy9wCVoVNwg/n46av/P5c6rtM8GoFYsK21AbzGHEtOjCtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnIM4W2IyJPbhsjB8/zE0vAq5OOYEWddwNf8+xnh7mhItDKaLE
	Ca5J2w7DlKWlyq8I6kbWbhLausb34Kp4vdUoz6p76ytVks4qlzBbjAU/A8cM2y1p/6W7Pe3AhhP
	ZbblCl6sSu+jfV1qvBcDc8zXHDe05wzxF2jxHSMjJi2JFdblIG0ljx8XOlA==
X-Gm-Gg: ASbGncuTQD4VRIW6C6O1gTTGITiTsyfW/5J1VhYUVIondy9nrXDPmfHj4AW3X4iVBbN
	AwIJ44aeldGgldJCDTGTxkRlb9P0fQ1iFfJiPtyKujElciQnARnFawhCkd4eGCGNLiHm9Xt3QYy
	82L00DDxdO2QNwL0LMXclTsAmifgmdYHc0Ko8SNxSu08flyTRRLBo3HxZDELWihEGXk7aR+C4oR
	XtW+Ywf6L6IlkIeDRrwYvRSYLQqTkni1IIEcZG61fobWRUbgdd+ndcdhv0fQQaBj4w=
X-Received: by 2002:a17:907:968e:b0:ab6:f998:794 with SMTP id a640c23a62f3a-ab6f998082dmr1141288866b.45.1738506229947;
        Sun, 02 Feb 2025 06:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsgHqcbZYXqRwH4/X7TogMqo4Q775tDp3ZqS7HD4WcJ6uncT9knWgSnfJY1093rpp0kepfAw==
X-Received: by 2002:a17:907:968e:b0:ab6:f998:794 with SMTP id a640c23a62f3a-ab6f998082dmr1141287166b.45.1738506229574;
        Sun, 02 Feb 2025 06:23:49 -0800 (PST)
Received: from redhat.com ([2.52.7.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc72404887sm6057950a12.38.2025.02.02.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 06:23:48 -0800 (PST)
Date: Sun, 2 Feb 2025 09:23:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
Message-ID: <20250202092300-mutt-send-email-mst@kernel.org>
References: <20250129222003.1495713-1-bvanassche@acm.org>
 <20250130020209-mutt-send-email-mst@kernel.org>
 <20250130155843.05418f6dacfc094c7cc587fb@linux-foundation.org>
 <9f3dac06-1329-43d0-89c7-6888d2c96bd2@acm.org>
 <20250130172053.74f94d9c5eb9291b64ab586f@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20250130172053.74f94d9c5eb9291b64ab586f@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dn_fStyevZFGTKH2lBITqzxALw_n0Im63QHw_a45mgY_1738506230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_062355_734010_9D317577 
X-CRM114-Status: GOOD (  16.99  )
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

On Thu, Jan 30, 2025 at 05:20:53PM -0800, Andrew Morton wrote:
> On Thu, 30 Jan 2025 17:02:08 -0800 Bart Van Assche <bvanassche@acm.org> wrote:
> 
> > On 1/30/25 3:58 PM, Andrew Morton wrote:
> > > On Thu, 30 Jan 2025 02:02:38 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > >> On Wed, Jan 29, 2025 at 02:20:03PM -0800, Bart Van Assche wrote:
> > >>> Unlock vmcore_mutex when returning -EBUSY.
> > >>>
> > >>> Cc: David Hildenbrand <david@redhat.com>
> > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >>> Cc: Michael S. Tsirkin <mst@redhat.com>
> > >>> Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
> > >>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > >>
> > >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > This applies to patches which are in linux-next via your tree (I
> > > think), so I'll take the above to mean "thanks, applied" ;)
> > 
> > Is my understanding correct that the commit fixed by this patch made it
> > into Linus' tree a few days ago?
> > 
> 
> Ah, OK, thanks, grabbed.
> 
> (So that's what "git pull" does.  I'll have to write that down.)

:)
Thanks.


