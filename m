Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11577D58D69
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MScn8ssJmjWFzuQu613/bokENlntta6i81Ip2l7cj5c=; b=VQ319yD/VxPXrA6QDttuPbMurK
	Djt3+UWZVjIHjbLRIieIrg3/2gvByyPksP2fZl0/lZSNLMm5B4+s/RkXkG8ZfUh6MXzgt8X7HVWqf
	nohnSlzcMK7NK96vhryykD+eHY4jP7nkFVtlu/HWsSAjfZQzTsARA3TvGO7I/a6fd0wadWhUlOCLZ
	mzIyjndzcwd17qm6Uy37dcYIp2CUi1AyBwca7S53lDAeiKnEpo120SB+MVBgPohj+gbp8Gpz6/kOu
	y2wrYywoYejxWy6pszr76m0uMMoBMLtM1GMbo8Ny7h3YmqIJbKmER/9dwAOwR82dfp5nDGuZspgRj
	P1CEfv2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcKK-00000008fap-3m11;
	Mon, 25 Nov 2024 16:52:44 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcKH-00000008fa5-0DNE
	for kexec@lists.infradead.org;
	Mon, 25 Nov 2024 16:52:42 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-21238b669c5so232585ad.0
        for <kexec@lists.infradead.org>; Mon, 25 Nov 2024 08:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732553559; x=1733158359; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MScn8ssJmjWFzuQu613/bokENlntta6i81Ip2l7cj5c=;
        b=op0qDRwu4WeIU3ntTo5fX17o/+jQZ3+0pvsbV0207nqsHk385eSq4EdgxSpjWhJAd4
         I6KZ858fhH+R23YTLuCqeCf0ZymQB/Mzad57hd9w8v3yr6TrDrGOMyR2TTr/IVx+BkUr
         Ctn4Y0ywkpVgVnqrmHH9CgbmiP/ewPYzUmJq0FaY3gZT7tkr/WXwrs5U9oWSPf5ex+h8
         B+YCihvZERI80G4svFLQkv/L10kPtdti/yUokbbZrAy/m9gdD9/6B44IuLglpfMZXByh
         kv4FWq+6nyZtxf6V/mXnQIZgI9U1sj9CoQHrI5lmIVjqdcO9GLvIE+2OIMYdUJaDzWAn
         zuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553559; x=1733158359;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MScn8ssJmjWFzuQu613/bokENlntta6i81Ip2l7cj5c=;
        b=jQ407wK2I/wYK2kwyImGSBMHmx4ovdUvoT+OCeS0XmJqmAx+QfPmYsEHYMfH1+RQYg
         c1dtGKf6KGN6Rlropu8WQ4NWp/egy/sDUsF4hf4x2YQJbqgZwduWWdZ9vs1zwgZWWVkv
         wp0UB8Ro0o3cnYWOyEq6H0p5+9r03MLvNr2z8OJteVnFDPEHJB7NAFDmvvciNGWB9JbR
         u48q/HZDGZa+7Jt9YR0lFrcUv+aVMTeR862OF7v4JX8KgPg6ASqjl4S4GkCuCqxMS2zC
         gfYPOXfbaPuky1/j8h5DpFy8MI6MxrD2PD4tEAdKZ25+9el2vVvKdQKuL11GCBjaFtSj
         GJQg==
X-Forwarded-Encrypted: i=1; AJvYcCXMzpEB/EMJpFGnCkotnt29QnDpK9mt9kuGeOO9mmfCernUAJw1gIOQHyQMizECREKt3lrzUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyd4aTI15J+3RLN5induzVKun34/wgZJUrC5l8zjVJm8szvmk0Q
	/8Q5lFG5AlVJpJmI7v0Ys2vEvGv84QREJK368gmlwehLJtUd+Hnt42txKEybIQ==
X-Gm-Gg: ASbGncsTem/52QjrnUgpbLmObbDraE2P8JeYh76AAm09V0yIXa8dR4LG1YVrDT34C79
	ipa2wZpWlzf1ETNGWstOnNQMbVCXkX1t6EyEeh9mbnJbAnWicROHZWcfwMwzvW4AYvTG6vPG33u
	R5m1XQaUEperIeGqKcloNXiG3yM+UgtRZKHMz1HugIRWd+9LVfsv0uvZicEURyJEZcW8+G27rMz
	9cs2HshupW5t92MAHyYQsIEFMjVRtvSd63geOihlwY03xG9pdW+vt4zjYXaN3GnrB05L8UWJok=
X-Google-Smtp-Source: AGHT+IEBd19iekqPFlRwdUM1tCHOJZ5TfF8QZGZ2X4tJVfFvBwvTzWI0r4flhCa1scoUGZh3OLrM2Q==
X-Received: by 2002:a17:903:40c5:b0:207:14ca:f0c1 with SMTP id d9443c01a7336-2149a798087mr4712665ad.16.1732553559236;
        Mon, 25 Nov 2024 08:52:39 -0800 (PST)
Received: from [2620:0:1008:15:cc4:72a:36c5:7a9b] ([2620:0:1008:15:cc4:72a:36c5:7a9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d063d1bsm6949041a91.52.2024.11.25.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:52:38 -0800 (PST)
Date: Mon, 25 Nov 2024 08:52:37 -0800 (PST)
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
Subject: [Invitation] Linux MM Alignment Session on Kexec Hand Over (KHO) on
 Wednesday
Message-ID: <3913c651-9173-32ff-174b-1ac7c4ab1309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_085241_087030_F3570A78 
X-CRM114-Status: UNSURE (   9.13  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi everybody,

We host a biweekly series, the Linux MM Alignment Session, on Wednesdays.
We'd like to invite MM developers to attend and will announce the topic
for the next instance on the Monday prior to the next meeting.

Our next Linux MM Alignment Session is scheduled for Wednesday.  The
details:

Wednesday, November 27 * 9:00 - 10:00am PST (GMT-8)
https://meet.google.com/csb-wcds-xya
backup: (US) +1 347-682-5874 PIN: 356 962 072#
international: https://tel.meet/csb-wcds-xya?pin=1301132214803

This week's topic will be a follow-up to a session last month, this time
specifically on Kexec Hand Over (KHO) led by James Gowans, David 
Woodhouse, Alexander Graf, and Mike Rapoport.  Slides will be available 
after the call.

There is lots of interest in this topic, as well as iommu(fd) persistence 
and guestmemfs, so feel free to forward this along to anybody else who may 
be interestd!

Also: if anybody has ideas for future topics, please let me know and I'll
try to organize them.  We'd love to have volunteers to lead future topics
as well as requests for MM topics to be presented.

Looking forward to seeing all of you on Wednesday!

