Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89702CA0ED3
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HtZBK/ltJDAw1oyCAEsI0dGtleHZZKoW87QqYmrLiL8=; b=VS2sq4/mdDePH7
	ni4fEZpC2a0zIBYHRKkqeriyAmWDcnJOiYC8DBoIIZcS0uGsIHYRi/YlHfpGvs5U7J2mF7QriAM99
	kgD2uiEn6eNoZ0vtcKnaJgzcdsQL3eb0BAR0Igga9aGf1kaIMQj6NiyPAnNRDyQTA9nJZTYKu2Sx5
	5oiuCmQSRKKzazIrZMIn0uD3xznY3xKcfU335CW7CQE2Wk90ek2IjpW4WAx1jJ12NL5rDouoFNuVX
	KdH+Dpt/Pd35PNTG9nyi7xuHIzbppdTmqB119ly4AMpAuH2TolvmIiuzdOG1bqFqe6jCxo905GvBq
	JbOqzPnO+4uLGk3LT/5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxgY-002NYU-00;
	Tue, 12 Sep 2023 07:19:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxgV-002NXA-36
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 07:19:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694503183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcEya9HqsW3o+5ldQKv7HTPg9J+Z7fGPS0QxHHzAjY0=;
	b=Llhd2xeNnpjLByHP4tUI6MoGML/jPRat3EwY7wLIXtprvvu4h7/2H+3gAL3Q5N4ETSiiBw
	6RVrXqFnPstkSiuz34AzxLExKlOmL8dVbhtAmMfqsP4F7gBPv+KF5CJ8Efov725ygPnhYJ
	y9Pq1x87EWk1IwFQEUpB4KSbJtVvWxg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-7VF65HJeNjKRXxHZtqmvFQ-1; Tue, 12 Sep 2023 03:19:41 -0400
X-MC-Unique: 7VF65HJeNjKRXxHZtqmvFQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so41527505e9.3
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 00:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503180; x=1695107980;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcEya9HqsW3o+5ldQKv7HTPg9J+Z7fGPS0QxHHzAjY0=;
        b=R24YNWawvxk8Zh5G0M/Hl4MwSeRjoTJJ/1pQbjjTxtduDcMS6BvB/0K54IxHO2my2Q
         6zKbSseb3G8aFVBMwANgcwnvf0t5X09TJMUWJdH/7z7SXHNfoQV9uwypKRvgfDEZjqMd
         20lSxk/nV7pe6Ja3JHpKFBea1au/o2gWBG0nJT76YdgTX9j4HVb/d/zNwOlBmtWz8lZH
         U4WFm80Bhc6aBm5zv1QL+C0NGmJYCXXKqlPAmHgY11LmcbWNFo763tTKQoaZ9mF10VRv
         q8OCcA+gMa7X7uBeTCAC5hjcbiEtgoljq93dJS6MAMypVQlUOesGpY2icyHDm7UDEZRd
         i7LA==
X-Gm-Message-State: AOJu0YycVV6JoLUOVacQCYWRW9pKtMmnW5sIpio4PSWXXL5dKIaft5Wv
	3i7wQKzaCts/Muhmhz3qPL27U4/Hg75i3/1Yu/45DrvkVv4MXWE7Y4keaM5r6wHlBTPbP67FKqE
	4SjmIiONuqt5lR/NoW5UP
X-Received: by 2002:a1c:7c0e:0:b0:401:6800:703c with SMTP id x14-20020a1c7c0e000000b004016800703cmr11272007wmc.21.1694503180596;
        Tue, 12 Sep 2023 00:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBHMbRtiRZlVheP6qVSb8MqZ6oMl+4dwmRZR30fLEhp0pib6sKRWhTtFCZOTZU2I6KyZfYPg==
X-Received: by 2002:a1c:7c0e:0:b0:401:6800:703c with SMTP id x14-20020a1c7c0e000000b004016800703cmr11271987wmc.21.1694503180236;
        Tue, 12 Sep 2023 00:19:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003fc02e8ea68sm15188204wmk.13.2023.09.12.00.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:19:39 -0700 (PDT)
Message-ID: <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
Date: Tue, 12 Sep 2023 09:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
To: Adrian Hunter <adrian.hunter@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-2-adrian.hunter@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_001944_067603_BB65FAB3 
X-CRM114-Status: GOOD (  10.81  )
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

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
> need to accept memory before it can be used.
> 
> Do not let /proc/vmcore try to access unaccepted memory because it can
> cause the guest to fail.

Oh, hold on. What are the actual side effects of this?

Once we're in the kdump kernel, any guest is already dead. So failing a 
guest doesn't apply, no?

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
