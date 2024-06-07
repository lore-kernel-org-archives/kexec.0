Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5936C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8ha1PEM2yPUN7p8svtNp+lgFvAmycFbWnpGqXVso3A=; b=fnJks3aFbeJ5RfWSn0YO8SWbUs
	+fCbDG2NCGwRlmt3aSv6SzofcDM/bqpo9XQLX/M6/EELOZJjWCynUMUF1p5W3RGsJCm9tehC4DRHH
	Hh+TvA2iW4pQpM7h7l6WdUen/QsnGmhBk8b1LMcA2rKyl1Fh9aKfWLHYfxx/uN7Urm3GsAnXGHgCq
	g8BitwnPHohMEqvFZm17GEXdwS14XQHEoMwJx/88hr0EAV26SZ91r8XyNQMyBFX7IyniUGN9OIS8s
	ducvi1IWs/jQ9vmveGUngCIqFul2vjbwfqrqNY50uFcxDwicX13+PaphYtU3c0lxyli9GjYp+iGJt
	gZkfrnng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhU-0000000DvHo-1Lxo;
	Fri, 07 Jun 2024 12:28:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhR-0000000DvFm-1WEX
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbWgNDxp6kqI8KSc+gmSAycDQgB7Zp2ds8pce0lyFW0=;
	b=KjPjdNZROJgn1KFkPYqrYQWbRO7n2MZDWbqku1KXNrYeDx+9fwJ79vHfjETsDvHgnEckB2
	DfTDIHlIUR8ihl0hXNM+dEDfLiB+i/t6Ct5/53It7BDZyADTfGcaTILeqauNLgkRdkFLuv
	4Gb/aCRr7Z3z2KLkUhuDbD76mLcL4nw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-3oICSqaIMM279If6WsIu1w-1; Fri, 07 Jun 2024 08:28:03 -0400
X-MC-Unique: 3oICSqaIMM279If6WsIu1w-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb5e67b186so48027039f.3
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763282; x=1718368082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbWgNDxp6kqI8KSc+gmSAycDQgB7Zp2ds8pce0lyFW0=;
        b=DabrL+nEOQkRv5HSvwAfpkDyVfxL8sCfZneaWChU1qFP9DaiHU/88zxwWAOR5mMGU5
         MGGNjEAmDNuoeDj50gs4sTdYqieb/e+6yasgQ0zeSw5ab3DtjaKfYP9tnYRuiwulQiS+
         ize6smgegLsG2f8gj50rqQI8Kyrrsxb+zCLjoV8ugHMrkSDh/6PVhqf1fkUeYw1JbVss
         biygQaxYOCvuFmyZqKjNoWZPzPZpdYy23odaYYtDOeRfpkBdnVLgga88l55+Zmi6Bgxr
         +RHrrMlPOAN4QtE0scu5pfOmY7eo2os/hSsJYSLlX4HHJAihEN/Y1fUWuG5dIqfF9byY
         MpCA==
X-Gm-Message-State: AOJu0YztC6uwIKJl6hgKUrY52jc8c6yFNV+nX82Y8xNfhieKgR5vW6Wy
	pCLmDgUsWSGuPjeOQjN72hEuhiK+WMVn9HEiM52AS8GKlsTk6ANxazBDOazxc83wfLseX0SksUB
	qUOoIuPaQSgydVtazkjyFZiDETqkqUgqsEQ01AGCIcwzA7utk8BSFerKnQw==
X-Received: by 2002:a05:6602:3f94:b0:7eb:54ed:b5a7 with SMTP id ca18e2360f4ac-7eb57214c4dmr298375739f.10.1717763282035;
        Fri, 07 Jun 2024 05:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQ/weh8538++SUkRqyPxVISqGPPf+OfZIrUi8Bg5xu2zrDrA/DcENnY/2SmEnB/E3niLYSQ==
X-Received: by 2002:a05:6602:3f94:b0:7eb:54ed:b5a7 with SMTP id ca18e2360f4ac-7eb57214c4dmr298371939f.10.1717763281515;
        Fri, 07 Jun 2024 05:28:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7c2273238sm58172173.102.2024.06.07.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:01 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:39 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>, Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <um2wwcbti6vyu72lbjhh3ywzzardeize2joi5qedvzce277hav@f5bfokh3k7po>
References: <20240523050451.788754-4-coxu@redhat.com>
 <202405241012.KlmCbp77-lkp@intel.com>
 <Zl8ckh7FBErY3Oh6@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Zl8ckh7FBErY3Oh6@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052805_513260_C74998D8 
X-CRM114-Status: GOOD (  22.71  )
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

On Tue, Jun 04, 2024 at 09:54:26PM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 05/24/24 at 11:17am, kernel test robot wrote:
>> Hi Coiby,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on de7e71ef8bed222dd144d8878091ecb6d5dfd208]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240523-130727
>> base:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
>> patch link:    https://lore.kernel.org/r/20240523050451.788754-4-coxu%40redhat.com
>> patch subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
>> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202405241012.KlmCbp77-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>
>Please respond to lkp report sooner, otherwise the reproducer link could
>be unavailable.

