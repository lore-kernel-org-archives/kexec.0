Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F01C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZ6nri1rZ77q5sVj4lKIx7chMdO95ZHykyJ6ov7q+Tk=; b=dHKrAHHHM6XAX3ELFEF6b+CiEu
	Nteh1Bw0kwyS+0kIURmWdWN4GNoyGWz2+PSpHcpDFRFYaKPouregJDMJ1UewxFTHweDBzaJ71YJ07
	aDBmoykwtizjhoobEExFi10aZixzXH2E/832SEE7yeCilV3ytfx+SkkOwc/vNUp5HjfIWpNbjzN8y
	aSztAqCuvPbJZWLIVBSWBbT5gmcbDKWxMXc0TwQedJUCsfNrQsn1gpIh1MmObRvfjpfobGPWxvDx5
	pzpJzBJRRcpLjk3+jZS1fGT81OA98BdSDeyB674eVnOeZJMilBckrfw93nkL7T3SDkgf8wQDfPJ7y
	Lo5RjzFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhg-0000000DvNK-00cG;
	Fri, 07 Jun 2024 12:28:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhd-0000000DvLq-1Z6d
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
	b=eSWjvATNNTHaqJTnMt6FVtD7vaWRaqROg6ATMbNj1ugKRl8myPjW5jsj7PH75nscLfdnNI
	88/wYfHA72y7JrSecmRFDFsAITA/Ioq2ZMYqvm5tFjlgDhz+qVE5a8EPUvdMc48gUyWSma
	/lRg0dXX3/1m/imUwGZSrkRX8N69XO0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9brVwmR3Po2IYfnbMveciA-1; Fri, 07 Jun 2024 08:28:15 -0400
X-MC-Unique: 9brVwmR3Po2IYfnbMveciA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6e3341c8865so506381a12.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763293; x=1718368093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t6956UOv5lCksdjLk7UvP2/agO8Fjf4ixoixsQ5vC4=;
        b=kK5rUPEg3x8YGaLkah3JFqHi5m4xxgqJjsSI6UthcOcT19KBcuFyQUMdj/pS8lChOy
         5qg3rWhUqMEyEUXeIP8n3IJ7B3KPG4a5J8k0X3wd5A+vI5CR3wR2IZC1+OL6yGgchBIS
         9yebgjhgwRE52Vd0pO+wJ5pC3DqFFd+0BkvqCeT+HJOyQ21OvbTAwtkgIc8rKd2S4rxv
         nXvT/8Sukj6sWFGK95j3uc0IOmBc5NVdY9oUusa2ydyftsM0k856lMCsg0zEsCr7GpwE
         BOBUJFVF6UHDma3NbkGPCedtiGLd+1Fl00HrByFJfAchi1rr6gernyOrVlVrwlF1vQ7F
         GqmA==
X-Gm-Message-State: AOJu0YyXH5A2fwIYieZOBHJlzim5YAGXdeFC3s+XqQEJHGuZr/kpC2Y0
	zywwP4QKn1tXTLdW+GrPVPrR8HKz3SUvKUIGFvj8cwyijLhFl1TBtEGzNnCB8hm6zN6QuB/QL71
	HN2eTy4J91bDsxtp94fCW7V71Ahl68XcMkUtgH8QPkx1Y3sWkKSV7toZwNw==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654917637.14.1717763292875;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQo9mPlRLCIa6N5kRoMuchaJ04EmyjXCzB3G/zjo7E3SC6tybqM+xniohJslEjmSTV/Ig+lw==
X-Received: by 2002:a05:6a21:32a7:b0:1b4:68a2:908b with SMTP id adf61e73a8af0-1b468b1d6b1mr654885637.14.1717763292099;
        Fri, 07 Jun 2024 05:28:12 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70410b976a9sm942536b3a.147.2024.06.07.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:54 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <y5ah5hdueqh5l5m4ll6qdebvnkvkdfbghvjprgyfeacajo3nhj@zg7qj6vfo3w6>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052817_518902_C82D84A4 
X-CRM114-Status: GOOD (  28.31  )
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

On Thu, Jun 06, 2024 at 11:11:30AM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>
>This patch highly lack document to describe what it's doing. For
>example, how you will manipulate the /sys/kernel/crash_dm_crypt_keys to
>initialize, record the keys, can you give examples how you opeate on
>them?

Thanks for the suggestion! v5 now includes
Documentation/ABI/testing/crash_dm_crypt_keys.

>
>>
>> User space can also read this API to learn about current state.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |   5 +-
>>  kernel/Kconfig.kexec         |   8 +++
>>  kernel/Makefile              |   1 +
>>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  22 +++++++
>>  5 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index 44305336314e..6bff1c24efa3 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>>  static inline void arch_kexec_unprotect_crashkres(void) { }
>>  #endif
>>
>> -
>> +#ifdef CONFIG_CRASH_DM_CRYPT
>> +int crash_sysfs_dm_crypt_keys_read(char *buf);
>> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
>> +#endif
>>
>>  #ifndef arch_crash_handle_hotplug_event
>>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
>> index 6c34e63c88ff..88525ad1c80a 100644
>> --- a/kernel/Kconfig.kexec
>> +++ b/kernel/Kconfig.kexec
>> @@ -116,6 +116,14 @@ config CRASH_DUMP
>>  	  For s390, this option also enables zfcpdump.
>>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>>
>> +config CRASH_DM_CRYPT
>> +	bool "Support saving crash dump to dm-crypt encrypted volume"
>> +	depends on CRASH_DUMP
>
>Do we need add dependency on some security features, e.g KEYS?
>The current code will enable the CRASH_DM_CRYPT regardless of the
>existence of LUKS disk at all.

Good suggestion! I make CRASH_DM_CRYPT depend on DM_CRYPT in v5.

> [...]
>> +static int init(const char *buf)
>> +{
>> +	unsigned int total_keys;
>> +	char dummy[5];
>> +
>> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
>> +		return -EINVAL;
>
>This is what I wondered and tried to find a document to get why. Can we
>search in the current system and deduce how many keys we can could use
>for kdump kernel? Or we have to retrieve and pass it from user space?

I don't think we can get this info from the kernel space directly
because the kernel don't know the kdump target. So we have to pass this
info from user space.

>
>> +
>> +	if (key_count > KEY_NUM_MAX) {
>> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
>> +		       KEY_NUM_MAX);
>> +		return -EINVAL;
>> +	}
>
>Why chekcing key_count in init()? Don't you need to check
>total_keys instead? Clearly you don't do a boundary test for total_keys,
>otherwise it will trigger issue.

Good catch! Yes, I should check total_keys instead.

>
>> +
>> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
>> +	key_count = 0;
>> +
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>> +
>> +	keys_header->key_count = total_keys;
>> +	state = INITIALIZED;
>> +	return 0;
>> +}
>
>Please add more code comments, kernel-doc for your code, we can't assume
>people reading these codes know the entire matter.

Thanks for the suggestion! I've added some comments and documentation in
v5. Please let me know if there is anything more to improve.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
