Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E4EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vEhs0U1ka72XBSapyLnFOCK5m3i4mPI5PhILWKFHyjg=; b=F+9CXSII5KHCkR
	D+8Hr34bYbaL7ToxdYhHRg2yHBpEEhJpjLpDFUKAOO2oDZUy5zi4KG5pvK+O6MMLKvHXdvKUsO/70
	9eOr1wlgWdU9ZGda9jDxx2s43TolUZmQ2H8rGFWXDI5sVbFgVGwCSfNWrEEs4YGLrgMWxSjT/kyWx
	n+n24xHHK/Ls4eVYwSJcp2vhBt1FO0rKapUgZAXLgMBRfYiMuSwORusjt9GdVcunNtCkS9m2TTD3I
	numxgo4mVPAe7bcUr8mw4L1WqPGrFaP1A+bero4pmlkxm49bvF4e4PAJ10XFQFO0YpkZG/BkDAw9i
	XhMiFjk2GeQvtgLglWGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcVY-00HYiJ-0p;
	Mon, 11 Sep 2023 08:43:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfcVV-00HYhx-2Y
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 08:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694421776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1O9Hjy9rHsZrvC8iggQtpHWHNRqlOhd3zFoat4Zny8=;
	b=SXcwhLXnJLi+LlIp2MIOs54nBcimFhDhLMr3Q9Du7F5CyrOVhkr2pGxT2wPVmpvss6vmLD
	ziT4tYhhk86OLUGmWB3dZZ2gIUj6lIeb9pEjyQH/aVNIv7vq63spYeXtzqsmcOUZmuSslO
	uQQgAixZPG+8FKyPa3cMJgwII3BiKwo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-D797LD_ANXqaz1bF1-v0ew-1; Mon, 11 Sep 2023 04:42:54 -0400
X-MC-Unique: D797LD_ANXqaz1bF1-v0ew-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso31441405e9.1
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421773; x=1695026573;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1O9Hjy9rHsZrvC8iggQtpHWHNRqlOhd3zFoat4Zny8=;
        b=Y2pvm3on3OlQ5k3PgKp+rya9kwevgDAb25gjAaJM0Ja7d6/xRpdLJ3fmc2+mi93cxQ
         ROik3YEIuXdQdfCQZi7ge2GSFiFSagMZWuBwgt7XnBvoH2F+tXMu2ZUen2bojvJd6070
         ZusXhEVw/z/Zp+XuUsUNAuT3IYGpSv1kSAKRlO5shfWD8JZ2G1fh1dcu8Fms+BVoJNI1
         YF0r2k2kssYXXLqP4C01afSTnGrgsxE2KZupNcypcShr1TtHxlklKMrwfII8F5myqHAa
         uKm8RfzuWa4UC8QzzzDfVXxKnt/T4XIysOFOi4/UeRhW5yEbO9B2q6eCztAXfW3Eexeo
         GYBQ==
X-Gm-Message-State: AOJu0YzO9lCbNNEEBHNtgrcyYCS2/knQidiOb7MOcaHw2mqF7rgblQ3v
	OBizjP5iZ5De4S2VDHSAsaMNfd/aDzS7MY0dZsMa+p2F42aB6biLSFeJllhPq9ix3GRq0SZzJZk
	ptbp7bYRLOLZeUDIhSjAE
X-Received: by 2002:a1c:ed0b:0:b0:3fc:21:2c43 with SMTP id l11-20020a1ced0b000000b003fc00212c43mr7346840wmh.13.1694421773452;
        Mon, 11 Sep 2023 01:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8aoBWfTO9D3ZTCmaaRT0GwaH8BSrY/roXA5t7CzHxEaXPavXU1Y6T8UuPI7Q1KEVVmKAG3w==
X-Received: by 2002:a1c:ed0b:0:b0:3fc:21:2c43 with SMTP id l11-20020a1ced0b000000b003fc00212c43mr7346817wmh.13.1694421772969;
        Mon, 11 Sep 2023 01:42:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003fee849df23sm9372755wmk.22.2023.09.11.01.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:42:52 -0700 (PDT)
Message-ID: <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
Date: Mon, 11 Sep 2023 10:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_014257_924548_8AC3D05E 
X-CRM114-Status: GOOD (  15.83  )
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

On 11.09.23 10:41, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
>> On 06.09.23 09:39, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit
>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>> a virtual machine may need to accept memory before it can be used.
>>>
>>> Do not map unaccepted memory because it can cause the guest to fail.
>>>
>>> For /proc/vmcore, which is read-only, this means a read or mmap of
>>> unaccepted memory will return zeros.
>>
>> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
>> to the information whether memory of the first kernel is unaccepted (IOW,
>> not its memory, but the memory of the first kernel it is supposed to expose
>> via /proc/vmcore)?
> 
> There are few patches in my queue to few related issue, but generally,
> yes, the information is available to the target kernel via EFI
> configuration table.

I assume that table provided by the first kernel, and not read directly 
from HW, correct?

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
