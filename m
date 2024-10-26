Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B161CD10BE3
	for <kexec@archiver.kernel.org>; Sat, 26 Oct 2024 06:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MmtPLDU1AQ8+vYWuAAgNvcGpU+ezOz8I3tiVtvPORtk=; b=ANTP/Utzr54qp6
	3tHv6GXMU5NdE62DH04WabtL0aRFE09ahFoeamtCG0ENev7dCI2BtnxuD0x22F8v+f0RabGlHcI7B
	pLlfWe/c9kNPVeq7/Rr1+16z8ZCk+VTDjZNxtZLgpgHzLbUbhd9PSoRC1r4gnI5D2U3+jVRpnRDhl
	BQYGn40ESfV2W1Mg0yKd6eWfWcSRi6rephYzUN2L23Qx/TV8FsZcQzl4y3sYZc3R7CmbCIqcCglLe
	PN+uQiyg4WWXY5qWv3cJnDw+H8Z4BUWSPo8BbVK8imMA9rdtFpcJvTxu5xPjInKwsqq8HMGTvp0qg
	CNxcjt1OHz82Uf265Amg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ZxU-000000061Bg-0c5J;
	Sat, 26 Oct 2024 06:07:32 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4ZxR-000000061B1-3ZGJ
	for kexec@lists.infradead.org;
	Sat, 26 Oct 2024 06:07:31 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso157425ab.0
        for <kexec@lists.infradead.org>; Fri, 25 Oct 2024 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922849; x=1730527649; darn=lists.infradead.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQSPHe+PJtxEzujGUtNL873qp26GJXxZytaxypHA5kI=;
        b=R+AtZWj8SABF+AMpziLcbkr5G4Dx+cO12nN4B0oZjWwnGtZXQPHCuR7pHxHXjR482U
         d6poXH9H3DtNHqGNSet4VtnrDzKM1AVemyq/M+KZZ1VyjDarHQBoj6tbrU2gqTxFzfCf
         YOmPKGWvg17+KWDGNXiogLEr4g/7xLSSfTNgW0IqBWK8Oy8XrvJXibKSkaxJdcag+Jns
         nHz1WDM7BEGt6avgVXfn/s6XwwbR4YrHE3pl04l8rsGXhU2gCGQSkvpVlal0mitGBZFQ
         AeOuTUEW+0/rNvS/zULLD/PWo91Xpb1AJvF0RJEU8s2sDnCB6+J2iYJmqUw4MN5II5ow
         5r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922849; x=1730527649;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQSPHe+PJtxEzujGUtNL873qp26GJXxZytaxypHA5kI=;
        b=eJ54OsG8vr387Oe6oOPDNShwKb9AHaQJUDl4bzlavQG5Ie4AFNrzGc4I1OKIOmRCj1
         0y5jJrcyR6fEi+65Pay4/lrlos6JmU7XYli7zejBxjTfQJmX7WqnxcsrxHuSmUr9IdAL
         4t276MFK/MlF8O7eOHyKBEMProkOxQDs1LUFXKVpePBcx62iJdG4f6v1bhba1Iy/F5rN
         XWM4uj7tQWaG0IMJPM4cjNBz43n14q+e+GJe9SFQkW6AogfLo5tfJDJ4B5a9TzThylNu
         YBi1SB7F6yx7rLOM5S3xs0GMahfyNKaHq0qZlqeGGy22lgy6Q+u2EIc2TlvcDAzpTM9o
         KPlw==
X-Forwarded-Encrypted: i=1; AJvYcCXwL7YSbrMyU80hnbKHuWQe6qrAHsAd8kgqQMZZjexzrR41EruRJ616fL4wI8o9bYJ5Apu0cw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yznmf7pFR8MvB29gj+5BUgf5nS2KVaSWa2Rh6cqhNLJBv6SKFfW
	zxjq5gr5y1rQ9RW5xWo13ESnZMwUBhIRPB20p3H+W8avK5G4Ay58d7o6BANRTg==
