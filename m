Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367A1C3ABDD
	for <kexec@archiver.kernel.org>; Tue, 20 May 2025 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhESp3G/SIa6HPbqoYw8chTa3J1tACi3fMTgeUE9g64=; b=Meh8evbzsMwAOUc7z5UIOb4nuJ
	2KusaloOmgobYA6gRb/gYdBi6N04W56/Jbc59mOeb11aCBY0/M94I9xsU0TA8FJFqy72Hfi2ZsgrY
	98BBljriX/VHV2NjODeSbC1jQPpKSUojYY7UVf5XFVNY8n7H8ucg8jFtDtBIw+rCUzCcxTcLrFl2y
	AXpDUCNANJpSjiJTVgDxStpUUtDgoXlqj+zwvXxkGn2o9O90c4+G5lHANSt0OJfCMfTZwyhb8bdP6
	a+WCPFIrfszTGuZMbmghmhUNn9poifj2BbMFOO0P7D/wEdyZqN/c0JCxl1eT0tyzr1pTP+s5Oy0wu
	mCv3Tmww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHJK0-0000000CCUB-0wYJ;
	Tue, 20 May 2025 09:31:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHJ4l-0000000C9sS-0feU
	for kexec@lists.infradead.org;
	Tue, 20 May 2025 09:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747732553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhESp3G/SIa6HPbqoYw8chTa3J1tACi3fMTgeUE9g64=;
	b=dEOO6kLmog3cOGGEzvzUv4vwwziKBHMXHSPK8wSZKIyKv/ECQGCGiIf7mE5SV4glwiD1gx
	507P2R16T8z0LkwD6yQ7aB+NFjKJsJWyaOJxjVawhgixIWaRz2bK43AcMJbGtSYDVjb//d
	YHN41SpxrBAh8DLd1NkkGVX1qGCB6h4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-YRJj7qeMP4GP3LMuVwHySA-1; Tue, 20 May 2025 05:15:49 -0400
X-MC-Unique: YRJj7qeMP4GP3LMuVwHySA-1
X-Mimecast-MFC-AGG-ID: YRJj7qeMP4GP3LMuVwHySA_1747732549
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30ec5cc994eso2188907a91.2
        for <kexec@lists.infradead.org>; Tue, 20 May 2025 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732549; x=1748337349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhESp3G/SIa6HPbqoYw8chTa3J1tACi3fMTgeUE9g64=;
        b=UrP9vxwkcQvvR9lesRU0adlCRVvv6VCjGISc+0eGJoLbDePZSdbjXfhVChhcbNexUz
         7QqayJb9tW6kmhmEfsw3E0NDBVWQ7h7YFrXKICUCxEyud085UGPWlnDV3+u5HpXAVyst
         SPVPtzb0jjkZJT7kQ+lO/WXqY1ELcbCm5QfI3ZjDPmJOzFnKnc848718dyuw8gGFG0WN
         KnIlvcU310TpPhEhzcGRDWFrebgSRlaqjgNAJDfgcChqgNBMNpsva1ZPLMASA9s3O9eq
         tSdQuW70KPrqGbr2ciSjgrrdl0On72XYP8t7ipgpJrKTEsuK0lA8/pRkMxVUzu+vYVab
         VbFw==
X-Forwarded-Encrypted: i=1; AJvYcCW+PUCuy5uOnOJ5AQC83/ZeXA75bPk/x9mwYMfundVISrY2kQgAJDjyt3wx7YBuEf7ybZgA+w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvztYjC7asM2OVxefA6xvR8DWg3FqIzQiSZ34MHlCSRPjSRp3X
	3JHq9OzUv2vmNS+4RBPEwMqp5+45rvfux4bI/X9PAgrOfGJkH1vi1yZvVrCKDxZiK668LyJWtbt
	cckRK1viVI3sE0ZkWDJNt4roMA36JOy5qc1e4M2AedQ5saXsNkCkfb6D2BL0+JA==
