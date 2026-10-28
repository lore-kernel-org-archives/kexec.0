Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA02606A32A
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tXx2XLhH;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=0qKH7FR6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=; b=tXx2XLhHx+QNJ+
	PZUUttDNZfPzvtaiZPTAJFWAlYJneXx5ndK4BAjigFg9A1q5We6kFMgisappoktY5+TFmaGvXn+it
	fLq5ssq4x3pwQes+dhJOSTy+4zv70PypBS6/rLkt9D2cRNc+u3ProAFVYYUxwM+ZBKFtYO8acpvVR
	Czry9gPvuqyW/jUmNbjsmGJHMATR7tVms9mCGvS/lWnq/3raE/Fjv7ecbyXctVg83DI8v2cRiRAOu
	UqPj4QZ6H4JBTIG5Hy2/H5qjyqdjjkAINcE23UHXulOVQMKz3MZDunyhrqrMbYktgajpNGrYtBbLZ
	uLPc9ayBwc/JrENWAL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLrJ5-00000005yhH-3OcS;
	Wed, 28 Oct 2026 00:14:19 +0000
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLrJ1-00000005ygc-2YOV
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 00:14:18 +0000
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIwkUo1043411
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 20:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7p1u
	cq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=; b=lsovCs6IxaWMyufeHyab
	UGnNVfqeJNBrnilLDH1hmBBzIDO1Xw2PYSUP6AO5lBNUxpxEQbs+32FmrWqXgs2U
	tOPH30t80MNHG2qpSiuiuflnpzM+Fl8MrVaIQ/TzOQwsV3+8EA9G3C0UHn/qCG3Q
	PQj237pzIWWLwXlIO/8itmTx5LzX4mvdorMSSEhTUlDiVt+iAvZg3DPutnck/E72
	SD4t4EgnBW4hfXCWuhw5rDgUQrr386PNS4Nzie4yCvvMNEyT2eeHSzgksDyKzRBz
	69BiiAg+4Y9BSAZh6oP9aUSXMEnXOkAGEduwN+78Gc0cdd8YkiEvb2dw4F4cmelV
	dQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hk17e2m1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 20:14:12 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c7b175e38so10019116d6.3
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793146451; x=1793751251; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=0qKH7FR6VXr62rGdPqKlH0yQXopaUA7sXU4D2JzesQw0rugjaGbXzZVCU1O6+8ld76
         XtGkJMLwuWro9eVz88KobwoiftQjUsq9LINX560PrSJIcmkUltac0KO4OSjRaj0YxOK+
         HCfrVY2zYwohYB9hoHTxsK5N11/0DEP4omAkdu32s7f95CZFyBqm1FabWSB2hKe8heV/
         7kAY6JiCX8qwAsfuYwKg9jWs4aTGoS5WdBG9AIhZYL3b7da5ABUMB/1oDolHhwImN5lt
         vztK5nNbWMSP36rNTu4AVq9FhYe3nn5OJzG7Zecyyn0xcwxQTSzcbc9HkZuI/DbBTj1J
         Oarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146451; x=1793751251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=DsmFQPNXYUKD6e20EQ4EHUFjdjrqLANt8WkmsSMQxquu9rczTd+s9cOrNJh+GC7qVD
         thSmhXGkbmND7Fo3STgueCgHlliIf5kMoNInVfaPN7mf6c/QIrTZVZdbcXIC02z2i8/g
         nHQvlW9jszCi+OXEEkEHkI5g4kvcogsLr2E1ZyQLWrALMyXcytggoZGQPT0hpp5qb57H
         1/+LxtqlCtni6ATmdGMJlymWa4uzvmwZcOKqkLwSCGYVLDu+AGjVkr2tob9bCtOd+bAF
         54555QnfBZ3XFJslAIu6xgR4Fp/ckRd3D7fwO7I9ACrp6sEtmE7lcnhMyJGPFmvr3pXn
         qmMA==
X-Forwarded-Encrypted: i=1; AKwUvBwK1icU7HYsL+s+082lpmYw2/7YhI8pOdJfAsMdXp4+QX7+2PZuKJAORz4d42j1ChYSBiy1sQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJErCthS53/r9eMjsCm9iMgTkMiWMWtuTtu5eOofn/BQwbVOrG6
	qEN72juPM8i2Bl6YvgFTPRj+tlTITjYLb0hi9nkRoFMACl2kyJTRP63nhrnJWeXSxzr7f5260ny
	ZWO4SjHu4Kn4DG7rKILrW/B3jN68QAzJVOpxBHAX4A87t+CCSyWfaiqIDww==
