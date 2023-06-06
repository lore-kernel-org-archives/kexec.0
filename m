Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147A3C77B7A
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c35lshbiN3xtgCvJy6AK5A1nMHb7s2lNdZGu8ilWJ6M=; b=H0Vs1SaEecxkaHC7boFMK4uZNg
	kyGQlqouTslftjuKXJtDvipY7E9OY5jv34ziQbNGmIATexU4yE7ad0QK7LADk/g4GRXXLPI9Ah/gE
	0Tg+cB6rpAj43Ms0YlDjopB3GMm1rwG4fFO5FSvrALtoqnoqpyTcu7VlsmwARNwUefD1YQ8cnTBZH
	oJjb5Z/KCrSEHxiqOqMKfEQmd7jVGbhvZad0L4qNsRSarZOlXhSqipb5md70geUGoCTNqBdaZvR72
	mJblIRXe843gDNCdj6ZPtuNGPjoDDwPevYTZLKtpyYu14YHneayBw/b6dqMakLPmeFaO7QJvFeTBe
	KjMbSSfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UTV-001Nu6-0V;
	Tue, 06 Jun 2023 11:03:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UTP-001NtN-1L
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 11:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686049413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PECCGAhd7teBhoQVIkKkQ0gCChVRirWpXr8QC6vVa88=;
	b=b54OKLEvK+NAKPBFsc68Rt9vnMKHqjavlIlPotac5n4rfG3L44+lqKxG4+YdXL4PJ5MeWl
	zwr4jpXEti/IS3kJLg9BM2+3LAs7KL4fv2/sJdIXUxLNCUmBm1KlSeMgvwCBRvb6N7VONr
	JQ8cLo7mHtapx4quGhZ6yy/0kTpWLP8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-IVpL27TPNbuIpqrqyRRwvA-1; Tue, 06 Jun 2023 07:03:32 -0400
X-MC-Unique: IVpL27TPNbuIpqrqyRRwvA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5400b72fcb0so1704846a12.1
        for <kexec@lists.infradead.org>; Tue, 06 Jun 2023 04:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049411; x=1688641411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PECCGAhd7teBhoQVIkKkQ0gCChVRirWpXr8QC6vVa88=;
        b=Hs/c4JqKKh99SY2RJRuM5InRO4Yzp1J7i+WjDQT39/AQatl+6h3+fdMeHU37bWSB9j
         xDDHXWLeUja5TQ4h1DJRBRFtL6vBTL82q5Fga3lp3zLsXviOHCm0eIgHOhX6VC+I+2Ys
         He7d9D0/f0zrOhKIVzHbY2qtfZto/oYb0BVhtKPPQofZx7tyjSpInymXuNPr1aof1Y5E
         VmvlfyJej0tpyhrl1KJm5uSO/3WY0Nj1/kotG8CXxQxhubTsji86a/lYjFcKQyH3aemI
         HLE6BQb63KrNfBr5UL0+1zWvw2At/ntN5L72wBaO4bi0i2J6IEsP9+VWZGv/xj+7UnEv
         Ihww==
X-Gm-Message-State: AC+VfDzZewuPxCRI9Dqpwlg0sY5nNSbVLd2zhOPZ9cJUdONOGMolXzV+
	BUZv7Znp4ey+gJ3JXScpOC8ifNS1H7xDfZkCf0uFrxU5E/ReyOYF95H2FPYO3kzGdNgitIyqyVh
	SYK+eXb+QPfy81D5p9Z8tSSVJU5jHBAJ8VhqK
X-Received: by 2002:a17:90a:cb8f:b0:24e:2e86:5465 with SMTP id a15-20020a17090acb8f00b0024e2e865465mr244064pju.31.1686049411620;
        Tue, 06 Jun 2023 04:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ut1fWyiC1Sxe/ag4hpzoFeyDmazttp0G3bC8zYvg1LgXcS3Mz6lzRVYGA5vny7y9WWqUGuQ==
