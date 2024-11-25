Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D8ED58D69
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0Eppn8ZRBULBO8mV9n2eyB7k6VLTPpJ/SGt1N8ZO3Y=; b=1+XCDSxTQLq5gnbyai4s97RD3W
	JEtgniSFoFWlX8XQVszAnUaihfMrHdVIXC0JjLFysOLD5y5NeNbRVlDTEbyl2eQCrC/O6+0dzencu
	yf+ezlSXT+7IS7wr0k56PzEBAjXrEtlIaHhyrZ4EaT2OX7LC6N6UTZlA6JikoxW4GB4povuHIWFuD
	M5Q9vyQXuEleaWpAQlI3nzEpHpjbWHlFmQ4f06mRCyOfFhZ6eqdfLfzrHSIZg1AXRdJqU3QQbIjQZ
	QxxDAEPQ48/9l3g9xvUtAG6lOYAf+AwTvaOqHCR0+CVqLD5RZk5ntXPLIBP0/y7BB29kZt31xxT00
	aFwGQO0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcUl-00000008hLL-0PrF;
	Mon, 25 Nov 2024 17:03:31 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcTo-00000008hAt-1ITD
	for kexec@lists.infradead.org;
	Mon, 25 Nov 2024 17:02:33 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-211f1a46f7fso236225ad.0
        for <kexec@lists.infradead.org>; Mon, 25 Nov 2024 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554151; x=1733158951; darn=lists.infradead.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Eppn8ZRBULBO8mV9n2eyB7k6VLTPpJ/SGt1N8ZO3Y=;
        b=f8htEXNcusB7fEJvNL2rZBF3ZSEAfVMRkeBlLHA7n5J64d6/vUtizd8qnAF8PYsERq
         VlsciocF0rp+FGOwg7z2M7+Yp2MKdWxVmO2m9y4j/hjTkWeCA1TpYon3egnw6sbFbMyy
         OQ0EhOf3o2z23Orlc8C4sbndBcrcnIkJFQzyU2KUBYHTP3wEwsvUlsgn+ZF+SLBqh+rT
         yE1OBbN+tSubfmSIFhNIzVOnFMcGpeWhAv3sQ+5/brcLuKz51z4PQ4edwZPdwZR1BKeJ
         CQyl07sHjTh7AlLGZWu9wsiZtXu+E1FdVhkRn1/rHIm0Hewi3iQ9QS64EEePa9KROG7+
         BRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554151; x=1733158951;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0Eppn8ZRBULBO8mV9n2eyB7k6VLTPpJ/SGt1N8ZO3Y=;
        b=p4KHP9xp3wXKfEsRHMTytyZAgCj5gxdwUUsg44hBJKF15YipYHS5Avtewk3lbDexNh
         NkmZ5Kkh/uh4Lh1kYXKpFvq0bzKXqUnqb3cd7sRK0x6ewcW1R3v1PvqsLPxEp5yvJLtw
         t+tqEOWefAQZfZYTVxgsSEhK+4jEyd0Et8drBfYZ/kNemUy8gKjCcPAbboZalQE6vPJS
         xzvFLQMhIdXsds9Ui0PtnZuZQ7CB2tKFAEiSeSoRvYIehMKONavhIzHbVrdB3hpphdL7
         5SNPoPGKJwDsBxSQSazTGVdu/JwbcOWjo663FMdYfxSW8AQ0z/fywNcIVOo23iLgEgJo
         C9CA==
X-Forwarded-Encrypted: i=1; AJvYcCVlzGbBS1yjklqyi16YY2RBYYwr2s0vwdD5UTRcxchm8p4TQuFuWefGd/Fh8i/PzYtRS2pgTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTiYcZmX0mkxHkuTkgK6Bm4wJAXGImX3mRY+KpIDWd8zy68Y8H
	g8nOdU2D4mONYSm7RYc+fqLHfXCtkJ+zfm5b1VHuFwU+g60VX3S9TWsi4z2kxg==
X-Gm-Gg: ASbGncv6T6UVB4aqrNQTKeJTb/KDD4Dl5Rskv/v8I+s5i1AiH/Eip2DZi4/GFZIamW9
	4gAR5lA/Gl/TTRODl80D38WVeuPaOngU1SMW5E9RzaXLB52I+s+fxHtaIPaZ7vO0DR5LGJGHPIy
	tawM2qhWMy7/Jt31mrkxoYyKxAb1M1xSg97itXlZZ6LaGpT5nPONN6xBYM7P593wP6AIE757H+i
	JUSJCPKt4NJjuLhCRUAN8I4i3u2wFB0n+4BmoSbnNt9etybeMZip8uN7XM6pkH1DFYOcBumJMs=
