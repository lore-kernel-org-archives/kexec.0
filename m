Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF02FC25B77
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zze88UcStTeovTKDwVM5JP2qxAmitN/VbmZZ5w0qYAE=; b=XTQ8IV9rIF81jlctUC4xRtxCJ2
	XOZCrz0XUALNT7igtC1uUgr0ysEc4uvqvH+o+a4PnXHmipD2kWf6FHcbshEq3eM+EvRdffIQ6bxwq
	KcZbgQEEf/dSEshtBtGWWSeeCsWku72jxrRcIgQw75TL4nAPoG4lhv0qLBUH7XCGKW+AjojQEPAwF
	Mfm3NijjuhwuvsiKYrcp/670r48zSVv11vjtE8TxnRcgPwOw1mKW98bPfHBG9St56TpM9hjl1fAXJ
	R8qyjCPnuWR8mWkOOQfa+67aXbfUUGX52X9KPx9GEUqGmR7TlSs5cGXkM+tqbqO9MaXSRZmQxNeKG
	JNkqmtbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9EoC-0000000G20l-4BQK;
	Tue, 21 May 2024 02:00:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Eo9-0000000G1zj-0zWg
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 02:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716256851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5UjzgLZqQ1A3A/STroNQKIAanlssx47OVX19tlPyfkk=;
	b=ROtjQResrv+TnQaWViN/QlRdp2IRh8aReu96cKDkPDomIXNzrica7x7th1GRBRQMOwonNt
	MkEzAFZe1wc5PwHPGKNv6H6D2gaHj/3JiizeIBReqjtEZmZ8RMvL+9ZMWDZ60gY5x9g8a3
	NMiANG643DQQ04L2TyEAdPghWDyLrj0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-1rsNRzJjPuGTrQ9b5EWizA-1; Mon, 20 May 2024 22:00:48 -0400
X-MC-Unique: 1rsNRzJjPuGTrQ9b5EWizA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6f454878591so7309703b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 May 2024 19:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716256847; x=1716861647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UjzgLZqQ1A3A/STroNQKIAanlssx47OVX19tlPyfkk=;
        b=j87ZUvThSut7+p7jfikHuIp7RNvll+pSO/o7S8JjUIZRV00xzI57Z+0N0mcV6iuSEB
         j/1cqNGooRRAWuLzD4Nj2xD/rrsat5xi+h4XHe4najjvx+fiVkD6zoVqoI6rT99iOdLM
         3v6XVz4GiiMFSwIXYeYtm1ufpv43aIt7JDAh0e258EP4lR/eAWeTpN49fpzNoQSvfrdV
         ByxxYH+NMXgfMNvieOV78yRPu9+lvrMvvdTjITIfbciB8OqP5LT3ufcaCcvOrxsY7h4m
         u/rCI5BYhqibdq3D/aakQ5G/e7/+RL77WU4cPTopE7/zfLIBki8cM2h2RWwqvYhktnFO
         nb5A==
X-Gm-Message-State: AOJu0YwjRlxgmXRP2WGAd3EVygwbN6bQD7BV+DH/A+8w2ntnlZyjHo0b
	ydXR4KnKy/hoKMek6n4Zj/bKC3/UYjtfQ4km8hNKACFK6znymdKxknEeMbzf8MMbL/Ku3KSb7Vp
	kgDp4Hc5+aPuM80wOcQR4EbtNV8LsTrnNNRlEhVqj/mSHPeZxLmAAnSZmDQ==
X-Received: by 2002:a05:6a00:c93:b0:6f3:ea4b:d235 with SMTP id d2e1a72fcca58-6f4e01b91eamr37168632b3a.0.1716256846928;
        Mon, 20 May 2024 19:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7HhBHnJNneyIw7ihYF0Kt+meuvDu1Ef/rXN+B35MEGXdllcXI7mvKKuXqDyPl0gxaXLFSQ==
X-Received: by 2002:a05:6a00:c93:b0:6f3:ea4b:d235 with SMTP id d2e1a72fcca58-6f4e01b91eamr37168566b3a.0.1716256846045;
        Mon, 20 May 2024 19:00:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f67f3sm19982062a12.62.2024.05.20.19.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 19:00:45 -0700 (PDT)
Date: Tue, 21 May 2024 09:58:36 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_190053_747888_653A58A0 
X-CRM114-Status: GOOD (  14.57  )
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

On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>
>Do you want to randomize the key's position for both kdump and kexec
>rebooting? Assume you only want to do that for kdump. If so, we may need
>to make that more specific in code.

Thanks for the suggestion! Currently, no one has requested this feature
for kexec reboot so yes, I only have kdump in mind. But kdump depends
on kexec thus I'm not sure how we can make it kdump specfic. Do you have
a further suggestion?


>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>index 060835bb82d5..fc1e20d565d5 100644
>--- a/include/linux/kexec.h
>+++ b/include/linux/kexec.h
>@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>  * @buf_min:	The buffer can't be placed below this address.
>  * @buf_max:	The buffer can't be placed above this address.
>  * @top_down:	Allocate from top of memory.
>+ * @random:	Place the buffer at a random position.

How about a comment here saying this is currently only used by kdump.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
