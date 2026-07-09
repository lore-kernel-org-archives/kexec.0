Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC70C44506
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPfLC5orl3FOJPqKVHrYgEfUBkfZk4Q5lRT44NLSQO0=; b=DrZC0ZrKlZ2XXiQ0rwP3+5s1D5
	qJr+MiTDclSKU0R+W/6EyRh0Ew0hlg1zIoIav/Hfvm5A0E1vmLxTeDPSrri1oifg4lW/KdxPN6Tfc
	1sO8ebXA3JdCS529N9eADCx5COVvaAXUkGdEe9cYtpKVKo22/tAGtIrzonnayuOI9TGqc4SeTFp4g
	K0Czl5gwd+vR7tSo4oZ+Nj7FwpmWb8saL9LiIFxY4AdNCexVWVFCY9q4UxuSGdUO36JkUbXMNdjxw
	n6HMwrr9pmMr0dHbDgKWxpoF04kjl1G7WQXUvpdALrNWp7XL9SVOde+HcXXUDCT7eaiGLSbukqYUh
	sNZ+Z/Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlrl-00000001vY7-1Ho4;
	Thu, 09 Jul 2026 10:20:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlrj-00000001vXj-11SI
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 10:20:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9D30404D5;
	Thu,  9 Jul 2026 10:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6601F000E9;
	Thu,  9 Jul 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783592422;
	bh=MPfLC5orl3FOJPqKVHrYgEfUBkfZk4Q5lRT44NLSQO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TkQYk0bInxmgbiOA9FOncoBSAGMtj+4O2aDKrMF3sQkk3lVKYVEYVWLhlNCjtHH/h
	 0ac62rG5qNjPNGJwnjcTdsKTGqi4OpqLkl6A/iDY9RizgvLAYJPynjqSi5WCRYWTbi
	 k70BVKmx6p/gDfx6KuujGDUVuXmBzvn7EIxkI0HLhz3I2PXQXBg+r8M54lv6YCtIoD
	 FPdOhbaji0PqzQ4epn0oXwWIQ54ZVK4X56kVXJo91FnPlUMapy5N25Dv4joagEqqT6
	 0WcjEKp65OaXqodIL9MCOihLA32LdiYInZWcs2wFVBM9VlerpcHJfpcNNAFWQWE3In
	 krq8LtfPyD96w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-mm@kvack.org,  Mike Rapoport <rppt@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  skhawaja@google.com,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] luo: Update serialized data to use KHOSER_PTR
In-Reply-To: <178271651966.13502.2620034351625890943.b4-review@b4> (Pasha
	Tatashin's message of "Mon, 29 Jun 2026 07:01:59 +0000")
References: <20260628001114.1869564-1-tarunsahu@google.com>
	<20260628001114.1869564-4-tarunsahu@google.com>
	<178271651966.13502.2620034351625890943.b4-review@b4>
Date: Thu, 09 Jul 2026 12:20:19 +0200
Message-ID: <2vxzldbklb18.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Pasha,

On Mon, Jun 29 2026, Pasha Tatashin wrote:

> On Sun, 28 Jun 2026 00:11:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
>> index 288076de6d4a..9e78625cfdc1 100644
>> --- a/include/linux/kho/abi/luo.h
>> +++ b/include/linux/kho/abi/luo.h
>> @@ -89,14 +90,14 @@ struct luo_ser {
>>  /**
>>   * struct luo_file_ser - Represents the serialized preserves files.
>>   * @compatible:  File handler compatible string.
>> - * @data:        Private data
>> + * @serialized_data:  The serialized KHO pointer for this file
>
> I am concerned about layring violation here.
>
> LUO is designed as  a generic, opaque transport layer that promises to 
> preserve 64 bits of raw data. How those 64 bits are interpreted is 
> entirely up to individual clients.
>
> While some clients like memfd_luo will use those 64 bits as a physical 
> address pointing to KHO-preserved structures, other clients may store a 
> generic token, cookie, index, or non-pointer status. By
> changing u64 data to DECLARE_KHOSER_PTR(serialized_data, void *) in 
> struct luo_file_ser, we force KHO pointer semantics and layout 
> constraints on all generic LUO files.

That makes sense theory, but in practice, no file handler is going to
need only 8 bytes for its metadata. It is always going to need more, and
to store more information, it needs to store a pointer to that
information with the 64 bits it gets.

Do you have any examples of something else one might store here?

At least looking at the current file handlers merged and in flight,
memfd, iommufd, vfio, pci, hugetlb, guest_memfd, all of them store a
pointer here.

And if everyone is only storing pointers in this field, might as well
give them a bit of type safety.

>
> Clients that need KHO pointer serialization must cast that opaque 64-bit 
> value to/from a  KHOSER_PTR  within their own callbacks.
>
> Also, the field descriptions in  struct luo_file_ser  are no longer 
> aligned due to the length of the new variable name, I believe it will 
> cause warning when making docs.

-- 
Regards,
Pratyush Yadav

