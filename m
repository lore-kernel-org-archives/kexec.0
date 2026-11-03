Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8A606A336
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y7s62a6X;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BgTIjVx8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=plPOmmg8Wbucg4dOntyZK89XdF19GIkTemSi8VnEEAM=; b=Y7s62a6Xr1vJopY7oW++rUY2B4
	/1s3Kh0hUxrNWHi1JEhoZqzSWdLMBGpN37WmNYusEG1Of3484XmTNO9IDQpgjaWBMWAYAO/hk1t2Z
	u8mHwciS0Ak//m1LIr1deXNiDlDruQCU5sG90H1qTM8nT5P49YaeFVxE+oj2JNDZmvkviw6NYxmtp
	SfaTWgIb9tS/LOnlb1hYSjhcZ9rGKoMKhipctSOmzU4tmiLLdWS+FiFmQbq1/zmyl/EASKok0tzdo
	xTmZ1927Wa0pOeKCnj/ZqfdCssbH+1TChmMZfuSOx+n9Z9CoDsmy0Yaxgyc0PsLJPkbAmRUuBh8xP
	AqEaR0ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4L9-00000000spj-3B9f;
	Tue, 03 Nov 2026 02:33:35 +0000
Received: from out-26.mta1.migadu.com ([2001:41d0:203:375::1a] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4L5-00000000sp7-1cdm
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 02:33:34 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=QEpd6a+5vyb7YKmH2HfXuDiiboBz4CjeIOL7fouBhLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793673205; v=1; x=1794278005;
 b=BgTIjVx8nAsBtP3F1/GUXtMqw3pw4OJEPGpQ++uutFfQds3NbRcIfmcp3GNAGaLK7RPpjY/S
 yw/Uj5HTzpBk3eyf5tM9Jsqi8rj63sDupbOUjOGiN5/9gjgHzyT+vi9Zyr+9DoBdCp16aZJbRus
 vipK+BIW9Sgzd5Lh3Bd6yy9Q=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 09cae95fccecce83;
	Tue, 03 Nov 2026 02:33:24 +0000
X-Mizu-Trace-ID: 09cae95fccecce83
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 10:33:19 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Barry Song <baohua@kernel.org>, kasong@tencent.com
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, muchun.song@linux.dev,
	ridong.chen@linux.dev, sj@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	ljs@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, kees@kernel.org,
	peterz@infradead.org, jannh@google.com, pfalcato@suse.de,
	hughd@google.com, pasha.tatashin@soleen.com, pratyush@kernel.org,
	willy@infradead.org, jack@suse.cz, ziy@nvidia.com, riel@surriel.com,
	harry@kernel.org, apopple@nvidia.com, nico.pache@linux.dev,
	ryan.roberts@arm.com, dev.jain@arm.com, usama.arif@linux.dev,
	kas@kernel.org, matthew.brost@intel.com, jhubbard@nvidia.com,
	peterx@redhat.com, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, osalvador@suse.de, minchan@kernel.org,
	xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
	gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, josef@toxicpanda.com,
	stable@vger.kernel.org, usama.anjum@arm.com
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <aulH7zeGrjIvF8Hs@fedora>
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
 <20261031055838.60138-1-lance.yang@linux.dev>
 <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
 <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_183331_594383_4F52A46C 
X-CRM114-Status: GOOD (  20.43  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/03/26 at 04:11am, Barry Song wrote:
> On Sat, Oct 31, 2026 at 5:42 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 10/31/26 06:58, Lance Yang wrote:
> > >
> > > On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
> > >>
> > >>
> > >>>
> > >>>
> > >>>
> > >>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
> > >>> for the maintainer role.
> > >>
> > >> +1
> > >>
> > >> It would be great if they could take this over.
> > >
> > > +1 from me too ;)
> > >
> > > They both have been really active on MGLRU and doing great work for quite
> > > a while. No doubt they'll continue to do so :D
> >
> > Fully agreed, we really need some people familiar with this code to help
> > maintain it, and Kairu and Barry have most experience on this.

Agree. Kairui and Barry have done so much to review and contribute
patches to MGLRU. The nomination is well deserved.

> 
> Thanks to Ridong, Muchun, Lance, and David for all the
> kind words. Your encouragement is truly inspiring!
> 
> >
> > Just a note that I also don't want to pressure into such a role (which comes
> > with responsibility).
> 
> It would be a great pleasure to work for the MGLRU
> community.
> 
> Over the past few months, we've seen many active
> contributors join the MGLRU effort. It feels like MGLRU
> has never been this popular. I'm really glad to see the
> community growing.
> 
> I may have missed someone, but besides Kairui and me, I'd
> like to mention Baoquan, Baolin, Hui Zhu, Ridong, Kunwu,
> Maxim, T.J., Siddharth, Xiang Liu, Bingfang Guo, Shakeel,
> Zicheng, and many others.

Thanks for the recognition, Barry. MGLRU has always been on my to-do
list, I will come back to catch up to review and post queued MGLRU
patches after my xswap patches are posted.

> 
> It's great to see so many people contributing to MGLRU!
> 
> Best,
> Barry

