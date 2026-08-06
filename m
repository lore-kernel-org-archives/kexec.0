Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2B6C55ABF
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SOAFOHhNdPiE/zVJtR+92drLkni05r7F3CCyaWM+hc=; b=QbzGs3GHeRPfuQk12WSSvNVDw8
	ueg2gHC9eItssqHW0HOshZlMo34AaLv0bD/nwbqL5cPY+gC/I5L0VkZrN7K5zEQvMFKurbr4DRQ+q
	IuOlqgyNHpimsDygAJcvktIHcfk3nBsnoezNoe0kAPCEgSjSvMfV0daNOvNic++Mp3g5Mx4jDEmx/
	zkHsqWQgqFlXhNX0okYo8LpDUIPYJdblU0ZFE4agoViBFBmhtQ2EK4ZeDxgZjJ4TEfwtK1tHMXJgx
	Fls3SoJ96/0aTQwxjaDUpRmlOTZl8hFDzWCgsAYU1nBDpbft53/wqAzj8pIJoNcnN2jamMCDPaWqZ
	E1ERDrUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrrUe-000000051xp-0fVr;
	Thu, 06 Aug 2026 06:22:16 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrrUY-000000051x9-1bvD
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 06:22:11 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2194284b3a.2
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997329; x=1786602129; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SOAFOHhNdPiE/zVJtR+92drLkni05r7F3CCyaWM+hc=;
        b=U0osg1/SievNgLsbfaXdi5Xoogknw8O+zD/v1KwmqTXQHLgmQ9IvR452vuRZms7YrJ
         QXfLE2xoROaBayuQJQ5qB/YWFHAiBvZFqx96cHhxPgixRMCHU+0tVrZlJD3Gcl01SvKN
         kBGDKQDL0xQtJ7gUj8aK124ITaiTcga9ACRMsqKqxC0PBErs/Icp64OKXvHSkudfD4eu
         paLDjWFTEweQS4jFrZPJ8iEYVXQi0sHNhRP7Fc11xUvNClXC4qlvLGqF9ycjsQzW1gB1
         uMDkAtX2lOuMx2SzXgHESMGSTLgWI2wyASQklqhnmJXb0Ca+6QhSHSfNf1L0vpEk7OjP
         3ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997329; x=1786602129;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SOAFOHhNdPiE/zVJtR+92drLkni05r7F3CCyaWM+hc=;
        b=tVDlwBTb9wlDup4td3IYaBTgapwG27Dkm5TOheYWjZus/9baC4khg7fgprVJB2nmLd
         I9C5jR/oCar9OOCgsElKnnx6auCvZm0o9mya0A2Un8kqmUM3cf9QnzV9lXNMelsHSD+6
         qiQZm7diESfNH/FDEDa9gERyukqg2qdvXw1a4fdlBMvq0TfiCkk3BoWniKGKaOaQw8wp
         B7N4zOVXyP7KUnwceRuZ6C/0KVSKhKWB9+PWK3CgXDodWQSk+uY6Jl3pr5qnthA7xlgD
         KBumrmhqH/TpwDJArRK0zU/ESwt1ut1eNuMPBwIRRy3KiUAW6f1Ho28BAIcdUmxmTjrz
         J4jg==
X-Gm-Message-State: AOJu0YzirAoMsk1DbNiYngZj9QhbMSziUWWiF0AF80o5w4RH8C4252oV
	jCrgUXo7kXzhByE3NtdmxqIF4bBh6mvKRSuWpLSHZ7A/aq7OGLCVrgXG
X-Gm-Gg: AR+sD10RxUqEKg4YG0tcjU0cjk7xVUXsZHvknlZanUYilRU4js4aTqcIOoZpS4wBCPr
	7xm/ghYcx/cyjvsxjGiDxvpPq3u+GOrcyrF1UiQJzGrirtCa5OXPXGKLNqrCcXC9WtaJvYly/7Y
	VjvUUaeEeIsV01jnzHm9lVshb5VjgVHi/+scS/ldhvN2N8/jLz7+Mi74IarhViGyw5UZ4RKAt5g
	FO7Q+5RC1JzsliTMA7r/GuAuJwnI/X48dXSPTc3VEEcHiYjyW0j9WM/EOkr9EZ4GSFxNNmaPRZN
	SPCB4FTxkxn9QgAd5wmK8el5/wo+8sSHH8de71HYKVNPdnAc1S0tfrDvtax1QODSUKQpv4uLzDQ
	4Swt4otcFrc4xW6caJgIV9g+916woWCU7MVD+YMGWki5pzz2KfkwCX6xNRqECMVrMvl3NwXBPhh
	qGqlIsFC35L4MvkU40l7cy16Y1THZr5C9VufKjns7IKBI=
X-Received: by 2002:a05:6a00:8d81:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-84f2dfc8f83mr16142823b3a.11.1785997329428;
        Wed, 05 Aug 2026 23:22:09 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f3:25af::3c1:3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f459ba50fsm659110b3a.42.2026.08.05.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:22:08 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 6 Aug 2026 14:20:39 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] crash_dump: Read the number of dm-crypt keys
 from reserved memory
Message-ID: <anQkT6jwznGfzs1R@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-5-coiby.xu@gmail.com>
 <cf03f9c1-5970-4d65-9c4f-6b4fb12ccecf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cf03f9c1-5970-4d65-9c4f-6b4fb12ccecf@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_232210_427122_1700BAF7 
X-CRM114-Status: GOOD (  18.97  )
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

On Wed, Aug 05, 2026 at 04:35:50PM +0530, Sourabh Jain wrote:
>Hi Coiby,

Hi Sourabh,

>
>On 29/07/26 09:06, Coiby Xu wrote:
>>In case user adds/deletes the keys by mistake, it's safer to read the
>>number of keys from reserved memory.
>
>I am not sure how we differentiate between a key being deleted 
>accidentally and a user
>intentionally deleting it. However, I have a question about how the 
>kernel handles key
>addition and removal.
>
>How does the kernel handle key add/remove operations to keep the kexec 
>segment
>corresponding to the key header up to date?
>
>The reason I am asking is to understand what happens when a user 
>deletes a key. Does the
>kexec segment corresponding to that key header still retain 
>information about the deleted key?
>
>If it does, could you explain why? If it does not, could you explain 
>how the kexec segment gets updated?

Thanks for the questions! When a user delete a key by removing a
configfs item, the kexec segment still retain information about the
deleted key. The kexec segment will only be updated when the user tries
to reload the kdump kernel. Because I think introducing a sync mechanism to
automatically update the kexec segment when there is a change to
configfs is unnecessary. 

>
>Also, for my understanding, could you please point me to what exactly 
>is stored in the key header's kexec
>segment? During restore, kernel access the old kernel memory using the 
>information stored in that kexec
>segment, so I would like to better understand what data it contains.

What is stored can be known from struct keys_header and dm_crypt_key,

struct dm_crypt_key {
	unsigned int key_size;
	char key_desc[KEY_DESC_MAX_LEN];
	u8 data[KEY_SIZE_MAX];
};

struct keys_header {
	unsigned int total_keys;
	struct dm_crypt_key keys[] __counted_by(total_keys);
} *keys_header;

[...]


-- 
Best regards,
Coiby

