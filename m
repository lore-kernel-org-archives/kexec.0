Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C48CCA0EE8
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AA1qOPXqIhswlhuGjHEdTg+6yZowf6OxMfstKUodc8Q=; b=c/hVszY0K/bHgI
	HzckonwfLxi1nwb/hjY3XLdLfAHkeSR30zhjsX2tLDDBrrozwCH7A8BNk1TwPCPPQHxe+oalZ9jXX
	EWKBSz9kVWCIbd7NIQeYYMDRToiTQBvPDDhZX2JkIRA6kC4fYek9nFWNu8bqOXpnXFBHWLV5LMS12
	cVJzKaTslbesCp2RW8Qug8NZ8onTMChiiBJxLrez5uhtKPJJcNsTDyzN6KQhjD0mUunbNxDLGIkTZ
	qZXmlVeLmyKGd13L4n8LYve86U4APMBew9JwmJ2UWh7Ng9ClLCIhvq6B0w88krSRHRqjI2q8c6OdQ
	whAW4sHKVm7+87TF5sQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjvzc-000000055wP-0iPv;
	Fri, 30 Aug 2024 07:24:24 +0000
Received: from mail-qv1-f49.google.com ([209.85.219.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjvzY-000000055vg-3bZ5
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 07:24:22 +0000
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c159150ff4so8546116d6.2
        for <kexec@lists.infradead.org>; Fri, 30 Aug 2024 00:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002659; x=1725607459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVVslDV3vhH3TXW75WoEiVqsEhuwKn0gtiz/69L72e0=;
        b=enFHAIguv+WV2KSv0+YLeD91Aql6dfRZZHu0hz7g4yfo87pNAEbX6QhrjOAGCVs39E
         myBnL5wYaeGlvaWNKdif6iQZIerIpRHyJbvq08gsOe/Lnz+z/F4t7+IIoIOUnXL/Mm2+
         zw6XmPkuWlqc1ifcYuRlgFaReH0Ns1m7sPBi2pl1xQc0YfsMbOCxMwqzU8zepX8WeQIv
         hM+Z9/A1aZvtf/w/fAvR67XXB5UeryOT+15RBuD5FnYRQi0vSXA7kt2prbOwL30ah3rs
         NlxbZ1mTaM8xjtY9X65eeEODMGuvf4h5taTEFa7aO+8tsXt8Pc/0abeCQkGjYSTWupok
         sXKg==
X-Forwarded-Encrypted: i=1; AJvYcCVltFv0fwjARogomkOX8/QqGUUg90jxwYUA5djyxsxOV/lOGuHjQXU8nTLQ4oMs5OWvzV0q4A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBFH/5cIQBBEQxc+U4VLpthgQg5WA2ob6YEgwctJHandx+UaRv
	+3EorEm8Kn3ipjsJ5gqjoILPVfIAXbbLVkAEugCcvffmS/6IF0hksv9FHaVDL2E=
X-Google-Smtp-Source: AGHT+IHTmrzrM2U/eyTLZYz6w/tWs+TLwJZ5juO5eDi0aDfQrqBJTTIuzoqHW54tkQxTg2xYjnmIBA==
X-Received: by 2002:a05:6214:419e:b0:6bf:9281:96b0 with SMTP id 6a1803df08f44-6c33e626c75mr53795666d6.33.1725002659506;
        Fri, 30 Aug 2024 00:24:19 -0700 (PDT)
Received: from [192.168.2.204] (bras-base-mtrlpq3141w-grc-05-65-93-184-127.dsl.bell.ca. [65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca65b3sm12308646d6.119.2024.08.30.00.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 00:24:18 -0700 (PDT)
Message-ID: <e12e89e5-9617-4515-a3a5-19cf9a6db624@vasilevsky.ca>
Date: Fri, 30 Aug 2024 03:24:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, glaubitz@physik.fu-berlin.de,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtFoMMsS5PuFw3LF@MiWiFi-R3L-srv>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <ZtFoMMsS5PuFw3LF@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_002420_928827_FC943597 
X-CRM114-Status: UNSURE (   7.64  )
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

On 2024-08-30 02:35, Baoquan He wrote:
> The overrall looks good to me except of the CRASH_DUMP=n on sh, do you
> have a comment about the reasoning since you have discussed with John?
> Is it because of below config items?

I don't yet know why John asked to turn this off by default on sh, though
I'm sure there's a good reason! John, I'd appreciate if you could chime in.

Otherwise, I could split the patch, and we can discuss the default
on sh separately from powerpc.

-Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
