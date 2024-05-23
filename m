Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14475C25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZmo6DTPhXbDOuS3nfFyNLm5zfVBfGk7wF25mIErcL0=; b=WMOQaHbQP1R/Kl4WJAqc2u72Df
	4SV/4XzxNM/h5YSy5QlwRFbO+2fkx7zokV8f3rTMd/CqM8B24hA2sXGfQQT48fL9Dy0gLEbJZ3cD0
	JVD5RK4qnCg8Xhfy/ma4yWQPgtE7zPEgp5x7oFaflxzF10StM9hcozQmwgOCet1BZq6SXUvmnhcD0
	GDmBChR8x6Hwg+9sX4L0AqMGBiGBkoDbzUacTvJvCT3Ug+O1DDIp/wzaCgZquUcKb1rdVUUhv/zZC
	MNjXD9Ugcud7fz6b5Pm75rv+w8nCD0P0LwJnWgllIejdlOpfqV4OA7vZoiwxV0e3dYg+SQ1rtplym
	F6cslOsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA16v-00000005778-1iAm;
	Thu, 23 May 2024 05:35:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA16q-0000000576L-467R
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716442523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
	b=QCFfD3DPjUPsyToJngNmVi10pJwym+ZjfaydE7aVIG9hclLArlBZeAqeFZRqqr5bic7GvN
	ohCJzigkOtxJli4vPI+O2YTKbbx0RKrBCEq+XMsTnOBsV6h2oUw8s9ge8wQFEax3DXs4wq
	lcMRwi97Ilcl8+54W9IVCbe33wHyA98=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-LS9phG3XOtq5r4mnIY4srw-1; Thu, 23 May 2024 01:35:21 -0400
X-MC-Unique: LS9phG3XOtq5r4mnIY4srw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f1190504b8so1062870a34.1
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716442519; x=1717047319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
        b=A5xxLDZK7ge/sjSbEtNh2/PcqkZf3y/dWt9VIPA8B6PxS2fp5gmCahEzQtVqOJ0EGN
         xQxRzlX89y4CCil+m0t7nZm0LiRav03lG8q20/S9eZjgPxXYGBpSr6mnsnuJjGaortjz
         KZEL8EbVoZ0rVM/bvsMAwoyKin9S6jQAXbttHfIJcF2ypOJes5d8s88WsnK6MhgA9rmx
         rQKYjmX2JzVbbON14Bzi1fXgJpvYaVJ2E5fk5QCZbpknNsEcEngJuFhxyEOQXoY5HLmT
         TioSpu9DAS9yeqcfi70EYqAesMeOrRDRJeunV2O3ZafRvh1b5FLKS9n20iM3FOX557Ab
         Tmcw==
X-Gm-Message-State: AOJu0YzI5J++BfOQrsbZ7Kqnu0uYBN3r/KRz9Fdv78zNCnspxcvvzJTI
	sDdr8uJafaXsFVTgFTdj4705sXnyLiHRQpaRHD4ZQCuC6J55Heik1EVP9WIWI2vMpwFqWJhBf1F
	QHELwWkiqAoQ8Z/APbtK16/G4MgZXlICcqc2CgDTDrfv00VuTMo4AtDQS1g==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851748b6e.0.1716442517757;
        Wed, 22 May 2024 22:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9TCM4OePsLNJcyJGxLImpn1NPmzuyatA+WiPDO4CMkcIyNbE/3eCPkgw29C+PBMkQ6fM4w==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851705b6e.0.1716442516284;
        Wed, 22 May 2024 22:35:16 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm23300983b3a.186.2024.05.22.22.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:35:15 -0700 (PDT)
Date: Thu, 23 May 2024 13:34:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <xnsvk5wlfuxomr3aayz6essyzgofux5orj366cizh5525ygbbx@tpdunjmf53m7>
References: <20240425100434.198925-3-coxu@redhat.com>
 <202404262003.qsWvGwZU-lkp@intel.com>
 <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_223525_118768_B302768F 
X-CRM114-Status: GOOD (  17.64  )
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

On Tue, May 21, 2024 at 11:20:35AM +0800, Baoquan He wrote:
>On 04/26/24 at 09:10pm, kernel test robot wrote:
>> Hi Coiby,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v6.9-rc5 next-20240426]
>> [cannot apply to tip/x86/core]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
>> base:   linus/master
>> patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
>> patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
>> config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
>> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)
>
>
>Please respond to the lkp report in time whether it's a problem or not,
>otherwise the link will be unavailable.

Thanks for the reminder! I've fixed the reported problem in v4.

>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>> >> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?

Yes, symbol 'keys_header' should be static! Thanks for the report!

>>
>> vim +/keys_header +31 kernel/crash_dump_dm_crypt.c
>>
>>     27	
>>     28	struct keys_header {
>>     29		unsigned int key_count;
>>     30		struct dm_crypt_key keys[] __counted_by(key_count);
>>   > 31	} *keys_header;
>>     32	
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
