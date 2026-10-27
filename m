Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA28606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TUimq9vr;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=bDXHJhhz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=TUimq9vrr+pkCk
	7/OWbTMNsF/7gZB2acJ/RE2oPztvN5D6z6NiNAtBcq24x82KVAvlPpFzFt/uHL6bu4RG6VsAoAC1j
	QoTEqlOuuUiESzouUAMUYJdyWpQNr5ggT0w2YfEwROfjXsBSa22IRDFOR6qcPeHcTwiZb9xihd3p8
	MDCucVLB+4XL8Ie8Ud0SWO4ukbdLZftwir7zcWFvemmu3XLxHTWV5tFw4pczeXrP3kvUZZPJHOdxa
	dIT3bErQ67IbHrY1UAkYHMZTmH+zQWXxwYqRkk+nH2sQOOMhSZk7/9EIH8akekvqlz3ejtq/71r5R
	cNEI+YuR7o9L2541d0iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLlWv-00000005Wlq-24v6;
	Tue, 27 Oct 2026 18:04:13 +0000
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLlWp-00000005WlL-1Dma
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 18:04:09 +0000
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHhCZs273711
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 14:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CbwQ
	ln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=HWMW+LuCz6utW8S/VyIJ
	rHuo4CHhRhfcBnkgT2it5oCdt4YIlLKc6jaoFTG6NBRm9OQx8/Gj8cgBC4Do0iWk
	mAEHeGX4ZEQrgjmx5BHUqwprw2uw/fxZQF3p+JzRElcb76yXcKt4GQvOnFFzOajv
	msygurYhvvDfEXZY1Y1OFRcS/MQ3DzxL1Zn7WjVKu/boL2iCknUIbvotLMEHVOFn
	8z9EcTAubn7A/+OQElkqnT0CU8euYHGKsuMyJovfBE9MpfZ4akkMjYw62aGpHRD7
	9NYu/mzCxLPH6caGTchbWrsAFJNSQvq09+77FlRkr73QTb2lnAcZCq5a3XUaooGA
	UQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hjqr9ckwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 14:04:03 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a7c17166so3709056d6.1
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793124242; x=1793729042; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=bDXHJhhz/kd+gbM/BD1CHoa5FLw2z9lY4zEwu0/Uzx19HK1JgmtnVRwMJlCui+UOPu
         /G2MXgoqbSYGwKmvNUdUMWApwVLOBgKKXWYB69cgt5NJFdl8st1utVU+lymLyxTRvwk0
         KvESXzrt9s+at5/gIzAo2U2dCIIKYZQLfWmMjF7S+iglimNxVClGr+mWD8VUeFK7kPrX
         W4qXFE5dWSYyh5jozRS6i05jZBce2gC84yk4hjxuz9PY9opdTN8J8pcE1xa2/pGgY2NN
         2gG8qygNj3HatLYmdqJF+fHKG8ZTCrcfZ7swqAfWDSyT1kL/E+LvI69/CtTY3tPh2kMw
         2JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124242; x=1793729042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=VMJ4TGNqz/peKgBMsRvRblm5fDpSkJ+zq7rsJ6mWAClUAu1MdjgYa9FQTvaVz1kP+O
         6yNm9hp/Rtf6exXqNmV4bz+LkSJceyHCKcLsYNhTkqUR6KQwRsPn7S0FiRIf7z6uKv+3
         iTS0/uYYYPSi0qbW1nRLrzgrHOhvYmOx2nynDYm3RYxN2it8H9vc588mLLncwYflTETC
         KgNZF4GmRYf4RxkxoPpo6XM0nmXlmbJN02NC5IEjgfM99kzweDeQapsbxDwI4R+3Npgq
         m6BHOLKGJPyTjLybypLTmfI2agmpIRvij22ZnBa9huz2LP2sg70gYWrNuliDtIkcysTV
         0DUA==
X-Forwarded-Encrypted: i=1; AKwUvBySuAW/J96qL9D/LLHg0ZbUyhyhD+MkUemr39mHGwSLVDW3ZcLkw+pWvnLo7T6CdyhU5Roufg==@lists.infradead.org
X-Gm-Message-State: AFq9FYKjBpTh7FxBceHb5rVI663wUrw1QD+eg4tkvKXD3b8+rlgLy6Nq
	Xe3uYKTysf8lS7Whf7ka//gxUExzgcQ6H4/qs2dMMjRlAy2w+X3esUT4MmQSLlN3QiHtnRXmsxW
	lTjPfD5raXOlmH+UoM9Mx2oLINhqpssEZGmDsti6xGclcNaxPiBFBvApbfg==
