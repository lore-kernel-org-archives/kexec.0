Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE025C531F7
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v0qWoxbum+mc2LRSxBlzJpjmKPNemz4JvYfhVDhJ98E=; b=hQ/hTaXBa6rUkE7e61hvwN4Yc+
	IyEAIFlwr/vyOEUPXAo7eSmCsyHJ0feIvbJ+178rmdtHhBFPDWce9DZVWucmaCL+VQ1ny/g+nHX+N
	/tGtQ/PTFNM5sy/s/lVeum7uWMZkeKnC/UpffNUdTk0lQKUWKlpmDSKzosKHEN9KQVAMLiZGBp6/6
	159L9+kOlrDFIRqzG0J6U2ujq8luQyOFXrqxF+9iPBzrUin7a3kDMK6ErceDu+GeTJH3lX/S6K9Er
	yv4LHvpu7KXwsW/PsxdufbTctN+7YI5DuRfcIjKku293sStVPzic5PXaRt/UHIWL2aUQuuxsGOj4V
	3NYE0xpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmvQO-0000000Ec8p-18Nu;
	Thu, 23 Jul 2026 15:33:28 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmvQL-0000000Ec8C-0QYM
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 15:33:26 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-69f4a9eaa68so1482576a12.0
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784820802; x=1785425602; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0qWoxbum+mc2LRSxBlzJpjmKPNemz4JvYfhVDhJ98E=;
        b=RJJDAsMt4w8U0Tc7lhxRNLkIyUcAN58ZrCn95/FHIB1I348KQulXf34xI6sPo48Pvm
         LVSBcCEcfd82pby3ZaCli3U2nSea4cauP4/pfgTbDnRAwjjwZKSOZZCJt4KlKwJ8z+cj
         YbmC36b/vUPVDj5y3rw3Tx3sQbSThRQf/ph0X67nbYMLhxN40F/BgTSYiyf7C1c1HSTH
         eZj4OoDsS/7I0s5taog2HDAcMWrEpoExSxEYMssCDW5Fnwgo5+Oss9k8PoqJTf51cTzJ
         ZOeS+Yi2mhqo8a13DWYGqPGHTWsOj6fT9Q3ULeXmx6+RZI7vZCqK8gSSWrL6gWFMG/T3
         Q/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820802; x=1785425602;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0qWoxbum+mc2LRSxBlzJpjmKPNemz4JvYfhVDhJ98E=;
        b=KElDMy5Kg0dY7N9afwZdROjGfGu1ggAyzgsM/iR9yQlpAM58wQvQUjcs9hGbvD1eMh
         CVXmJBGCLHUmYA/Nrzl74+23zxDjIBPRSfh+6wcWllnop8pKmG1d18cw8oVuCZrNu/H5
         amCfR/NGTu7SnW7qW3ze04TRyF1hxCu6eNLlCkibnIBaTSmbBej0Fmt/eA8QnDgEdnP/
         Q3Yy3BIjL+S79w+N8kh7wBVsyYSjpMia/2SoQEbJvoT5Zlny5A841sBFvLEotsVLbXs9
         RKMHETYFJEmX0DNjUGZp0b7IQy8TOpFD3yHjNsfrWoWv3NYSco5d5DnMR9VzAudnkptC
         b5WA==
X-Forwarded-Encrypted: i=1; AHgh+RoUmFky7Enmg09j0748Tgrn3zhHl4YHwsqGIncVrnhO/LJpx92GcfBCVCF8EujSujkqdst8SA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7Yai5qS2ov38cNpVVMciuTGsJgTvNIm78Vnu5LSczYOVDTSCT
	FE54gRwQYewuzYjEhkkrJMH70IUa9VAFHjj6BFLGTcdxyXr1ju8MNncZBJ/Eh+f7doaGGgC9tIY
	k7FPLilkA7eGbUshNqg==
X-Received: from edbbf4.prod.google.com ([2002:a05:6402:1a44:b0:69a:9f30:4b29])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34cd:b0:699:2448:be63 with SMTP id 4fb4d7f45d1cf-69f6b63060emr1442487a12.16.1784820802174;
 Thu, 23 Jul 2026 08:33:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:33:21 +0000
In-Reply-To: <2vxzldbklb18.fsf@kernel.org>
Mime-Version: 1.0
References: <20260628001114.1869564-1-tarunsahu@google.com>
 <20260628001114.1869564-4-tarunsahu@google.com> <178271651966.13502.2620034351625890943.b4-review@b4>
 <2vxzldbklb18.fsf@kernel.org>
Message-ID: <9huzbjbx201q.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v6 3/3] luo: Update serialized data to use KHOSER_PTR
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_083325_180566_128416EB 
X-CRM114-Status: GOOD (  19.38  )
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


Hello,

I dont have much opinion here. I am writing this as a
gentle reminder to the open discussion below.

~Tarun

Pratyush Yadav <pratyush@kernel.org> writes:

> Hi Pasha,
>
> On Mon, Jun 29 2026, Pasha Tatashin wrote:
>
>> On Sun, 28 Jun 2026 00:11:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>>> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
>>> index 288076de6d4a..9e78625cfdc1 100644
>>> --- a/include/linux/kho/abi/luo.h
>>> +++ b/include/linux/kho/abi/luo.h
>>> @@ -89,14 +90,14 @@ struct luo_ser {
>>>  /**
>>>   * struct luo_file_ser - Represents the serialized preserves files.
>>>   * @compatible:  File handler compatible string.
>>> - * @data:        Private data
>>> + * @serialized_data:  The serialized KHO pointer for this file
>>
>> I am concerned about layring violation here.
>>
>> LUO is designed as  a generic, opaque transport layer that promises to 
>> preserve 64 bits of raw data. How those 64 bits are interpreted is 
>> entirely up to individual clients.
>>
>> While some clients like memfd_luo will use those 64 bits as a physical 
>> address pointing to KHO-preserved structures, other clients may store a 
>> generic token, cookie, index, or non-pointer status. By
>> changing u64 data to DECLARE_KHOSER_PTR(serialized_data, void *) in 
>> struct luo_file_ser, we force KHO pointer semantics and layout 
>> constraints on all generic LUO files.
>
> That makes sense theory, but in practice, no file handler is going to
> need only 8 bytes for its metadata. It is always going to need more, and
> to store more information, it needs to store a pointer to that
> information with the 64 bits it gets.
>
> Do you have any examples of something else one might store here?
>
> At least looking at the current file handlers merged and in flight,
> memfd, iommufd, vfio, pci, hugetlb, guest_memfd, all of them store a
> pointer here.
>
> And if everyone is only storing pointers in this field, might as well
> give them a bit of type safety.
>
>>
>> Clients that need KHO pointer serialization must cast that opaque 64-bit 
>> value to/from a  KHOSER_PTR  within their own callbacks.
>>
>> Also, the field descriptions in  struct luo_file_ser  are no longer 
>> aligned due to the length of the new variable name, I believe it will 
>> cause warning when making docs.
>
> -- 
> Regards,
> Pratyush Yadav

