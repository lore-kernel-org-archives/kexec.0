Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E46C4829E
	for <kexec@archiver.kernel.org>; Fri, 16 Feb 2024 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pn8vMJFSfiVRvWrsj6uqrYtN7hlaKKAYWqZlDDQIUZI=; b=3JarqHc5dziBhy
	GjQJ4p3Jm48ZedAPV4L2MZCw7qf0UyVKYMUG/ZalS01Auq80VUAwxRiLUc8feMPCtk9q/csAHueYm
	3Kc9m5cZbIVQr8J2VSW1OCC0DK+bQ/i24VVPN+5b60/o5mirHe37dAteSHiVGRLOMw8RnWvcrOpSM
	OtTIR00/SWow7jHMgXADOIVl5eeBcjdj0aVbWOio/YIMg63uYucwHfjXMSX443E4o8F5KzynNNcvB
	Y14Fdn6V+hKryYFiYrgq9Z9t2gNHTTuiA6m0/emZZ44xRhF4uHUW1wR78gdgG8lnfZVRe4/e1Z4k8
	CZI2FauHToMR7zvZvkbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ranRC-00000000mlD-1iUJ;
	Fri, 16 Feb 2024 01:54:50 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ranR9-00000000mkQ-2Sdz
	for kexec@lists.infradead.org;
	Fri, 16 Feb 2024 01:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708048487; x=1739584487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELe4LEal0dJOP+F2HGkC1aCnEIJ8KzGDyQcgMtnRmzo=;
  b=KQzMHp2/UbM9mUdiiepCvcDSuqHYf3Vbiw6c4yL8O96CFRJjAx65DFq5
   mXSTj1IRlOCaY1RB5YbkkmM1g2SlVhs9R4elb/+aO+LnzkqR5gan/h/Fg
   I4LolbZCKbtL2JUH+6IgXioQ1V24rw0JaBpo101Wv4NXoLO9jtgefUN0Q
   R/KpHwVbNInruwNLn/Y5LvKPktFw55QlrpwpN8owmfJAcS9hNMkc8Jo6N
   9jGubwdOlgpKFFi8fJXMH2vFMenPioZnyv/KboOInNycL1WvDvwFHd2Jk
   kRF9DdG8Xwwi4YAgYmWh4ElJqWrp/BH7pfxEETXKaRiPk26mVAOiRxD6H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2026574"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2026574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 17:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3793970"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Feb 2024 17:54:38 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ranQo-0000vw-1g;
	Fri, 16 Feb 2024 01:54:34 +0000
Date: Fri, 16 Feb 2024 09:53:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
Message-ID: <202402160909.BRTtBK7T-lkp@intel.com>
References: <20240214221847.2066632-15-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240214221847.2066632-15-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_175447_716817_EEAA56DB 
X-CRM114-Status: GOOD (  13.27  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.8-rc4 next-20240215]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20240215-064712
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240214221847.2066632-15-ross.philipson%40oracle.com
patch subject: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240216/202402160909.BRTtBK7T-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160909.BRTtBK7T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160909.BRTtBK7T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/slmodule.c:28:
   In file included from include/linux/slaunch.h:185:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     167 |         int mapping_size;
         |             ^
>> arch/x86/kernel/slmodule.c:352:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     352 |                         default:
         |                         ^
   arch/x86/kernel/slmodule.c:352:4: note: insert 'break;' to avoid fall-through
     352 |                         default:
         |                         ^
         |                         break; 
   2 warnings generated.


vim +352 arch/x86/kernel/slmodule.c

   313	
   314	static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
   315					       struct tcg_pcr_event2_head *event)
   316	{
   317		u16 *alg_id_field = (u16 *)((u8 *)event + sizeof(struct tcg_pcr_event2_head));
   318		struct tpm_digest *digests;
   319		u8 *dptr;
   320		u32 i, j;
   321		int ret;
   322	
   323		digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
   324				  GFP_KERNEL);
   325		if (!digests)
   326			slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
   327					  SL_ERROR_GENERIC);
   328	
   329		for (i = 0; i < tpm->nr_allocated_banks; i++)
   330			digests[i].alg_id = tpm->allocated_banks[i].alg_id;
   331	
   332		/* Early SL code ensured there was a max count of 2 digests */
   333		for (i = 0; i < event->count; i++) {
   334			dptr = (u8 *)alg_id_field + sizeof(u16);
   335	
   336			for (j = 0; j < tpm->nr_allocated_banks; j++) {
   337				if (digests[j].alg_id != *alg_id_field)
   338					continue;
   339	
   340				switch (digests[j].alg_id) {
   341				case TPM_ALG_SHA256:
   342					memcpy(&digests[j].digest[0], dptr,
   343					       SHA256_DIGEST_SIZE);
   344					alg_id_field = (u16 *)((u8 *)alg_id_field +
   345						SHA256_DIGEST_SIZE + sizeof(u16));
   346					break;
   347				case TPM_ALG_SHA1:
   348					memcpy(&digests[j].digest[0], dptr,
   349					       SHA1_DIGEST_SIZE);
   350					alg_id_field = (u16 *)((u8 *)alg_id_field +
   351						SHA1_DIGEST_SIZE + sizeof(u16));
 > 352				default:
   353					break;
   354				}
   355			}
   356		}
   357	
   358		ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
   359		if (ret) {
   360			pr_err("Error extending TPM20 PCR, result: %d\n", ret);
   361			slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
   362					  SL_ERROR_TPM_EXTEND);
   363		}
   364	
   365		kfree(digests);
   366	}
   367	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