X-Gm-Gg: AYBFou1HjxVsgKxFHZwRyPbjWsIX2NaLU+IKLw+wa16+zTLJ09OsXL71mpncjp5FbAz
	10NHENyTzwhOdIsqA2EKCOXo//C0f3xSVDbubRab8hmPL5GR3TSFYA2acVzMAr/b1ZjDveTZ8aT
	13jsvVGHFL1wFs2EK56/Vv7j4SP68OUCv6Pb5axUnGKoCnvE35dE1H//ahUyIeKBNfZoCxMExS2
	j1vsWAmap0dYwcIeg42TG8dtQ0/O2pipVoqD8vnOIkI8ynaitzo4q3F1IHWyNG2ku9dagivflfK
	Oj29FlaewpVeN/BlwWu3OOLmzsgu4kljgfDw+Uv7LDsJ37Cytb3q0XAvh9S2Axt30QlfXz3ijR1
	QuV56qEnWo9MSuMmyd+l19sIQuk+gIACduIGss8L4XvHn+rIPXDSDwYMvQuI1rnL8ocmQw4QW+S
	J3BAkOv4lmhefbji/e5LK94vFunJTL7SLh5Uav99jx26Ni8SCu1YG/28TCb1wHbR4SGF96gU3TS
	tc6wi5uOFDvzV8=
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547497185a.82.1793124242379;
        Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547486985a.82.1793124241704;
        Tue, 27 Oct 2026 11:04:01 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1037624685a.41.2026.10.27.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:04:00 -0700 (PDT)
Message-ID: <208738b1-35df-458c-9955-e2e5318fd2c7@columbia.edu>
Date: Tue, 27 Oct 2026 14:03:58 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
 <auCw2-_yjh1_RjiO@cmpxchg.org>
 <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nC0VgfdNtapynqZ8WMZIqVSHiVZ6Ul8_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfXxuOMobAKdpuD
 vh/R8ayb4RkIQGLjJbWfhTCEswzO7GfbhDfpXiNp7OWB6zT+5ajMRyNjfyoCSTMoUnMHTdSisnG
 dYsYGl/+PMBXQ30ZmLrtYoyJ91RtpfADRKrJIhK7q80709y+0u+L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX0HDnoPK3n/T2
 CT1EX55nokNcl47FAEicZmh4hXWFl4zhxkSWwjLGxk+Bx+3CEgqg7b07ccA/w1PW2LeipjIhW8b
 JfgbGfXJppCQvZyczdBXlocR8f499ZPNCxttdaH63PkJuhBPc7E+8hSazdkh8QM/8YAzFFkXLHw
 qZRDqbWjOFb4UKNBEJpsul7Cx/4p2QAZIU8svek7shM+G1gQNJiIw5xDUCrdd1HTrg0NcE2qZvi
 nq1c1PIFwaHxzc7zPStNW9jPUeRfIG3+Yc3KcEccHmicbL/c38qv1vaOl9bIX4V1hqqEYbUw3F2
 76gMfdukLk25DhlKvJK8fzmRIyYdERO3iRkiu0lIURplT2oPAtsSGuyEXOHdmC6i1Qd4d8VGGoW
 jb834NttwQ00fMOz1boJBpLjZrfV0RtKqgNvJvBPns5bTBC/Y2VErKi4Lexdm/kXive07xOdvLr
 O/Fmt8/QUCyhNk3RzUA==
X-Authority-Analysis: v=2.4 cv=PKSaavqC c=1 sm=1 tr=0 ts=6ae0e793 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=pJWPUViXIfCbsMganCcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: nC0VgfdNtapynqZ8WMZIqVSHiVZ6Ul8_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=10 adultscore=0
 bulkscore=10 impostorscore=10 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_110407_688249_BFC745B6 
X-CRM114-Status: GOOD (  11.13  )
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 11:15 AM, David Hildenbrand (Arm) wrote:
> While I have your attention: This variant works, a different proposal used
> 
> list_del_init_careful()
> 
> instead. However, that is documented to require list_empty_careful().
> 
> Do you think it's worth looking into?
> 
> 
> https://lore.kernel.org/all/20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu/

In this case the careful variant is fine without
list_empty_careful() since it writes ->prev first
and then ->next with smp_store_release(), and
__list_lru_add() only writes to the entry after it
sees -> next == entry so it can't race with the ->prev
write anymore.

But your version also covers the PG_partially_mapped
race your comment mentions, which mine doesn't, so
it's the more complete fix anyway.

Thanks,
Mani


