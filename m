Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0140EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lq9u8sX4TqN3hNWZwZJKGCQVuYRZV/BCEkUQDu/G/fs=; b=qV1jWXu8D8UDqC
	6ua5w/LBmIspHqO5fAeeL9PwPdqJeJivlhSWpUcSIkrYZWgU4YQZtGfU4P6H+/Gk9IWu5CZL3E89M
	0TrvZV9I174wfAqO7Gu+A0nD5e2X3hNSJBT/WkqRE3HuLg8PuftqRSAHrC99JrGUt4gfYq4OG/mTL
	tClONYOo3/IFSA7DqRCR00oCjMyqlgDFJZ+kFHBGVngJz6b7dDbVcyg0G6/6UIckSEZvyovKptIUL
	0At0+3dEFUdgLCFCUxHeCUB8lBbpGWHal3LODovJpyMQ+cUwp/IsYvBEtOvMyqgbwI0dtFNOPTXVs
	AgwO21CvRQO44VZBNsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbtb-00HUog-2U;
	Mon, 11 Sep 2023 08:03:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbtX-00HUny-1d
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 08:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694419421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrV+UHvgaplY9/k+vBVt5n0teGN9bGsHMMAwUGo1dQ4=;
	b=FbL5rWxUq3SEePjUP3/v6nbZYfKhML0eBZwCJi6aO8N3k+eJwFemmmL6nqeOxAuqBknPQe
	n/zgk5OaMK+wZwxCFLRmxt3SDPORNVlTKOI+nX9A+bztFuiEIiVjmBEUz5pVovcgPRRLVF
	HuWefuSN77EJEdikENSrA5VzLRJRe+o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-SP_s-jLCPC6xaaeVonthjQ-1; Mon, 11 Sep 2023 04:03:40 -0400
X-MC-Unique: SP_s-jLCPC6xaaeVonthjQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402ff13f749so15852775e9.0
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419419; x=1695024219;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrV+UHvgaplY9/k+vBVt5n0teGN9bGsHMMAwUGo1dQ4=;
        b=T7wsd80dLlwywlUlz5hn+7kGUFCmSxf/lLS9vVDeMktaO7bdVE7tQK5mbQfjCgC8kC
         fwOVk/7REd8Th2kkvmDtk0vpztiZHG85IctPfBxaobpTs8uF3BMMN5CQ2w1ZyBdp+9k7
         8gJzqJZ/mFfXEE9yoHbwLNJ6NJ7FqbIAEn2HUSfzD6LodLMlh930qFl/Eayq/y36eC/p
         wlXrP/4YB4t+hNXHL5HzK/dR1l8qWp6+bxCSJJgJSybOcsm8HPz4PD/tRveG8dWMCn+h
         JpJEaltHd7G7gQmUDNAEa7Lz7+xrIr7BSZ65TvS2hgLAT036lzZ33fFfugB/JS9URhVJ
         fe5g==
X-Gm-Message-State: AOJu0YwnQxlyO5+dx2bUNIU8H8nCrGd7BgtleJUUcJkZUM8smQTV1V9+
	bdjEAvIHESByhMmIaGM+h/Ts8Drt0FYrNNERJsjMM8Kkg1wBujBlyZa+nEBq/nTRh4HZjWlU124
	/P2SfmErIuKsUpVIKfujX
X-Received: by 2002:a7b:cbd7:0:b0:403:bb3:28bf with SMTP id n23-20020a7bcbd7000000b004030bb328bfmr2323544wmi.23.1694419418732;
        Mon, 11 Sep 2023 01:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7EvIVVm6lIu/W9CgMSy8CEDYEwYaFhdi1B8VWOvJfeNjozxmbl+32f4PcpqOmD3Ruy38Uwg==
X-Received: by 2002:a7b:cbd7:0:b0:403:bb3:28bf with SMTP id n23-20020a7bcbd7000000b004030bb328bfmr2323518wmi.23.1694419418297;
        Mon, 11 Sep 2023 01:03:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id r23-20020a05600c321700b00402b9d611d9sm5118569wmp.0.2023.09.11.01.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:03:37 -0700 (PDT)
Message-ID: <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
Date: Mon, 11 Sep 2023 10:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
In-Reply-To: <20230906073902.4229-2-adrian.hunter@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_010343_634697_A2CE3533 
X-CRM114-Status: GOOD (  14.92  )
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

On 06.09.23 09:39, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
> a virtual machine may need to accept memory before it can be used.
> 
> Do not map unaccepted memory because it can cause the guest to fail.
> 
> For /proc/vmcore, which is read-only, this means a read or mmap of
> unaccepted memory will return zeros.

Does a second (kdump) kernel that exposes /proc/vmcore reliably get 
access to the information whether memory of the first kernel is 
unaccepted (IOW, not its memory, but the memory of the first kernel it 
is supposed to expose via /proc/vmcore)?

I recall there might be other kdump-related issues for TDX and friends 
to solve. Especially, which information the second kernel gets provided 
by the first kernel.

So can this patch even be tested reasonably (IOW, get into a kdump 
kernel in an environment where the first kernel has unaccepted memory, 
and verify that unaccepted memory is handled accordingly? ... while 
kdump doing anything reasonable in such an environment at all?)

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
