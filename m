Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF223D3B7F7
	for <kexec@archiver.kernel.org>; Mon,  2 Dec 2024 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7OrPaqjsbcgeweoMhNllMsBWtFbTQTtneD0XhvQpzBI=; b=k79M4EEbpNmVhf3DtxtBM9BOOU
	fkoXlJ4RYZB+Eckxh9zk4lGjJlk3LmXE56KuxQHBFoTXSEPNRAWcAveS830PJ17c0YJyNKyeMVnzj
	NYRTzrqN3LyujcnLjLJ1h9Bib4RlK/MZ67ekUvqcePAmJx5L4tewNXzYsNnzMQ4KqWU6FJPbXVgQp
	7jH+UA/Cor55UN4OJFiACp40FBFNOFgdGvve55w8SdoOBeU3N+y458gK6cjZfTP8FAKZTYekAcgS0
	1AMlBtQtRCFdKMa9+SV95bRSN7ou2Xcd/B3XGAUiEEbJ2UBPsefjMNnh805NYFqfL8I24MJap5pVj
	iJou/aGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3Ix-00000005f4d-3KKd;
	Mon, 02 Dec 2024 10:05:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI3Is-00000005f46-3vui
	for kexec@lists.infradead.org;
	Mon, 02 Dec 2024 10:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733133916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OrPaqjsbcgeweoMhNllMsBWtFbTQTtneD0XhvQpzBI=;
	b=afrSt0j0nwl/JMxXwuFT3XpC2MRdCdfWKv6K+tifhbpwl3vCGvF0i7RXMwLlKHtK1vh3o9
	Md87gvCXVn64Cc7lWl9plZXUa/q59xBkHWP5WJQYg7mh3DDMftkdBsXYntP4qpw/e2bRfY
	O5fTLAJn00b+kGKCk/M1P5DYYMa9/y4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5TgAKa8CMsuc8heo1wn45g-1; Mon, 02 Dec 2024 05:05:15 -0500
X-MC-Unique: 5TgAKa8CMsuc8heo1wn45g-1
X-Mimecast-MFC-AGG-ID: 5TgAKa8CMsuc8heo1wn45g
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7f80959f894so4123500a12.1
        for <kexec@lists.infradead.org>; Mon, 02 Dec 2024 02:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133914; x=1733738714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OrPaqjsbcgeweoMhNllMsBWtFbTQTtneD0XhvQpzBI=;
        b=TzWlID+meBeAKpWtVRftC5aMRYybsq1+CeugogPiBM5e1fYX/B8tktpSCM7CtEjbKK
         bb8neCLuqHYbhBOOVN5F8azN3Jmg56Lakf6bLL/Sfmby24kTYaVY+6YQaD6ZbZVNtuyR
         tgwhl2JRKziZhwwG4nfRdCGT5gM9gaRGR6Puvi/HjUue3SVBcVWxD+I8yHTs9P/S7eSo
         hf0G1E+gPc+yl59q7pE176BSKS/DK887RbUcjoVDxJYT9TA3xORzccdRRuk8uqkTs/Qv
         BnV0DBfKcueWnqeG5t/SoQBhBb+GLMNvgEit9MxftIlwrGnHMjYr6fphhDBLigw/wS1B
         HkYQ==
X-Gm-Message-State: AOJu0YwY0zVjijitFtWzeySu6x7NM/QUnQmSTpHmHN5Cj4rhIVgPgsy6
	LzFzfkIHLleMDWDoO/eoQAifRax6n3oGH7MjWYF92rJmYWC0WcVrewIXSTHfbSSgOsue4MYOuhs
	n+4tTBUYn0n/yjk5JzsI8/dUQFvLtmE9Kb+ZsPAFYXYAUz0Atph6A50XIqxOJsQebMJsbngv4zA
	==
X-Gm-Gg: ASbGncutGCppyRZa58CMop6yjMub/VgK/RVTMkK7tKKVSAMpB3oS+NcOnBh33zCjxZr
	Yg+5pDvwiO1FxGV3YXlFL5sOTD24PFFqwkCpdcVWtEbhHk+thPVcd6SXxTafUOxQXyuclgy6Ro7
	EDPbcOcT7sJxb40bEwG58eDqCzRVIXM54YXe1GWBQCOl8oUrw+OxqAQ3JFJPCBRFGeGrq4dlPYA
	2Ik1EE/6dUZqbfSZWMKYyKHRYvlLjcTRn07u25upA==
X-Received: by 2002:a05:6a20:741f:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e0ec83cf22mr18681083637.12.1733133913954;
        Mon, 02 Dec 2024 02:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB3NSbvHNFkIbyngZ4ixvt1XNNHTdRsVlMICP66j5qS+PJTaT9IAiRRpmMF3Ih7NXyt+N12w==
X-Received: by 2002:a05:6a20:741f:b0:1e0:b319:fc05 with SMTP id adf61e73a8af0-1e0ec83cf22mr18681064637.12.1733133913634;
        Mon, 02 Dec 2024 02:05:13 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d4946sm7438932a12.14.2024.12.02.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:05:12 -0800 (PST)
Date: Mon, 2 Dec 2024 18:04:58 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <ry7sz5vcsergpc7cux2eotoj7eid652dw3fqrivhq3vhsbv7fo@vrinjqre7vbt>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-2-coxu@redhat.com>
 <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kA12P7byZb5J4OknfMpNoUz7BVLrxBZ936T-JpRxoy0_1733133914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_020519_049565_AF8478B6 
X-CRM114-Status: GOOD (  15.99  )
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

On Fri, Nov 29, 2024 at 09:38:58AM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>
>This change the generic code, but you don't mention this only takes
>effect in kdump case, won't impact kexec reboot case. I got this from
>code, while this should be mentioned in log.

Thanks for the reminder! I'll put a note in the commit msg.

>
[...]
>> +
>> +#ifdef CONFIG_CRASH_DUMP
>> +static inline void kexec_random_start(unsigned long start, unsigned long end,
>                      ~~~~~~~~~~~~~~~~~~
>This function name is very confusing. I thought it's a starting to
>randomize at the first glance, then realized it's to randomize the
>starting position of range.

Thanks for raising this concern! I'll rename it to
kexec_random_range_start.

-- 
Best regards,
Coiby


