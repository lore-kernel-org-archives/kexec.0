Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945C4C48BF6
	for <kexec@archiver.kernel.org>; Sat, 17 Feb 2024 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GEfELvXewLIxizHfC+XrGSh/eIXB0TFBSlUGUML4Co8=; b=rZE+Xn/DgVjeaF
	wSltU7v/VlSUdEuCu3Iz59dhcXKHaDOpL1+SvdbnGlsg2LersIULmlv4KgMbhuUY7Xor4l1gGZjRQ
	iqY1ck0JY5HEx8/iRViqH25exntTgVe8UIlpuLo1KhVRJGnn7g+umLG9NFPvYgoosQNz2l9rKNDnq
	77qXMghzM6XJnerSwWh3ZzC5ZpIii0ZCt/b5PTYIX/a/++K/iCAX1tEk9vCBUYw8ujVuFQ0drOaRd
	2WwtNoZap76I/RE+7WzlKgRUkWkX2IMsHbi1iSORJ1aBrtrPRy4NN2CxQ10NSTuJAqJQk8yRoYMAQ
	5knAki8aCP2S6yN7jQgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbFX9-00000004qx5-3Y7e;
	Sat, 17 Feb 2024 07:54:51 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbFX7-00000004quX-0sEg
	for kexec@lists.infradead.org;
	Sat, 17 Feb 2024 07:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708156489; x=1739692489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wzz5SmshZSlav/lHAXs6G/IAqLV2Qmvclb48zyontW8=;
  b=SANhR4AtcMALD0B+vBs4lF5Kp1Ott9xO3OA4lBa+maorL1Qwp/QpeOGu
   MOpGo0ZVNoorPsJTK7WOZzjcB+rQY63cEJrQsfcI5+N5AQ+pSbH7KDJnW
   RVFJQg195kU6TIsI3g4Yh/141Y9ALMvAnC6vf5h8lvAqRNLcSec51TNaP
   17+KwiBAu/Kw8FOEXWwLNQX+gxcFyiviKqh++PCozG8bjhD/JKqTKD4zy
   0XUJTPO6W/HAsQdXxZveCFMRRuV7tNoGsFttlZQg9rbH40LunPu2mmrpU
   y0Z2a+Lubfktc6ummCqpzz71P8qS/Rih7wGXu6BIbMubaSO+g7U1uMnTS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6066338"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6066338"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 23:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4017642"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Feb 2024 23:54:31 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbFWn-0001w0-02;
	Sat, 17 Feb 2024 07:54:29 +0000
Date: Sat, 17 Feb 2024 15:53:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ross.philipson@oracle.com,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
Message-ID: <202402171536.dNnLrhB1-lkp@intel.com>
References: <20240214221847.2066632-15-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240214221847.2066632-15-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_235449_267353_23F61DCC 
X-CRM114-Status: GOOD (  11.13  )
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

Hi Ross,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.8-rc4 next-20240216]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20240215-064712
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240214221847.2066632-15-ross.philipson%40oracle.com
patch subject: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
config: x86_64-randconfig-r061-20240216 (https://download.01.org/0day-ci/archive/20240217/202402171536.dNnLrhB1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171536.dNnLrhB1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171536.dNnLrhB1-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/slmodule.c: In function 'slaunch_pcr_extend':
>> arch/x86/kernel/slmodule.c:471:14: error: implicit declaration of function 'tpm_preferred_locality' [-Werror=implicit-function-declaration]
     471 |         if (!tpm_preferred_locality(tpm, 2))
         |              ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/tpm_preferred_locality +471 arch/x86/kernel/slmodule.c

   461	
   462	static void slaunch_pcr_extend(void __iomem *txt)
   463	{
   464		struct tpm_chip *tpm;
   465	
   466		tpm = tpm_default_chip();
   467		if (!tpm)
   468			slaunch_txt_reset(txt, "Could not get default TPM chip\n",
   469					  SL_ERROR_TPM_INIT);
   470	
 > 471		if (!tpm_preferred_locality(tpm, 2))
   472			slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
   473					  SL_ERROR_TPM_INIT);
   474	
   475		if (evtlog20)
   476			slaunch_tpm20_extend(tpm, txt);
   477		else
   478			slaunch_tpm12_extend(tpm, txt);
   479	
   480		tpm_preferred_locality(tpm, 0);
   481	}
   482	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
