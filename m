Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAA4C43334
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHDbHhIDiXI2xoLadD2AtR6e2Qr3MU3Q9Cci13JFRKA=; b=J4Qxe+ygnAPtaDno6GG9osMxnP
	APn5C+aMU6k/8tW+Z8HKYAjaTa2IMvlAu2d0gwniQDILuGSs8wSIlwrJlijVo056sS0bHq3XxAl1j
	zzG33bR1oxJlevZVsmVom7uR2VWqjTDikG/3vgBCzmz/m4Wvc7iXGUa899eBjc5R2YhJGLnifMs1X
	AfC8MTvlyO9vy4ifKNXTYguKY7pDm+dHbqI1pX0NuvulEwHItDLeYWiCd08Wku0JexCBzZ4heUtBe
	KYRLn8mjhhRP7yAF7fx44BGotkTahj3MDFrSelams8yC3JwJe23OiRjWHi2ZaLJoTNqnzwzYw7MIP
	ryVWJTWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzEr-00EtxJ-LB; Thu, 14 Jul 2022 13:50:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzEV-00Etgu-Sc
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 13:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqRw1G8aZam6OHUc5a/z5Gnu6/RwvclS67B8cHWbrGA=;
	b=QS7dk2ntuxceXG2vj6A1aTruzvijuyzrjW2/6Ya+Lq7ImfcbV0neHXc6I+MFC35MIU7ftk
	OJXvE1PHxvEjrYB6dFw1PK5kGwIegoTHTBeD1va8Cw6kxnoTY5a/TBHhbONl0EG870/+id
	khuYzDCMX3FPylcUKI4y9Dy2VyMrumg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-ajWpLfz-Os2jOiwNLbPQ9A-1; Thu, 14 Jul 2022 09:50:20 -0400
X-MC-Unique: ajWpLfz-Os2jOiwNLbPQ9A-1
Received: by mail-pj1-f72.google.com with SMTP id pt7-20020a17090b3d0700b001efb2800e55so1320767pjb.3
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 06:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqRw1G8aZam6OHUc5a/z5Gnu6/RwvclS67B8cHWbrGA=;
        b=oAl3jC8KfgeQcHA3uA3IAeH01K81IRNM9/l3uw58wGp3AHDQUPvwTPYNe7Yg5vLLN1
         UNab/G3m8rnPVzbrEmbI/tFJhP+ule9oGow5Slns6mmaC9nMAGl49oajVIXJwPayLcBM
         h4Djg948/J+PWYsoFn9RkW/m8qYHITceUxjHucwj/xXCaZdUH5hWdOLx6VWK2U/PMQZg
         RAMU2qiXjqNKHLNSIQeMGqDl9L3xniZPmhLP5erbyKyExNTQo7EJ6NTCTElngj2/wxZ2
         Lz1fCcZ/WC2gKKfD9ehh6JyOxL+mL+o3tV7f/YsClDwUfhHntZo6VwVTo4d7T6CqPDvl
         hw9Q==
X-Gm-Message-State: AJIora/KQEALx1FxG8KHBvvzsgZL3UQ/ph8jLG66SXLU+RRjJf5eYhxZ
	YR4E+qEOmmIoSJK6guk5HRjqJBsAFAIQPRjVLT87aIIUOsKA8OBUzCwn5llT4a7kFlhB1yIOzfn
	IHVFCkdvDLimQYaxCxJKt
X-Received: by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id l12-20020a170902f68c00b0016c4eb6913cmr8356005plg.2.1657806618469;
        Thu, 14 Jul 2022 06:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ubfYsFNwV/IDviweRzJNFs2D5e+LIyoL2+y7WGNS1yi9NhFkim8OrEWegyv2jH+eXRVL67hg==
X-Received: by 2002:a17:902:f68c:b0:16c:4eb6:913c with SMTP id l12-20020a170902f68c00b0016c4eb6913cmr8355975plg.2.1657806618165;
        Thu, 14 Jul 2022 06:50:18 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b0016cae5f04e6sm1487526pll.135.2022.07.14.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:50:17 -0700 (PDT)
Date: Thu, 14 Jul 2022 21:48:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: akpm@linux-foundation.org, Will Deacon <will@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220714134845.ypm25hxk773qxe7v@Rk>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
 <20220706114806.GB2403@willie-the-truck>
 <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
 <20220707141029.tj6zerqd6dcu2wrr@Rk>
 <bf0d023a719db587ba8dc5ef7559f3d0b9542cd5.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <bf0d023a719db587ba8dc5ef7559f3d0b9542cd5.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_065024_072941_9D1B1546 
X-CRM114-Status: GOOD (  16.02  )
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

On Thu, Jul 07, 2022 at 06:28:50PM -0400, Mimi Zohar wrote:
>On Thu, 2022-07-07 at 22:10 +0800, Coiby Xu wrote:
>> Hi Mimi,
>>
>> On Wed, Jul 06, 2022 at 10:33:50AM -0400, Mimi Zohar wrote:
>> >On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
>> [..]
>> >> It looks like this series is ready to go, but it's not clear who should
>> >> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
>> >> take it via the arm64 tree (on its own branch) if that would be helpful.
>> >
>> >Unless Eric is interested, I was asked to pick this patch set up.
>>
>> Thanks! FYI, Andrew has queued up Naveen's patch set "[PATCH 0/2] kexec:
>> Drop __weak attributes from functions" though:
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
>>
>> With Naveen's patch set, "[PATCH v9 1/4] kexec: clean up
>> arch_kexec_kernel_verify_sig"" can be dropped. If you need me to send a
>> new version, please let me know.
>
>I'm not quite sure how to handle the prerequisite patches being in
>Andrew's tree, without his creating a branch with just the two commits.

FYI, I just sent v10 based on Naveen's patch set and it targets
next-integrity since Mimi is going to pick it up.

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
