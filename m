Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EB606A31E
	for <kexec@archiver.kernel.org>; Sat, 31 Oct 2026 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bMrkYvbl;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WvaC4FsD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wHHnuTTmSOXbH6E8lHg0GEvp+GQz96PM/IlXLU1wjgs=; b=bMrkYvblSoLMmD
	oCox2h/Pg3SZ9sszLZOkdXukjGdnaLszJWXIMA5B6WV1rbQzpo07jnK0nx80P8vgLmmpk1r6DEbzY
	dCEhFLr10WNJWDiKpj4p/08nTgcmurKpf2HJkDw5HOPWyKIIVNKSfS6vFFcmnejtww6Dsbhoqxk4W
	qaJkMexPkrO+WpsHzEjpfLOVjhotZTYLAkI6amQch19hzHl1pYaubQ0WMBbAj449Ple0Jl40J8GZ/
	/oE7f+mVxBsM25Z1cMsQbXBwWddTCC4Rk0OS8TjeXnrtsbL95nmo8Ds3wCu1xROyfxeZV27zC7wDO
	QJASYhURDz/25zCapD8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN27V-0000000CyhH-3fVO;
	Sat, 31 Oct 2026 05:59:13 +0000
Received: from out-105.mta0.migadu.com ([2001:41d0:1004:224b::69] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN27Q-0000000Cygo-2nIQ
	for kexec@lists.infradead.org;
	Sat, 31 Oct 2026 05:59:13 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=r3xzYw939vN9vzH8UsK6AomPfxJthDwVeWo/3xRQ2Fo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793426343; v=1; x=1794031143;
 b=WvaC4FsDcAHQ2NQ2JuiHYy56AQRK9rpDlaBUPZSd+xgQihu0+x11PWIm4iqwRFyZyy1U2XAd
 No3BIBUDoNW7w/V5YVqDdoRSxK0L8ZNvB0OPSou2EJq8Y5jatu2VQdepv+5F4j7PiwSI/BjV5Zc
 4e5m+WqcgzPmPI8SJmGlTm5c=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 14fc0ff97d323868;
	Sat, 31 Oct 2026 05:59:02 +0000
X-Mizu-Trace-ID: 14fc0ff97d323868
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: muchun.song@linux.dev,
	david@kernel.org,
	kasong@tencent.com,
	ridong.chen@linux.dev,
	baohua@kernel.org,
	sj@kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking PUD and PMD tables
Date: Sat, 31 Oct 2026 13:58:38 +0800
Message-ID: <20261031055838.60138-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_225910_317878_9705661D 
X-CRM114-Status: GOOD (  14.21  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
>
>
>> On Oct 31, 2026, at 09:41, Ridong Chen <ridong.chen@linux.dev> wrote:
>> 
>> 
>> 
>> On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
>>> On 10/30/26 01:20, SJ Park wrote:
>>>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
>>>> But I can show there are already quite a number of recipients, so I'm just
>>>> noting here.
>>>> 
>>>> - Brian Geffon <bgeffon@google.com>
>>>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>>>> - Steven Barrett <steven@liquorix.net>
>>>> - Yu Zhao <yuzhao@google.com>
>>> The CC list was so long that I limited it to people that area either a reviewer
>>> or a maintainer of code.
>>> MGLRU not having any real maintainer is a big problem; because that maintainer
>>> would know whom to CC.
>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
>> for the maintainer role.
>
>+1
>
>It would be great if they could take this over.

+1 from me too ;)

They both have been really active on MGLRU and doing great work for quite
a while. No doubt they'll continue to do so :D

Cheers, Lance

>Thanks,
>Muchun
>
>> 
>> Both of them have been contributing to MGLRU consistently and
>> substantially. Barry is currently working on improving aging and fixing
>> the swappiness-related issues, and Kairui is driving the MGLRU-FG
>> optimization work.
>> 
>> They have also been active in reviewing MGLRU patches, and their review
>> comments are usually to the point and helpful. They have been looking
>> after this code well, so I think they would be a good fit as
>> maintainers.
>> 
>> -- 
>> Best regards
>> Ridong
>> 
>
>

