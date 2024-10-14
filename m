Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A8D18157
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3gM5AYAOGlyOAz5aW7JOGzqE9fQAywmXE55LVk3U5j8=; b=Sy+t5g5CnSLWuw
	ahWNQRwPmTdfJ3pj5AXVUtS0Gvq2fVu/a7nUm4o0bci1tsoOIq/jjHBkELx1ZCElC+XUHIx+OygpF
	xhvedzxg4wfuybF+EEUcWxX8t1U74bB0KA9Udf55lV3lR/P5yqSzImkxbZbzh0yb+UB9UzJrbd9ja
	Y++xEcflOiTCpzqNoH4GDncINHwEPxRfERR+ufvMe3YWs+AzuvZuK0+NKaCW99MEeOO2eKUnaaWsr
	61luIWrI7rNTNBJSuKgdMBucKS2Kg07yFBughIwUc+z+JWrkqhHQBFdGtQc/ATPRpkTlHxiLqg9ES
	mO5A0+v62TM+IkNHT/0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0UXQ-00000006cou-0Ty2;
	Mon, 14 Oct 2024 23:31:44 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0UXM-00000006clf-1SOW
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 23:31:42 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-20c8ac50b79so353765ad.0
        for <kexec@lists.infradead.org>; Mon, 14 Oct 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728948698; x=1729553498; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gWTMPTNCC/8Upu0C8zzRCEaq4eVE5b9bz7f1nd++as=;
        b=a11T0GYxSf1pMeZxmYn5Pl4JLRZRVoWW/EFLiwn2GYz9G7/wS9WlpzQmcfuCVA0+a7
         GWGvp7TUnI1/P/S/TGGNG8+fWBJo+IezcYp64BPM/A9qk/jnDTOVOAD7VuBSH/Sgidt7
         /sHq7cUqDhWZnWBxlDSrXitjDYbV8bw7nkQvIEbuWQdBdtdNdrxNF6qy9U4X7P6JtbOq
         uCsjiCjgK+EVMT9AUdbLf9ZAU0zxGC0Q85rOZNnezwTjvHkIDdpIAGITMOdj4p9vgTqt
         ROdE2Dp8bKcxzNVR79gtU1Qwb03yGYY2QcE6HqrE8DvGkZG0lChQHIz8s3RQ1StDWiFD
         8eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728948698; x=1729553498;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gWTMPTNCC/8Upu0C8zzRCEaq4eVE5b9bz7f1nd++as=;
        b=jLtscS8ily5fNsciFOi70hoOnphxsCwPqYfOGLtnnI6+bfybpe3dBG7MAaZ9yBE5R8
         mjW4dg4DXUSHm2nU095YkI6dqRHNvrxduhK3wTiNye6y0O5i4K93wngWXrolwFyJLql1
         7C7Ppf2bKbxKsCi50PjrBdhbZC1ljDm076OOrF1l+8SuEtxGxPlCJcvTnxHmiOzQm33u
         XdEYVe2lELsGNuOfsJxFkz9Hnc6FazO07wiyhcIzMuGrUkPVyWpk9U5JS4yuNFVlycaD
         e06ylbC+YkuieOxz6Yh3G4LfSKpsOkdLqWN6s3d1YliebVK5L8JgFiHCOhwOK/yGNjCN
         vkHg==
X-Forwarded-Encrypted: i=1; AJvYcCVdoHIPDIkuS6nZicBKLWk2YdxWozOa6n32H2iIU4pkyjun8sn/CwNksxsixkrd30DAXIEfMw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxW5MzZ8GYMFcJVYyu6f+urT6fKxXpdz9kTrJHacUF3U4PTBUP9
	msH3vKcJZhYG0tUXwCFbhK+NTWkCtsMDIgdo0h+FOloW8kBpzbCyZUIf/4g37Q==
X-Google-Smtp-Source: AGHT+IHSw8oadufVZhm066765u8QHv90EcT5p2Ss3yjBXT8IeUrK5FRockfraK5NiDwBudQlzrTYug==
X-Received: by 2002:a17:902:e5c9:b0:205:60ef:18af with SMTP id d9443c01a7336-20cc0300a99mr4594555ad.29.1728948698239;
        Mon, 14 Oct 2024 16:31:38 -0700 (PDT)
Received: from [2620:0:1008:15:438b:95ea:de9c:e1d1] ([2620:0:1008:15:438b:95ea:de9c:e1d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036681sm757415ad.122.2024.10.14.16.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 16:31:37 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:31:36 -0700 (PDT)
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
    James Gowans <jgowans@amazon.com>, Ashish Kalra <ashish.kalra@amd.com>, 
    Tom Lendacky <thomas.lendacky@amd.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, Andy Lutomirski <luto@kernel.org>, 
    Anthony Yznaga <anthony.yznaga@oracle.com>, 
    Jason Gunthorpe <jgg@nvidia.com>
cc: linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [Invitation] Linux MM Alignment Session on IOMMU(fd) persistence
 and Kexec Hand Over (KHO) on Wednesday
Message-ID: <c85a45fb-7b21-4f9f-568a-e86debbd001a@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_163140_408518_DD66A1F8 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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

Hi everybody,

We host a biweekly series, the Linux MM Alignment Session, on Wednesdays.
We'd like to invite MM developers to attend and will announce the topic
for the next instance on the Monday prior to the next meeting.

Our next Linux MM Alignment Session is scheduled for Wednesday.  The
details:

Wednesday, October 16 * 9:00 - 10:00am PDT (GMT-7)
https://meet.google.com/csb-wcds-xya
backup: (US) +1 347-682-5874 PIN: 356 962 072#
international: https://tel.meet/csb-wcds-xya?pin=1301132214803

This week's topic will be supporting iommu(fd) persistence for live update 
and Kexec Hand Over (KHO) led by James Gowans, David Woodhouse, and 
Alexander Graf.  See 
https://lore.kernel.org/kvm/20241002185520.GL1369530@ziepe.ca/T/ and
https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/

There is lots of interest in these topics, so feel free to forward this 
along to anybody else who may be interestd!

Also: if anybody has ideas for future topics, please let me know and I'll
try to organize them.  We'd love to have volunteers to lead future topics
as well as requests for MM topics to be presented.

Looking forward to seeing all of you on Wednesday!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
