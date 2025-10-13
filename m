Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B720CCD185
	for <kexec@archiver.kernel.org>; Mon, 13 Oct 2025 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFlHlO0O6C3nxG+D2VSZdFcVU1iu/EmHMNhuweyTS0g=; b=PvibHPhkhGj2NO8rnl+2gwysY6
	Vb9vrwq/EPHkpD40lf0ydUbC3QDIkhoy39Iudj6ktvt3PP9DGAd9ZLc8h2lRgZdrIjddLqlLYqNDi
	k9MKKA9PjaKFVD0DV32J9i2SeB2ZiRolA5Lry8mwdk/0Yh9ss97SNa36EiRugs2Hf3UXy8ZSfMg3A
	58sPNq+h1A1YqaZs1uyDh3cRFv7QPt6OOpmJHLBQX5RSX6IdIXuLqUEGfuNILzdk/VKOE8FFCujYm
	FbFQGC4HA2OX8tM5MVQYO4jYhkj77VB82oN6iJ6VEnYuXxPAHKLSgijKScALNcwilqU1ZMV2WV4iC
	pJ5ptDwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8DU5-0000000CXZW-0Mn0;
	Mon, 13 Oct 2025 08:00:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8DU1-0000000CXYC-3z71
	for kexec@lists.infradead.org;
	Mon, 13 Oct 2025 08:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFlHlO0O6C3nxG+D2VSZdFcVU1iu/EmHMNhuweyTS0g=;
	b=GNFK1D2ttWSAyogXT7J5cT8vHfqMUeItE3U0F/OfloKRrEc+Hfbwz3MBG9jETVqMfi9TIY
	nev4+GKao4qFGHK7zij6VDGFWV2EPa49SqNQUTxjpQUZ5VNuS+GEOyDXRIjmQA2BQAJbKz
	udzDoMjgEPbpIQqq7W8M00bvXflU6Oo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-65F0jjyQMbuZ5KxSBM9Nvw-1; Mon, 13 Oct 2025 04:00:37 -0400
X-MC-Unique: 65F0jjyQMbuZ5KxSBM9Nvw-1
X-Mimecast-MFC-AGG-ID: 65F0jjyQMbuZ5KxSBM9Nvw_1760342437
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so2523002f8f.0
        for <kexec@lists.infradead.org>; Mon, 13 Oct 2025 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342436; x=1760947236;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFlHlO0O6C3nxG+D2VSZdFcVU1iu/EmHMNhuweyTS0g=;
        b=D8YpRDWO7OUD7bJnn321rIfG7u4Bp+PkHVSsUXKK0q3YeJuFo1FtZCQahVb9z65vOU
         USO8Fy8rIz45vGh8b9JXzUGp7loNhizQb6Z+9qj4ki3/62r7zq47FpmU8gwE6QZ9RTpg
         BJe1kcr4/C23y2MYpec02U+uW5xIBi61GYKAbUin7ka7Ck6xwiLkW691/bx79cC4ln4i
         hmlvAsVr8kp7Y2usxDvighd6FsmVDztry7bhDvyRbrpvWaz1T4wX3uC4WQy7IHf5x7ZJ
         9yc2MTAShvcdt1w6x+pV9a9U7ZJHU75EwyLCskX9ZcB19TXgttfCqGP22PX2Dl6DmLg3
         kSYw==
X-Forwarded-Encrypted: i=1; AJvYcCVDEve17RrOO5ymjNyl3H7z1nbjs2jUp+tJ6SRJwQ9/yBbyERet15qPpUcZ940MdHPxU+Mwlg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKuCobrSoPScRx3Yq6zLyf4DWfPDrN42WtftrMWGBuhflHQNH/
	HUJh1etPtZduq7/qV7ufSkmkNyRu9KctJhnfl3KBKqoMl+Laf1KIGCwcGbJGQdrYZfuIHSVp5hb
	fACQFrUlX8qxGjFUlAji3ZfChKrqn9a8lH+/UxBWXAmZ/UGFMNzygo1yv9d3xZA==
