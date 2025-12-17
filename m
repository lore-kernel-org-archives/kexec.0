Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F4D6406B
	for <kexec@archiver.kernel.org>; Wed, 17 Dec 2025 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GF+3sgdUAhny2ZPYjdUVpHompppY0bhD9HfmFlhoepI=; b=Zdxh4pkaI0Cq/yPjLnUrcIwJ3B
	6mfrULYXE5KJJaZyJI7rM0eXsjViHb6ufMxSzrzWKSNbb//P5VHFtmHTiqnvsgvMzwbCdGJh5QmXB
	hj6Jd7mLc7wffBnKIx7U1ybfGAUzMlL5Stw3NPcZrMdmFh3JTBDODGEVQvhER2ljVx2JQ91pYTA7z
	jQW6cm1rlHdiQzQP1vqAGjlyAdVQXet69fpLG1cG/agh2FdGoAKJQlj/UPccD7twanBaaf8ODY9pw
	uxHb1Nqlv6qqVZFT6rG5hCLQ9mE5WmSZWJrUMI4Y+oSZ6v74BOB/HbsIc8NcTNWV9wBxq0LVCJE9D
	2VBW2YKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVhAC-000000063Lh-2Pzn;
	Wed, 17 Dec 2025 02:21:16 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVhA1-000000063Jm-3z0X
	for kexec@lists.infradead.org;
	Wed, 17 Dec 2025 02:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765938032;
	bh=GF+3sgdUAhny2ZPYjdUVpHompppY0bhD9HfmFlhoepI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YdzOUZjbCDS1mXVczM3iMLmh64eGd+EyvDMXHi0hotUjM06FsuKJTS8iMo3OUj420
	 hhVcYE4hzDVp5Yt4Oc0pG5HNKiIjJH0bm0nZ56hYaw+yylr8GV14mG5q9ODItsnRv+
	 p95fbJGMZHAa2CiBr+gjwpuNf6IfJ7dx+9TqZ65U=
X-QQ-mid: zesmtpgz1t1765938029t3af4a8f0
X-QQ-Originating-IP: j8lmfWx0ux/ss3mIaZAmCneU+tcQ/sgwcZH7sUI59ko=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Dec 2025 10:20:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7886424329474010171
Message-ID: <A940369E59AD3EAB+ea9d2380-94f1-4c75-a3e9-140a8cf222e2@uniontech.com>
Date: Wed, 17 Dec 2025 10:20:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kexec: Replace the goto out_unlock with out
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251216075518.1626114-1-maqianga@uniontech.com>
 <20251216111139.9a96dcbde829bf5d667ff50e@linux-foundation.org>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <20251216111139.9a96dcbde829bf5d667ff50e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OAj1qrjhA85AXm8lu8yAt9gR9AVnMiZMrkCOjb64jfvHt5/YqgtcDptZ
	Vos5d8QKMEnSy4MAV6zePz6r3lX/rGJ9X46TOUvstMJyOuX8y0bs03xBWUVaiotJIfHGUFI
	Afmml4vS0W7Qd6bLZG4M/WBBbAX/XtVUOeKVtGQ+oNzqZiPpwV4AW4KCqsvfwMecMV18RvA
	C+NzSYigHVF2FA3r9AeuJPJQcyq08URqIPqQpDJLrMBOLX0ct9yeqnAkmp6ONv3bF/ixpzd
	8B/2nVuOW31JBVoiNZGIK1TrhkRmppRhQXD4SlI5Ykf2vuMMAQ+GEwE27KW9b8XsB7JaPDr
	KyHkJboimoEzv8FwKJuh/mD9556w2ILpmoo/q7UmJQz4rMre9LSv7OJgu3RakNVzqbEZ6/a
	0GV8/y367li0ynhu/8vC93+SHVryre/mg31VftD3bwnxuQbPFivMUrnGoPqmqFru/08W9DY
	gRTDr/eM29aIoGPplJwItxdILPj3DcbU2OiDRWDJ8BAeD/A7NvdwUBzbNSARNdqe6QT7ez0
	1uHL5RBMVZIoxE2EHchZwNBth5/M0Fgo2bZQn/xMeh0L22yxewHmS/OC6xnmcCko5hw2zOu
	vUFxnBHjFVZSQWyJfz31SXeqsbaRQZYRSqD+I/thkYwu0CGCbVFJYH1P/6jQrsBX083Z/dQ
	Ahu2p6O9zw4+faHtvj8pLVJ5rQwz05dL4+coJwnFhKqZN7uxrD4O1T8CqevcEFlEUtaxD+F
	m2mWJp/MF4nKuqyu20xsBILb4HlJaLtWPWvVOYKjTsntbHKoegG6H9d4yGNJcNutaN+kIvY
	fVHtlPhbiZVY/ISoLltD4OmumUWp3pYBNs3cAFFZUizo1ajVevRQypuQ91H6y/ixqlsnLcQ
	QwkSTsHIJQl7woe0HKEmn07R9IWgQGodRhOU+3IcxJyM2v+gzcjCnPkDN0/22LbI4WUPJk4
	SOQ4kPdRJ82ZQe5tMf8FsP3vjMnC418GAxFy5kfG9+KbR6dJL62nTKAAQDLdXw6Veqc8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_182106_665920_3E8C6C64 
X-CRM114-Status: GOOD (  11.79  )
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


在 2025/12/17 03:11, Andrew Morton 写道:
> On Tue, 16 Dec 2025 15:55:18 +0800 Qiang Ma <maqianga@uniontech.com> wrote:
>
>> The image is initialized to NULL. Then, after calling kimage_alloc_init,
>> we can directly goto 'out' because at this time, the kimage_free will
>> determine whether image is a NULL pointer.
>>
>> This will prepare for the subsequent patch to reset the variable in
>> kimage_free.
> There doesn't seem to be a benefit to applying this patch unless the
> "subsequent patch" is also applied.  So wouldn't a two-patch series be
> more appropriate?
>
Yes.
This patch is a preparation for the patch series "kexec: add kexec flag 
to control debug printing".
I plan to post it together with the v2 of this patch series.

