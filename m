Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C145C5B549
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FcLOeL0j8aYWy2M7p1kJWLoT3h6nC08D9zaPSw+D+1I=; b=fsaWOUJMDrGDATIXi7OA7XH+W/
	UN3AqotZQ/fVrKnAyEPrqIFja2SyvNLF6Ncgs/jHA4Z50qWDcPHfPVEg1U3JAxAIsDQm7LqnEuaHV
	BbrWWbSCT2RFtiV/mi4oXoHOjabk2THfpKKqfB684BCkw2gFmeLGQDkZGp9Hv4LGDNF2mxYr3Smy9
	2jHjX4ExQlzk9AwelT5yzHicwcOVNzR5CWBV6pOYT8PY2bzTIIHXqGLMkLieTXzhn6iGHUPilg+ei
	GHkR7+Z2G4unw5YgUHVTAf4vcvWLSkL9IfcJh6RNKZSO+VluCf7lxilU8fMMWVBhV9nOVOEO5GUlI
	c630HdhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvrw-000000005ww-0VcV;
	Fri, 30 May 2025 09:17:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvmF-000000005K5-1Bro
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 09:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748596305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FcLOeL0j8aYWy2M7p1kJWLoT3h6nC08D9zaPSw+D+1I=;
	b=N0oeLiPpZSVm2kJLnIkG0SZiJ2PX782J6jmz2Z44BAJRby6Ql2EykRvXlz15L2bh7SK4YM
	SdLR3u/cgiESCu8upEu3MVg7vjUkKY8uJRSdkteSV5e65JEGSUP1qiAtKLNtNgNUZ77BgH
	/NV+FbXuRwL6gY6B7aHRkvOdPf6aKUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-QRO7wOKMOPiMN3OR3KxusQ-1; Fri, 30 May 2025 05:11:43 -0400
X-MC-Unique: QRO7wOKMOPiMN3OR3KxusQ-1
X-Mimecast-MFC-AGG-ID: QRO7wOKMOPiMN3OR3KxusQ_1748596302
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso10807265e9.0
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 02:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748596302; x=1749201102;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FcLOeL0j8aYWy2M7p1kJWLoT3h6nC08D9zaPSw+D+1I=;
        b=kXs4SqZJaLhJU7i7wyFpyPM+QKNWvmhEYb3VmOrWQb9wH0Os+MLokh4PIqnjHA+WBn
         vvtOSxusf8FB1KfwXRMHztgxQzAuOkiTRArgOjLWuk6GvbBCUflnvUGf+dC8+s6MbM7k
         GY+OboCvXfD7I1iUkHt6hNT3kUvLZA7zsB9SiRB71vq2yb3T1+VZSSqMKjzqKCOIAHAf
         GexbDYkgngPz+xRej5zFDtisQ+/9FEQ05GMJZOiih/QokYG4ZiBxMFtE0sqg3uj3fqAx
         Cxb/fkjtBwqinMLLk/FiLTyfVLvyJzgljwMiaZlWjRJq6JChrqQtZ+mhrCGv3Dix8/vX
         AumQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfRPI9Xf1/Yw5SOrLXU6eula+hHphueDSJn/yjBIFsjxF46WgNIXN5TsIMaopLbimcHaFDzg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyP6T9t6qucFcbX6WhaG+oXaJCwVLKClJe3rzYJlZ14b5OXh7bq
	53qgpf4cemeo4FtGPB6iGT5PQN/Lok1BmNIspUe6IxmcV7dWp2c9Lk9/zLEqbPng+JS7giNFWTs
	RxQy3/V6TzQkILhok3qNCF26GdstJay2bX92pWUnE+ACAVMjj3POobmp2aKHDVQ==
X-Gm-Gg: ASbGncsHY2B760BpeasB8DrbW7YQmJZiTzDNb1Nbwt3IA1gXt4YzKOhGAd48Stcg+m5
	9U/Yc8kEpsu/jnF5a223RqO4PCvkZwYrofT4V0K7OHVYwQtAUWRjaEcgadmMQInQGPWoMTVvWyw
	EUJltO2RAfQHBHPHf9J0Yo+DXxs4mIcE6nqPVxYy6SE60Rw9OFUjPgzlXpBbt0puPWK98OFsbxw
	SbaMKB8PqX9dhRN0ChCHfZJiMesrvYzwZUd6mqITyrWp8MUb4JqqOUL+UN76xt6rKxEWW+dRe7F
	eqZYVy2GM0RPXBze2aI6gBBT2ggF1ZcfHvLSkN1o0CE0EGZqZ2IjuoBIwLyNNVHALmP1j15JuJN
	z9tD1/0iYmM16zzx1b7Qa4JsvTW7P2qy+06gyIDo=
X-Received: by 2002:a5d:4ad0:0:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3a4f7ae78f2mr1566392f8f.15.1748596302380;
        Fri, 30 May 2025 02:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF60h8rKE0nPobuy20ZXqTnSFgBrTuintIRkVxcH5DFZBoUxjL88SfayitoqDnRNANVj/A56Q==
X-Received: by 2002:a5d:4ad0:0:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3a4f7ae78f2mr1566375f8f.15.1748596301992;
        Fri, 30 May 2025 02:11:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6d0dbsm4192895f8f.40.2025.05.30.02.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:11:41 -0700 (PDT)
Message-ID: <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
Date: Fri, 30 May 2025 11:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dhildenb@redhat.com>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
 <aDl1ViMpK_6q_z06@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDl1ViMpK_6q_z06@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fkN49k83jv7QdOXef9ZJmvtpkQxn15aobqkHLucii-U_1748596302
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_021147_399488_C22205CF 
X-CRM114-Status: UNSURE (   9.88  )
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

On 30.05.25 11:07, Michal Hocko wrote:
> On Fri 30-05-25 10:39:39, David Hildenbrand wrote:
>> On 30.05.25 10:28, Michal Hocko wrote:
> [...]
>>> All that being said I would go with an additional parameter to the
>>> kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
>>> otherwise. That would make the optimized behavior opt in, we do not need
>>> to support all sorts of timeouts and also learn if this is not
>>> sufficient.
>>>
>>> Makes sense?
>>
>> Just so I understand correctly, you mean extending the "crashkernel=" option
>> with a boolean parameter? If set, e.g., wait 1s, otherwise magic number 10?
> 
> crashkernel=1G,cma,cma_sane_dma # no wait on transition

But is no wait ok? I mean, any O_DIRECT with any device would at least 
take a bit, no?

Of course, there is a short time between the crash and actually 
triggerying kdump.

> crashkernel=1G,cma # wait on transition with e.g. 10s timeout

In general, would work for me.

-- 
Cheers,

David / dhildenb


