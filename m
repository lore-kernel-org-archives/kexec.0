Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAFFC43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hq7eEnQib48sA7qvWqTP/A8BgQK5U/wzzhIAYhf1IW4=; b=AMBcLlsIU2n0FZ
	76tNHOCzm9FOr57IQ6REhewL23DD1gBMg4IzKSVjiLcI69oX6f0y6OIZW2yMkZc1KzNMXDdxh3YQb
	m+cWwaraVjV5us2AKdMyXLRmsd22ciobz1E7wPHhjVzTriFej4UDXhD3Q0joaFKtm0dPjDYjSe2c+
	DPDBvRlzUe3eK1b91Gg9PwgAGNIcgETTzo17JB6rp6JeY6U2723wtGU/1HUgGKhNpOjZRKh8WbdmB
	2Cj00Jj0araCTovKi39bwC6iOEk7BqQ99dxnYOBok13gH7i9KXy3x1sC9mLkXcAK3YJ/8USevMAlq
	KRIVJ/4XOxJPOEhOcTJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1w5g-0047DC-5W; Thu, 16 Jun 2022 20:27:44 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1w4I-0046JV-I7
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 20:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655411178; x=1686947178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mCBE9b7OKZue36WoDEtNzIp8Vup2V1mQ1A14xh+mBlQ=;
  b=R/HxEYtr1hGbcj60Z6+5hi/kMBUCEmw2aQKbPvL8PLI4lYh4wK7cQtD1
   adwNEwtUEie0ACvhMH/w9xn9l31dR3RB4ME1yETtve2ghazPg+JmIi4tF
   buwsBRcy2ouCST4lDbHMHdHMrClJvCI8rbACVb6JT6oRaImFHb0CrwpXL
   mPxDr7ywvzkBLdo/vdyXGK+pmMA9C2zaEx77jiqPkWwk4RpMP4AuBf2B4
   Qwt79w03JWLvCjDEZ0ia/EG/esZHv+Fnf23cQjIkSNeneyNbHNFHNaCYi
   ibyYvdHYa2m+ZZrUvG9V+DA2hYaoXMv8yow7a8rSAr2ALl0vGJWQhKdGX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278140804"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278140804"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536584728"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 13:26:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o1w4D-000OkH-IZ;
	Thu, 16 Jun 2022 20:26:13 +0000
Date: Fri, 17 Jun 2022 04:25:27 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/3] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202206170406.VbxuBICz-lkp@intel.com>
References: <20220616154130.2052541-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-4-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_132618_726712_AF2DC9B7 
X-CRM114-Status: GOOD (  14.13  )
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

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linus/master v5.19-rc2 next-20220616]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220617/202206170406.VbxuBICz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
        git checkout c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/of/kexec.c:305: warning: expecting prototype for tpm_free_kexec_buffer(). Prototype was for tpm_of_remove_kexec_buffer() instead


vim +305 drivers/of/kexec.c

   300	
   301	/**
   302	 * tpm_free_kexec_buffer - free memory used by the IMA buffer
   303	 */
   304	static int tpm_of_remove_kexec_buffer(void)
 > 305	{
   306		struct property *prop;
   307	
   308		prop = of_find_property(of_chosen, "linux,tpm-kexec-buffer", NULL);
   309		if (!prop)
   310			return -ENOENT;
   311	
   312		return of_remove_property(of_chosen, prop);
   313	}
   314	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