Thanks for the reminder! I believe these errors are false positives
because 1) include/linux/kexec.h is included after "#include <linux/crash_dump.h>"
and 2) similar errors are seen for kernel/kexec_file.c by 
"make ARCH=arm CROSS_COMPILE=arm-linux-gnu- kernel/kexec_file.o"

>
>>
>>    kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>> >> kernel/crash_dump_dm_crypt.c:158:16: error: variable 'kbuf' has initializer but incomplete type
>>      158 |         struct kexec_buf kbuf = {
>>          |                ^~~~~~~~~
>> >> kernel/crash_dump_dm_crypt.c:159:18: error: 'struct kexec_buf' has no member named 'image'
>>      159 |                 .image = image,
>>          |                  ^~~~~
>>    kernel/crash_dump_dm_crypt.c:159:26: warning: excess elements in struct initializer
>>      159 |                 .image = image,
>>          |                          ^~~~~
>>    kernel/crash_dump_dm_crypt.c:159:26: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:160:18: error: 'struct kexec_buf' has no member named 'buf_min'
>>      160 |                 .buf_min = 0,
>>          |                  ^~~~~~~
>>    kernel/crash_dump_dm_crypt.c:160:28: warning: excess elements in struct initializer
>>      160 |                 .buf_min = 0,
>>          |                            ^
>>    kernel/crash_dump_dm_crypt.c:160:28: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:161:18: error: 'struct kexec_buf' has no member named 'buf_max'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                  ^~~~~~~
>>    In file included from include/linux/limits.h:7,
>>                     from include/linux/thread_info.h:12,
>>                     from include/asm-generic/preempt.h:5,
>>                     from ./arch/arm/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:79,
>>                     from include/linux/rcupdate.h:27,
>>                     from include/linux/rbtree.h:24,
>>                     from include/linux/key.h:15,
>>                     from kernel/crash_dump_dm_crypt.c:2:
>>    include/vdso/limits.h:13:25: warning: excess elements in struct initializer
>>       13 | #define ULONG_MAX       (~0UL)
>>          |                         ^
>>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                            ^~~~~~~~~
>>    include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
>>       13 | #define ULONG_MAX       (~0UL)
>>          |                         ^
>>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>>      161 |                 .buf_max = ULONG_MAX,
>>          |                            ^~~~~~~~~
>> >> kernel/crash_dump_dm_crypt.c:162:18: error: 'struct kexec_buf' has no member named 'top_down'
>>      162 |                 .top_down = false,
>>          |                  ^~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:162:29: warning: excess elements in struct initializer
>>      162 |                 .top_down = false,
>>          |                             ^~~~~
>>    kernel/crash_dump_dm_crypt.c:162:29: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:163:18: error: 'struct kexec_buf' has no member named 'random'
>>      163 |                 .random = true,
>>          |                  ^~~~~~
>>    kernel/crash_dump_dm_crypt.c:163:27: warning: excess elements in struct initializer
>>      163 |                 .random = true,
>>          |                           ^~~~
>>    kernel/crash_dump_dm_crypt.c:163:27: note: (near initialization for 'kbuf')
>> >> kernel/crash_dump_dm_crypt.c:158:26: error: storage size of 'kbuf' isn't known
>>      158 |         struct kexec_buf kbuf = {
>>          |                          ^~~~
>> >> kernel/crash_dump_dm_crypt.c:187:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
>>      187 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>          |                    ^~~~~~~~~~~~~~~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:187:20: note: each undeclared identifier is reported only once for each function it appears in
>> >> kernel/crash_dump_dm_crypt.c:188:13: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
>>      188 |         r = kexec_add_buffer(&kbuf);
>>          |             ^~~~~~~~~~~~~~~~
>>    kernel/crash_dump_dm_crypt.c:158:26: warning: unused variable 'kbuf' [-Wunused-variable]
>>      158 |         struct kexec_buf kbuf = {
>>          |                          ^~~~
>>    cc1: some warnings being treated as errors
>>
>>
>> vim +/kbuf +158 kernel/crash_dump_dm_crypt.c
>>
>>    155	
>>    156	int crash_load_dm_crypt_keys(struct kimage *image)
>>    157	{
>>  > 158		struct kexec_buf kbuf = {
>>  > 159			.image = image,
>>  > 160			.buf_min = 0,
>>  > 161			.buf_max = ULONG_MAX,
>>  > 162			.top_down = false,
>>  > 163			.random = true,
>>    164		};
>>    165	
>>    166		int r;
>>    167	
>>    168		if (state == FRESH)
>>    169			return 0;
>>    170	
>>    171		if (key_count != keys_header->key_count) {
>>    172			pr_err("Only record %u keys (%u in total)\n", key_count,
>>    173			       keys_header->key_count);
>>    174			return -EINVAL;
>>    175		}
>>    176	
>>    177		image->dm_crypt_keys_addr = 0;
>>    178		r = build_keys_header();
>>    179		if (r)
>>    180			return r;
>>    181	
>>    182		kbuf.buffer = keys_header;
>>    183		kbuf.bufsz = keys_header_size;
>>    184	
>>    185		kbuf.memsz = kbuf.bufsz;
>>    186		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>  > 187		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>  > 188		r = kexec_add_buffer(&kbuf);
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
