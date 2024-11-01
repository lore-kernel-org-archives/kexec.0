Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C694E674AC
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVf9JJEaJC1BzZad8wKQxrD1f//R/LLV0SGk1IsA72I=; b=JCrHrbmU/kf62dH3tUORAVO5qT
	qVjMg0SM/zMKhcZnkVCDC0xU+zvaSLAemswND9gEeudIUSWRNMltQx9TbtHIAQnUNt78ORRPP3qUB
	i5m9JsBS2plk1c+d6xBsXCY33hThZx9SbYUrW2ymHliQ1zmcERwn22WrfVzF0a7iyG6A33NknGCjm
	Pe4n6k7YFWeQFyezomp1f6tBXPHCWU8LnkQumEyBo8HGvjmrDNS7RaKIAGzUShO3SFvYwWl1uvLUm
	XoOR5/5q+eqiqL1dE4yiLbzwwObdF6qLPb+WR5mYB1nWKGjLop8TBEeWJaNQP/tDmbg1L2Fu6mx/B
	GSJjvIJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6m7M-000000067wf-2wuf;
	Fri, 01 Nov 2024 07:30:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6lxG-000000065rH-167J
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 07:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730445619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5hXjcqWXRn59a0xbdSnVFt2VZK6FjShJd6whf11uMo=;
	b=h0HXucU+KFi4rmjYc7KbUaLjmvB4QZooOwRB4Bh5XDhBzd+5fW1C96ltNceRrlb4ezc7cB
	ClVJJkZMIhQ6NpDC+anvS1kOAUy0b50QsmRsDwozdXyBbABMPvjyN+LKPVKeiyVBKikH0C
	056s6ZacS9CiPsfHFSMu582OXwonYvQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-FcxqgS5yNj6dJ-wVN7HlJQ-1; Fri, 01 Nov 2024 03:20:18 -0400
X-MC-Unique: FcxqgS5yNj6dJ-wVN7HlJQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20e5df3e834so18165235ad.0
        for <kexec@lists.infradead.org>; Fri, 01 Nov 2024 00:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445617; x=1731050417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5hXjcqWXRn59a0xbdSnVFt2VZK6FjShJd6whf11uMo=;
        b=t5ugbSr/sGt8VMR3qGfrSWlcyTqrkk7CVJA2rntjt5IumzuSu0eKRR2oxdbANPJshR
         I/rMzH88ue2a/655H+FiHjdhWd/7qnq+RzaVbsgl1eI2vFSJ/6aEkj+gGW7S3M5ejgSp
         cwy9xG1A6i/tOcm00d8AOK3kazqmWs5wDFdwvFZRYSJG1xb5Q84JUc2DKIhWDRf3Llk4
         jCX4IL+Wauq5rdhNsg5d1TQNLhq/GYbhYUphun293PKO5QEkeMRQbPpzyGaHnVIPyYvs
         j6dDZZJNwQoYQjjJr5xxJnOqH/kT2Hbj+qSBlbGMl8Z2onzlnT6P5huR+9IzrpvbjXjE
         hV3w==
X-Gm-Message-State: AOJu0YwgDHa1zInLLF/rEgL6cpAy8Z0d1GedF8mOcAo39VA8jHTnfqfM
	bWe4OA47QVHoPyO3uh2uc/w+fsEkyZdESz/bs1RFFrEu2V4FFwRbUn9fpk6V+CwbYMiYAuhsWcD
	6LH2AC0CeGDNhL8dYV4yn25IcS0PfqqYnKSoc6NM2Rl5RsCp0yu1DB31qDeStv9pk8j3O22LJyA
	==
X-Received: by 2002:a17:903:22c6:b0:20c:6ac0:f1f3 with SMTP id d9443c01a7336-2111af799c8mr30759205ad.34.1730445617246;
        Fri, 01 Nov 2024 00:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG2Y5WF1CYx2a1shsD35rPwqjdlx6MHWPlasgIsp973u0b68S35AogeDETQd5q6GacNCn+OA==
X-Received: by 2002:a17:903:22c6:b0:20c:6ac0:f1f3 with SMTP id d9443c01a7336-2111af799c8mr30759025ad.34.1730445616668;
        Fri, 01 Nov 2024 00:20:16 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm17362645ad.58.2024.11.01.00.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:20:16 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:16:03 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <greg@kroah.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <7iimyaxqzvjn7f6xorz7ng2kvgapvay5dwhyuisd7ls6rhs6zz@q6gtyynjxpzt>
References: <20241029055223.210039-4-coxu@redhat.com>
 <202410292237.HA9vMqbC-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202410292237.HA9vMqbC-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_002022_410262_61460FDA 
X-CRM114-Status: GOOD (  23.06  )
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