X-Received: by 2002:a17:90a:cb8f:b0:24e:2e86:5465 with SMTP id a15-20020a17090acb8f00b0024e2e865465mr244050pju.31.1686049411302;
        Tue, 06 Jun 2023 04:03:31 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3-20020a6542c3000000b005307501cfe4sm6611337pgp.44.2023.06.06.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:03:30 -0700 (PDT)
Date: Tue, 6 Jun 2023 19:02:19 +0800
From: Coiby Xu <coxu@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, x86@kernel.org, dm-devel@redhat.com, 
	Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
MIME-Version: 1.0
In-Reply-To: <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_040335_529973_F4C9FB02 
X-CRM114-Status: GOOD (  27.20  )
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

On Mon, Jun 05, 2023 at 09:09:49AM +0200, Milan Broz wrote:
>On 6/5/23 04:31, Coiby Xu wrote:
>>Hi Eric and Milan,
>>
>>On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>>>On 6/2/23 23:34, Eric Biggers wrote:
>>>>On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>>>[PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>>
>>>>The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>>>happens to use.  But LUKS is a userspace concept.
>>>>
>>>>This is a kernel patchset, so why does it make sense for it to be talking about
>>>>LUKS at all?  Perhaps you mean dm-crypt?
>>>
>>>Exactly.
>>
>>Thanks for raising the above concern! The use cases like CoreOS and
>>Confidential VMs explicitly want kdump to work for LUKS. And correct me
>>if I'm wrong, I think the two problems addressed by this patch set only
>>apply to LUKS so the kdump part of the kernel only cares about the LUKS
>>case. If there are use cases where similar approach is needed, I'll be
>>happy to make the solution more generic.
>>
>>>
>>>I had the same comment almost a year ago... and it still applies:
>>>https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>>
>>>Anyway, please fix the naming before this patchset can be read or reviewed!
>>>
>>>LUKS is user-space key management only (on-disk metadata); the kernel has
>>>no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>>>(either through keyring or directly in the mapping table).
>>>
>>>Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>>>is used in many other mappings (plain, bitlocker, veracrypt, ...)
>>>Just use the dm-crypt key, do not reference LUKS at all.
>>
>>Thanks for the reminding! That comment was on the first RFC version. But
>>starting with "RFC v2", there is no longer any interaction with dm-crypt
>>(to save a copy of the LUKS volume key for the kdump kernel) and now I
>>make cryptsetup talks to the kdump part of the kernel via the sysfs to
>>reuse the volume key. So only the kdump part of the kernel needs to know
>>LUKS which is what it cares. Thus I don't think there is any kernel
>>namespace pollution now.
>
>Hi,
>
>I am sorry if I did understand correctly, but I thought that kdump is part
>of the kernel.

Yes, there is the kernel part of the kdump although there is also the
userspace part to make the feature complete:)

>
>I am trying to say that kernel generally has no concept of LUKS;
>this is a userspace abstraction for key management.
>
>Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
>has nothing LUKS special in it (only in DM-UUID as a name prefix).
>
>So I do not understand why you need to mention LUKS even in kdump part.
>Perhaps it is still only a naming problem, nothing more.
>
>All you need is to preserve key and configuration parameters (for dm-crypt).
>If it is set by cryptsetup, dmsetup, or any other way is not important - on this
>kernel layer, it has nothing to do with LUKS key management metadata.
>
>No problem if you support only LUKS in userspace, but really, all this machinery
>should work for any dm-crypt devices. Perhaps your patch even works for it already.

Thanks for the explanation! After reflecting on your words for some
time, I realize I had an implicit assumption. I assumed is if I use a
name like dm_crypt_key instead of luks_volume_key, I need to support all
mappings like plain, bitlocker, veracrypt as mentioned by you and this
could mean much more efforts. So I'm not motivated to do that as
currently users only request kdump to work for LUKS.  

But maybe I can divide the efforts into the kernel part and userspace
part. For the kernel part, almost no effort is needed since only
renaming is needed as pointed out by you. For the userpace part, maybe
it's OK to support preserving key only for LUKS2 in cryptsetup as hinted
by your last paragraph? Does it look good to you from the viewpoint of
the maintainer of cryptsetup?

>
>Milan
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
