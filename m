Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863ABC369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ya1y/PIPsUcPJdbK+tBdJ/PntQDR0r5QpbF6nQFyMU=; b=eBR/L64o2SgE1vZ3X6mtRNpOy/
	cQZj30KPPZXIF+OHh3zB0j/XpxEFIRg6+EShfkGcuOXOkPgxQUcpt20kGKNHTlVuFRB6smxMH3g5x
	q9I/5+HJRB1/+ErfEZdRBOnBZ1r3Sf2iGITnf1CQ2TMDPGDRCswCoJosscFe1aXvsmrVvANjaUSWt
	14Alzg/dLgcogAQQT3eqIGnhxRAv8i26TLWxYgA0dhHi+KvoQlHXhyuXkqb5TEqVO/7vFsGTu2eXx
	Y4/j5GoX5E+uNMi3lC125Twi7UMTu+jXxLy0nh9a/hSYEy6dTgm97ni8h2Il9u65FbQY52YN0Iv3m
	HBkuepxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9iTb-00000009LsR-3fju;
	Tue, 29 Apr 2025 10:46:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9hNX-00000009ASe-0ek1
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 09:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745919348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ya1y/PIPsUcPJdbK+tBdJ/PntQDR0r5QpbF6nQFyMU=;
	b=Amj03N3C4gm8z7mKzVq7VgtrW7Dc8UsSERm5xrdKvmCyl0qu9lRjd6LlwBSQm/eSpwXNQ9
	RoBoIO4x0DymxU3bY9z0zDWCvMyn6SYEq61hUYxSFocwJxh1gKC/vBVAdx0DxYfDKpdSYf
	McnxdQXdwyaRY6ZNW0DTaWc9qO+pM2A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-U1zS0ODMOJS0aa6lRIZYgg-1; Tue, 29 Apr 2025 05:35:47 -0400
X-MC-Unique: U1zS0ODMOJS0aa6lRIZYgg-1
X-Mimecast-MFC-AGG-ID: U1zS0ODMOJS0aa6lRIZYgg_1745919346
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-739764217ecso5030727b3a.0
        for <kexec@lists.infradead.org>; Tue, 29 Apr 2025 02:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745919346; x=1746524146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ya1y/PIPsUcPJdbK+tBdJ/PntQDR0r5QpbF6nQFyMU=;
        b=WIAPnc/xZgJq+0LXXFsy402qFakdLXYc46yCo8i+SsGHpz7EvBMhsuvBI/bXDYwG7k
         VpXI76RFON5KvkQSqFsNutKEy0eJyh10EgK5jwmGGuV9jbLLQQ0fH52W5oerFtIYOMbR
         6qyPdS4ssuRoZhbMfhurWnUaNVVAaeSb0Eabf7CDUV+FyA1H0VP3nAFtmoVDxeSKtBBB
         5rTtSd84FkUqzzDCSUuADVshpyBALUZ+MEuNHLctXSXJHFvXzrrcNuZLOimM2eDknR9R
         p6uXHFLKMZTMH2diBKYBqnaAPjHchI5yyy/a3Tg6sJ6pU9hIDzz6Y2s/lZhq6IwbIRhX
         KjBQ==
X-Gm-Message-State: AOJu0YyZo01IM1NFfX9H9oY2vegqCjP2duQEFRhQePgTP7u+hHW31SRi
	KrysC9SRETkxLQbtQlPDrHwy9UO+JQ4YaZGJQnBTUf9tg1Yyfkfzqj1dPE9QgN8dugl5tn8RUyH
	p5I7ZaL4RtNxjsngtZBeTodTQyIzknScxqB7X3jrzc1ayESglGVFFHdhogQ==
