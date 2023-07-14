Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD38EB64DD
	for <kexec@archiver.kernel.org>; Fri, 14 Jul 2023 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+xM5Ylmu78KmL/uejgYdj6BZw4MitROynb/4y229kU=; b=DO7KzPaMlZ95oBht9oshKMnrV1
	7cwrX9IGKMqMxab9D+6DDSento6VJlar14xi3AxnJhbmwoVpNmLqsrEfIlLA6xtZeSwpuYMUw55gu
	wbSoYfyrdrBERt118FZmjQsemp2F/1rfFtPkChaCwF+IpS61PjAUW0WzUUlHXMrkNioXT4Gj+8m8i
	Ldq5CyIy+VPIRL5Rc0ZkVuzFtJbYqq0A5u/vawhI8NYyBahn0at6BYMgymS35CE2pE0EzWJ9julXP
	eR4Kvc9xLDqdGAUlRghn8f1GmoD9MbZnZlv5r1xn65kJPxQzzEGpVe/3wQDoXCCXpvJ9QWsZIso6+
	sLu+/xOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qK8ZS-004nPz-01;
	Fri, 14 Jul 2023 02:30:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qK8ZO-004nPO-3D
	for kexec@lists.infradead.org;
	Fri, 14 Jul 2023 02:30:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689301809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rR7vBZIbJEjWBvWkQDdyveT7be3Oj/MPoWB5KAF05U=;
	b=iRG5ucUqBDXY1rd99GIbRkurokc2+bi0if/gaiqvQA8fTJHxOolwEdYjwh2ae8pQMMJFdG
	faS8NhENcLzl8578b9Vrff+h24tRMiQ9qQF5+Wy35u/77H+rBDfEaYFB68QFXmjL8P7Xu4
	JUNKXZ5mkKGdy+x6o1U2gvCBays0WYw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-CZ6Ny8fIOW2vgzh0v_Ve0g-1; Thu, 13 Jul 2023 22:30:07 -0400
X-MC-Unique: CZ6Ny8fIOW2vgzh0v_Ve0g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b9de8fbfc9so6870225ad.1
        for <kexec@lists.infradead.org>; Thu, 13 Jul 2023 19:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301806; x=1691893806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rR7vBZIbJEjWBvWkQDdyveT7be3Oj/MPoWB5KAF05U=;
        b=OgQSRKgl18eFCqTz1Bn/ZYDY6D3EgdTv1HNB2bj8vT8vTOS36rxfytq0czeca+SLTn
         TjXC6euaoRwgj8fIEB/4Dv3UYNu4SyHRbxVzM3JEY/Tkgr6+RtPHxt4cqaBPAwIwKtYL
         WWETQkTxwQqBWryeemqhGAORh9Y9QzK73WhcItEEp5Xf/lm2uM9IjfGmkDyuoc8RnOII
         rOuUrNzesdXpSEIHIImy3Rg4Ad3NAv+pRs6di2QOTl1anCRcdpeNJm7Jz27+q3tccOXU
         tliPx+/WNrszsAxNqnTHcgr0vy9ncKVIgnHSs30P0SiyHw8IMqF0+s+nbOdlJ3upUJKl
         z6bA==
X-Gm-Message-State: ABy/qLZu9JvGL/enERj55SuwRKpv9f84Oss0cl1qebqck4HWMT/xvS3O
	U7UOd0h2FE4vJWcYEZeRvLQVeTNijZZ34yH/gI8h1IoE/7rVNuE4s4F8ZMCmGRC3A3PG5aJQ39b
	N1lH8uPAYFgcYKI148qm+
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id i13-20020a17090332cd00b001b8a9361905mr3308418plr.38.1689301806598;
        Thu, 13 Jul 2023 19:30:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEs4pde8jppPSPo0CHtKv6YPw48gJ9ZsJ9Jr04I327cFtviAE9UC1q66//Yn7OoEuBGrzwEoQ==
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id i13-20020a17090332cd00b001b8a9361905mr3308403plr.38.1689301806236;
        Thu, 13 Jul 2023 19:30:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902c50d00b001b03b7f8adfsm6566850plx.246.2023.07.13.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:30:05 -0700 (PDT)
Date: Fri, 14 Jul 2023 10:29:56 +0800
From: Coiby Xu <coxu@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, "open list:KEXEC" <kexec@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Message-ID: <4d6t456sswt66tnpzysxuu2wmlgkmlww3elhdsf4fxzejbroza@qig3hahn5paq>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
 <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_193011_107935_0BDCEA79 
X-CRM114-Status: GOOD (  22.45  )
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

On Thu, Jul 13, 2023 at 05:59:38PM +0000, Eric Snowberg wrote:
>
>
>> On Jul 12, 2023, at 12:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> [Cc'ing the LSM mailing list.]
>>
>> On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
>>> When IMA has verified the signature of the kernel image, kexec'ing this
>>> kernel should be allowed.
>>>
>>> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
>>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>>
>> The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
>> appropriate IMA policy when locked down") was not in lieu of the PE-
>> COFF signature, but allowed using the IMA signature on other
>> architectures.
>>
>> Currently on systems with both PE-COFF and IMA signatures, both
>> signatures are verified, assuming the file is in the IMA policy.  If
>> either signature verification fails, the kexec fails.
>>
>> With this patch, only the IMA signature would be verified.
>>
>>> ---
>>> kernel/kexec_file.c | 14 +++++++++-----
>>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 881ba0d1714c..96fce001fbc0 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>>> 	ret = kexec_image_verify_sig(image, image->kernel_buf,
>>> 				     image->kernel_buf_len);
>>> 	if (ret) {
>>> +		/*
>>> +		 * If the kernel image already has its IMA signature verified, permit it.
>>> +		 */
>>> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
>>> +			pr_notice("The kernel image already has its IMA signature verified.\n");
>>> +			return 0;
>>> +		}
>
>The issue I see here is ret could be many things, for example it could be
>-EKEYREJECTED, meaning it was contained on a revocation list.  With this patch
>the revocation could be overruled if the image was IMA signed with a different
>key.  Do we really want to add the ability to overrule a revocation?

Thanks for raising the concern! I haven't thought about this case of the
key being in a revocation list. If the IMA signature comes from a
distribution, the distribution should also blocklist the IMA key when
the PE-COFF signature key is added to the revocation list. If the IMA
signature is from an end-user, I think the user wants to pass the
verification in this case.

Or how about only allowing IMA signature when EFI runtime services are
disabled?  Another reason I am yet to add to the commit message is a
real-time kernel currently disables EFI runtime services for latency
issues so it can't access the MOK keys to verify the PECOFF signature.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