X-Google-Smtp-Source: AGHT+IFOn4vhlmVR/VWfjQd3ef7ZgpE4NnL4mHJn/1ef1H0m3EI0wMaX4v3hvaXUvGkIQJFW2M5SpQ==
X-Received: by 2002:a17:902:f789:b0:20b:5e34:1850 with SMTP id d9443c01a7336-2149e0e6730mr3998255ad.23.1732554150620;
        Mon, 25 Nov 2024 09:02:30 -0800 (PST)
Received: from [2620:0:1008:15:cc4:72a:36c5:7a9b] ([2620:0:1008:15:cc4:72a:36c5:7a9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfed7esm67295915ad.148.2024.11.25.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:02:30 -0800 (PST)
Date: Mon, 25 Nov 2024 09:02:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
    Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mel.gorman@gmail.com>, Michal Hocko <mhocko@suse.com>, 
    Mike Rapoport <mike.rapoport@gmail.com>, 
    Pasha Tatashin <tatashin@google.com>, Peter Xu <peterx@redhat.com>, 
    "Rao, Bharata Bhasker" <bharata@amd.com>, Rik van Riel <riel@surriel.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    "Shutemov, Kirill" <kirill.shutemov@intel.com>, Tejun Heo <tj@kernel.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Yang Shi <shy828301@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Alexander Graf <graf@amazon.com>, 
    James Gowans <jgowans@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
    Andy Lutomirski <luto@kernel.org>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Jason Gunthorpe <jgg@nvidia.com>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [Invitation] Linux MM Alignment Session on Kexec Hand Over (KHO)
 on Wednesday
In-Reply-To: <3913c651-9173-32ff-174b-1ac7c4ab1309@google.com>
Message-ID: <6284a071-ec6d-d441-b1e7-887fdc36e2f5@google.com>
References: <3913c651-9173-32ff-174b-1ac7c4ab1309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_090232_349332_FA1B29B0 
X-CRM114-Status: GOOD (  17.21  )
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

Since the timezone changed recently, here is the world schedule for 
reference:

PST (UTC-8)		9:00am
MST (UTC-7)		10:00am
CST (UTC-6)		11:00am
EST (UTC-5)		12:00pm
Rio de Janeiro (UTC-3)	2:00pm
London (GMT)		5:00pm
Berlin (UTC+1)		6:00pm
Moscow (UTC+3)		8:00pm
Dubai (UTC+4)		9:00pm
Mumbai (UTC+5:30)	10:30pm
Singapore (UTC+8)	1:00am Thursday
Beijing (UTC+8)		1:00am Thursday
Tokyo (UTC+9)		2:00am Thursday
Sydney (UTC+11)		4:00am Thursday
Auckland (UTC+13)	6:00am Thursday


On Mon, 25 Nov 2024, David Rientjes wrote:

> Hi everybody,
> 
> We host a biweekly series, the Linux MM Alignment Session, on Wednesdays.
> We'd like to invite MM developers to attend and will announce the topic
> for the next instance on the Monday prior to the next meeting.
> 
> Our next Linux MM Alignment Session is scheduled for Wednesday.  The
> details:
> 
> Wednesday, November 27 * 9:00 - 10:00am PST (GMT-8)
> https://meet.google.com/csb-wcds-xya
> backup: (US) +1 347-682-5874 PIN: 356 962 072#
> international: https://tel.meet/csb-wcds-xya?pin=1301132214803
> 
> This week's topic will be a follow-up to a session last month, this time
> specifically on Kexec Hand Over (KHO) led by James Gowans, David 
> Woodhouse, Alexander Graf, and Mike Rapoport.  Slides will be available 
> after the call.
> 
> There is lots of interest in this topic, as well as iommu(fd) persistence 
> and guestmemfs, so feel free to forward this along to anybody else who may 
> be interestd!
> 
> Also: if anybody has ideas for future topics, please let me know and I'll
> try to organize them.  We'd love to have volunteers to lead future topics
> as well as requests for MM topics to be presented.
> 
> Looking forward to seeing all of you on Wednesday!
> 