X-Gm-Gg: AYBFou3UBJbCleNjKMTeeOWIHVSt5XA7psSSfgVpPR6P4UXtCTfxNZrfM30RpOgyyWD
	bLZPiy83Vtxv+jBjlwfDIpdQ5IkmT04ogGJwkS+1cDrTsZjYzy1OMXGsn5pPmreUDkFTfUm7wBs
	zCiQFtOfYjHuagAURC0ildL61oziSNVlWdUmSQzWRkIN2YJGlXPYrJqA0bgxmH2k+vHzuTb4sQS
	ESDCwPQ+pgQX7mf7jxkOmImKtMJ7LVR0LzZQocUJ8cUQ9kaeK6J2gJ2UW6QPKXjbK2J3XPiTgPq
	LIkYqMdThqY4AFw6HYYxbItFt9XJ2DDtwkXFKJDSw53PPsPV5dp5iirRYAOJaR1/VZnPE1z8IrC
	swvD1GQ1PF/RpqCf2EOUOVOiBRax3Eis38HtAL/qZrQB7zCax6XNKRaniJsXTrm679p73DsBCXl
	UrASiBmF2QaHJOi1jKI6qveQQJt1gn1/G2EXEyeV/f+R+O8Lvg+W5vyrrFmjeJ4h/TOpGfnuxxp
	cZKNEGz1bCc5mU=
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12070716d6.39.1793146451418;
        Tue, 27 Oct 2026 17:14:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12069876d6.39.1793146450883;
        Tue, 27 Oct 2026 17:14:10 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6d8103b1sm40645156d6.44.2026.10.27.17.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:14:09 -0700 (PDT)
Message-ID: <3c754c36-86de-44a6-ab3f-5c86e4bf83a6@columbia.edu>
Date: Tue, 27 Oct 2026 20:14:07 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PeJqFShd c=1 sm=1 tr=0 ts=6ae13e54 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=_zromwrzjHPDTWxWFBQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfXwvwg5wsd5WgL
 2vh6cg6moBIcOi54Y4b8GGtCHgB1rQHpIogmFp9W9PHZdmi1MqySIihUswH1+IcexawvaQu0sAO
 eoDH+07RowBEHID3lJAWf5vBpDQsH4E4+QjBBdqFywGym4Ot3O/e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX8KiGs2j2jA8b
 rtoNMemmTDyoj8GS3KK29WGxcvpBZ8A8QexKTZDRM4lEioEk04Lo1IokqeMLwpS642UgNX+FGq/
 iJrOPSF0PlVE95lyWy9jFPcNai1BDyuUkpD2FZ9lB4CLAA+KzWmcAjwyDbcB+gM99R2cbzE7Jwq
 XwUeUiqAyuV+EXN7iJn2nw0jiMXhP/BBlWGX9SYge6ucB1nXNPLwLAjwoKgG6GqiUhVuT4iUE3E
 N21F2+wyiOyD+3Y2rcuj5ZQLNUZL/ExvDTDjElvd25h9JyZI+PeieKCqtjCYeKf4F9s+e9yJ2D2
 TO6yj7w5EkIKAzkvMe+hGYEvo836tj46VqfJJuIOWothKWqr0q8IaS0AGYXH+c89KV3LVfBtAmi
 ddWZV6NHX0VDf05YYvU0oCrPTdazcjt1JJVsamcXecQmaqoemc+ha7EXoYnmWmfEQO84fs6Lphb
 nqccMRB2cK3jFTP7+HA==
X-Proofpoint-ORIG-GUID: vDYjj3KhszWv9ye97y9q5ETea0fifKmX
X-Proofpoint-GUID: vDYjj3KhszWv9ye97y9q5ETea0fifKmX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 spamscore=0 impostorscore=10 phishscore=0 malwarescore=0
 lowpriorityscore=10 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_171415_951636_24FFA1E0 
X-CRM114-Status: GOOD (  18.65  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/26/26 7:17 PM, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>    CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>    list_del_init(&folio->_deferred_list)
>      next->prev = prev
>      prev->next = next
>      entry->next = entry
>                                        list_lru_lock_irqsave()
>                                        folio_set_partially_mapped()
>                                        __list_lru_add()
>                                          list_empty(item)  -> true
>                                          list_add_tail(item, &l->list)
>                                            item->next = &l->list
>                                            item->prev = tail
>      entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>    list_del corruption. prev->next should be ffd4000000270090, but was
>    ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Mani Tofigh <mt4022@columbia.edu>

