Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38892C43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fS7FgEa9+YD3enCSNRokSO4Oy46yfeOx0xg6XgbjQIY=; b=xZGH3YYPaNrTjnaJ0bz/D68acB
	11zgFxXSkxJbO8SDZeQKemZd8rd2TZdlGlrxIU5sbB6Td8pQe7C/79ZufelAcGDEcRVN5bFln6/9/
	Q6F+WOMNvCxU9QNptULdBtnxp3FjkXdtQwekwQ9zuSrdi1iBOz99jUnpJlAbt79HYjtLVotD7Lh6Z
	14XL6w+Ke0fkJRcNtzU3zVKXU5Ywsd2IfhnyfWyu8K6uzjsRpj1dgR4AyxarKkRP2ScdsRVFs0q1Y
	adgBEUK2nUsm9A8dOv784PNDLhdWVkmcjk/VW9q54SqSNXbCtWomVsizq/rmf9rMTazAhXCtkZbC6
	SeNUcJWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eGL-00HOEk-JU; Thu, 16 Jun 2022 01:25:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eGA-00HOB5-Cr
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 01:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655342721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D44Dr4YMc8cT2I8kBBUFAcAZBxETYvbJSxn5FHOEfW4=;
	b=d9+OJeNqwhHLCAtPSBq52yPfDB6gHqhKvnLfcRIxSkNgAWpF5PkjGra1iGP3tDDBRwFbIW
	M2jo22L3rPdjmitZdgX94Q8Ixc3MSYplNuFX1stveHToFSY3/PtouoDERXs9K+jVAi/RJl
	S0nlmaw0vL0hZZvfQv+tF2+c7dm4BTY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-qwAS1TOkO0C99JuXtBSDHQ-1; Wed, 15 Jun 2022 21:25:18 -0400
X-MC-Unique: qwAS1TOkO0C99JuXtBSDHQ-1
Received: by mail-pf1-f197.google.com with SMTP id z186-20020a6233c3000000b00510a6bc2864so97832pfz.10
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D44Dr4YMc8cT2I8kBBUFAcAZBxETYvbJSxn5FHOEfW4=;
        b=WqOV+g5XCsVjql14TSczsDtV7usMIkVb6LJV1V109nL21P2TdhpABK8s4rxy/+edXR
         jijNSvMrL3ARIUcBd9KtHnKOielHKvn0lcdiSktxypupDqcOc65rINzNdhW9VjtPENzq
         AbEJKbSYv2w4HBf7+Lybx5GjVx5sDOcRcSi9gwacW4/rDh8gRPoaa21FdNgpZSrukdvc
         mfvZoq7ce93oY0Boh41iS3Ge5t6DzrOQ3iVg5WVVbMHKgkvNKOChZPE9HjI9H5YWvAG9
         U7ZruuM9aidb/DR8xPqZaf2s44A3tVHQha3a2jr8eMhVzrl6c8ZeehojwcdJemxgcvwE
         JDgg==
X-Gm-Message-State: AJIora9Qt2jAz2eWrXFu+n40s56XHnJQO6RGmqwhlIB9uoznt7VKpg3w
	KZPoIP78hDdP+RMKly2jQ0x0YkHTXoPfukLgtbY5Hzeoo0hBudEm63NzMaPo0nfeuTJHN1eN60U
	O01lpZYAoE2924yHyN9sk
X-Received: by 2002:a17:90b:1d0a:b0:1e8:7f14:8db with SMTP id on10-20020a17090b1d0a00b001e87f1408dbmr13087389pjb.218.1655342717165;
        Wed, 15 Jun 2022 18:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOjYTGh40XzdifkbuDHlq13ntELiTF3c1SqlwRgQ4mA+C9ql0VnOeF8KNef5kg+vvKioqBXA==
X-Received: by 2002:a17:90b:1d0a:b0:1e8:7f14:8db with SMTP id on10-20020a17090b1d0a00b001e87f1408dbmr13087362pjb.218.1655342716811;
        Wed, 15 Jun 2022 18:25:16 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm275270pfy.128.2022.06.15.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:25:16 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:22:32 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20220616012232.5rjmukabncqnus5s@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-4-coxu@redhat.com>
 <e44bb6b11573838417b5d561173c27a1571c94b6.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <e44bb6b11573838417b5d561173c27a1571c94b6.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_182522_537324_3BF031B6 
X-CRM114-Status: GOOD (  22.14  )
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

On Thu, Jun 09, 2022 at 07:15:27PM -0400, Mimi Zohar wrote:
>On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
>> Currently, a problem faced by arm64 is if a kernel image is signed by a
>> MOK key, loading it via the kexec_file_load() system call would be
>> rejected with the error "Lockdown: kexec: kexec of unsigned images is
>> restricted; see man kernel_lockdown.7".
>>
>> This happens because image_verify_sig uses only the primary keyring that
>> contains only kernel built-in keys to verify the kexec image.
>
>From the git history it's clear that .platform keyring was upstreamed
>during the same open window as commit 732b7b93d849 ("arm64: kexec_file:
>add kernel signature verification support").   Loading the MOK keys
>onto the .platform keyring was upstreamed much later.  For this reason,
>commit 732b7b93d849 only used keys on the  .builtin_trusted_keys
>keyring.   This patch is now addressing it and the newly upstreamed
>.machine keyring.

Thanks for explaining the history to me!

>
>Only using the .builtin_trusted_keys is the problem statement, which
>should be one of the first lines of the patch description, if not the
>first line.

Thanks for the suggestion! I've provided a new version of commit message
in the end.

>
>>
>> This patch allows to verify arm64 kernel image signature using not only
>> .builtin_trusted_keys but also .platform and .secondary_trusted_keys
>> keyring.
>
>Please remember to update this to include the .machine keyring.

Sure, thanks for the reminder!

>
>>
>> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
>
>Since the MOK keys weren't loaded onto the .platform keyring until much
>later, I would not classify this as a fix.

For this Fixes tag, I mean arm64 couldn't make use of the secondary
keyring because a secondary system keyring was introduced long before
commit 732b7b93d849 ("arm64: kexec_file: add kernel signature
verification support"),

	commit d3bfe84129f65e0af2450743ebdab33d161d01c9
	Author: David Howells <dhowells@redhat.com>
	Date:   Wed Apr 6 16:14:27 2016 +0100
	
	    certs: Add a secondary system keyring that can be added to dynamically
	
	
	commit 732b7b93d849f8a44886ead563dfb6adec7f4419
	Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
	Date:   Thu Nov 15 14:52:54 2018 +0900
	
	    arm64: kexec_file: add kernel signature verification support

Of course, my commit message is misleading since it talks about MOK key
in the first line. If stating the problem as arm64 only using the
.builtin_trusted_keys as suggested by you, I think this Fixes tag would
make sense. How about the following one?

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".
  
This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image. 

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")


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
