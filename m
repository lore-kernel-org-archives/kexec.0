Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60288C02196
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+E4tyOIaMD9iTV+vxsPHkI9fcl7y9d2AE2AY86e0L5A=; b=FSGeXBYa6NRsqiv4dd00W+aruX
	fmXDBoqOZaGeb72Eo65Zy2pZukSPnyCdsRL3Q8MW5hTRdtrKHNdL7afeQQ4ObqEMMSRsD2rdRn+El
	1AreYdDyookrE06H+u/PSOVxf3RfuGms1yHNbinweYyyHo5zIAv9dapJkLp0uNG06MyQYIJ3x1Zuu
	oA6E3d5v4mmqj8H6yJOzXdZ2GPVaDYmiWW5NfXxBx8fbY6dVhJxLC4uP6eUPfIQ4EbfaefHR8sPsW
	yvx8NnMXsoIg9UWbZyfRXtFkQaH9ZEnjukQjOtl2vkW/xo8TnSlP26HzgmaUCuj0F6YDHVP2nWGNb
	8ptH51yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJEw-00000008iHG-1KzN;
	Fri, 07 Feb 2025 07:57:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJEq-00000008iFg-2puV
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 07:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E4tyOIaMD9iTV+vxsPHkI9fcl7y9d2AE2AY86e0L5A=;
	b=QHS/RuJlvpn+tuEr3ZdHyOt/d626DCcvPc9rf50o2MxqQTuOnDv9tUIkCS6SPml+C0uKja
	jL6xtEaITNdmFYdM8IhxQfKkj4WWebBEVOT4mnY63IIQR9COi4HoC9LewaT1Xs18qT1nkP
	vqUNsDR9jeD1r8X7hyHh+q9r2qePxdA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-258UONttNAyG--JjENDnwg-1; Fri, 07 Feb 2025 02:57:20 -0500
X-MC-Unique: 258UONttNAyG--JjENDnwg-1
X-Mimecast-MFC-AGG-ID: 258UONttNAyG--JjENDnwg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f9c02f54f2so3786910a91.3
        for <kexec@lists.infradead.org>; Thu, 06 Feb 2025 23:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915040; x=1739519840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E4tyOIaMD9iTV+vxsPHkI9fcl7y9d2AE2AY86e0L5A=;
        b=hXU1Hxs6J69bDT1E26DJkwBAMuipJAoGuzXkGl2aIpVIbsMydFCkq5epJsLKp+mSJg
         owDrFwxgz73RXvSN0HcXXC0UsVHrQ4Wo2faLfngjQ5u23VmeLyOr32QC9rC/8JA3seMr
         7/xbeZ7Ifxs39l6glmbbFVU/9K5CSy6NtOTqpHrXSWp64qQ6hgqmWahRVESZJv/LbjEN
         idikXzED+D293Yy5hSorHHIpVzL3QBg47+7kWuc/fOs8gpeJSR3CGPm789yXO/phcDD5
         kHRn/LfJVKIVMlJQ7Yi8gqi+VhU8rcWLP7/wGQU9UxqXPjgayAkY4wPRXrY0LhS40TnH
         0rnw==
X-Gm-Message-State: AOJu0Ywu0qZrLUj1MuNKRKgMTOZ7c9414+RJxX7qNOjz4dSRr8fX2pnL
	JpDDC+Q27fgJ2NCsupw505UyuDYmzDsqVDZ8mQgJ5rmkXo3M/BZMy9zFRSPzLecrBRKnhIwAV3e
	RaqDOlGt1wcF/3zun0PgRclXisLyN5cruQWO3RNyL98Cw5Ef+WPuL8xNaZw==
X-Gm-Gg: ASbGncuSO2ochkEzGYaJ9XP+9fFBMdKtrCDjqpRRj4jATggcrOlnU7oWJziW5uSbTy7
	r2HVhAzh8+C4p6DEsUxD84B8S9BhKg7YAKM5/HbsPxt/HMaaDuIkBYhRjNVUbg2ECFgfnPi/8Dr
	5vV77HmD34GOacs8gCNdCtgnuMQkLOWjZnC7Vvnt+mnq6qDFDkDMEVW/eQya/ONmpGJkYIQEPKK
	FDB7+41VTjEF2eWK57k3FUJeWULxBWuBD37ZCPVMOjq0+Yqhwgc8YuqE80+A41G0rtMog91
X-Received: by 2002:a05:6a00:999:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7305d42551emr3689018b3a.5.1738915039680;
        Thu, 06 Feb 2025 23:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlCduPvZoT2kdtGUGIf3M+qw7MXxQrIVbDVUudc4+qEcL6XKQWqM8w4dZu6STeAHsFx4TyuQ==
X-Received: by 2002:a05:6a00:999:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7305d42551emr3688992b3a.5.1738915039282;
        Thu, 06 Feb 2025 23:57:19 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d4a0sm2490403b3a.15.2025.02.06.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:57:18 -0800 (PST)
Date: Fri, 7 Feb 2025 15:57:05 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v7 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <36wuxuweax7e5p3q7nqrgh64m3c5xbizvanxdzkkrsuarhejws@tmjheoas6stx>
References: <20250116065825.1041558-1-coxu@redhat.com>
 <Z6V3e3yPQyhaRBCN@fedora>
MIME-Version: 1.0
In-Reply-To: <Z6V3e3yPQyhaRBCN@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: csWnTCr8EGEEjFVcK6phVwQtT7RV9gmUFc2H84vdC6c_1738915040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_235724_788793_2367C0A0 
X-CRM114-Status: GOOD (  13.03  )
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

On Fri, Feb 07, 2025 at 11:01:15AM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 01/16/25 at 02:58pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption, widely adopted by users,
>> and in some cases, such as Confidential VMs, it is a requirement. With
>> kdump enabled, when the first kernel crashes, the system can boot into
>> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> to a specified target. However, there are two challenges when dumping
>> vmcore to a LUKS-encrypted device:
>
>This v7 series looks good to me, other than Randy's concern. Do you plan
>to repost to update the document?

Thanks for reviewing the patch set! I'll send a new version which will
apply Randy's suggestions!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


