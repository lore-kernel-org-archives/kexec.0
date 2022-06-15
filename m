Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EEC43334
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Apk2joC91gANropMDJteWGHAP1wj6GYuGG2j0Su9w3c=; b=Yimt00/lVcLGj3
	puGsQiynF0f3iazhLt0YW40mL8+6ViacTwgepbROwMj5lkZ2s0Khj/PvMXnzBnIWsVfJpYxTiIoA8
	tnsk1Irl34J0HVM3bgftDjy/1JhUeSZphEi4f+lBnSEr3sf85TgzGcJVX9ld9/UR3foHofHf1oGma
	hl0Eti7hc+LuuYCjJERTqjOOqGxvGOrvdKruzUW0OKCtH8gqKa8+bAl7WH+fWRicGvS3UTyXmlx4a
	ul3iZ0BEqe8Xa9iBxPfWOQ5gxaAPDkEWiA88VSlvnRnM2QYbZph1Z/mUvfagwG8lPTCDg4Jlk8hcd
	fVDqbKYBVUyVzPBpSvTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1PYU-00DXqK-Ti; Wed, 15 Jun 2022 09:43:18 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1PYS-00DXo6-Le
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 09:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655286196; x=1686822196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gzz1iRzP8BZUucFTdSJ/RhCje5/r/u/CNl2OzKbkMoM=;
  b=WJBzEZHDdxoTDEmVTCWKPiRrSaD5ZrBdlGh+i19zTWdo22BIMHeSvacl
   cC2JcgGtHLOgtj5RPARLQytjmoS7VtEosTB8ch2VTTxfdgcQPjBjvDfyn
   AXAO17mBhLCq/HP+rQM+fCKLHO+iHePIf8eFDad8HE1S7/mMxWQA+2dFZ
   RjGwShWrRt13P/MDlroOL2+4nkYRp3tHudgay4Saf57dNOBxyg9Ltf6Tx
   H6d/RA9oBYzTCBcD5IQ/9qO08yCpjswA/Esuu0LUgKBwbK/ESfa2a2s7p
   icJLUPxVQY8LOWr9d50H+szT7N74aeA0na1PZ3so7sl2N1XgMW4B1+5Yy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342862191"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342862191"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="589018691"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2022 02:43:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o1PYJ-000Mjj-TY;
	Wed, 15 Jun 2022 09:43:07 +0000
Date: Wed, 15 Jun 2022 17:42:19 +0800
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
Message-ID: <202206151737.t3TxlR7I-lkp@intel.com>
References: <20220614161258.1741427-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220614161258.1741427-3-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_024316_792354_192F14A2 
X-CRM114-Status: GOOD (  11.31  )
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
[also build test ERROR on linus/master v5.19-rc2 next-20220615]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: x86_64-randconfig-m001-20220613 (https://download.01.org/0day-ci/archive/20220615/202206151737.t3TxlR7I-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
        git checkout c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/kexec_file.o: in function `kimage_file_alloc_init':
>> kexec_file.c:(.text+0x880): undefined reference to `tpm_add_kexec_buffer'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
