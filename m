Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6ABEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gzw47Pl5vjBrIdgsubRwLWeIqDsMx9E0lNLYJVyIL84=; b=LbkJMvzNNn/qju
	ep0WP0UJ5g8HVspz/CtGfKitxLX9SWgTpu+JnfMA3cMkWGd5jfCqrJHX6W6ArO+Ts1AoEzbr3rh44
	z0Pp/H//fmgRrowMTxrImqu20E+3APO8VXp1oS9VjU6LanCk1wHDQe1ybmsPFdh7eNawp8OxBIoq4
	SDwne6ky4w2HfMZVhIsBE0ZmDOQvsz+tcdtHQb3aHMu707oF9/W2AY7gNMKTBBPVXdHUlxr2MnIY/
	I+Y/qjGhNHURV9u97/2RIC4SfSMEJBRNRNUSXuBqf+obhsWMIJoqJ/ieKs63lU8yvcxYf9e3CiUyW
	SyolpVEXolQsDYkDHEyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbzW-00HVo3-1w;
	Mon, 11 Sep 2023 08:09:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbzU-00HVmu-20
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 08:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694419791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE5jHWIoTi0oDDOVSbCQAUkm2GG93rVvkvjC/9s+zDo=;
	b=cXx3V0XyUbZrdCM8ZrLBSAuiRMW/d5EFZxCOCqg04FhQlnDp5M6W0bQq5bbfRztb/V1k9W
	++3RojbGKDvPyeiv6bNMGbAgNG+WsffPQM8VtiXcjfKIgOTaCvVllyq62B0oP48M26o7MC
	D+KW6OVh9c2GsLAAAzCQw/k8f/T3ktE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-wqneJ_zvOkubF0kDi54_sA-1; Mon, 11 Sep 2023 04:09:48 -0400
X-MC-Unique: wqneJ_zvOkubF0kDi54_sA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40309efe8b1so7695545e9.2
        for <kexec@lists.infradead.org>; Mon, 11 Sep 2023 01:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419787; x=1695024587;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5jHWIoTi0oDDOVSbCQAUkm2GG93rVvkvjC/9s+zDo=;
        b=HK7HHTg3e/cC1Pf6//kcjwlTxI/bDLJVXWdztdkUt7WvVyaxdckmfhVs3dia+dLBov
         DDOxIq6ddqagfbebujwsSe2uSh1DedybXxOblhsS5Dj5Zo7gmJC1UcMQXFZ/xgYOOOln
         o4C5lPR0FIR17ZTm9CwjoeF4CDkJm/j/dGAENNyDjYPnS+Bqiz/U93XBSTZfLHli6jtW
         6QZUBv4ygeH5uj3JnMY6th0DMKtYs47GnuRexa9xahNhJODYcI47ic2pT9mcens4HjQn
         ZnmqiyjGpj4mLxQyBXo/yk2TWUIswG6xSP4JMRChQ0ixVKliD/bAKVQCJ6wa6421AOTf
         gsBA==
X-Gm-Message-State: AOJu0Ywl8j0qAeHaW5SQZmhx8rb8yNaVC/rRfrbhyHH4fnVf1O5LocWJ
	6vzoObfww7AlKTj3q03QXYaAilEqTvtIzZOd7Q661aTHgfVkymBsq67m5jQXhoDkGCyepleMEWY
	26mqk3ku+e7vATy3ISihH
X-Received: by 2002:a7b:cd97:0:b0:3f6:9634:c8d6 with SMTP id y23-20020a7bcd97000000b003f69634c8d6mr7756892wmj.18.1694419786956;
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP/fXfkIDU6FsZ0+ujLPL6eiYP/U8dRfUXceL70QbvmQvHtk7DVWUJv4/1OPaMnnx/ifbxFQ==
X-Received: by 2002:a7b:cd97:0:b0:3f6:9634:c8d6 with SMTP id y23-20020a7bcd97000000b003f69634c8d6mr7756871wmj.18.1694419786499;
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004030c778396sm3452549wmb.4.2023.09.11.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
Message-ID: <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
Date: Mon, 11 Sep 2023 10:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
 <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_010952_726041_8A29B485 
X-CRM114-Status: GOOD (  12.03  )
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

On 07.09.23 16:46, Dave Hansen wrote:
> On 9/7/23 07:25, Kirill A. Shutemov wrote:
>> On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
>>> On 9/6/23 00:39, Adrian Hunter wrote:
>>>> Support for unaccepted memory was added recently, refer commit
>>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>>> a virtual machine may need to accept memory before it can be used.
>>>>
>>>> Do not map unaccepted memory because it can cause the guest to fail.
>>> Doesn't /dev/mem already provide a billion ways for someone to shoot
>>> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
>>> Is this really worth patching?
>> Is it better to let TD die silently? I don't think so.
> 
> First, let's take a look at all of the distro kernels that folks will
> run under TDX.  Do they have STRICT_DEVMEM set?

For virtio-mem, we do

	config VIRTIO_MEM
		...
		depends on EXCLUSIVE_SYSTEM_RAM

Which in turn:

	config EXCLUSIVE_SYSTEM_RAM
		...
		depends on !DEVMEM || STRICT_DEVMEM


Not supported on all archs, but at least on RHEL9 on x86_64 and aarch64.

So, making unaccepted memory similarly depend on "!DEVMEM || 
STRICT_DEVMEM" does not sound too far off ...


-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
