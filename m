Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74031C43602
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMed8Aal2XzeNAdRp76BDF3jCpjJx/NH7JDMMBYScHA=; b=lPQ4+XqKg25DVqfPjVy4ooBkNY
	a1FW9YEUkYrYmVsfDvtv756PV9pJNgv8DrVXD+npfUzw6YGapYw5jAczUSIpFY9uI1gPC6wVm2sbK
	EZJOujgbSKm7SCgLnqtHEtNsY6ooec9zRyD4oKTNcX5xa8cneJC9unZDM6bmM7s1+sJgXzHDkW1sB
	s7gUJkGkaSkWujahwe5latb6z9blyCwxe+xQrsD/Lz9ZECWEcqfZ3E7n64RKpSIUu+sFmAOB+dMox
	v7OsW3fw/1A9Ea/Xy/ZmjAnEduBimyTM5rGpI2bBa/OC4i5PBC0HA7QzfVKPb+TVCnGLi06RHq3eQ
	RYvo1IPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whViE-000000002zd-1soU;
	Wed, 08 Jul 2026 17:05:30 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whViB-000000002yn-26Xa
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:05:29 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ccdf36f63dso3375ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783530327; x=1784135127; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HMed8Aal2XzeNAdRp76BDF3jCpjJx/NH7JDMMBYScHA=;
        b=Y6EdG6VbNsUMe0/DaRcCVxKtRY1RuQNVMQg1S9euRC9LBQ2pBXxtzpvter95ePo9rX
         5jJRKN4zvXb8h23TGibKInAE/aF7XDu7Z7e89bjbB2aaBT6B/IGb82D5yivig+SsVC8a
         swLxnA4td2ODhMIcPG6H5ZXGUe+uzGi5gXOTo7ypHDghf/K+SmCAoD44mpl8bAEu0fvz
         bau4b2Z6AwIBdk6beA0ns/iCt6jNlsllQCgkwCRhGtXwYva7YqpC++WtU9ZVUHkqN85h
         xKd5TP3gCm17sll9OrurMNcaSWjdfMAc5nE6JhmyUJPvfzpACPwLgg1tNNvirTbtOqKj
         ePlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530327; x=1784135127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMed8Aal2XzeNAdRp76BDF3jCpjJx/NH7JDMMBYScHA=;
        b=YdD4tZiF8bpIAIwt4a43t7ab6mv0kpFi+BZxkqekOf+x+8zD/hcjJC5W7mOGf6Ys6y
         YIfMHurmCBmqmgzE5T7q7MERsp/l2qISD8LyNqtGvpfD9TvgzaKEg/Ckq8FH98Y/5KZP
         /BZrGVkjC22IVYtawxswKcRdqz6OQIAF27QHluqsP2YCpzbquHAn8FUMWrcGq8iqIe1J
         yYdv1K0YFvvHJ9XyqX30eeIz8YDRW4OHcTP7Cae+SdjzQclZt4HypSV5cJqK6E1JDI6/
         48lApi47DsZjFECZX+nvo309aR0yrBywQOMg49CUqx0Ckkgw69ZkLzbXT0rUj6Wh0R4F
         PN5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqtadW0sTyqYtKEwc4KC+nfkD4utDS04OY668AusqM7sJZDe6+dIXR96d3jVVRnBiq6uEdX1w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwnSTeymMPnHaed9vImCBxrmRBcDckDt0hxOO4wWZpEtvmW1wvO
	sYgOC3l5X0WzP2WLu9nM0PKlZZMCqXj59XMJXvZfTgotYhNyEbMCXqUcZ06kgcJHTCMfVWrFtac
	J0Xak5A==
X-Gm-Gg: AfdE7ckjXtqUFFCLXgBDRHotQ3Hf33g89Nz1PVRP/8haEeOdHbKAimQt33sKUSbUcMA
	d0nixhdFGX7r/Ji6n2rOr3TD8rF/qc1BnFAdgUIcY0s/62baeX+Mmaf6TAUJyiCnNMHlb6TcIQU
	e+2v4Ry9C1GRKw20ZS1NJ9H+hv8EwqhheMZFGbN677U3VTRTNnoNrtMKbYGLv+eulobgVbCUyGM
	fwiOOmomGk3ZK4q27YJgntu5eMUO+mdKYA/cogcAvK6EVhctac0Xnq22Ho+PLB9FRzFUu1bhkgo
	zLknmFQnH17k/DSriKWkIS5+yplB81q3ups4bFpgD2T5r9mULPAko7tTT7dq5kwLnnOWwdnnBI6
	qiALLPhRsoLZMsUkRKVJsdEpmtGhdPgHtfyJrHY77TDqHIU/8/FriX8p801ZOoIss7PZE9bZOoo
	LtX1ThhAjPHuEtKWbN8a8p1o3+nD9TXB1GMJ+j5zARQA1VQ33dNMtbWpB88w==
X-Received: by 2002:a17:903:22c5:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2ccff679a46mr339855ad.0.1783530325931;
        Wed, 08 Jul 2026 10:05:25 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdddsm30623695ad.77.2026.07.08.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:05:25 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:05:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6DUC7NsIZ20RZD@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak57VeunO8qd4wEh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak57VeunO8qd4wEh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_100527_544355_DA48A9CC 
X-CRM114-Status: GOOD (  25.80  )
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

On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
> On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
> > On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
> > 
> 
> [snip]
> > > 
> > > 3. kho_restore_page() applies the correct refcount pattern based on the
> > >    preserved metadata.
> > 
> > Why do you need to save the type of pages in KHO metadata? For example,
> > for pages or folios, we don't store any type information and leave it to
> > the caller choose the right API. So reserve-mem and kho vmalloc need
> > pages, they can call kho_{preserve,restore}_pages(), and memfd needs
> > folios so it can call kho_{preserve,restore}_folio(). The radix tree
> > itself does not hold the information. The caller knows what its memory
> > is supposed to be so it calls the right restore API.
> > 
> > So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
> > name; we can argue about the naming later)? Then your driver knows it is
> > restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
> > takes care of initializing the pages with the right refcounts.
> > 
> > You won't have to muck about with the ABI in that case.
> 
> +1
> 
> I think this makes sense. The mm already relies on the allocator to
> track the type of pages it has and expectes it to use free_pages or
> put_page() or free_page(), so it is natural for KHO to rely on the
> caller to call the right restore API.
> 
> Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
> preservation can use the appropriate one during restore.

Ack. I like kho_restore_contig, I don't think we'll need a preserve for
this though? Preserve doesn't seem to be preserving refcounts, I guess
we could rely on kho_preserve_pages and the caller can use
kho_restore_pages_contig() to set refcount correctly for unsplit pages?

Thanks
Praan

