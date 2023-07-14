Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FC1C001DF
	for <kexec@archiver.kernel.org>; Fri, 14 Jul 2023 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8C87FeL/mpFd4rOa5AnfMNJ2RlabA0P9yAkoDovsWug=; b=ye7bvANdqPv2rEfusYmXxnqhnO
	UFf51504zndUD82XC5GugT677kPGkdmQKgXx5Xkp5336se/aw8eELFpCpb3qQ7TAx4K9jZ5BMYFAh
	d6V9cMpRAdaYV31gXrg+X4Zv70WPVVX2WefIFF+TXYke2LkMTZjDtQFOuvMqTP3qEgwMmLAZfyU2e
	6zw+y/WJ4IIrvuuhC4+j45afD2CzE3Rx0PImBna61kf4YcEQplwj5OOJxnpONQ1iEUjsoA5OpvSuL
	2z3zKYAM1d9gHcSxx8sZX3JshpLZgm0mB+iwqyzjf7c2DlwgCtMFjVUK9UgAcjyg7Cfxyw2Jkle/6
	7FnH9sTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qK81d-004kEh-2e;
	Fri, 14 Jul 2023 01:55:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qK81Z-004kDj-2k
	for kexec@lists.infradead.org;
	Fri, 14 Jul 2023 01:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689299709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t11z2xnva4fny6jsTsvYyK9TF2oEGJCt+IK9C2prKKY=;
	b=Go1uVO8gkHKymxP3g5XA255cUFIwocl3GXviKSB0T1Lo8Kb+nqFiEw9KC4Wzbuq3pByfjN
	Z6FeTtt9VcgSqYgmNuwcWWzLYDSyL6gbNARpRJv2lIOlhQPk/Nq7a/HVR98Lma5COU8MGO
	nrrLf3d4VWzcrzuxHXzXUBXUMttGbeU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-16iMFzQlPV2_bL9-UR0jcg-1; Thu, 13 Jul 2023 21:55:08 -0400
X-MC-Unique: 16iMFzQlPV2_bL9-UR0jcg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-66872e30de9so1190367b3a.3
        for <kexec@lists.infradead.org>; Thu, 13 Jul 2023 18:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689299707; x=1691891707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11z2xnva4fny6jsTsvYyK9TF2oEGJCt+IK9C2prKKY=;
        b=OgWkrp/tC31ttAdm4KS3OD6kcCfDtLseleQP/35UKn4BM58bViiH1XLFjMmd2BMoOj
         8c8EVZks2Py03pv2JwqH4xl2DlNCmCtPGzhd/KPRco9G7rsJEuqmu8cqaBqSShggXClx
         g+bYRfc+K1ZruqzTUv34/JJIkuN+aNhGJJ5/fLM8MxcNhSVDpJIf2WUayA3e/VxypOAZ
         JIc8VZIeqWissCvyKAqz03rXNlOwsIjDTYOiBZp9dBunOPUdtCfXUtpOri5yDn5mA8pl
         C2ZhOAKkK/fWcjmYMtzh5ZYFqTmIZmK70BCNAferp8uoLON9FOOUFQJJ+dCQvEcU32uw
         UH2Q==
X-Gm-Message-State: ABy/qLZcFwg7K3s8JKQGgOIRXo5Us8YdHe07cyp1V1rzTYZlX3UgpKjn
	zYmwuMq/2qkMJurWaW2s6BgUJREg01V3wy4QKQ2w3kMv8fKxdR+FIHHtUrkyfNAloPBz9I5oVoe
	SQ3Xq9rakdrz9IBuulEvr
X-Received: by 2002:a05:6a20:3d84:b0:12e:68af:dcfc with SMTP id s4-20020a056a203d8400b0012e68afdcfcmr3869006pzi.18.1689299707146;
        Thu, 13 Jul 2023 18:55:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQDiz8QNDl10fiRzDQ8whsY+IzQwOJ0SezSEKyqNHzS749qb8dB3md3RyPi95svCJAa6qRlg==
X-Received: by 2002:a05:6a20:3d84:b0:12e:68af:dcfc with SMTP id s4-20020a056a203d8400b0012e68afdcfcmr3868989pzi.18.1689299706802;
        Thu, 13 Jul 2023 18:55:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902b18a00b001b9dfa8d884sm6537684plr.226.2023.07.13.18.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 18:55:06 -0700 (PDT)
Date: Fri, 14 Jul 2023 09:46:29 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	"open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Message-ID: <dsiyhyusai6yvet3dd44c6ptumw3fq4j3xfvi5qy6ebwkoyk43@g3anjnbhzvqk>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_185513_987699_BF43C5A8 
X-CRM114-Status: GOOD (  22.50  )
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

On Wed, Jul 12, 2023 at 02:31:43PM -0400, Mimi Zohar wrote:
>[Cc'ing the LSM mailing list.]
>
>On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
>> When IMA has verified the signature of the kernel image, kexec'ing this
>> kernel should be allowed.
>>
>> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
>appropriate IMA policy when locked down") was not in lieu of the PE-
>COFF signature, but allowed using the IMA signature on other
>architectures.
>
>Currently on systems with both PE-COFF and IMA signatures, both
>signatures are verified, assuming the file is in the IMA policy.  If
>either signature verification fails, the kexec fails.
>
>With this patch, only the IMA signature would be verified.

Thanks for correcting me! I thought it's already a consensus that we could use
either signature to verify a kernel image because that's what the code of
commit 29d3c1c8dfe7 has done and the code comment seems to confirm it.  But if
we just read the commit message, it indeed didn't give an answer on whether x86
and ARM are only allowed to use PE-COFF signature.

>
>> ---
>>  kernel/kexec_file.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 881ba0d1714c..96fce001fbc0 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>>  	ret = kexec_image_verify_sig(image, image->kernel_buf,
>>  				     image->kernel_buf_len);
>>  	if (ret) {
>> +		/*
>> +		 * If the kernel image already has its IMA signature verified, permit it.
>> +		 */
>> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
>> +			pr_notice("The kernel image already has its IMA signature verified.\n");
>> +			return 0;
>> +		}
>>
>>  		if (sig_enforce) {
>>  			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>> @@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
>>  		}
>>
>>  		/*
>> -		 * If IMA is guaranteed to appraise a signature on the kexec
>> -		 * image, permit it even if the kernel is otherwise locked
>> -		 * down.
>> +		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
>>  		 */
>> -		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>> -		    security_locked_down(LOCKDOWN_KEXEC))
>> +		if (security_locked_down(LOCKDOWN_KEXEC))
>>  			return -EPERM;
>>
>>  		pr_debug("kernel signature verification failed (%d).\n", ret);
>
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
