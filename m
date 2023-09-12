Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7451ACA0ECA
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7YsugySsB6eEcUMiEF3p+G+Y5KOQtQoIuBmX+Pelad0=; b=oAqtcTxga29qMf
	c2kDaZmuSZTOBDZUgVgrEKFFOXO74dggcP7SqhVx49T2nRlAcQ4mNn/rr2GowjTRtRTIlqCxZYHiN
	AXE7Bpuq8Z8u5LwvhFPEl5jgjszlaCnPfCN2jrGkvy+AVg512tbGfF7j3NO0iuWmBUo8gmFgDzkVf
	rm7cXg0iJA/YIArxFHEI8pprPS3+6Kl1Jk9rK1TRyB1TBRHkxfTCjWmZ2cw+5+jSFvYCCHD1nI1qK
	+pGny/hCMDakeoCYxVrqV6HPZLBe8Bt3S0mEW5vvBIXhVwezx9AfxhIhiCe+ixSklOpnIGQkbUjKT
	Nn9qRf+BU96wUyPxE6vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxaF-002MYB-2F;
	Tue, 12 Sep 2023 07:13:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxaD-002MXg-1C
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 07:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694502789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTSpSyC5EzR4JqjtmXWa4jhow1lkJCD2XnaN08RB0m8=;
	b=ZV82oyxX6lYliNZKE8gy0UHyXoCc/oB/F3Z0Dby9Xblcz+BRWNa4JhRSOefMlW6KhBVFa8
	9Ll65ZGUyK1kcLa1u5o8bmYlybc8F20fT9XZJfxaa5cZkxC4yPaLhH1xrvA6Cy+WLzkS58
	nR7R4XIXc9Be5uxhUxOlAXCj6dkpfK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-woOQleI7Oq-Ftwj7s2U20A-1; Tue, 12 Sep 2023 03:13:07 -0400
X-MC-Unique: woOQleI7Oq-Ftwj7s2U20A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3172a94b274so3755671f8f.0
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502786; x=1695107586;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTSpSyC5EzR4JqjtmXWa4jhow1lkJCD2XnaN08RB0m8=;
        b=o40CBoxZilWNMz3SzjwZSrSfTyOv4h2ZD7r6BMQ3peoyfeDVaNgXwyQkxQbWVIbM4Q
         m3HHXlljz1PB8fXC3o8qBb61vc3p4m3jYt2zvrycr2krMjN1zd9s9gmhbh5DKMlK0P94
         fy5quHACvn2f3340E1hT/gVnxJxsZSW9TSlBw5GWoQWuC6kNR3Jjrt/ugpz6zvpDIzgo
         KrqADqeZPmUgsz4rhaeFFNz6Zg8+VgbxV7dfTqap7a/0Aqgzt4BOiFLjEDlpIGSoGnA3
         VORLubOe+3sj/krXcuy3Pxerf71QRq6jKmjw0DK9pNuMzCR6AW/Myaj7mgoKHKY9dMlI
         CdMA==
X-Gm-Message-State: AOJu0Yz1u/QhuY7qk7WeMZIWOkW0JANmYhUtUOOe/DTezMU3fIQVf2LO
	sk4KGXtPckZrDoB2A1/SSEWB1eZMw6zPWStlMydGUE7kvH1arZq4zS61yM/a6SVgJ0KxmyWDkbg
	j1reaDK5HJ6PPVa6netWc
X-Received: by 2002:adf:ec10:0:b0:31d:1833:4135 with SMTP id x16-20020adfec10000000b0031d18334135mr9258404wrn.28.1694502786647;
        Tue, 12 Sep 2023 00:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzD/JqAKRst1uRyrpQ1ec8A47CJ05RJvD9vhfbLXgEIWlOOIOrNSivNy+JkLaFrl4za69IRw==
X-Received: by 2002:adf:ec10:0:b0:31d:1833:4135 with SMTP id x16-20020adfec10000000b0031d18334135mr9258385wrn.28.1694502786274;
        Tue, 12 Sep 2023 00:13:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id x18-20020adfdd92000000b0031aeca90e1fsm12117706wrl.70.2023.09.12.00.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:13:05 -0700 (PDT)
Message-ID: <3a37361d-1f3b-c283-3fb0-ab3614e3d38c@redhat.com>
Date: Tue, 12 Sep 2023 09:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/2] proc/kcore: Do not try to access unaccepted memory
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
 <20230911112114.91323-3-adrian.hunter@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-3-adrian.hunter@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_001313_478906_6791B8EB 
X-CRM114-Status: GOOD (  21.13  )
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
> Support for unaccepted memory was added recently, refer commit
> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby a virtual
> machine may need to accept memory before it can be used.
> 
> Do not try to access unaccepted memory because it can cause the guest to
> fail.
> 
> For /proc/kcore, which is read-only and does not support mmap, this means a
> read of unaccepted memory will return zeros.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   fs/proc/kcore.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> Changes in V2:
> 
>            Change patch subject and commit message
>            Do not open code pfn_is_unaccepted_memory()
> 
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 23fc24d16b31..6422e569b080 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -546,7 +546,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   			 * and explicitly excluded physical ranges.
>   			 */
>   			if (!page || PageOffline(page) ||
> -			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
> +			    is_page_hwpoison(page) || !pfn_is_ram(pfn) ||
> +			    pfn_is_unaccepted_memory(pfn)) {
>   				if (iov_iter_zero(tsz, iter) != tsz) {
>   					ret = -EFAULT;
>   					goto out;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
