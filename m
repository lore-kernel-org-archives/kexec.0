Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61E2C77B75
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yEWl2fSJl9WALFEMA/TmhRK4Sk8ZqSC1i6uXUAO9oQ4=; b=uhxQgZONDn8ZqC
	h4dY0Zeyl1V9MWsSR3D5N11D2X4H0iMf8pK9jMUotTvo35/6ocelT2564iEOLrbeAUM/og2aIqQJ+
	J5WX5bCwzzgZoVNnD30Ne4MmsfKX/z/NKRNZANSO0rpA/PqkYDK03Dk4xqdMDRCFJk+ruX3NU9HoB
	ajYbDN5bWsUaynwKr2RNENiRltaWa5uoG8qgqUCNdgL95kUeCAh1h6ddPW6KY5bUCstpd1L2BPTcY
	jJLt6T/QT1J7cMJZ2wAh06qD9pjVSf05G2GCWr2Px9PuB3G/th6U2EJi80Jm9udqGl9xO6Gnz8Y0B
	W/OSYy6zWcy+XrRTqBJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1popT5-002zHE-2d;
	Tue, 18 Apr 2023 17:50:15 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1popT3-002zFp-0x
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 17:50:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840213; x=1713376213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7EmeuTp2AWwh1GqSAAygCLfWauOKIDuUnAJOtFCpvdI=;
  b=On+aQVPx2yPNggQ7+rHeOBwfMivh2pKmaiazrduOE7GCypIMSCLiMUkj
   Vz5Vm7dBl/Nw7tOagWcRgzTANgUyOe+JC9NUlOx12jEjUsIdWHkR8h44i
   D5vrN+ZlSw8cuP2ryh7Sh1700cLJU1yNOotuBYg07DU5okISC/43hrRYC
   BF1WPhBEcxL2Vt+h/MQJUSlVuGoINL3UVo8S18P1GImyswscJokkSZoew
   ZD8ghiKDneKYd+7Rp8bWyJJJUVkN0v5YDR39/kbANoK4oXqqQuxC5k/sz
   DLeL7vxx3Yzq511+9MqkqFz4N2U6jebTohSAq9KphHv+X1ogOIcbHLjJ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334051388"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="334051388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937337180"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="937337180"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2023 10:50:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1popSp-000dpl-1r;
	Tue, 18 Apr 2023 17:49:59 +0000
Date: Wed, 19 Apr 2023 01:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, nayna@linux.ibm.com, nasastry@in.ibm.com,
	mpe@ellerman.id.au, Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202304190146.FrlhoboB-lkp@intel.com>
References: <20230418134409.177485-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-5-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_105013_378172_E06EF3D2 
X-CRM114-Status: GOOD (  13.56  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6a8f57ae2eb07ab39a6f0ccad60c760743051026]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
base:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
patch link:    https://lore.kernel.org/r/20230418134409.177485-5-stefanb%40linux.ibm.com
patch subject: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230419/202304190146.FrlhoboB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/16a833d47b9aca53a1b099dea4066b76b7f14ee1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/drivers-of-kexec-ima-Support-32-bit-platforms/20230418-214600
        git checkout 16a833d47b9aca53a1b099dea4066b76b7f14ee1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/input/mouse/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190146.FrlhoboB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:36,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/input/mouse/synaptics.c:30:
>> include/linux/of.h:1664:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
    1664 | static inline void tpm_add_kexec_buffer(struct kimage *image) { }
         |                                                ^~~~~~
   drivers/input/mouse/synaptics.c:164:27: warning: 'smbus_pnp_ids' defined but not used [-Wunused-const-variable=]
     164 | static const char * const smbus_pnp_ids[] = {
         |                           ^~~~~~~~~~~~~


vim +1664 include/linux/of.h

  1660	
  1661	#if defined(CONFIG_KEXEC_FILE) && defined(CONFIG_OF_FLATTREE)
  1662	void tpm_add_kexec_buffer(struct kimage *image);
  1663	#else
> 1664	static inline void tpm_add_kexec_buffer(struct kimage *image) { }
  1665	#endif
  1666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