X-Google-Smtp-Source: AGHT+IHnGileZkvepxLdTSybvUnOAtRRrxty8+lkuWaRJ6nqZp9GWgJxqbOMP+zu3Uk5mBAi7NZuKg==
X-Received: by 2002:a05:6e02:1a86:b0:3a0:aa6c:8a50 with SMTP id e9e14a558f8ab-3a4edfcc5cbmr1355895ab.29.1729922848679;
        Fri, 25 Oct 2024 23:07:28 -0700 (PDT)
Received: from [2620:0:1008:15:a73a:2b46:3ef7:2150] ([2620:0:1008:15:a73a:2b46:3ef7:2150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fe5fsm2091901b3a.160.2024.10.25.23.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 23:07:28 -0700 (PDT)
Date: Fri, 25 Oct 2024 23:07:27 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Mike Rapoport <mike.rapoport@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Ashish Kalra <ashish.kalra@amd.com>, 
    Tom Lendacky <thomas.lendacky@amd.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Frank van der Linden <fvdl@google.com>, Vipin Sharma <vipinsh@google.com>, 
    David Matlack <dmatlack@google.com>, 
    Steve Rutherford <srutherford@google.com>, 
    Erdem Aktas <erdemaktas@google.com>, Alper Gun <alpergun@google.com>, 
    Vishal Annapurve <vannapurve@google.com>, 
    Ackerley Tng <ackerleytng@google.com>, Sagi Shahar <sagis@google.com>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: Pmemfs/guestmemfs discussion recap and open questions
In-Reply-To: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com>
Message-ID: <5b6613bc-beef-79e6-62ed-23de4dfafe51@google.com>
References: <f44f317a-2dcb-cfe2-013c-7508907ce3df@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_230729_921396_4CB58BBA 
X-CRM114-Status: GOOD (  23.96  )
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

On Wed, 16 Oct 2024, David Rientjes wrote:

> ----->o-----
> My takeaway: based on the feedback that was provided in the discussion:
> 
>  - we need an allocator abstraction for persistent memory that can return
>    memory with various characteristics: 1GB or not, kernel direct map or
>    not, HVO or not, etc.
> 
>  - built on top of that, we need the ability to carve out very large
>    ranges of memory (cloud provider use case) with NUMA awareness on the
>    kernel command line
> 

Following up on this, I think this physical memory allocator would also be 
possible to use as a backend for hugetlb.  Hopefully this would be an 
allocator that would be generally useful for multiple purposes, something 
like a mm/phys_alloc.c.

Frank van der Linden may also have thoughts on the above?

>  - we also need the ability to be able to dynamically resize this or
>    provide hints at allocation time that memory must be persisted across
>    kexec to support the non-cloud provider use case
> 
>  - we need a filesystem abstraction that map memory of the type that is
>    requested, including guest_memfd and then deal with all the fun of
>    multitenancy since it would be drawing from a finite per-NUMA node
>    pool of persistent memory
> 
>  - absolutely critical to this discussion is defining what is the core
>    infrastructure that is required for a generally acceptable solution
>    and then what builds off of that to be more special cased (like the
>    cloud provider use case or persistent tmpfs use case)
> 
> We're looking to continue that discussion here and then come together 
> again in a few weeks.
> 

We'll be looking to schedule some more time to talk about this topic in 
the Wednesday, November 13 instance of the Linux MM Alignment Session.

After that, I think it would be quite useful to break out the set of 
people that are interested in persisting guest memory across kexec and KHO 
into a separate series to accelerate discussion and next stpes.  Getting 
the requirements and design locked down are critical, so happy to 
facilitate that to any extent possible and welcome everybody interested in 
discussing it.

James, for the guestmemfs discussions, would this work for you?

Alexander, same question for you regarding the KHO work?

It's a global community, so the timing won't work for eveyrbody.  We'd 
plan on sending out summaries of these discussions, such as in this email, 
to solicit feedback and ideas from everybody.

If you're not on the To: or Cc: list already, please email me separatel if 
you're interested in participating and then we can find a regular time.

This is exciting!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
