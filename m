Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD377C4332F
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CX3hwptgf6QClbGwG6KDxSsB8YaRf5R/3eAkhWhgWQQ=; b=DD63R60dusv0+kozgDhlANBc/D
	U04yRBdwMfFYAxnvU77iq76MDrqR378uHGvSO4DwWl0UXkjS1cy+lz/nlcfMbkQdSgh5O4UD50PgL
	+X4AHjuQe1OuEFEZRarzGxBe4A2JRs2OhcWi3chu5IL2iWwezc2OhpHiE3dAp4K9oJ5AGx8+IBZ+t
	Ks8uAdOoz0o/YgErCl7McABz41N/G91osQAZGnsVwsUUxC0GR5l2kDbimhGn+6Hvud846/2l+z/Zo
	NBCu5KVZBJreUItTDF02P6CvgitZG+BYS/oHu4tCW/kI+YvxnkLyoyLVNbaDX2m+JJdkXB/BbWsGZ
	IjPKT1YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxe2t-00CW0M-Vl; Wed, 23 Nov 2022 00:55:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxe2q-00CVzk-Rr
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 00:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669164918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
	b=FIHw5TaGr6oQp7joJdwp3Y4GrgorfdwUZ9yUSwXYAyKRYcdEn7ZRw2g90DLz0kNqFIGMGx
	5QSUekeFNnGtIb+61EGp4CD/Fx2AKaNXzrHyJQEeRwyjhgPcumEmB7ZX2swfinvFPZKPwI
	6HbGs6GjDImOE8I50SwO8ZZQ0iK3TvM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-XBTRA3hgOLGulw3oT0oN8w-1; Tue, 22 Nov 2022 19:55:16 -0500
X-MC-Unique: XBTRA3hgOLGulw3oT0oN8w-1
Received: by mail-pf1-f199.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso10129121pfi.7
        for <kexec@lists.infradead.org>; Tue, 22 Nov 2022 16:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
        b=6DDu/jkB5iZLFrH3GaEoZQpE1n2LGtSRreOtFrFflEqoDXv21y5qIpbf6iBmi5Jp3T
         eDPS5bWn6gICa0A/d2Njwgl9VX+7rG6pgkSSaVSMY+Jci02pNToHKfZNllE03JKI2X5m
         /CIwp7txI1OZ8gewa2q9KdYA70PGFPG8nGufAMA8WvQTDeFYT+iAsg2onVX1HpUdTS6X
         feYHFwZgVf8kk4OJ/xVhyrRJuONYzQG1fuM67lJhn4mUB6RMm+TIIS96aCCE2/+1uHGe
         Cx+ufX5/J7nBmHtkJRPfy2jNAOKUBfpa0CshPWu2kcIo9J0ssi037FsabkgS4Ckn79RD
         0+hw==
X-Gm-Message-State: ANoB5pnzUO3ZgFfuak1fShD7M5OYqD5Ni84g4r4jre6X/B4VX8aCFBy7
	SPTP4yBrNB2f4EvbieyjGjmN+TLGqYKmJkDxv77CtBjv555PpgS4gQ1kLwCD1Wvs5CTh7EQwfLU
	7jg+FxW2IE4ftuqlnh+Hg
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986150pgm.408.1669164915691;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SY5uzfyZkQfox6l1AVbBTdoWvAzzF3EYm8zF40IS7nL6i4eU6Gl7YQvDisX2vPoUAGKlnHw==
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986133pgm.408.1669164915365;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a67c400b00212735c8898sm155313pjm.30.2022.11.22.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:55:14 -0800 (PST)
Date: Wed, 23 Nov 2022 08:52:51 +0800
From: Coiby Xu <coxu@redhat.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>, David Howells <dhowells@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	James Morris <jmorris@namei.org>,
	Matthew Garrett <mjg59@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] lockdown: s390: kexec_file: don't skip signature
 verification when not secure IPLed
Message-ID: <20221123005251.h4t2t2lv6tqb5nrp@Rk>
References: <20221121072715.836323-1-coxu@redhat.com>
 <your-ad-here.call-01669130104-ext-3635@work.hours>
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01669130104-ext-3635@work.hours>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_165521_015383_41FB3118 
X-CRM114-Status: GOOD (  15.58  )
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

On Tue, Nov 22, 2022 at 04:15:04PM +0100, Vasily Gorbik wrote:
>On Mon, Nov 21, 2022 at 03:27:15PM +0800, Coiby Xu wrote:
>> --- a/arch/s390/kernel/machine_kexec_file.c
>> +++ b/arch/s390/kernel/machine_kexec_file.c
>> @@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>>  	unsigned long sig_len;
>>  	int ret;
>>
>> -	/* Skip signature verification when not secure IPLed. */
>> -	if (!ipl_secure_flag)
>> -		return 0;
>
>Looking at s390_verify_sig() especially before commit 0828c4a39be5
>("kexec, KEYS, s390: Make use of built-in and secondary keyring for
>signature verification") I think this condition actually expresses
>2 things:
>1. the firmware is secure IPL capable and secure IPL keys are
>   provided and present in platform keyring.
>2. secure IPL is enabled.
>
>Wouldn't this change have implications for machines with older firmware
>which doesn't support secure IPL? In this case platform keyring won't
>have any secure IPL keys (since firmware doesn't provide them)
>and any properly signed kernels will be rejected for kexec in this
>function. Unless secure IPL keys are also present in built-in or secondary
>keyring (which is possible after commit 0828c4a39be5) - is that what
>distributions normally do?

Thanks for pointing me to the above commit and reminding me older
firmware doesn't support secure IPL! But I don't think this change will
break machines with older firmwares which doesn't support secure IPL.
Distributions like Fedora/RHEL have downstream-only patch that enable
lockdown automatically when secure boot is enabled. Since there is no
secure IPL, lockdown won't be enabled which means
kimage_validate_signature (kernel/kexec_file.c) doesn't enforce
signature verification (sorry I should change the commit subject which
is misleading). For the case where users manually enables lockdown, I
assume they know what lockdown means and expect signature verification
to be enforced instead to be silently bypassed.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
