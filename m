Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D21EC25B77
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 03:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9MhE6Shuv6D7FoD+3L+t6Cj4XUO8G0rkW/G9y0B94AQ=; b=CIdkkgQwwp7oDQ
	sKLJtnyv7YzXz+IDErwuSbBK3Q3N6wFBV57MQyV4fJqmxNP4yeCKwRutgZCroYAiGcmNwdk5Zlb3l
	H8h6LuTWfLcLEBjrFR25M7C30b2fViAUth8sC+d7jwCzSF1Rwurmw8QoOh3kw56hL9otru7E3Q/FQ
	LjCHlLBAoiqyK5UREIoYwX45b817Pdk8NAJ/IjK/YGRccJcEtdSG4V8/8hiQWt2PI5WdWQ0uVoW8Y
	oQWi+Goek0nwoO7dxP5qEcqqbkby9QMM1QnQcevKKA3lcrn7U+6Gn0Od4LtnLL6RuY3mu5eTYu9Pk
	hIpkv6y0N2Rs4Jl/2RBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9G3Z-0000000GB9p-0or8;
	Tue, 21 May 2024 03:20:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9G3W-0000000GB7d-0vL8
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 03:20:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQBu6zkfNaoqqNc//ysbuuuADju5TmrSNilJ4cHGKE=;
	b=UBkKs+USMkX+NpcEYrm/aDN7ElqbII6EPvElVPWTmJcMtWi1fX/S9s5d/SBravWzsFMeEZ
	HHuJdisyLy/vOPYHyMXiSPWaVJNK6Ic8bGFLULVpA40PVLUqk2Tyw4wdqziFLBBPXewC6q
	zh+xkWZq2z7CkoxHXz3OzbkYjQpL2Js=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-maRvBiRFMj-o6900q3ZQgg-1; Mon,
 20 May 2024 23:20:43 -0400
X-MC-Unique: maRvBiRFMj-o6900q3ZQgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D3D31C05137;
	Tue, 21 May 2024 03:20:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1435B7412;
	Tue, 21 May 2024 03:20:41 +0000 (UTC)
Date: Tue, 21 May 2024 11:20:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kernel test robot <lkp@intel.com>, kexec@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
References: <20240425100434.198925-3-coxu@redhat.com>
 <202404262003.qsWvGwZU-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202404262003.qsWvGwZU-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_202050_379336_53E80269 
X-CRM114-Status: GOOD (  17.25  )
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

On 04/26/24 at 09:10pm, kernel test robot wrote:
> Hi Coiby,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.9-rc5 next-20240426]
> [cannot apply to tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
> patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
> config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)


Please respond to the lkp report in time whether it's a problem or not,
otherwise the link will be unavailable.

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?
> 
> vim +/keys_header +31 kernel/crash_dump_dm_crypt.c
> 
>     27	
>     28	struct keys_header {
>     29		unsigned int key_count;
>     30		struct dm_crypt_key keys[] __counted_by(key_count);
>   > 31	} *keys_header;
>     32	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
