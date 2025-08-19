Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868DACA0EFB
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9SydW5uDyMxt+461cvb6vXKm2D0LcZRub0lHp9a7wk0=; b=drVkO0AKr5T3MqH9MR7Wtdbth/
	Se8X8N6E/T2FpzGvGnTg796beSLI2dOp3DH63a0UJmwtlaPdVg8cjlm7FZ9lKFrBGCUzwdbp8tQ7g
	QYwH0gaDk+1d+ZFWP2hI3EmsMlF8lulb2IJ1V6xPekTmBfWaabBzZpKubJyyIP6yWWLQszvqtyUd+
	ll25GPrNw4CYzbIglJFW+FOs+Ff2vhf4/E9/yaFPqAukT69M6rAtaYl1xKVshEBuHhHz087pOenV2
	dUpTM+C8f0aK2zCMm0Ec9FWt78qFF5XzlMWmUjfpqoNqiTt95x4y9QdK0btJ9UCJR+xMQ9iXYKPYn
	ZFkp4d9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTAa-0000000BZ7Z-36Oe;
	Tue, 19 Aug 2025 20:43:00 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRUE-0000000BLka-2noM;
	Tue, 19 Aug 2025 18:55:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755629710; x=1787165710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0364bt9jMRC3C6+N0XTj3sLdDMekTNts+hQ0L3+ZhA=;
  b=N/wh35VFgxdhr6vC25Ta76dv1DNN3ihy4FSdCsT7Hwxa031Gwr08OQrY
   lnvl62TunSf3AWv5Av2nvSJtgifOFgJec1/Io/gFop0+hrXpWk/YhPiHx
   9BPsoZcQmvZjjkzTUw6Y05oWuEl9T7oAsu6HZkN3qP5esKegLUD1cRP7j
   /Y7ItgQZeA2oxtN8JYJn44OiqB28t9kCOBIR+EuvMPhMyK4lNt6lV2CFE
   Yucp9yjEJSOXAc/oCHW5MKSKR+1pXqOZ4wjFcdyAZ1TLDH/EuOhI3Ke2Y
   1ZYATbtUPiz+LK9x17bRjXCGgSZoOmIq8AP7U7YtyosXiZ2el0nT6k4pT
   w==;
X-CSE-ConnectionGUID: hAakasCwSu+3zcYMhxaZdQ==
X-CSE-MsgGUID: tXlpd2C0QUy0NKLaRyIOHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83313116"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83313116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:55:10 -0700
X-CSE-ConnectionGUID: 0/ig0LXNStKG9JH+moRfMg==
X-CSE-MsgGUID: fmte1CfuQNaazIakoZsu7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198785908"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2025 11:55:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoRU5-000HIT-06;
	Tue, 19 Aug 2025 18:55:01 +0000
Date: Wed, 20 Aug 2025 02:54:38 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Message-ID: <202508200238.hckz21nw-lkp@intel.com>
References: <20250819012428.6217-11-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012428.6217-11-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_115510_719455_4B5CBAC8 
X-CRM114-Status: UNSURE (   8.42  )
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

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250819-093420
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250819012428.6217-11-piliu%40redhat.com
patch subject: [PATCHv5 10/12] arm64/kexec: Add PE image format support
config: arm64-kismet-CONFIG_KEXEC_PE_IMAGE-CONFIG_ARCH_SELECTS_KEXEC_FILE-0-0 (https://download.01.org/0day-ci/archive/20250820/202508200238.hckz21nw-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250820/202508200238.hckz21nw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200238.hckz21nw-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE when selected by ARCH_SELECTS_KEXEC_FILE
   WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE
     Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=n] && BPF_SYSCALL [=y]
     Selected by [y]:
     - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

