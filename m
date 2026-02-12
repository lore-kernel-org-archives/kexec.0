Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5E3EB2719
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=; b=zgt72/cG1mHI2zMFW9l1XC88tf
	il5kJwA5i1o+/FEcvFz5JX1LN8QJnwUgG8GcyLvPownJc6M1vsMuqMqzkfKJ+OqWEn42pxglQklZo
	6dMJtQt2UA105vg6YPlVOj2mz6G6LF/WOlLf/jYMduGPQtlAx6RBHR3g8rXnrFLAEsodrCzVlMceT
	M3yG1bzQoyFLPBaKoiRJtMS8HFk6h0pPrjs1jlkl8Rp6ws5pkpVsNVPDhsA+GubF716UyJ3ot5T2p
	168cyG40ZQgxx9vXgoMw3W/PPqMTphv7hVfO7nTLWDlck/kcnPVlbT8Y46xyiguSRaUli0ZfadPTN
	WmdQXZiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMOX-00000001JMa-08Dk;
	Thu, 12 Feb 2026 02:25:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMOU-00000001JLr-3gjr
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 02:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770863125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
	b=K5DoyXpPysvfVRTPxJtxGLMC8QdvDKiI1awH0JfD+qpxgQI4WUKX04/Y/GpIAP8y+gfu9Z
	6eax6tD1013cF+NsClhFI9taXsZJzAGD0dBLW3Ad3Z3Cxn2sG4oB4NMTVDia5xpLG0dGei
	a/cUcNCrQeNYIcYCLDHkaQd6AvSXjmM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-pUCe5iVpOdiy2auq7lFnfA-1; Wed, 11 Feb 2026 21:25:24 -0500
X-MC-Unique: pUCe5iVpOdiy2auq7lFnfA-1
X-Mimecast-MFC-AGG-ID: pUCe5iVpOdiy2auq7lFnfA_1770863122
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so2596258b3a.1
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 18:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770863122; x=1771467922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW+Mgpaq6SwF9hkVhCNywA9aCMpLFaTHrW15uFZTbFY=;
        b=psgeQgEiiJkglpPRhnBVuiacuojxUgnJzDw3JmfKBTLPMjJmWAMgDvyE3+yVOvj2AQ
         Hk3hgd3frW5r02/RX43ZPWjxdncX0YEdlRql6pz77sQikBJgCpGpZI/oseZNw+31khpA
         O7PwLt8ptaaDV+XV7cV3QUfrd0H6DWyBxcDPeP0T+wLVROKtOkF8LMp+tgi85tzHTSOu
         obR4l3CyKm2ZWSo4twGZ7r5vujE+oVuVZBqCKW8gUJLKa0gg/FyCBUXYwn4IS8PojZO5
         Ytts9j4pH8Z3gEDZfqAiUbVsS93Z/zR3eeIHyQwNVXCujDxacoqHdgq06/8lWAkTufdh
         0mEA==
X-Gm-Message-State: AOJu0Yyi2SRaxs2J5hddWhZ94ncd3HjQGCmS+13vPuty640IgPC+9OE8
	rRBUnamKL9N9KGjP8JexlY7NiaXcaYyVuiAIGTQnDUKtn7Gf12hDXFKZUAXkBplBvBNB3k/OZbp
	A+wMW5zwMb1laPxFsIx/T/kOrgnPFcDohV6UDKMJpt+5GcJ2BfrKZXAc3GbtxfA==
X-Gm-Gg: AZuq6aLdKP29PQ6yeeb3TyHP1wUeixo+jd2B10tcoRriUAjXyFC3UUoN9J7U2Ou93Ho
	+Ck/DRWyWgjko4OyILJq0R3rgDMWM2ZeOilB77vx/1C7h+tv1xInFwuOKLlukhnKfS2j6gQSz4M
	nLOn9pLME7xjJb+hRihDl+at6WZTU5wVziMqTtSsyYZfBt4ZuUJnLZT/TyNsgxKz0pGDOKA9PFb
	hZTBDbiLvk4M4kiPIuW0cJBJgnfwJ8wCOvOgWth2qLIDHqn8TTLapTZ39G1p4ULZvuOQ+JHJm7r
	qKklhMsT/ZneRu5hr3m6hoJQGQT/In5C3DVD301Ib0yXPT9NiyxedUVz2M975SEQKXw21bbcMzJ
	x+Oh8PLFxJWvE
X-Received: by 2002:a05:6a00:1d84:b0:824:9451:c1ee with SMTP id d2e1a72fcca58-824b3068659mr493716b3a.55.1770863121978;
        Wed, 11 Feb 2026 18:25:21 -0800 (PST)
X-Received: by 2002:a05:6a00:1d84:b0:824:9451:c1ee with SMTP id d2e1a72fcca58-824b3068659mr493667b3a.55.1770863121385;
        Wed, 11 Feb 2026 18:25:21 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e8198a6sm3984873b3a.50.2026.02.11.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 18:25:20 -0800 (PST)
Date: Thu, 12 Feb 2026 10:22:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <aY05DpHN6QL8xQQ4@Rk>
References: <20260211082401.2407853-3-coxu@redhat.com>
 <202602120648.RgQALnnI-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202602120648.RgQALnnI-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CJEkj3a1gbME6q-pfiN50tnav3BCwv-JElWN8jBOlrE_1770863122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_182526_984418_6C35F97F 
X-CRM114-Status: GOOD (  14.19  )
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

On Thu, Feb 12, 2026 at 06:35:52AM +0800, kernel test robot wrote:
>Hi Coiby,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on 2619c62b7ef2f463bcbbb34af122689c09855c23]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash_dump-dm-crypt-Don-t-print-in-arch-specific-code/20260211-162729
>base:   2619c62b7ef2f463bcbbb34af122689c09855c23
>patch link:    https://lore.kernel.org/r/20260211082401.2407853-3-coxu%40redhat.com
>patch subject: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
>config: powerpc64-randconfig-r111-20260212 (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/config)
>compiler: powerpc64-linux-gcc (GCC) 11.5.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
>>> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
>      82 |                 ret = crash_load_dm_crypt_keys(image);
>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors

Thanks for reporting this issue. I'll fix this issue in new patch set.

-- 
Best regards,
Coiby


