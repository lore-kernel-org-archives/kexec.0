Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48777C43334
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=50q2+yoA1d7wBsztQOWZA5aCgtDAltFwlS9aKZ9CfXY=; b=WvSpIdGJhLON4X
	iTbT1f1a5rBe6cUpRBKd7NnOq8+4DbigVYqSSGNdOpkvIdMGcPluimpEcZt5H30tSw76H02X2Q+Fn
	qudoCrXccyZiANoBSg927EW6rAC2oLd+Mtk4vZdf8ns1viL7XKQw7P51fekTXIhrMtTBsydfdns3f
	d33jYXBPebrDgumWTJhR/y7ABK7jUiaZvd2OQ9sBOF3B+IjwmspJnO34CZmorxkKAp7SJxVahVBB4
	Xajow+O85gzbl7WzFxVVCdxvw0KrA6p1aA72qQVuOjq/haMz6biC2iisGkv4dcgM5TuS1ulFGHRJS
	t2xDOkBGggnRmD6uVO2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1HJJ-00Bxms-24; Wed, 15 Jun 2022 00:55:05 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1HJF-00BxlZ-Hu
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 00:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655254501; x=1686790501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcnNFG/zqM4/ixpw6inku9EczznlEWvUdxlz+0w+WCA=;
  b=HoDTxiy+mX4m2Rl+k+SCTmru4h/I9yqkl5rHYobnXl6mxFPYSx/68N9+
   CDRfdbJ97zxZW+6kHSGYHcvyYvziVTBYoKMASaPqx2Q02rn4gKvj9RpiV
   p5x++08ROTMOL+UKqGpVm1+1cPxfxRihawwugaTXqaK8MmqRS/lgCiiw7
   HY4i46esNM/MuB8KUk0JsQ5roKoHkdYvg7BgPoLdaGLoRUugbz0LCP0vr
   jNczHs64m1dpk+dBqlpZI3st1kBHjg4Ys6uXSqVklu3m5mXZVjYPonFrt
   ayp8C0O5KBK0LfC5yWyd2wLSZ8y3DUPdTyQdgNZHi72BPFuqn5/0vqf1Q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276356725"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276356725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="570696311"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 17:54:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o1HJ9-000MRP-Sx;
	Wed, 15 Jun 2022 00:54:55 +0000
Date: Wed, 15 Jun 2022 08:54:02 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kbuild-all@lists.01.org, nayna@linux.ibm.com, nasastry@in.ibm.com,
	Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree
 for kexec
Message-ID: <202206150856.h2psJLGs-lkp@intel.com>
References: <20220614161258.1741427-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220614161258.1741427-3-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_175501_654115_1DE1EBE4 
X-CRM114-Status: GOOD (  15.60  )
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
[also build test WARNING on linus/master v5.19-rc2 next-20220614]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: x86_64-randconfig-r022-20220613 (https://download.01.org/0day-ci/archive/20220615/202206150856.h2psJLGs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
        git checkout c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/of/kexec.c:306: warning: expecting prototype for tpm_free_kexec_buffer(). Prototype was for tpm_of_remove_kexec_buffer() instead


vim +306 drivers/of/kexec.c

   301	
   302	/**
   303	 * tpm_free_kexec_buffer - free memory used by the IMA buffer
   304	 */
   305	static int tpm_of_remove_kexec_buffer(void)
 > 306	{
   307		struct property *prop;
   308	
   309		prop = of_find_property(of_chosen, "linux,tpm-kexec-buffer", NULL);
   310		if (!prop)
   311			return -ENOENT;
   312	
   313		return of_remove_property(of_chosen, prop);
   314	}
   315	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
