Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7381C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O5FN1ZzKpvmXUmb2Ey+6VBvwGbeMn0Aw+1Txs3tFGec=; b=R0He4s3sUVzIUm
	7+u7ZOEaxshWOpUk+Zrb9B2m5v3pmigRNY3RyotyNyRRwsAN7ZUDKa71HQxuT9j3XMbgFc/te6KZx
	ZAbab8vsqZVTptgZfIMqN4GXc5oZXd1h6yU7L01uuHL1VfEUaCPYcqhF65KhgEYZm367zqAmdN1qs
	gTNkPnDp7b0QeUm36sgAz9LcXX3RyS2RVSDbcm1yxHIXEdPlu5LLsj0YKNIxGqEyiUCSUgTk1b6T3
	mUSfByCo2eyYlanPY05RFXeG1GJuQ2fzk8MNnPIMdzujcNDiu9GYn+nu2SgjWenN+hNvY3PzFFBo/
	tDrLDGxaKh7SrFG2SkBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEUcb-00000002aI4-0Fr4;
	Tue, 04 Jun 2024 13:54:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEUcX-00000002aGi-2CDP
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 13:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zKKZvS6BOZCnR19TBgVvw0oiH1zc+KtZmMFFr2lKZA=;
	b=CeoakvcRSVJoWPI3+kLN+FJkfQfCqG2VPySQt+2fyKNXYmwpePDFxUEfRv4KXJ48IEzcGd
	9KdsnY4K0cBFEKxhfzeN9DEEc/bzGS2YKeX/7JAXU/iKnONvw7o0xi/HLSkTutNII4Ux67
	Oz3HmfWLpM7sm48Rd+R/NcmZuPND+iE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Jq0fwLYpNsmRMH9Gzwu6bQ-1; Tue,
 04 Jun 2024 09:54:32 -0400
X-MC-Unique: Jq0fwLYpNsmRMH9Gzwu6bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7931429ABA03;
	Tue,  4 Jun 2024 13:54:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E9683C54;
	Tue,  4 Jun 2024 13:54:29 +0000 (UTC)
Date: Tue, 4 Jun 2024 21:54:26 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Message-ID: <Zl8ckh7FBErY3Oh6@MiWiFi-R3L-srv>
References: <20240523050451.788754-4-coxu@redhat.com>
 <202405241012.KlmCbp77-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202405241012.KlmCbp77-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_065437_663452_8F1213E5 
X-CRM114-Status: GOOD (  23.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Coiby,

On 05/24/24 at 11:17am, kernel test robot wrote:
> Hi Coiby,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on de7e71ef8bed222dd144d8878091ecb6d5dfd208]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240523-130727
> base:   de7e71ef8bed222dd144d8878091ecb6d5dfd208
> patch link:    https://lore.kernel.org/r/20240523050451.788754-4-coxu%40redhat.com
> patch subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241012.KlmCbp77-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405241012.KlmCbp77-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Please respond to lkp report sooner, otherwise the reproducer link could
be unavailable.

