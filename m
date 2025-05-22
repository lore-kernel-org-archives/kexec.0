Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639DCC54756
	for <kexec@archiver.kernel.org>; Thu, 22 May 2025 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=; b=TeEGbk5YWyu4v7e91hKngU6Qbx
	qsKpeOWNxLGX7Yfe2pqxgAb+m+3TZuY6ZR8cN0ebVE3pI0NqjyTeESrIKDyWacy9HxJCe5PtHC6an
	yQJFUZWrVF2sHXVKRV3L+35pAGDU7HO05QFat8G1PSA8miwkpSasdQ3aLbfOuSHgMzwe6fRUd7aL9
	h/uvqdgTuk/P//8J5gIo4c07plqUtEcL9dx9LDKHN6AI7XJkQY3NIjHegKVP77keQ1bdJ7fYGkbHi
	17xxQdbnpOsYTwPl+vi0kuMDpvi7CV4IifxzwpdMxL6mhVRREHYSyO4Id+Wg882+IGLelNZBcp/FR
	qpAKKB/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHz41-0000000HY8x-21kq;
	Thu, 22 May 2025 06:05:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHz3x-0000000HY8X-27xi
	for kexec@lists.infradead.org;
	Thu, 22 May 2025 06:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747893951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
	b=a/o7v4ZkwmBXwwC5djpQGh5E3iE7kPwsGSehez+eqvdE1PI4tM0QCW4vxC1N52f80gzasr
	MFAPb0E4Ht7tTFAbYx1UlI9eMCArXgaGA15+l7sfAltxz2lTaO/YH84OIEJvt358qdrvh1
	+1Fs9b/FCcHmiWkB9tqKCU1eVN8EAGc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-u7lxcaLUN5e0gqz1RGy1Uw-1; Thu, 22 May 2025 02:05:49 -0400
X-MC-Unique: u7lxcaLUN5e0gqz1RGy1Uw-1
X-Mimecast-MFC-AGG-ID: u7lxcaLUN5e0gqz1RGy1Uw_1747893949
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0e0c573531so5264402a12.3
        for <kexec@lists.infradead.org>; Wed, 21 May 2025 23:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747893948; x=1748498748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5UcmE338HgvT5w4WTQ/s8ig0Q1beM5AA/bl1F3aF54=;
        b=o5qrLfnLYxo5TOjeYoceQBLd/7xH62Xo1yX0ZxWTJxWz05rSMM6bubRi0tPD4d1BOp
         Qg4dbMUx+fdASAVSsonDOyvhTEkvQ2Bpcyonf3foHFTGfm8AwnpphGVHqwrzTrSAaYZ8
         SSlxloT04j8dD5KGtHiWN3QV2DsWiRXGOdgeHI3qlFkiUUGQPKjXJsZ4td1YK3tZWgnz
         N4hw2045uAP6gfOAjxRg1LkE6B9gognR5ETkEIFX432liu7ebh4f8gd1i0Rg7C4qNS69
         RQBDRbp1LwJY7wT3XNNdx3oCugqSfJF59PdCSnzpgnzGJqyUAyWm2600H85tp9sVqDxJ
         4hXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQMFURb7/cpeEYjgONO2trjfpVMmwSjB3MqaJkJklj0lGy2dKuJWxiQYp85vvvBF1Yj+sR4A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6tTMv/8LKMdczis/2weTffyMqdEwSnZ4u76txQciUaHYjFG8l
	TiF1CIbXhOXl66fiX9fQymuARDC/okz4N1YO6lTtYY5YX+qVduNWMzHbOiRUtgR3NZK/JCweD+a
	EuYstqH7Udv/AlmYk3bqeDQJu84J3DuD8e9rjVddBxrJbCwAdmqf4FeXPtBSNLQ==
X-Gm-Gg: ASbGncsyu9FI0yRsNbRvwmokPkwo+EVPXWllYkvhwkyBo0qOOx9SU0w35rUCU4dGAQw
	ZGo//v9wmiaeCoOMpXdPSZofKLK+SZhkvUDlCaSDG08aDMCz0lCN6f6IJWhtsEiCa06Bb4wpcKs
	MwBILX86lLAYkcHZSHYHSiFlw+P7Wii4ywWOyF/3Dp0YTpMdLjh4QmZVJLOZ5BGmU401icO4dqC
	C4u65FPMCG3WkVkTf/ATvm/snrUKoqJdlPHuKBlGVhkt+xu/acLAuYOM6fMLb+KwX5aPaCu9GlS
	rhE=
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263904637.4.1747893948583;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTFkdwaFGdarcTnLubzQX5o2FjgnhFMq7UwYkJHfRvH9tVaqvdnFp2FCz6WDEjhRKA3X+QBA==
X-Received: by 2002:a05:6a20:12ca:b0:1f3:418c:6281 with SMTP id adf61e73a8af0-21621875ab8mr35263873637.4.1747893948226;
        Wed, 21 May 2025 23:05:48 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0b19sm10539159a12.74.2025.05.21.23.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:05:47 -0700 (PDT)
Date: Thu, 22 May 2025 14:02:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	ruyang@redhat.com, chenste@linux.microsoft.com
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
Message-ID: <wzquib7u5sycaf5prdgztlcudvaa2kma6jv3zmyfw7krzgnbkp@x2u5vnumfl4v>
References: <20250515233953.14685-1-bhe@redhat.com>
 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ef2Sd4kNuyATnKNmhLIm-9Dl8T7gNR_Xf0JjejskKRs_1747893949
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_230553_984998_D1168631 
X-CRM114-Status: GOOD (  15.55  )
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

On Thu, May 22, 2025 at 11:24:13AM +0800, Baoquan He wrote:
>On 05/21/25 at 08:54am, Mimi Zohar wrote:
>> On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
>> > CC kexec list.
>> >
>> > On 05/16/25 at 07:39am, Baoquan He wrote:
>> > > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
>> > > extra memory. It would be very helpful to allow IMA to be disabled for
>> > > kdump kernel.
>
>Thanks a lot for careufl reviewing and great suggestions.
>
>>
>> The real question is not whether kdump needs "IMA", but whether not enabling
>> IMA in the kdump kernel could be abused.  The comments below don't address
>> that question but limit/emphasize, as much as possible, turning IMA off is
>> limited to the kdump kernel.
>
>Are you suggesting removing below paragraph from patch log because they
>are redundant? I can remove it in v2 if yes.

I understand Mimi's suggestion as the commit message should answer the
question why disabling IMA should be limited to kdump.

-- 
Best regards,
Coiby


