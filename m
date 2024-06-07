Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7B3C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06rJfvnNK8UwW4zD5rJNW4W77EMP6qgwmFhLwTx7pJ4=; b=zNmzuIGawW5unZCRBihuhBYtbZ
	RiAhWsuGbzsuFbtuztXQvaNBnDVi5uXs6IGwRPAR+awgewX7qrL7/M9Wb0MC6NBYKztEoc63ljXoD
	dS6gipxcgxzngowH8yXKvlYC/wy9/V4/OQi8v/bk1+omh0NP7ktRH9sedSWv6DYYTLnDzgQZGItCZ
	briLdAG1aKLKLSCIj0yRPZaluZOKaKe+mnGQiF3oYyz70NwQrzsQZK0RJQHUJTyv7iedntQNKeC9r
	fOFUMatR1xg4bd6MCNfZ+5LwwvY7HSe+6yDM4a4w1PsF0NXVg1nxPkLYshxA7yNdPuYfONmv/d5XZ
	6mdJsDXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhP-0000000DvE0-09Dx;
	Fri, 07 Jun 2024 12:28:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhL-0000000DvDZ-42nF
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Z+9D3XMToghs4HAhDCgGVwTyyKde4buT3Zr7Fkmi4=;
	b=EMnUTQEgVeaV8H2YSrhpuIQUHkuaBPrwb6glIKowN/6oFM1es0JTsxeKsFDju8x9q2df90
	/WeTnWLzHA0/SouOkhbU6Pc5q4ZLOJeiCmYRL1nzz+eFrjhNMz42QZRRJhyl3o1vmg+XO2
	VQsdvwJeTXlBTixpHjzJr707rqWNTvs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-VzO6kZchPYS63K8PAfCwYQ-1; Fri, 07 Jun 2024 08:27:57 -0400
X-MC-Unique: VzO6kZchPYS63K8PAfCwYQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso170484939f.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763277; x=1718368077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Z+9D3XMToghs4HAhDCgGVwTyyKde4buT3Zr7Fkmi4=;
        b=B0LRwNtTEtwEbY2hjeFwif0DH2DRMuHfXAao6nPmzhSDheVVaRXfGG1F89Ubt42WlO
         +Gd55yCZ4zN9+TdT49olxJmsdvpEdQKwEjonISxq993AyHNksmckzg4J7Udk2BuHXhVf
         XOj9dvfQ8JI3o5dGDuO48V7UZK+gn4hJPVWk779l7VghyVaiCfMvaHc4dVcBnnqHE99Y
         ISAyHyiHYy5oKdF9GY+YchcemQV/2Aizsc1VUkHkRsr+c/AWPWNaXOfKsOZKBQ344keV
         NEqwhBohaI9ceNkgwNFoS7tJqhFz487/cdxwI17xJ1m+19RKmBZxKhxxn0fTgdmI/oPd
         3Q0A==
X-Gm-Message-State: AOJu0Yw+jGOuL/MVaD+Pr+cwvXBhKURVZmc/saMjx8nqOTkGbFX+bF7y
	XvRcFCs7xg3vcyiY1UlQJiccQ7q8tnxw0q5WhvLEgJ+AxC2GLt0DOpFcMuRXIVUqHjLu4F1ikim
	XSQbO4oCENq43DS4SnzV9/bSDcFh6fUiHdbe4l3zmbkExo9HN7w3Bjm8duQ==
X-Received: by 2002:a05:6602:6411:b0:7e1:7a0b:309e with SMTP id ca18e2360f4ac-7eb571d8a89mr308503039f.4.1717763276372;
        Fri, 07 Jun 2024 05:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgIRlC0cojMP2aKUvU9Fr7ZztffoFIYMR/czaqcAI94Cnx2B/sfklXmqiLidBDJ3FGj6JBqw==
X-Received: by 2002:a05:6602:6411:b0:7e1:7a0b:309e with SMTP id ca18e2360f4ac-7eb571d8a89mr308500239f.4.1717763275781;
        Fri, 07 Jun 2024 05:27:55 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a225cecfsm829578173.64.2024.06.07.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:27:55 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:22 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <qe3bdssg2zw4r4rzwhdiklcrp24on4r66f2og5brkhulguph2t@jrjrpldght65>
References: <20240523050451.788754-1-coxu@redhat.com>
 <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052800_114794_575C1F99 
X-CRM114-Status: GOOD (  15.57  )
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

Hi Baoquan,

On Fri, Jun 07, 2024 at 06:06:18PM +0800, Baoquan He wrote:
>Hi Coiby,
>
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption. Many users choose LUKS
>> and in some use cases like Confidential VM it's mandated. With kdump
>> enabled, when the 1st kernel crashes, the system could boot into the
>> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>> specified target. Currently, when dumping vmcore to a LUKS
>> encrypted device, there are two problems,
>
>I am done with this round of reviewing. The overall approach looks good
>to me, while there are places to improve or fix. I have added comment on
>all things I am concerned about, please check. Thanks for the effort.

Thanks for taking time on thoroughly reviewing the patches and
suggesting various improvements! I believe all comments have been
addressed now except for testing sme/tdx:)

>
>By the way, do you get confirmation on the solution from encryption/keys
>developer of redhat internally or upstream? With my understanding, it
>looks good. It may need their confirmation or approval in some ways.

Yes, actually cryptsetup's maintainer Milan pointed me to
libcryptsetup's new API and suggested me to reach out to Ondrej for
help. And Ondrej has already finished the major work in upstream
cryptsetup and systemd. But it will be good for them to have further
confirmation and I'll ask for their help. Thanks for the reminder!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