X-Gm-Gg: ASbGncvegf86g3Roj1yZ/kvqj29zd2jjK3T06+rHuYG47VUl4iC/wiUajYgoBH849Bc
	k9sU81UcGMCqgMTrh3CrjamL6Ztew7ioQJkZuugxn1LZQ1W8mkypfIGZR42O1iCOdEiwRBQmMwp
	7dH6rT2ZVtdW8k53mjBirnFQLKfnWItI+2jzfBUqeaKqNGCdcZdJ49XdrAUKJYa+M8njQwXlrJH
	2qshNqqZejyFilWHaV8wUefCEQiiLUdgOfyr6dEBfVajz0VXVmZ7i1UgIAsA4Mxu7vAJp9IXC1g
	SLQ=
X-Received: by 2002:a05:6a00:39a2:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-74028a64220mr3881929b3a.8.1745919346341;
        Tue, 29 Apr 2025 02:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcRRRYCT0Ey5PUAul1cem5LsfGawyLhW7VHOQTRyfJoa6t9dY828zqrHeMujEDVJTxyYQbsw==
X-Received: by 2002:a05:6a00:39a2:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-74028a64220mr3881906b3a.8.1745919345989;
        Tue, 29 Apr 2025 02:35:45 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a99a9esm9731097b3a.140.2025.04.29.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:35:45 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:34:57 +0800
From: Coiby Xu <coxu@redhat.com>
To: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <mrvtghwiry77qwiakyjft3mt2po5rdntjrl7btlkmgnvgjrlru@lnkoytr3ozzh>
References: <20250207080818.129165-1-coxu@redhat.com>
 <20250207080818.129165-3-coxu@redhat.com>
 <q3l724gslm3kzljjdo42l5murdw4pclpnmmtzu5jvqv4gwyxma@ek4jucbut32i>
MIME-Version: 1.0
In-Reply-To: <q3l724gslm3kzljjdo42l5murdw4pclpnmmtzu5jvqv4gwyxma@ek4jucbut32i>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qeu8WxtSR3dA4Kb1AeFhLN7hX5TScLfUSuBlzoJIqqY_1745919346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_023551_394046_D0B05781 
X-CRM114-Status: GOOD (  10.84  )
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

On Wed, Apr 23, 2025 at 10:44:22PM +0200, Arnaud Lefebvre wrote:
>On Fri, Feb 07, 2025 at 04:08:10PM +0800, Coiby Xu wrote:
>>+config CRASH_DM_CRYPT
>>+	bool "Support saving crash dump to dm-crypt encrypted volume"
>>+	depends on KEXEC_FILE
>>+	depends on CRASH_DUMP
>>+	depends on DM_CRYPT
>>+	help
>>+	  With this option enabled, user space can intereact with
>>+	  /sys/kernel/config/crash_dm_crypt_keys to make the dm crypt keys
>>+	  persistent for the dump-capture kernel.
>>+
>
>Maybe also add CONFIG_CONFIGFS_FS option? Without it this series code doesn't compile:

I'll add the dependency on CONFIG_CONFIGFS_FS, thanks for your
suggestion!

>
>Last build lines:
>
>   GEN     modules.builtin
>   MODPOST vmlinux.symvers
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   KSYMS   .tmp_vmlinux0.kallsyms.S
>   AS      .tmp_vmlinux0.kallsyms.o
>   LD      .tmp_vmlinux1
> ld: vmlinux.o: in function `config_keys_make_item':
> /usr/src/linux/kernel/crash_dump_dm_crypt.c:250:(.text+0x228028): undefined reference to `config_item_init_type_name'
> ld: vmlinux.o: in function `configfs_dmcrypt_keys_init':
> /usr/src/linux/kernel/crash_dump_dm_crypt.c:442:(.init.text+0x71e5c): undefined reference to `config_group_init'
> ld: /usr/src/linux/kernel/crash_dump_dm_crypt.c:444:(.init.text+0x71e82): undefined reference to `configfs_register_subsystem'
> ld: /usr/src/linux/kernel/crash_dump_dm_crypt.c:454:(.init.text+0x71ef7): undefined reference to `configfs_unregister_subsystem'
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> make[1]: *** [/usr/src/linux/Makefile:1226: vmlinux] Error 2
> make: *** [Makefile:251: __sub-make] Error 2



-- 
Best regards,
Coiby


