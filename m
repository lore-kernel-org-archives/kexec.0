Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3711C28B2E
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFBtxCm2NNfm7x2M1GghiCKntj9sXi1mQQfDL+fSHLc=; b=s3sBn2C8dvjBNgUuajbRl46+wA
	RhjxBvWOgWU0yrsW6+Rm5W8bBRdNNDgL1x41K2f3AKgFrM8ojufz4asgCxHM+Yd9Hdl8g6qe7SaQ0
	qr21p45MgjH5V6aIxQsoC6AGXeUxPmNvY8IpnsrQLtJBSQw0nQ16xKJNycKobGudGcwfZhy3NPCFj
	c8kP1NPmEhahmZOwbHJ2i2+6NrRlwu3/Z5QxqvT8LiLYeVQAaenB6DZlKuUK/XL5JBpqeLk85h+uK
	68cc1X6Ns4AwENOdqWGLY9MZMs5rHMi7K4/Y/N6DxMLtFLP+nOrCk7u1zZrsVUEHioF3mC44MGcig
	rmtkzAug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHut-00000007sxS-0n19;
	Wed, 12 Mar 2025 08:58:19 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHup-00000007svb-3PVq
	for kexec@lists.infradead.org;
	Wed, 12 Mar 2025 08:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741769896; x=1773305896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HttexNxW0KtxV4sJ29IXJAlxzJTo/xsJm31W440ao9w=;
  b=mNvmMihDke/8GvPKfq3nqqUJ9IZZixpTo320Bkys80YD7amEmBFOgaTv
   I6WeBODtNSTfM57ElNGy35jDDd3z4mSxHFHlcUPGFXIaj1cMScaEgo8ef
   sIRdBhefh4+03e+CRxbJ3+23Om8DnGEGWRrTLPspWOF+1HpCpMj02Wxue
   eVDQgQfaq2pyHWGV0B/dPky7AcmlBso+e8v+IuR7rjdJ9243RuVV6vlyJ
   z9h9VqOE8qkKb7qM+dFZiKRsh8iHuxw49Wubit9eO9h/zDIJSLRXWqbQI
   /pY9wH/L9Uvt3+NNwvN3kit45xuEV8lWkFcCN85/JtOYA4dcpepbGcwXA
   g==;
X-CSE-ConnectionGUID: xXKC/wfRRA+dDOoNcVlkfw==
X-CSE-MsgGUID: QMe5zVr1QS++PtEij+HyeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="45618598"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="45618598"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 01:58:14 -0700
X-CSE-ConnectionGUID: UzbWyRTKQ0+krqIOMX7qPw==
X-CSE-MsgGUID: UBs0sv0gTUSLN+/Dr7g3Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121475893"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 01:58:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsHug-0008Im-0k;
	Wed, 12 Mar 2025 08:58:06 +0000
Date: Wed, 12 Mar 2025 16:57:30 +0800
From: kernel test robot <lkp@intel.com>
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com, eric.snowberg@oracle.com,
	ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
	bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
Message-ID: <202503121600.IMBKp2gC-lkp@intel.com>
References: <20250304190351.96975-5-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-5-chenste@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_015815_889695_AE1ADAEC 
X-CRM114-Status: UNSURE (   9.94  )
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

Hi steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-5-chenste%40linux.microsoft.com
patch subject: [PATCH v9 4/7] ima: kexec: define functions to copy IMA log at soft boot
config: powerpc64-randconfig-r133-20250312 (https://download.01.org/0day-ci/archive/20250312/202503121600.IMBKp2gC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250312/202503121600.IMBKp2gC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121600.IMBKp2gC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   security/integrity/ima/ima_kexec.c:107:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] version @@     got restricted __le16 [usertype] @@
   security/integrity/ima/ima_kexec.c:107:30: sparse:     expected unsigned short [addressable] [assigned] [usertype] version
   security/integrity/ima/ima_kexec.c:107:30: sparse:     got restricted __le16 [usertype]
   security/integrity/ima/ima_kexec.c:108:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [assigned] [usertype] count @@     got restricted __le64 [usertype] @@
   security/integrity/ima/ima_kexec.c:108:28: sparse:     expected unsigned long long [addressable] [assigned] [usertype] count
   security/integrity/ima/ima_kexec.c:108:28: sparse:     got restricted __le64 [usertype]
   security/integrity/ima/ima_kexec.c:109:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [assigned] [usertype] buffer_size @@     got restricted __le64 [usertype] @@
   security/integrity/ima/ima_kexec.c:109:34: sparse:     expected unsigned long long [addressable] [assigned] [usertype] buffer_size
   security/integrity/ima/ima_kexec.c:109:34: sparse:     got restricted __le64 [usertype]
>> security/integrity/ima/ima_kexec.c:209:23: sparse: sparse: symbol 'update_buffer_nb' was not declared. Should it be static?

vim +/update_buffer_nb +209 security/integrity/ima/ima_kexec.c

   208	
 > 209	struct notifier_block update_buffer_nb = {
   210		.notifier_call = ima_update_kexec_buffer,
   211		.priority = 1,
   212	};
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