X-Gm-Gg: ASbGncttgd78+wE/SCeCR9bnFMRYHHRKW5iTHFNANOZ+XjrY2hhLiCyF8nBx7YdjU1p
	xtRi6bIdHJpxOh93ShR8TDYJKrO5iI01fewt9U2jhvc+zPtVSHBHY9MVT6mOz9vTC8tta43Tben
	p4viveRHgMoY/tRG+aVK4nAYgKWkG6KndLpuPYoV+A/zhUsRZH5hywLRQiqH/kpDpSpAZw9NCFL
	p6SIzWFsZ5eBw/vE13yjfW4u0e2tA8U20ugDrHxqTEoTDq8tt3c7efnMrcrEU5DlpFkGWPdgS4O
	znw=
X-Received: by 2002:a17:90b:2e42:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-30e7d5aca5cmr21330344a91.22.1747732548829;
        Tue, 20 May 2025 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxay4p7pv52Vodnk4Tfn2ozXI0HmKtyE04pWaZsFVCaSe4/2BLoC7rn0Est1OtxnsGuBJXMg==
X-Received: by 2002:a17:90b:2e42:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-30e7d5aca5cmr21330307a91.22.1747732548461;
        Tue, 20 May 2025 02:15:48 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368bb0sm1213053a91.10.2025.05.20.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:15:48 -0700 (PDT)
Date: Tue, 20 May 2025 17:13:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Kees Cook <kees@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	fuqiang wang <fuqiang.wang@easystack.cn>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <gxysezp2tc6qtb3o3wpdsk7k4aijxontf3ozfnhn76giobkefe@v2vkfov2tcck>
References: <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
 <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
 <202505161616.F4C1BCCF6A@keescook>
 <aCksAsgAw1jsGBL9@MiWiFi-R3L-srv>
 <202505190716.B21F11984@keescook>
 <aCtBf2LqRqlWXaUp@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <aCtBf2LqRqlWXaUp@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t60XZIM7AgEW9S0OLZHfswgZURMnN6pTZlrVngQMsS8_1747732549
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_021555_270056_0BEBAF81 
X-CRM114-Status: GOOD (  24.42  )
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

On Mon, May 19, 2025 at 10:34:39PM +0800, Baoquan He wrote:
>On 05/19/25 at 07:19am, Kees Cook wrote:
>> On Mon, May 19, 2025 at 09:22:30AM +0800, Baoquan He wrote:
[...]
>> > > I went back through the thread and the referenced threads and I can't
>> > > find any details on the USBAN splat. Can that please get reproduced in a
>> > > commit log? That would help understand if it's a false positive or not.
>> >
>> >
>> > The original patch is trying to fix a potential issue in which a memory
>> > range is split, while the sub-range split out is always on top of the
>> > entire memory range, hence no risk.
>> >
>> > Later, we encountered a UBSAN warning around the above memory range
>> > splitting code several times. We found this patch can mute the warning.
>> >
>> > Please see below UBSAN splat trace report from Coiby:
>> > https://lore.kernel.org/all/4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at/T/#u
>>
>> Ah-ha! Thanks for the link.
>>
>> > Later, Coiby got the root cause from investigation, please see:
>> > https://lore.kernel.org/all/2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei/T/#u
>>
>> Looking at https://lore.kernel.org/all/aBxfflkkQXTetmbq@MiWiFi-R3L-srv/
>> it seems like this actually turned out to be a legitimate overflow
>> detection? I.e. the fix isn't silencing a false positive, but rather
>> allocating enough space?

The words "out of bounds" in the patch subject are kind of misleading
because the patch is outdated. A later merged commit 6dff31597264
("crash_core: fix and simplify the logic of crash_exclude_mem_range()")
has actually fixed out-of-bound access issue as illustrated in
https://lore.kernel.org/kexec/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/ 
Current crash_exclude_mem_range simply returns -ENOMEM when there is no
enough space to hold split ranges (I'll post a patch to prove the
correctness of crash_exclude_mem_range by reasoning about the code and
including a thorough unit tests). So I'll change the subject to "fix
potential cmem->ranges out of memory" in the upcoming patch.

>
>This v5 is on top of below patch which Andrew has picked to his mm tree.
>In there, it happened to get the ubsan warning fixed. But the hunk
>doesn't reflect it in the v5 patch.
>
>[PATCH v9 7/8] x86/crash: pass dm crypt keys to kdump kernel
>https://lore.kernel.org/all/20250502011246.99238-8-coxu@redhat.com/T/#u
>

-- 
Best regards,
Coiby


