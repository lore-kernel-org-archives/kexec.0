Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D10C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=catzsBo4ShS2UkHB+U+RlsXEnd/8w2oD6cRDdrD08mU=; b=YFAmIZ723C4zPE
	XWWcg9X1QpKkCY4/32bGV9pL0r0Fecwmc6R0T1QO1FppNKvZ66Q97Z3snvFsrJGTUHPTZX7iJwglL
	7aWXAslNbM8zK/h7uyFfJZsHKD6JI2Rqda3nbs7ozzJOUnRxk41C0u0bPRIRMzdE3L2pquMuzVzSE
	ZuM76WrgWKFbCw1nBoNL1X/JcNtqOwUYqZu7JEtWFFLNgTuo3plX9qKH3fysItl6ZKbdbH4iyuWPx
	E5mTWV/lYsiPR0ee2mMqySTPM2k/dEKFXOy3fjEoUeSPZGVHjypgIUfh0QP2JnY9qh/bgfBLD326n
	X/w7ZlPylnNe2whFXwxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8M9L-008iIC-11;
	Wed, 29 Nov 2023 15:06:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8M9I-008iHR-2Y
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 15:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701270407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8z5muuD6V1KzLPtZY1t02hDIxFyhn4XoZnCFtfZqR98=;
	b=W/pPwrKMr4Up5bJI4ZwV97Rer2cF1B/JCF7Lj/e4E7mhnyJaJcoDQUyYPxMnqThfrJ6DvJ
	+5Zmw4nXD1q98jnAjgkLuk2q13rOmFjXHNmOed+j+X7mjp1kxKEJObwN9nkoxYjZgIkNks
	S1RXcBe8wR/b3RhdhSfhJyQ3sArp14Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fyyY5Z_3PJy-AmMbfxnNnw-1; Wed, 29 Nov 2023 10:05:00 -0500
X-MC-Unique: fyyY5Z_3PJy-AmMbfxnNnw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77dcbb52f2dso96790785a.1
        for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 07:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270300; x=1701875100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8z5muuD6V1KzLPtZY1t02hDIxFyhn4XoZnCFtfZqR98=;
        b=v7ERNlTYPQN9NqmERJzFu64FYFbEoLUUwsO6OOxElVxyVtpAEr/+L7UhO/HufHJUJK
         c9BRDr6uOaCfZ8ySLO2MG/nJmD20s5otR7z27tU8qenQP4fuUvLF4XvqoG32nncWLLfG
         3725nGdyLK8VopA0v1pHmVjSKcGnNXfGM/cDzFXmmcqKN5FNX6RqfbaKDftk/oTAQjUS
         Y6xV1lTuQYZpl/PClh492d3nETFm1UPJRjXtCbu5TRIWaSbOC0yDa3hTt25uRGod55nR
         bpKcT1C+rfAphpMJuj95jXAjCKSOo/PC3a7jhUgdBGKZAUIMwUQeqKf/z2KeECp/lKpX
         E7EQ==
X-Gm-Message-State: AOJu0YzKuubOcblbJy+MOieUECJ4dwnRiUZTl0SmPrG2bOcnK48iTZry
	36ELZsD5cHaa81Rrc8X1FWQsDNRVxHy8sMWzdY6ZGTTbQGsvKiz+C4CKOVXwOOebxW9I0fo9GMx
	WsITmhvGncJ4E9CeNvzcr
X-Received: by 2002:a05:620a:5236:b0:77b:9dd3:2f90 with SMTP id dc54-20020a05620a523600b0077b9dd32f90mr17517941qkb.34.1701270300476;
        Wed, 29 Nov 2023 07:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvYpEYtE1T0sVGQwzqNs5Yi4iXvBXcBME7iILi/8YhHs4ze5Gl0mMk/l8xbMuZGRLRaaZmzQ==
X-Received: by 2002:a05:620a:5236:b0:77b:9dd3:2f90 with SMTP id dc54-20020a05620a523600b0077b9dd32f90mr17517904qkb.34.1701270300022;
        Wed, 29 Nov 2023 07:05:00 -0800 (PST)
