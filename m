Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD3E7E360
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=; b=UeD1VshVv1qVLVK3vsITi69yC4
	GHuC9qNuMS0oaK0gn/d27fQB7xQszoKQc86YCblRUjX7+MrRi/bS6IQw3Bnvv78C/Oj/1nM6NgQX8
	oSLvTfrBPu6AIppbiAgMMXK4Y/HUWp95T7Ft4KDxQfjDwKbzn98ipn4tmCotT5YimM6Q7/moHhHoi
	AuLRbXzNHkNjNdYNdHcQ7+nHfs3X7uDXi5oqHf5gWQSjnvWFjPH1UB7OLoeHJxPyRS4+7FkarPThx
	tcdu7s0wn2Jbj/3eTkfD/971uRK04yOHyw5OTPbKJ2H4Pi4FLNKiEZAWV3yTCBJix/feGEC13xGCt
	qKA3W9wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b5h-00000001q5o-2LFB;
	Fri, 03 Apr 2026 09:45:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b5e-00000001q4h-28gt
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 09:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
	b=RVUoI8r0l3qExUBPz74z9H/QdXvOKXAJ2X2cYq/r04E2e8H3t0wA76cqtjSu923NkVvxta
	AHmIe/ON1HfH1tzf3gAUojF8nWpfsHuuPu5gE9BEIBf5hwXbFPrvoy3XZYrEQ133GkX46G
	89bTJ3doBFyf074+fZWQdrmpTVb6lOY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-DdCKTLDJMym2THKKaVA4dA-1; Fri, 03 Apr 2026 05:45:17 -0400
X-MC-Unique: DdCKTLDJMym2THKKaVA4dA-1
X-Mimecast-MFC-AGG-ID: DdCKTLDJMym2THKKaVA4dA_1775209517
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so2495718b3a.0
        for <kexec@lists.infradead.org>; Fri, 03 Apr 2026 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209517; x=1775814317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
        b=QDE5ZRY6wQ5z67dxydzYj2JZH/gjkz2tRsh0AktSSvxXMwe1ZgI5U64YyREAA9Q0ML
         lkD2U2E3Ws4K3XxHndHs9+fi+Faw7a/Sg6dm52UVzePy11YDkA6WxqPGB7Jdv7qBjyoy
         RuGFrI4ZXGGlNBJXN1vlWSo9pnLoYOl4DjVN0YTchnnXGxTu3ikOYXDhdgRauR41bY/u
         qeNP6Xm0c9XD9oyFz34ylZrIzE/c9DbPAXbb7dlHF0Mk5meTSZYd/Cq5yrswwpUUQEXq
         NkLXoAz1fw/D3ZRfkghgCAdLNUOUGM/UZBS6+dJ5D/W6JUFFsc9e1iNrBQXm85wg9iAr
         R+bw==
X-Forwarded-Encrypted: i=1; AJvYcCVUdujFVBu2Qh9yfLjmacHn3WBoqxubX2+JPx595k0j2CQUYf1JZBGI1sdb+W3Ze7pwcFH0Hg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzrpbJEmhLijFyRpZis6SMVUxKe/eoc3tbRxVJZLPpoNs0Lrz4c
	jWCUE2o0j1FKOwYcyH1MhzvekiRw5K766ZWR9HZOXLggUXZmrk5MftBoSa2/W4bI/jMPlzvO6yT
	gx+DFUyQ4otdjcu1RiB3Z9EfENne7FS/igKfIAuH7qgtemBoQT0o7NsWIgvzWLe7WenSI9FKm
X-Gm-Gg: AeBDieshR42RcreB3KExtehpE8kAurGVGQtliW+A4XGKAFUpHj8o95qWA5IyZjYdXM3
	ISiLjttaPfJkShdc/nxnhrXQqyGtSDmPf12vQiBL2dsn7ja890aqO3KtiEwE354d7G5+gSNTFXT
	WlAZ7EkAj50GehnRzVdq5FU2PXZuT2Q34GWjCfYY5PVSwLkV9oGTWq4KA8ZnhKkUWsGY7ZzD7TT
	Qk8rUGULQ77j/9RX7hqCdJpXXC1dDpEV0oYJTILdjfkfo9B+gxCPkkb/nAu+B/s8pk9yt4TNYPy
	SttRgVeCikmQcFARaulZrQ3y0XBk4R017K02honldKMhvfcB8nsQ/jIPkP1fRn90q6VUri1f+OR
	DKjmeatARcZCU
X-Received: by 2002:a05:6a00:3027:b0:81f:52d4:a5ec with SMTP id d2e1a72fcca58-82d0dba9c6fmr2625449b3a.43.1775209516625;
        Fri, 03 Apr 2026 02:45:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3027:b0:81f:52d4:a5ec with SMTP id d2e1a72fcca58-82d0dba9c6fmr2625387b3a.43.1775209515832;
        Fri, 03 Apr 2026 02:45:15 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbf6sm5915263b3a.52.2026.04.03.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:45:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:40:52 +0800
From: Coiby Xu <coxu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Will Deacon <will@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <ac-KKklNrB5eQFvG@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
 <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
 <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
MIME-Version: 1.0
In-Reply-To: <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aOt6fYlBkjIasfGTfkvuZpGlKaYdc4gImwzYyolj2KQ_1775209517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_024522_610563_813B8988 
X-CRM114-Status: GOOD (  12.25  )
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

On Thu, Apr 02, 2026 at 11:31:18PM -0700, Andrew Morton wrote:
>On Thu, 2 Apr 2026 16:24:14 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
>> double free at the address pointed by `keys_header`:
>>
>> In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>>      snip...
>>
>>      kbuf.buffer = keys_header;
>>
>>      snip....
>>
>>      r = kexec_add_buffer(&kbuf);
>>      if (r) {
>>          pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>          kvfree((void *)kbuf.buffer);                           <---
>> First Free
>>          return r;
>>      }
>>
>> Since `keys_header` is not reset, the next call to build_keys_header()
>> will cause a double free at `keys_header`.
>>
>> static int build_keys_header(void)
>> {
>>
>>      snip...
>>
>>      if (keys_header != NULL)
>>          kvfree(keys_header);
>>
>>      snip...
>> }
>>
>> What do you think?
>
>It looks that way to me.

Thanks for confirming it! I'll send a patch after finishing the testing.

-- 
Best regards,
Coiby