X-Gm-Gg: ASbGncuDBQjpqk63WG3kj8I0XKcdqaKpztbkOYua0E9aevzgYBaI5pS+BFL9vuqIGni
	X07GNQCd8e877FfIZoBe0XxtX3XvY/3OdZksD+Sx0aampVe8n6mFwRNI6LsfBDYaVjEmm7ZcI46
	O5kjx2EyaUsdKkabvCk5XtoCkETOFjOfXaHqD0bA/32O5XwlysWCrlGJNhTX5tn3qgdw73Bisne
	kb2kaj3fTSYw+3j3/l5VeJEFzo5HZpPY9AfMkTJMN9seKzad1civhGLbtA76JMOcu0kckv7vwC8
	lr+QiyybLo/LcXzDVIzY3J3zWSqLyGoEFOW1Be0Nm33XkM8m8rW6aqZcA+NPCYOKclpNpIOqMbr
	7XH0=
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-42666aa6354mr14480204f8f.7.1760342436478;
        Mon, 13 Oct 2025 01:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9zKgvCFHQqK79PNBLR7HvOrjaBc3GJvkWurJxkVUOipNzIMh+6r3Gzlkx5gnE7FnQ21SMg==
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-42666aa6354mr14480169f8f.7.1760342436014;
        Mon, 13 Oct 2025 01:00:36 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm16718144f8f.35.2025.10.13.01.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:00:35 -0700 (PDT)
Message-ID: <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
Date: Mon, 13 Oct 2025 10:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from
 CMA
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, jbohac@suse.cz,
 Baoquan He <bhe@redhat.com>
Cc: kas@kernel.org, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, akpm@linux-foundation.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Muchun Song <muchun.song@linux.dev>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
 <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LIU1aDiKCoYyUCe50yzAUTf1NjcqGVUf6s7Rfb34vFI_1760342437
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_010042_106037_6908A71F 
X-CRM114-Status: GOOD (  22.97  )
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

On 13.10.25 06:03, Zhongkun He wrote:
> Hi folks,
> 
> We’re encountering the same issue that this patch series aims to address,
> and we also planned to leverage CMA to solve it. However, some implementation
> details on our side may differ, so we’d like to discuss our proposed approach we
> have tried in this thread.
> 
> 1. Register a dedicated CMA area for kexec kernel use
> Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the control
> code page and crash segments from this area via cma_alloc. Pages for a
> normal kexec kernel can also be allocated from this region [1].
> 
> 2. Keep crashkernel=xx unchanged (register CMA)
> We introduced a flag in the kexec syscall to dynamically enable
> or disable memory reuse without system reboot. For example, with
> crashkernel=500M (a 500M cma region), cma_alloc may use 100M for the
> kernel,initrd and others data. This region could then be reused for the current
> kernel if the reuse flag is set in the syscall, or left unused for dumping user
> pages in case of a crash.
> 
> 3. Keep this CMA region inactive by default
> The CMA region should remain inactive until kexec is enabled with the reuse flag
> (or fully reused when the kdump service is not enabled). It can then
> be activated for
> use by the current kernel.
> 
> 4. Introduce a new migratetype KEXEC_CMA
> Similar to the existing CMA type, this would be used to:
> 1)Prevent page allocation from this zone for get_user_pages (GUP).
> 2)Handle page migration correctly when pages are pinned after allocation.

It will be hard to get something like that in for the purpose of kdump. 
Further, I'm afraid it might open up a can of worms of "migration 
temporarily failed" -> GUP failed issues for some workloads.

So I assume this might currently not be the best way to move forward.

One alternative would be using GCMA [1] in the current design. The CMA 
memory would not be exposed to the buddy, but can still be used as a 
cache for clean file pages. Pinning etc. is not a problem in that context.

Of course, the more we limit the usage of that region, the less 
versatile it is.

[1] https://lkml.kernel.org/r/20251010011951.2136980-1-surenb@google.com

-- 
Cheers

David / dhildenb


