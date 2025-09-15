Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6F5CAC58E
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9cBtHKBe6RRB8Snk7hpO1mjWCGkijKsQ31tvgy2vEzE=; b=bG5FucV69kD/J00MfELyrv67bA
	QRTvdca6q+FzEy2imdgCnISFT0jIT+6d2hRD6Vk8+T1tj+mOWNk+r0us3hDKGhcD0ykaUK+wuEytA
	yzw+ad+j9BQIovxQejXrCQcJanjSDOVTV5zIt6mfLPEmopgk8AI6BJMe+4c5+1BWifv1cD3gOsZM5
	qyi9/ORrKVfaMSLfY7pgSIDbehlo07SQT6+wMa8gBxvKqCu/DMxypMwIvujyUiVwBMytJukW7dH97
	23xUMPb8XZc7Mvncf3EXuqsuYWz4CW2BdJuBMuTOGvs0SzNDl62bj6hEh6GcvFHW3b+beZbRajZn4
	nOHIv0Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy2Zd-00000002uQP-0qzB;
	Mon, 15 Sep 2025 06:20:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy2ZZ-00000002uPF-0OUQ
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 06:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757917218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cBtHKBe6RRB8Snk7hpO1mjWCGkijKsQ31tvgy2vEzE=;
	b=Yzcd9xEigLlF1icPMpWNppJxieILpUVC9lhEZiHMWjnAKS8TqoFmfsbiiBEGSSoWTwHdSW
	yhRC+oBZUgLvE19XhV2/zNjSLYoZ7nRVjWelFgQr+/AkqOFbS/+mK7GnbWqhxjlms0blma
	jpGK1csvP7gHTuq/4l5m4YkFix9QryY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-NEBxw5EzMOKuoyaKVqnz3A-1; Mon, 15 Sep 2025 02:20:15 -0400
X-MC-Unique: NEBxw5EzMOKuoyaKVqnz3A-1
X-Mimecast-MFC-AGG-ID: NEBxw5EzMOKuoyaKVqnz3A_1757917214
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so363531a12.0
        for <kexec@lists.infradead.org>; Sun, 14 Sep 2025 23:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757917214; x=1758522014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cBtHKBe6RRB8Snk7hpO1mjWCGkijKsQ31tvgy2vEzE=;
        b=kb2iOpLW3ilp5r/tAFODobSkG4ZLR8lw+E3U/cGL83lbL/hf04DIX0QElIgYZ1KnAP
         WJFvc4LJCtK8LAcXXRGc+4DpbMyVpbsz34zvrroS0IdL6kvf9vR4wLs6T9mZZAjKYnQ6
         LZP1O/pPsigrovfe3mRRtmvFtY0hlJr3hKESBN3BEwAYYoJYtN6UlC7MXRDI+nmJiWAF
         yMqa6w0s/8kenVGaImNPlYYU/PlzcO6xt9AkOgvsFMoILtcLD2Aw3+7qRld5Flwxet6u
         f/9uSXPx22f0zlD8obi6YG0IdBvyUHWMpN1SYQtkH6eglSxOvlp+Jvh4EEv2MTATjIU6
         2zxA==
X-Gm-Message-State: AOJu0Yw7zs2STlY+IUsa2UraHO4+OkVteW4l6T9pzXjya3unNrabwLtW
	Yj/gU0IVfeznPcSQhogpVVCeatOzBC12bJ0IOOpOyypZ/lWOoXH2E+gGkBoBFvAzisO/zQTmSsU
	0RA5OY8OGSnDBXHhEiRiAXYTTgHq99VJKBWLMgIWgQ49D/U0qVUe5/6nazA8VEQ==
X-Gm-Gg: ASbGncu0+rvAFMbToxl632p0i5k3PH6044FVO9M37xRH7KU6xCu+8cQASzEXpcPUmpb
	75fKKdxrmhvv0U0u+rA/hAW5jNqdSEiQFyA6Gbh20pv57Evbi4dy4zIUgHQ3mvDcFj/QNeN61dc
	808IK96l5RRZQ1vQFozrrv/xC36Tlkm/N/GOaj+jT2xmb6CVuZ4lymvxAshD9EKxe34k8SsQYPk
	fm/3negjXup0uN9DIaQpVFLH+ykiYhSjZZ6IyXi4fakmoxAgQsMUCg3SRTXMUG4HCNOKhmSM1Dx
	R48reQb7UEuTJ0Vv1hJO3CwJLH4EHng=
X-Received: by 2002:a05:6a20:7d86:b0:243:b92d:72c1 with SMTP id adf61e73a8af0-25cdefc7abbmr21753646637.0.1757917214123;
        Sun, 14 Sep 2025 23:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErivlYOqYNMD1uzOOLvIYOeSFyGjheTCp4Vv8Fmhsfn/ts4DA9nnO0VA6qrA0q8hxFLJc/yg==
X-Received: by 2002:a05:6a20:7d86:b0:243:b92d:72c1 with SMTP id adf61e73a8af0-25cdefc7abbmr21753609637.0.1757917213616;
        Sun, 14 Sep 2025 23:20:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b169f2edsm7546506a12.19.2025.09.14.23.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:20:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:17:51 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, fuqiang wang <fuqiang.wang@easystack.cn>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
Message-ID: <x33mpzp6bhnx2awnszjymuyfhgmtvq5hhfs6aoyvuoo6opsbqr@tkegmqv3lucp>
References: <20250904093855.1180154-2-coxu@redhat.com>
 <202509090415.cOytgte4-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202509090415.cOytgte4-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x24y2eJusl7aRQzqnfKEkkChQAgY4PUb5DoBByv5b6U_1757917214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_232021_380985_2F5DC8E6 
X-CRM114-Status: GOOD (  13.09  )
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

On Tue, Sep 09, 2025 at 05:25:17AM +0800, kernel test robot wrote:
>Hi Coiby,

Hi,

>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on b320789d6883cc00ac78ce83bccbfe7ed58afcf0]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash-Add-KUnit-tests-for-crash_exclude_mem_range/20250904-174105
>base:   b320789d6883cc00ac78ce83bccbfe7ed58afcf0
>patch link:    https://lore.kernel.org/r/20250904093855.1180154-2-coxu%40redhat.com
>patch subject: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
>config: x86_64-randconfig-073-20250908 (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/config)
>compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202509090415.cOytgte4-lkp@intel.com/
>
>All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "crash_exclude_mem_range" [kernel/crash_core_test.ko] undefined!

Thanks for reporting this problem. This issue has already been fixed by
Andrew [1][2] earlier.

This issue happens because the KUnit tests can be built and run as a
kernel module. 

[1] https://lore.kernel.org/mm-commits/20250905031921.E0A26C4CEF0@smtp.kernel.org/
[2] https://lore.kernel.org/mm-commits/20250914001748.77104C4CEEB@smtp.kernel.org/

>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>

-- 
Best regards,
Coiby