Received: from [192.168.40.28] ([216.212.61.246])
        by smtp.gmail.com with ESMTPSA id ea11-20020a05620a488b00b0077d93c7c785sm3781530qkb.119.2023.11.29.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:04:59 -0800 (PST)
Message-ID: <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
Date: Wed, 29 Nov 2023 10:03:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_070648_922270_61EFAE03 
X-CRM114-Status: GOOD (  27.16  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Baoquan,
hi!

On 11/29/23 3:10 AM, Baoquan He wrote:
> On 11/28/23 at 10:08am, Michal Hocko wrote:
>> On Tue 28-11-23 10:11:31, Baoquan He wrote:
>>> On 11/28/23 at 09:12am, Tao Liu wrote:
>> [...]
>>> Thanks for the effort to bring this up, Jiri.
>>>
>>> I am wondering how you will use this crashkernel=,cma parameter. I mean
>>> the scenario of crashkernel=,cma. Asking this because I don't know how
>>> SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
>>> driver will be filter out? If latter case, It's possibly having the
>>> on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
>>> reset during kdump bootup because the NIC driver is not loaded in to
>>> initialize. Not sure if this is 100%, possible in theory?
>>
>> NIC drivers do not allocation from movable zones (that includes CMA
>> zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
>> RDMA drivers might and do transfer from user backed memory but for that
>> purpose they should be pinning memory (have a look at
>> __gup_longterm_locked and its callers) and that will migrate away from
>> the any zone.
> 
> Add Don in this thread.
> 
> I am not familiar with RDMA. If we reserve a range of 1G meory as cma in
> 1st kernel, and RDMA or any other user space tools could use it. When
> corruption happened with any cause, that 1G cma memory will be reused as
> available MOVABLE memory of kdump kernel. If no risk at all, I mean 100%
> safe from RDMA, that would be great.
> 
My RDMA days are long behind me... more in mm space these days, so this still
interests me.
I thought, in general, userspace memory is not saved or used in kdumps, so
if RDMA is using cma space for userspace-based IO (gup), then I would expect
it can be re-used for kexec'd kernel.
So, I'm not sure what 'safe from RDMA' means, but I would expect RDMA queues
are in-kernel data structures, not userspace strucutures, and they would be
more/most important to maintain/keep for kdump saving.  The actual userspace
data ... ssdd wrt any other userspace data.
dma-buf's allocated from cma, which are (typically) shared with GPUs
(& RDMA in GPU-direct configs), again, would be shared userspace, not
control/cmd/rsp queues, so I'm not seeing an issue there either.

I would poke the NVIDIA+Mellanox folks for further review in this space,
if my reply leaves you (or others) 'wanting'.

- Don
>>   
>> [...]
>>> The crashkernel=,cma requires no userspace data dumping, from our
>>> support engineers' feedback, customer never express they don't need to
>>> dump user space data. Assume a server with huge databse deployed, and
>>> the database often collapsed recently and database provider claimed that
>>> it's not database's fault, OS need prove their innocence. What will you
>>> do?
>>
>> Don't use CMA backed crash memory then? This is an optional feature.
>>   
>>> So this looks like a nice to have to me. At least in fedora/rhel's
>>> usage, we may only back port this patch, and add one sentence in our
>>> user guide saying "there's a crashkernel=,cma added, can be used with
>>> crashkernel= to save memory. Please feel free to try if you like".
>>> Unless SUSE or other distros decides to use it as default config or
>>> something like that. Please correct me if I missed anything or took
>>> anything wrong.
>>
>> Jiri will know better than me but for us a proper crash memory
>> configuration has become a real nut. You do not want to reserve too much
>> because it is effectively cutting of the usable memory and we regularly
>> hit into "not enough memory" if we tried to be savvy. The more tight you
>> try to configure the easier to fail that is. Even worse any in kernel
>> memory consumer can increase its memory demand and get the overall
>> consumption off the cliff. So this is not an easy to maintain solution.
>> CMA backed crash memory can be much more generous while still usable.
>> -- 
>> Michal Hocko
>> SUSE Labs
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
