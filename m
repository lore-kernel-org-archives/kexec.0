Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE897E77188
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eui++kz06c5Zm0ps9MJyTagiDgf7HwZZozSXkY68zTU=; b=ZcUGYb2vbdWgHnWr4DXzj5E/Id
	5IucxQU4jJiZcq6fcHs9LuuqVJXAUYHN09Z5XOBhBUde/2x3LKBQF0rRhAH8dCCSMnf9wZPiiuiaE
	zoKLQrbewpfM/oDmxhx6mku/ksjDezNzJ6GMyv4DcBkdAalpqrN2cNuG5/KZIxrE0xYB40by1yOGK
	CZpDc2l48NvrjVGo//P5PzWNqr+L2spvmELC6ICoIqLlSByHmUJzngpkGeUADdpUhDYU3Hvrtu08R
	zlavRmRHIVVqxCiRFu2+nEWnlZepuPCc9JeL4hIswPX0BlPrFp1oELHi7qz+Zw6gy8Ra1ChXZLwHs
	Rac46egg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKQD-0000000E467-1s1b;
	Thu, 16 Jan 2025 07:36:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKQA-0000000E45N-2ipY
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 07:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737012965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eui++kz06c5Zm0ps9MJyTagiDgf7HwZZozSXkY68zTU=;
	b=Ygtsmtl0uevNpboRsUPm9Fl9hwWI32jEGeBw1VchQrvK028uOxyhZ+GQFN302Y1iSERQHc
	5jd/fJDCFzbDu3ri5AMu2xYgV8sO6j32SG+yaZ/Jfde+qZRFIwjudf8tX/dbIU7LQbx+xM
	7OwO58njysS/besACLmkUI4Ta+GCCEY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-YawpXcJcMFKx8aT6L9SADA-1; Thu, 16 Jan 2025 02:36:01 -0500
X-MC-Unique: YawpXcJcMFKx8aT6L9SADA-1
X-Mimecast-MFC-AGG-ID: YawpXcJcMFKx8aT6L9SADA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21648ddd461so13139315ad.0
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 23:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012961; x=1737617761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eui++kz06c5Zm0ps9MJyTagiDgf7HwZZozSXkY68zTU=;
        b=bFAxWf54aR6nxJrNuQtJ8nuLr/cz9DYgAdUqalefo3BWfuK02kd6rMy2EtZZlsmOlh
         jML/A3u0bY8OF3YEkuzoBBiZdrVhxrNj4tO9iUe0++m4H75FpudFI78v1aRH3zUPDu8P
         4jY8VEvH66DHqs3l0KjZ2GL6XMO3+iCOnPNjYeusktNP/GDVjftB8gAPMFb9Ne0qRA86
         b/Oru+46zJdsJtG7uxeBz4iXi4gCwqPpHhawYSZkipsdFeuAwTAu5pQEnMlk18QzXihT
         QYdvOWRIiay5ZYNqMwBT52weqM5Gcm/+Z6vxXe4Jycf+dScP3Jkjm/GP3Qja/pSTivnI
         8ZWA==
X-Gm-Message-State: AOJu0YzftoTGCxSkTykJ509ojAK24bQyQiCNzmToKE27IFDr9ZitWItB
	w3W4wwB16oZED/RorYI5GXM0sjtQxq9yql8SmHECmR2Y1ZFxImAv3tA289QtyXo7JMimZ3Zj9V+
	nJlZrRqZ68kHcDBQIEYjdnAKz86BUiWFjNyPI1va05kUbTScUq/VSeE0htA==
X-Gm-Gg: ASbGncv1+HfRsu0BqA2SS77vXce4Mke39yllH8rfeIClcvJz0kZnwLWVH/s5RcpnDae
	mAhoXwC6bjE8P1Pih7tgaZCm7SgMFDCx9LTHXfEnbCqJBfVWregC6qYqQlnvjNRmuoP+wQr8fR8
	nyT7FVY+B1F2meraVvYDftShGZNuZZb33bIXiyDzQ83bBOMmA56JnTTxgBrI8oIiEfblZDOM0uN
	gHLNLQKKQmCXgiviDhwlH8/Uy3NaPTZlEHV1GNUqf5s19Nh
X-Received: by 2002:a17:903:41c3:b0:216:3732:ade3 with SMTP id d9443c01a7336-21a83fc3c07mr498538075ad.35.1737012960778;
        Wed, 15 Jan 2025 23:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEQcRSEn9Ttf7WDqWhnh1GKzD9MesNycc+d+4yC2eT+uNtB9t8zLpscJDtx5fwTbfwsBKVTA==
X-Received: by 2002:a17:903:41c3:b0:216:3732:ade3 with SMTP id d9443c01a7336-21a83fc3c07mr498537745ad.35.1737012960451;
        Wed, 15 Jan 2025 23:36:00 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f1372e7sm93614325ad.83.2025.01.15.23.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:35:59 -0800 (PST)
Date: Thu, 16 Jan 2025 15:32:01 +0800
From: Coiby Xu <coxu@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <6wziog4akqkpye72r33srnfk4peojizdi3q55ipu2zvinusfov@iagx6it375qd>
References: <20250116065825.1041558-1-coxu@redhat.com>
 <20250116065825.1041558-3-coxu@redhat.com>
 <4a663a07-2442-4552-b524-a5cc6b06b727@infradead.org>
MIME-Version: 1.0
In-Reply-To: <4a663a07-2442-4552-b524-a5cc6b06b727@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FyQP08BBY6XdVgPPSp-lGqW-kzynLFjkOzQOWTUwWe8_1737012961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_233606_755873_800D4F89 
X-CRM114-Status: GOOD (  18.39  )
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

On Wed, Jan 15, 2025 at 11:04:23PM -0800, Randy Dunlap wrote:
>Hi,

Hi Randy,

I appreciate your quick response!

>
>On 1/15/25 10:58 PM, Coiby Xu wrote:
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 5376890adbeb..192d6796ab94 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -551,6 +551,34 @@ from within add_taint() whenever the value set in this bitmask matches with the
>>  bit flag being set by add_taint().
>>  This will cause a kdump to occur at the add_taint()->panic() call.
>>
>> +Write the dump file to encrypted disk volume
>> +============================================
>> +
>> +CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to
>> +encrypted disk volume. User space can interact with
>
>   an encrypted disk volume.
>
>> +/sys/kernel/config/crash_dm_crypt_keys for setup,
>> +
>> +1. Tell the 1st kernel what keys are needed to unlock the disk volumes,
>
>               first
>
>> +    # Add key #1
>> +    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
>> +    # Add key #1's description
>> +    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
>> +
>> +    # how many keys do we have now?
>> +    cat /sys/kernel/config/crash_dm_crypt_keys/count
>> +    1
>> +
>> +    # Add key#2 in the same way
>
>             key #2
>(be consisent)
>
>> +
>> +    # how many keys do we have now?
>> +    cat /sys/kernel/config/crash_dm_crypt_keys/count
>> +    2
>> +
>> +2. Load the dump-capture kernel
>> +
>> +3. After dump-capture kerne get booted, restore the keys to user keyring
>
>      After the dump-capture kernel is booted,

Thanks for catching the above issues! I'll apply all your suggested
changes to next version.

>
>> +   echo yes > /sys/kernel/crash_dm_crypt_keys/restore
>> +
>>  Contact
>>  =======
>>
>
>-- 
>~Randy
>
>

-- 
Best regards,
Coiby


