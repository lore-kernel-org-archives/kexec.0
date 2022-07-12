Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7539C43334
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GecJCvRd6SOHvctXUep/MC5LSs5mXKDOgAaQXa/gPjU=; b=k0ugoylFZYjfvh
	ZI+i/K/vqYFU6EPbXkCCYB/12/I0kZwezQiBNEWQSg7m3JZN12jCHM6uCc4nqYrYK0buVO0Vhswqn
	p0qmnZY+dphlAZbtg8VhmIMnpQWgR9htQh0yNV8dj6h/D7O+EBiN8L+rUR6+FjqgwODNhZO9keqnk
	qh+M81pk7AxkXkOHJTgmY3NfvhcQHCj8eFPmz8heYd0UME6NEdso+4C8inX2Xrs0i/yBpeIOojbCY
	QcMKGPwtuyamhz/CgAg5ulVv5tnxm9jdsSfawlKGomsyq0/UEr0dHemEN8T+nDBjqVC1BwtZF0/qj
	O1+6nqVHMD6TZQvwwGNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBDpI-00AJjb-Ca; Tue, 12 Jul 2022 11:13:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBDpF-00AJgV-W9
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 11:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657624388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
	b=BFlszsJzRGWuN3pGa6VOfNTYJE9HzIMiNi97kK5Gtp+1SUCUUDRkpNzo9ffHBjy0szr9Lx
	3WCKF1+48BLReFSuU2wTaK82mS15dz0DJQXSWYFJu2wL+UPoBrROzmoL48Gln8kbhVXdgM
	91LoyBZxNuf+7rPnzwS+mUomWi16rgY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-NujKa4C-MnWL_fAPcTfCsw-1; Tue, 12 Jul 2022 07:13:07 -0400
X-MC-Unique: NujKa4C-MnWL_fAPcTfCsw-1
Received: by mail-wm1-f70.google.com with SMTP id c187-20020a1c35c4000000b003a19b3b9e6cso6569711wma.5
        for <kexec@lists.infradead.org>; Tue, 12 Jul 2022 04:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
        b=qbije9xS+Oi9neeC2ytlsOYM71LuxX8bJivkV5tAgj5H7oSD3TQXHnHDYz/KPovuG1
         1MnEET2Y8rRD4oc5noPFREMrKG/CMTjNeFk7RM7dP/ehB98LRkMlMURwC2HVU7hVmCs4
         ITHypvg0zxtDfuoIhl8Bjoq2F2kmIJrNHqj3pStr4NCpQ9/qTcX4uP8VQA4ADFtYnMxL
         Etg/PQlNdsWqM267lVqMw4Z/GXHExm1AzbJm3RpJzzwLUwRu3JbIgp/LTWZYf0aHLMt4
         dqcTWxUmqPVff/YVICdlFnFqry1T01eMLVE4Y3ip6gRDfvQbECr8wDluIPCTogR4EMl6
         y8kQ==
X-Gm-Message-State: AJIora/f0xWk5id0twjtC34rK5VpTazlXrH2SYf4PJbkUgE1HA5Hdfn1
	HIVYhnHhEpvb73g4dGhXJA3LKk8PH36fwX7zqGBlnLCK4UD00evmh/FrzrW8RSd9t+peYUr1cak
	F2/8BZwmqQeh/F7EOJYoL
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488336wry.584.1657624385904;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8ZhXvsJEW8VYsrpIys/4zoUZ19sQAWjNoeBLraKcWG+eh+OaPJTWsHlZQCLCOGeak6REuKg==
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488316wry.584.1657624385694;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0021d6ac977fasm8094998wrq.69.2022.07.12.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:13:04 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Arnd
 Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
Date: Tue, 12 Jul 2022 12:13:03 +0100
Message-ID: <xhsmh35f68tz4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_041310_120441_93AFE36E 
X-CRM114-Status: GOOD (  11.37  )
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

On 12/07/22 10:47, Baoquan He wrote:
> Hi,
>
> On 06/30/22 at 11:32pm, Valentin Schneider wrote:
>> Hi folks,
>>
>> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
>>
>> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
>>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
>>   here. If that can't be done then I think we're better off with the combined
>>   mutex+atomic var approach.
>> o Patch 2 does the mutex -> atomic var switch.
>
> This series looks good, has it been taken into any tree?
>

I don't think so, briefly poked around git and haven't seen it anywhere.

> Thanks
> Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
