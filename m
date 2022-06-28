Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68196C43334
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tuz6wF2YQBqmpd7ObDcO1/+3PCuwGTO+eLz7sr8RlSU=; b=oCeFV1QVuZ8/9t
	HVmy8aTQtQUQhW9suAkQ6g+7AdvsAA4rl24p/NPcliVWOAbIHSQrLDarvJHE2exglrS1ujFwwBY7w
	sGIRRX4derbg6F7bJml1fBEBtAO1H8NGc7TGI7BIIyqGGNMKO5v94kkUZ4jA+bu6WaiOjp0imSIgI
	+ofWPpm3/y6S7++n8tC6hg2p/7JReEwLVsFYF4syem5ZRyM0njH5Yux1qmeW2+fo6nYnSvwA9oIlh
	xAfNt9SkjsnOSxwxsW9mnB9sbNYfQF4K8jdI1Pgg53f+QngL8LM4HGMK/NIjUEtNWUCO5BmQoJTja
	SQNFkgYAhyYvOVCmHsgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ESz-007Hdv-Lx; Tue, 28 Jun 2022 16:53:33 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ESx-007Hco-5i
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 16:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656435211; x=1687971211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lk9i+UFDFPdV2X5SBVGrwZ4ywWGVr3wZW7Ti7xnz5Js=;
  b=G3wTIkjKK0dYP/i+wdOMvlOWyN76xQOH8cfRkGxxMFt2Xm52oy76TSHS
   YixWXbcVqZPtWPKPtqygYVoqQy3PZ1ESajbApX3zqW1BjN4iKrogOnVu3
   OeDkDffJy7wENZ1cnw0CH4jmDJMIiRB7x1nDDosq78NT3Zc//heiSlTpA
   DwJaAFZFMlhl7JgxSyvpUIbDowUWA8B60VdkTmB5atpyYQXOVz8qZW6iD
   aUvuEtG2hMo24hWed0+XQsiRfH66Cbj2QdbVbCnYfgMmpwanPcsMFfJ/2
   Soy/cH5GeCeVz8F6Jl335CYYwbphlmqwVkhhw5b5irBFiw63PsGOJETSx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281829588"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281829588"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="646993101"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 09:53:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o6ESq-000ARG-UR;
	Tue, 28 Jun 2022 16:53:24 +0000
Date: Wed, 29 Jun 2022 00:53:11 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: kbuild-all@lists.01.org, nayna@linux.ibm.com, nasastry@in.ibm.com,
	Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/3] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202206290021.AodC96Vc-lkp@intel.com>
References: <20220616154130.2052541-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-4-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_095331_270015_B491DA20 
X-CRM114-Status: GOOD (  14.68  )
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on linus/master v5.19-rc4 next-20220628]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: parisc-randconfig-r012-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290021.AodC96Vc-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
        git checkout c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/kexec.c: In function 'tpm_add_kexec_buffer':
>> drivers/of/kexec.c:371:18: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     371 |         buffer = vmalloc(size);
         |                  ^~~~~~~
         |                  kvmalloc
   drivers/of/kexec.c:371:16: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     371 |         buffer = vmalloc(size);
         |                ^
   drivers/of/kexec.c: In function 'tpm_post_kexec':
   drivers/of/kexec.c:446:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     446 |                 *(u64 *)newprop->value = (u64)phyaddr;
         |                                          ^
   cc1: some warnings being treated as errors


vim +371 drivers/of/kexec.c

   349	
   350	void tpm_add_kexec_buffer(struct kimage *image)
   351	{
   352		struct kexec_buf kbuf = { .image = image, .buf_align = 1,
   353					  .buf_min = 0, .buf_max = ULONG_MAX,
   354					  .top_down = true };
   355		struct device_node *np;
   356		void *buffer;
   357		u32 size;
   358		u64 base;
   359		int ret;
   360	
   361		if (!IS_ENABLED(CONFIG_PPC64))
   362			return;
   363	
   364		np = of_find_node_by_name(NULL, "vtpm");
   365		if (!np)
   366			return;
   367	
   368		if (of_tpm_get_sml_parameters(np, &base, &size) < 0)
   369			return;
   370	
 > 371		buffer = vmalloc(size);
   372		if (!buffer)
   373			return;
   374		memcpy(buffer, __va(base), size);
   375	
   376		kbuf.buffer = buffer;
   377		kbuf.bufsz = size;
   378		kbuf.memsz = size;
   379		ret = kexec_add_buffer(&kbuf);
   380		if (ret) {
   381			pr_err("Error passing over kexec TPM measurement log buffer: %d\n",
   382			       ret);
   383			return;
   384		}
   385	
   386		image->tpm_buffer = buffer;
   387		image->tpm_buffer_addr = kbuf.mem;
   388		image->tpm_buffer_size = size;
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
