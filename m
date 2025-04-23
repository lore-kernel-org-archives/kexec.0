Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DF3C369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4JQukv4V2SGT25PhTUE5gzgD7+TW+jjgBfY+fBa4EE=; b=SzwHm/FWeobwa+9yaKT+qp5Pey
	uFBGHczX6v3m/+ZS/mtsT1QUk9HCBr1K7ffl5R71GEe4Tj/PGtt8fPfcKYEpyrmUg7W3ALjTk53Es
	h34x6RUEC4iQfYqovJrJrFmDQoj2cxI8kN8eTu9twO7BTUg4/gbRk3sdoLT6SIuR+g5beTo/eFvIH
	abX9W5lBg0Hd2EKJCVgYMy5ijjlZJag1VxLYCugJDelOM0K/9aPAZ/J80gszockoqHZI77VE4d9fr
	ad0PawNpts+bhFaf596v9ckI1U/zU0Mu7BFiazeRulbspNYl4G7jehInovHYUVrsyYxFQ2+ddA9zZ
	gcM55Wrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7gxI-0000000C0Cn-3uz8;
	Wed, 23 Apr 2025 20:44:28 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7gxG-0000000C0Bx-2D5B
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 20:44:27 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-39c1efc457bso182097f8f.2
        for <kexec@lists.infradead.org>; Wed, 23 Apr 2025 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clever-cloud.com; s=google; t=1745441064; x=1746045864; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4JQukv4V2SGT25PhTUE5gzgD7+TW+jjgBfY+fBa4EE=;
        b=YqR0nzrhgQzZygi6KTWD0QOV9iZYDmJCMDeFK5YRCE1tNtliww1yakPavbH5PDJpUH
         7e9YjM1jDkYTlUMrTzLeDT+r8nMGnkdVA05jxxwcOvhp0jNpYSPipRZvKhIo5p0CjgoG
         0qpY9U+W5SdRYSESFpoFZZmhHHwtIFlkWJ13SD/WhhKF7ig0XRKQmbd8NkzB4ba6y7dR
         aRWuEhPL8YBwcBgWQ+3GuXS6gTLsVOsAPaK6/dq7GUFI6A+YWHfXmHycPVdPJNiSyeSz
         URxWB5rmzzxg6Ap0FHUxDUamSYParGO2UYL+PeCGHFnkW1zag2RRH5kQPgEmsznmr7tn
         tc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441064; x=1746045864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4JQukv4V2SGT25PhTUE5gzgD7+TW+jjgBfY+fBa4EE=;
        b=lDW0GZk4wzuTUtVliSM3Osl5Sb3y7s0hlYUqvH/MWp4bZp6nWWbIPugZJE97AhxnBk
         jdKelvaCRTMuPtkIRB9ukESK/NRcBghyXKL+CiPl3K1oGJFQkbAqscdlfYxsbxo6mxL8
         yASWunDKvigYnGnyYjQGtjrhAwFPw4MBQ2gnrVxt39l6a0COuDq4IeE3Ld0F+Yby58Ga
         UrmNaJLr0ASi6YVJe2dENNwYMAsIPa0w7JDUJANZfVG09whIc048FGrMlK0LK/5BOwWm
         Y5+M63AB+8A5Q+Vp92ewhjRu1Z1wmVVU6fbtsIbSFBiCq7HBhpdSPIAjCQe07UrEABB8
         nhRQ==
X-Gm-Message-State: AOJu0YxdMEMnjYNd1Piqmn0LoJ2W/clqZdKItklY6eXBj4KVa7sYAxxs
	H7NJb5oAQpE1vRPZBCTMPL8TLr99JumNt208H87MdJ5e+pGch0UK+0gGpMWUcvM=
X-Gm-Gg: ASbGncsWsGxqOQ3NK0rh6/GTy0qFtkAyw9N/Qcl7AI9keh05zTBoA+SoU4KQXHcGA9G
	I5RHc88mpJqdzmtY+FcVfm52XBOkhFMZEbwSoVJa10BDiw9eKuuDGi3PlYugsO8WomWl1qRdLzI
	HziPOOR7IMAUR4p3zQQ3xMqVyrFqjvSUMs+46A5BdxXV+B0wh3KN3kyCK0sGcooaOvl81x1ypGy
	jqvVT1L1vZ9MCXvRUKzmbBh3bztk9XpuvefmRVbwNJ3U3Qp9vHwvYmTMueiqnKCZVwgiTKN7HUO
	cUsW1u7CXHi3MJcikcOe9vr8wxqnJ0DpOWx5ZYdlNDx1eKIlsL2Oi5sQ
X-Google-Smtp-Source: AGHT+IHrt2OWKJypr1o1ICBn+gRGjQNOGrIDNNGpq6ACRGf8v97G9orsWa/cY0oOdwaup9byy966mA==
X-Received: by 2002:a5d:64a5:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-39efba45fedmr16053022f8f.16.1745441064448;
        Wed, 23 Apr 2025 13:44:24 -0700 (PDT)
Received: from exherswag ([2a01:e34:ec5f:fb40:df48:ecab:7887:deaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4c0fsm19841706f8f.88.2025.04.23.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:44:23 -0700 (PDT)
Date: Wed, 23 Apr 2025 22:44:22 +0200
From: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <q3l724gslm3kzljjdo42l5murdw4pclpnmmtzu5jvqv4gwyxma@ek4jucbut32i>
References: <20250207080818.129165-1-coxu@redhat.com>
 <20250207080818.129165-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207080818.129165-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_134426_578949_138163AF 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
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

On Fri, Feb 07, 2025 at 04:08:10PM +0800, Coiby Xu wrote:
>+config CRASH_DM_CRYPT
>+	bool "Support saving crash dump to dm-crypt encrypted volume"
>+	depends on KEXEC_FILE
>+	depends on CRASH_DUMP
>+	depends on DM_CRYPT
>+	help
>+	  With this option enabled, user space can intereact with
>+	  /sys/kernel/config/crash_dm_crypt_keys to make the dm crypt keys
>+	  persistent for the dump-capture kernel.
>+

Maybe also add CONFIG_CONFIGFS_FS option? Without it this series code doesn't compile:

Last build lines:

    GEN     modules.builtin
    MODPOST vmlinux.symvers
    UPD     include/generated/utsversion.h
    CC      init/version-timestamp.o
    KSYMS   .tmp_vmlinux0.kallsyms.S
    AS      .tmp_vmlinux0.kallsyms.o
    LD      .tmp_vmlinux1
  ld: vmlinux.o: in function `config_keys_make_item':
  /usr/src/linux/kernel/crash_dump_dm_crypt.c:250:(.text+0x228028): undefined reference to `config_item_init_type_name'
  ld: vmlinux.o: in function `configfs_dmcrypt_keys_init':
  /usr/src/linux/kernel/crash_dump_dm_crypt.c:442:(.init.text+0x71e5c): undefined reference to `config_group_init'
  ld: /usr/src/linux/kernel/crash_dump_dm_crypt.c:444:(.init.text+0x71e82): undefined reference to `configfs_register_subsystem'
  ld: /usr/src/linux/kernel/crash_dump_dm_crypt.c:454:(.init.text+0x71ef7): undefined reference to `configfs_unregister_subsystem'
  make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
  make[1]: *** [/usr/src/linux/Makefile:1226: vmlinux] Error 2
  make: *** [Makefile:251: __sub-make] Error 2