> 
>    kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_keys':
> >> kernel/crash_dump_dm_crypt.c:158:16: error: variable 'kbuf' has initializer but incomplete type
>      158 |         struct kexec_buf kbuf = {
>          |                ^~~~~~~~~
> >> kernel/crash_dump_dm_crypt.c:159:18: error: 'struct kexec_buf' has no member named 'image'
>      159 |                 .image = image,
>          |                  ^~~~~
>    kernel/crash_dump_dm_crypt.c:159:26: warning: excess elements in struct initializer
>      159 |                 .image = image,
>          |                          ^~~~~
>    kernel/crash_dump_dm_crypt.c:159:26: note: (near initialization for 'kbuf')
> >> kernel/crash_dump_dm_crypt.c:160:18: error: 'struct kexec_buf' has no member named 'buf_min'
>      160 |                 .buf_min = 0,
>          |                  ^~~~~~~
>    kernel/crash_dump_dm_crypt.c:160:28: warning: excess elements in struct initializer
>      160 |                 .buf_min = 0,
>          |                            ^
>    kernel/crash_dump_dm_crypt.c:160:28: note: (near initialization for 'kbuf')
> >> kernel/crash_dump_dm_crypt.c:161:18: error: 'struct kexec_buf' has no member named 'buf_max'
>      161 |                 .buf_max = ULONG_MAX,
>          |                  ^~~~~~~
>    In file included from include/linux/limits.h:7,
>                     from include/linux/thread_info.h:12,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/arm/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:79,
>                     from include/linux/rcupdate.h:27,
>                     from include/linux/rbtree.h:24,
>                     from include/linux/key.h:15,
>                     from kernel/crash_dump_dm_crypt.c:2:
>    include/vdso/limits.h:13:25: warning: excess elements in struct initializer
>       13 | #define ULONG_MAX       (~0UL)
>          |                         ^
>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>      161 |                 .buf_max = ULONG_MAX,
>          |                            ^~~~~~~~~
>    include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
>       13 | #define ULONG_MAX       (~0UL)
>          |                         ^
>    kernel/crash_dump_dm_crypt.c:161:28: note: in expansion of macro 'ULONG_MAX'
>      161 |                 .buf_max = ULONG_MAX,
>          |                            ^~~~~~~~~
> >> kernel/crash_dump_dm_crypt.c:162:18: error: 'struct kexec_buf' has no member named 'top_down'
>      162 |                 .top_down = false,
>          |                  ^~~~~~~~
>    kernel/crash_dump_dm_crypt.c:162:29: warning: excess elements in struct initializer
>      162 |                 .top_down = false,
>          |                             ^~~~~
>    kernel/crash_dump_dm_crypt.c:162:29: note: (near initialization for 'kbuf')
> >> kernel/crash_dump_dm_crypt.c:163:18: error: 'struct kexec_buf' has no member named 'random'
>      163 |                 .random = true,
>          |                  ^~~~~~
>    kernel/crash_dump_dm_crypt.c:163:27: warning: excess elements in struct initializer
>      163 |                 .random = true,
>          |                           ^~~~
>    kernel/crash_dump_dm_crypt.c:163:27: note: (near initialization for 'kbuf')
> >> kernel/crash_dump_dm_crypt.c:158:26: error: storage size of 'kbuf' isn't known
>      158 |         struct kexec_buf kbuf = {
>          |                          ^~~~
> >> kernel/crash_dump_dm_crypt.c:187:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
>      187 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>          |                    ^~~~~~~~~~~~~~~~~~~~~
>    kernel/crash_dump_dm_crypt.c:187:20: note: each undeclared identifier is reported only once for each function it appears in
> >> kernel/crash_dump_dm_crypt.c:188:13: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
>      188 |         r = kexec_add_buffer(&kbuf);
>          |             ^~~~~~~~~~~~~~~~
>    kernel/crash_dump_dm_crypt.c:158:26: warning: unused variable 'kbuf' [-Wunused-variable]
>      158 |         struct kexec_buf kbuf = {
>          |                          ^~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/kbuf +158 kernel/crash_dump_dm_crypt.c
> 
>    155	
>    156	int crash_load_dm_crypt_keys(struct kimage *image)
>    157	{
>  > 158		struct kexec_buf kbuf = {
>  > 159			.image = image,
>  > 160			.buf_min = 0,
>  > 161			.buf_max = ULONG_MAX,
>  > 162			.top_down = false,
>  > 163			.random = true,
>    164		};
>    165	
>    166		int r;
>    167	
>    168		if (state == FRESH)
>    169			return 0;
>    170	
>    171		if (key_count != keys_header->key_count) {
>    172			pr_err("Only record %u keys (%u in total)\n", key_count,
>    173			       keys_header->key_count);
>    174			return -EINVAL;
>    175		}
>    176	
>    177		image->dm_crypt_keys_addr = 0;
>    178		r = build_keys_header();
>    179		if (r)
>    180			return r;
>    181	
>    182		kbuf.buffer = keys_header;
>    183		kbuf.bufsz = keys_header_size;
>    184	
>    185		kbuf.memsz = kbuf.bufsz;
>    186		kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  > 187		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  > 188		r = kexec_add_buffer(&kbuf);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
