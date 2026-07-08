Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD87AC43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I81HX2GmopBIWHT1e1Dpw4r52DG7HH+WAATQwe2SKiI=; b=4tq5eTiRucd+Nz2NYVb6rMjuTC
	G1IZQGabdLToPzni15cR/GMZLIgBIylduynpmto1nf0FPFM2x28HTIFFsYAQpdw3sRNIHDcdpPWi5
	we9cTUb/2QUWyiJktXvKkFh2pYGT6RGBoG7MrKIwbX/517r2BKX1FYbwYmc25mEyXhGaiBI8/wXRw
	kh0BEo8rFR1e6b1cexK6gzgVBq5pwhzn0E89Bb/atak7kebTFueJOPFZ2RSXhs8JuFjdQAKJHaZY9
	WhmPJ4hfbHd7w8QtLTDc7TaxYoV4v4rSGbYpkkKrxz/Mtf6RWjDWK40p/8MQAdqac3QKmrCsl2kgf
	quT6NeBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVrD-000000004Sn-2hNL;
	Wed, 08 Jul 2026 17:14:47 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVrB-000000004SD-1VEb
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:14:46 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cacef7d299so2565ad.1
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783530884; x=1784135684; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I81HX2GmopBIWHT1e1Dpw4r52DG7HH+WAATQwe2SKiI=;
        b=FUIyXzZdfsDkIdi46VC8WWF/+n3uCwVAzu41I81DzV3TDw15UhkUZcSlPdvjnmE1sk
         8s48vHtlKFpU/KfeGug1kTE9vNeLO18EgPsk3XQHkzw2gmrVBmjCQaUta253ezA9biYA
         70/cegu244PMLZYwkbuHY97hvrqZkarikQNmRkpzaOVncTjhubLQ2uasi6ltjFdGlxCR
         90ghjkNm5nYc6pI5hfZSl0pzbGd6Onh3dJx8vXgcNPJiVvqk6b5pgWkvy71fENECgEri
         xrm5REb3RvQA3i/QmeEEM2lkvY1aukudaxgsgkPlic+NMljAB0ASiQHRVDFK8xAHQ3Hf
         XV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530884; x=1784135684;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I81HX2GmopBIWHT1e1Dpw4r52DG7HH+WAATQwe2SKiI=;
        b=c5/k7w23MIfe0b8/j4E8VsQr+nQwNluGlEoaHG1rVDDzHhNh3yBxLYVsyEP34C7gEq
         wKq314i38t8Jq2fXKwYtbKefNeDe3iA4uzjFzLVJiwQsD++8eKd8/3gBtlkb5oFErBaj
         Xp76W84+EjdQBTNipkmAN/OBpnASv869JSv6EjGX3H8gx7TJ15FtK6eBvLgU/JRRUIXo
         sf2iOQCGeRjtvTcv0debjBHcKR1QxyejaGR28oTs7Eb8u14LNdNTzcTXRJv3gyT/Ed/Y
         Q3tB1XYkkvOZu7xOQNSCwnunoL5NppItIhh0I/baPko4aPL5CkhW/kw+SAQ6IUz97WLs
         3ICA==
X-Forwarded-Encrypted: i=1; AHgh+RoNSmN2YRym6bzqcqf2RsFCQYzgErnFu+MWrXZGBa5qv1XkyBT3Ad87XEFQ2Mj7y54nGQJ7TA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfifChYzUivSObWlzOx+JSvZOEF0ssBK6f3bObX4xPxmzpzfMs
	4CWPKEc6KubcP7F0DlygFIyCqgV3Pq5W0MXBPC0B4qDxIAOU7T9ls2C0hulQl7lg/w==
X-Gm-Gg: AfdE7clJHgbnFxklnFr5BQhI4RSOLGSLtPu2yBFob+lliMGUMaYGF8hiCD1mCqz3bS3
	pDejKhftSocquyVrOAguHqkdlBXfZwrUmJzQu/6bROYXFdzmT3NPkOPyBn32k7WRthzv2Buvl3v
	aTB7U4RIkxwyROa4fWA8U3cuZbPCOdbmi+VRCusJzoqYCJgt87b/vrEUFCnK5WmkQjx3wq6OqSr
	AaT9V1LMGqC9f1+0w/wpjSEB097pLs1ulNDm/OqBv5n1T65ZgWf1XR+92Mf9Antz5M5y7fxxoI9
	81pQp/yylFhGIZo46sHHl8rKVwUUNQQOZEm+WlAxgUVBtUngN+6N2sSr6sn5GmLVEfKZ4DNKVz2
	Bpp7rMID9hO1O9hjH1ethvks4StEYyy1de+VDdDXFoQAyvr/s9HWGphGzc4NZkdlffKSctOqd63
	xZD3o2IgL112xpuC6N3vVPIFeETBQoJ5p1VKkDJptwBRH3td1a0kEIOTWr5cv4TNeJxnyGs8mSf
	txghMea8SM=
X-Received: by 2002:a17:902:cec1:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2ccff91bcfamr243315ad.21.1783530883940;
        Wed, 08 Jul 2026 10:14:43 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6162esm7529105b3a.11.2026.07.08.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:14:43 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:14:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6FJf8jUGudEw0c@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak57VeunO8qd4wEh@google.com>
 <ak6DUC7NsIZ20RZD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ak6DUC7NsIZ20RZD@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_101445_399362_2C989342 
X-CRM114-Status: GOOD (  25.10  )
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

On Wed, Jul 08, 2026 at 05:05:20PM +0000, Pranjal Shrivastava wrote:
>On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
>> On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
>> > On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
>> >
>>
>> [snip]
>> > >
>> > > 3. kho_restore_page() applies the correct refcount pattern based on the
>> > >    preserved metadata.
>> >
>> > Why do you need to save the type of pages in KHO metadata? For example,
>> > for pages or folios, we don't store any type information and leave it to
>> > the caller choose the right API. So reserve-mem and kho vmalloc need
>> > pages, they can call kho_{preserve,restore}_pages(), and memfd needs
>> > folios so it can call kho_{preserve,restore}_folio(). The radix tree
>> > itself does not hold the information. The caller knows what its memory
>> > is supposed to be so it calls the right restore API.
>> >
>> > So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
>> > name; we can argue about the naming later)? Then your driver knows it is
>> > restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
>> > takes care of initializing the pages with the right refcounts.
>> >
>> > You won't have to muck about with the ABI in that case.
>>
>> +1
>>
>> I think this makes sense. The mm already relies on the allocator to
>> track the type of pages it has and expectes it to use free_pages or
>> put_page() or free_page(), so it is natural for KHO to rely on the
>> caller to call the right restore API.
>>
>> Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
>> preservation can use the appropriate one during restore.
>
>Ack. I like kho_restore_contig, I don't think we'll need a preserve for
>this though? Preserve doesn't seem to be preserving refcounts, I guess
>we could rely on kho_preserve_pages and the caller can use
>kho_restore_pages_contig() to set refcount correctly for unsplit pages?

I think for consistency we can add both, even if preserve doesn't do
anything special internally.
>
>Thanks
>Praan

Sami

