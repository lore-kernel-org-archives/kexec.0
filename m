Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF6C54E76
	for <kexec@archiver.kernel.org>; Fri, 17 Nov 2023 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iBT2ZBDU0+8BZD4E7Y02xKY33kL8tcYf1lzGQWzVNbM=; b=421fTNU8iwIHWt
	UuIgHeNVud6eDfVkJg3/MRY7U6fUs6Zh8rgMeyN8aLxOj4bKMIvt7FbAT7SEYu21JABpuwg7jdqxO
	QUDUJ6r8qua8M3NaPD2rZnzfMNNVTansxQfchCwok4U4tIH8lFrdZYvO9WX9xGCeSKkFF7HVPIC3n
	3ZCWVhcU761unCUp6uYumFqxvM7fClGxu3F8vJqzXBPPNmf0pfnqUax7PCSLi4Gb1VdocuZH3pzIT
	PAsB1VHfizCmcCZShpk8EKFlIdepIoPWp+ny5ph5A1P4sfPkCTrJMJVY2KdyCxNE0AI0E4SXxfZp/
	zJqX70pcEq1YIoOqwopA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3n9L-005MgI-1y;
	Fri, 17 Nov 2023 00:55:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3n9H-005Meq-33
	for kexec@lists.infradead.org;
	Fri, 17 Nov 2023 00:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700182552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LapoxfhvOL55w/2dX60cKVAQiuf12D1o1P52tBY/F0=;
	b=NBKAGKkGFYKdjttwU7VZjL3a223PgWRxSSfuHA6fxUBw657r90UXAFBiIi/BoZAg8hkpHA
	6mV+1BfYv99xicwmbi74G5NYAmtueiyp9Z03vwMrh7t1XkzunE00PtfQDIec7Qgz9POK9y
	5AzQJXWrxX1AhlXWbxVZMzh0A5BR5n0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-hlErw1ZmNAuXtPqs3bx_HQ-1; Thu,
 16 Nov 2023 19:55:49 -0500
X-MC-Unique: hlErw1ZmNAuXtPqs3bx_HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B851238149B2;
	Fri, 17 Nov 2023 00:55:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EF2591C060AE;
	Fri, 17 Nov 2023 00:55:47 +0000 (UTC)
Date: Fri, 17 Nov 2023 08:55:44 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <ZVa6EDP8EI2jWhQL@MiWiFi-R3L-srv>
References: <20231114153253.241262-5-bhe@redhat.com>
 <202311160022.QM6xJYSy-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202311160022.QM6xJYSy-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_165556_083376_866ED26F 
X-CRM114-Status: GOOD (  13.97  )
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

On 11/16/23 at 12:58am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231114153253.241262-5-bhe%40redhat.com
> patch subject: [PATCH 4/7] kexec_file, arm64: print out debugging message if required
> config: arm64-randconfig-001-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160022.QM6xJYSy-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/arm64/kernel/machine_kexec.c: In function '_kexec_image_info':
> >> arch/arm64/kernel/machine_kexec.c:35:23: warning: unused variable 'i' [-Wunused-variable]
>       35 |         unsigned long i;
>          |                       ^

Yes, this is an obvious one missed, will fix and update in new post,
thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
