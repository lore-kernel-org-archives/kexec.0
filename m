Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B58C35FFF
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMWt8YvXyabuaMyB83WYD5/GSI63ZBxdSuLqDERj8Os=; b=tVvhBd7jNOSzzKovOUEAzG0gwZ
	kK/6vgzDmOZuj/DWcWNrR9mA0J0MOgTKN9xsV4kScH2I5y9e8Eg3WjmPxz9JCL1Nq8MajEbIDUSUi
	hhIxh/EBYKXy0CTMk+2YjChMd2n8gc5D1Dn3OJrsI/lIeh7YaKntRdzW0tblmkG5sq3ZXdkOjWHkq
	PSF3eASg/tf2t2tfb3+rlE/TDvIYtQyO+TsnUavVRaZQHJEz7P4I8PSjU9qzdZ9ULKBw8QMdNPm/+
	l/FvdmYcajvYzVWc0ZSD2qPK0Q3J06WIh8jU7NWqYeN4lpYKEp6V3SKAb5E4udKSwY6Dw098apbM0
	j+gGE1dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvWHp-0000000E2ww-1Osw;
	Fri, 21 Mar 2025 06:55:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvWHm-0000000E2vW-1Jg7
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 06:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742540115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMWt8YvXyabuaMyB83WYD5/GSI63ZBxdSuLqDERj8Os=;
	b=gf1ZXQz1+GINkgk3vrlCQt+8rsT1Dyp7qI6oj0+Lhfy01lbiMmxbzqXLBHZmbFceDs4j2j
	4CTTHu+lM9CHHQiU2Kh6W5HdC/gSrqwG0wAYzrI8lVKcc/nIAQRf9PnLHNNUxcxTmyInbO
	EpqzrKTsQi5UGKGEMaR6D2Qrip4Sang=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-N4flLxBEPUiuj-O1Qd_4uA-1; Fri, 21 Mar 2025 02:55:14 -0400
X-MC-Unique: N4flLxBEPUiuj-O1Qd_4uA-1
X-Mimecast-MFC-AGG-ID: N4flLxBEPUiuj-O1Qd_4uA_1742540113
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225429696a9so39690315ad.1
        for <kexec@lists.infradead.org>; Thu, 20 Mar 2025 23:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742540113; x=1743144913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMWt8YvXyabuaMyB83WYD5/GSI63ZBxdSuLqDERj8Os=;
        b=dU4njdxx5Al1wkaYB1rdeCyBJX7diPeu6RNYA/PILCDyXoeuz1ObEGRdO07Xlgrl1p
         u7Cgh30nSPB9zYFejnJGo2zjiqoJN+rCmT6Lwx6ynGs0uiqK8e9BAzseI+Wvykgq6hrc
         lzITfBakJWeFOI/EbWtKUGLoUOQlbLP3/NxWdDn4ApwQecihdoglZxD7CyZWM8T53k4O
         Uuoyu2/e0ErLrOnr2MLzW+1dottUZZvYOeai4WB0+x7xzIp9a1irFwAgH547FMP+3V/k
         QUW1Sikjp0fA6CJ7CkjWDVJiY7ofFIwI2Ebcd1c0BYV8Jq3CrxdKI250SpehpctMymhm
         5MGg==
X-Gm-Message-State: AOJu0YyP4L7E160Wvlwr/3f7sLz7eDn99Wkz5+lZNax3GJhvrW+Woo2J
	8RfCLbs7PPBrIb9fpohMYb5/+eOSIrm5cbskT28A8kICG+uGRSrNNtAK85eabt9qC7Od51rDwEi
	0Z2t/RK3Slw4SUyiu5NtMxF+VsPrvYEYcuu46Vf+zhqpi33qUl87c9OjV2w==
X-Gm-Gg: ASbGncsL0kAMyGVd2lho733iCHkw/sDRN25wvu+rMh2jmCAdzrgZt8ZXryAN2iF6VwN
	iwR0xPIdgfDQmwv49YxJ+RmJZyXCofqgeb4keJcHSTxCocegGDmWWDNR8BQHrBMyK3J2NkdNOhL
	splLOqfCqlF7yUzl83ZwHf6fUf1XmNYgYAVIayozcIc2A4fR4YRhcjwk5AQjBTJIfn8iQYfC+ln
	3/pl/MGxOO+00fSqRl0FCDswkdbUEnAstMg+l0cRV9FjySUw4ybJ7Sv26J6Z92OGHmTH++YTy2K
	jnpojPw=
X-Received: by 2002:a05:6a00:1954:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-73905966986mr3013064b3a.9.1742540112608;
        Thu, 20 Mar 2025 23:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUJjdikKFu9bVdd5Uc+aAJpIZjuZhFtSPz+rAzYpY6fPM3oklYwQdBYym81w0q7yVcYtU4Kw==
X-Received: by 2002:a05:6a00:1954:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-73905966986mr3013024b3a.9.1742540112161;
        Thu, 20 Mar 2025 23:55:12 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600bad4sm1053637b3a.77.2025.03.20.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 23:55:11 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:54:35 +0800
From: Coiby Xu <coxu@redhat.com>
To: akpm@linux-foundation.org, Dave Hansen <dave.hansen@intel.com>, 
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <jx5dxurvzupwsdp2gma3vi7baijmqd4co4i2ilhsbkucdzxofj@ucvpictjctb6>
References: <20250207080818.129165-1-coxu@redhat.com>
 <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
 <Z7vNMJPQPr4N6Dih@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z7vNMJPQPr4N6Dih@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ISKkcmwPqJRtkEOmaMoPX5pGt8grwZ6S9g-fSPuYsdQ_1742540113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_235518_425528_411C154F 
X-CRM114-Status: GOOD (  19.86  )
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

On Mon, Feb 24, 2025 at 09:36:48AM +0800, Baoquan He wrote:
>Hi Andrew,
>
>On 02/11/25 at 06:25pm, Baoquan He wrote:
>> On 02/07/25 at 04:08pm, Coiby Xu wrote:
>> > LUKS is the standard for Linux disk encryption, widely adopted by users,
>> > and in some cases, such as Confidential VMs, it is a requirement. With
>> > kdump enabled, when the first kernel crashes, the system can boot into
>> > the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> > to a specified target. However, there are two challenges when dumping
>> > vmcore to a LUKS-encrypted device:
>> > [...]
>> >
>> > This patch set only supports x86. There will be patches to support other
>> > architectures once this patch set gets merged.
>
>Could you pick this patchset into your tree since no conern from other
>reviewers?

Thanks to Baoquan for endorsing the patch set!

Hi Andrew and Dave,

If there is anything further I need to do, any suggestion or feedback
will be appreciated!

Or if it's more appropriate for Dave to take the patch set to the x86 tree,
it couldn't be better.

>
>Thanks
>Baoquan
>
>>
>> This v8 looks good to me, thanks for the great effort, Coiby.
>>
>> Acked-by: Baoquan He <bhe@redhat.com>
>>
>

-- 
Best regards,
Coiby