On Tue, Oct 29, 2024 at 10:41:50PM +0800, kernel test robot wrote:
>Hi Coiby,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on e42b1a9a2557aa94fee47f078633677198386a52]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20241029-135449
>base:   e42b1a9a2557aa94fee47f078633677198386a52
>patch link:    https://lore.kernel.org/r/20241029055223.210039-4-coxu%40redhat.com
>patch subject: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved memory
>config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241029/202410292237.HA9vMqbC-lkp@intel.com/config)
>compiler: loongarch64-linux-gcc (GCC) 14.1.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410292237.HA9vMqbC-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202410292237.HA9vMqbC-lkp@intel.com/
>
>All error/warnings (new ones prefixed by >>):
>
>   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
>>> kernel/crash_dump_dm_crypt.c:221:16: error: variable 'kbuf' has initializer but incomplete type
>     221 |         struct kexec_buf kbuf = {
>         |                ^~~~~~~~~
>>> kernel/crash_dump_dm_crypt.c:222:18: error: 'struct kexec_buf' has no member named 'image'
>     222 |                 .image = image,
>         |                  ^~~~~
>>> kernel/crash_dump_dm_crypt.c:222:26: warning: excess elements in struct initializer
>     222 |                 .image = image,
>         |                          ^~~~~
>   kernel/crash_dump_dm_crypt.c:222:26: note: (near initialization for 'kbuf')
>>> kernel/crash_dump_dm_crypt.c:223:18: error: 'struct kexec_buf' has no member named 'buf_min'
>     223 |                 .buf_min = 0,
>         |                  ^~~~~~~
>   kernel/crash_dump_dm_crypt.c:223:28: warning: excess elements in struct initializer
>     223 |                 .buf_min = 0,
>         |                            ^
>   kernel/crash_dump_dm_crypt.c:223:28: note: (near initialization for 'kbuf')
>>> kernel/crash_dump_dm_crypt.c:224:18: error: 'struct kexec_buf' has no member named 'buf_max'
>     224 |                 .buf_max = ULONG_MAX,
>         |                  ^~~~~~~
>   In file included from include/linux/limits.h:7,
>                    from include/linux/thread_info.h:12,
>                    from include/asm-generic/preempt.h:5,
>                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
>                    from include/linux/preempt.h:79,
>                    from include/linux/rcupdate.h:27,
>                    from include/linux/rbtree.h:24,
>                    from include/linux/key.h:15,
>                    from kernel/crash_dump_dm_crypt.c:2:
>>> include/vdso/limits.h:13:25: warning: excess elements in struct initializer
>      13 | #define ULONG_MAX       (~0UL)
>         |                         ^
>   kernel/crash_dump_dm_crypt.c:224:28: note: in expansion of macro 'ULONG_MAX'
>     224 |                 .buf_max = ULONG_MAX,
>         |                            ^~~~~~~~~
>   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
>      13 | #define ULONG_MAX       (~0UL)
>         |                         ^
>   kernel/crash_dump_dm_crypt.c:224:28: note: in expansion of macro 'ULONG_MAX'
>     224 |                 .buf_max = ULONG_MAX,
>         |                            ^~~~~~~~~
>>> kernel/crash_dump_dm_crypt.c:225:18: error: 'struct kexec_buf' has no member named 'top_down'
>     225 |                 .top_down = false,
>         |                  ^~~~~~~~
>   kernel/crash_dump_dm_crypt.c:225:29: warning: excess elements in struct initializer
>     225 |                 .top_down = false,
>         |                             ^~~~~
>   kernel/crash_dump_dm_crypt.c:225:29: note: (near initialization for 'kbuf')
>>> kernel/crash_dump_dm_crypt.c:226:18: error: 'struct kexec_buf' has no member named 'random'
>     226 |                 .random = true,
>         |                  ^~~~~~
>   kernel/crash_dump_dm_crypt.c:226:27: warning: excess elements in struct initializer
>     226 |                 .random = true,
>         |                           ^~~~
>   kernel/crash_dump_dm_crypt.c:226:27: note: (near initialization for 'kbuf')
>>> kernel/crash_dump_dm_crypt.c:221:26: error: storage size of 'kbuf' isn't known
>     221 |         struct kexec_buf kbuf = {
>         |                          ^~~~
>>> kernel/crash_dump_dm_crypt.c:246:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
>     246 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>         |                    ^~~~~~~~~~~~~~~~~~~~~
>   kernel/crash_dump_dm_crypt.c:246:20: note: each undeclared identifier is reported only once for each function it appears in
>>> kernel/crash_dump_dm_crypt.c:247:13: error: implicit declaration of function 'kexec_add_buffer' [-Wimplicit-function-declaration]
>     247 |         r = kexec_add_buffer(&kbuf);
>         |             ^~~~~~~~~~~~~~~~
>>> kernel/crash_dump_dm_crypt.c:221:26: warning: unused variable 'kbuf' [-Wunused-variable]
>     221 |         struct kexec_buf kbuf = {
>         |                          ^~~~
>
>
>vim +/kbuf +221 kernel/crash_dump_dm_crypt.c
>
>   218	
>   219	int crash_load_dm_crypt_keys(struct kimage *image)
>   220	{
> > 221		struct kexec_buf kbuf = {
> > 222			.image = image,
> > 223			.buf_min = 0,
> > 224			.buf_max = ULONG_MAX,
> > 225			.top_down = false,
> > 226			.random = true,
>   227		};
>   228		int r;
>   229	
>   230	
>   231		if (key_count <= 0) {
>   232			kexec_dprintk("No dm-crypt keys\n");
>   233			return -EINVAL;
>   234		}
>   235	
>   236		image->dm_crypt_keys_addr = 0;
>   237		r = build_keys_header();
>   238		if (r)
>   239			return r;
>   240	
>   241		kbuf.buffer = keys_header;
>   242		kbuf.bufsz = get_keys_header_size(key_count);
>   243	
>   244		kbuf.memsz = kbuf.bufsz;
>   245		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> > 246		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > 247		r = kexec_add_buffer(&kbuf);
>   248		if (r) {
>   249			kvfree((void *)kbuf.buffer);
>   250			return r;
>   251		}
>   252		image->dm_crypt_keys_addr = kbuf.mem;
>   253		image->dm_crypt_keys_sz = kbuf.bufsz;
>   254		kexec_dprintk(
>   255			"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>   256			kbuf.bufsz, kbuf.bufsz);
>   257	
>   258		return r;
>   259	}
>   260	
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

Thanks for reporting this issue. I'll make CRASH_DM_CRYPT depend on
KEXEC_FILE to fix it in new version of patch set!

>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
