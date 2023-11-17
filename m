Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8007DC197A0
	for <kexec@archiver.kernel.org>; Fri, 17 Nov 2023 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yQXk2YjKHP/JCPDwIyKzZvicachRfK41bDs/CNQoB9w=; b=4+NspktJascsPF
	wXllsEAjIUEyewYhktNLszUpSSzWQXSJ2ReyQ6ef9jh8D8yjZ7vGSZbKL0gou5Za5qb3krcbqvJkG
	2b321RfTBNm5QcdBLXgrVV2oc4RNWDEIyw7kPoKKlnDxqSzUDyJBpcMrZVT+pK0G+NusOvOPJF2Lk
	tHZn6JKsfwd6qpWIHeEXqNCjfXTBWW9I+gMGrcRXJL143NsClrjzDxdBR0Sxk1xol3Gdzs6SUomVg
	Qs+fYsgVlxntcYSRX3taKFNHuJ7ZlkMeNaUXcbylzXW37oVyr0BdOYZNld6/MRztX/LwIhv5MsRXC
	ZU8fuaw/wqERe1Ku1lIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3uwF-006269-0y;
	Fri, 17 Nov 2023 09:14:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3uwB-006246-20
	for kexec@lists.infradead.org;
	Fri, 17 Nov 2023 09:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700212494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THEmzVaHiZNeIcTvImwINSr7vb3xKiQAOUmNcyEPO1U=;
	b=FoAn9LnyjYNK3huaBUM1MopHpHUaxaZQZGLHgmvCykmzkP99jjKPjuoadCJaqKwoQdJfZq
	Rn1Xs9W8wFCWB/cDYkI/8POs2e5/Sqle0P4KYNHAlfZDrYr3IrfFucoWdW3gPnXMbCGA9n
	7Cgy+SmNX105kzelWmV1YXId0NdFeIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-hjMHbHTxMrW87-VsMRHqXw-1; Fri, 17 Nov 2023 04:14:51 -0500
X-MC-Unique: hjMHbHTxMrW87-VsMRHqXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69AC2185A780;
	Fri, 17 Nov 2023 09:14:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3EB92166B2A;
	Fri, 17 Nov 2023 09:14:49 +0000 (UTC)
Date: Fri, 17 Nov 2023 17:14:45 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
References: <20231114153253.241262-3-bhe@redhat.com>
 <202311160431.BXPc7NO9-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202311160431.BXPc7NO9-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_011455_860255_77C1D448 
X-CRM114-Status: UNSURE (   9.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On 11/16/23 at 05:04am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231114153253.241262-3-bhe%40redhat.com
> patch subject: [PATCH 2/7] kexec_file: print out debugging message if required
> config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/reproduce)
> 

Thanks for reporting.

I met below failure when following the steps of provided reproducer.
Could anyone help check what's wrong with that?

[root@~ linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
Compiler will be installed in /root/0day
lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/
get1: /pub/tools/llvm/files/: files/: Is a directory
Failed to download https://cdn.kernel.org/pub/tools/llvm/files/
clang crosstool install failed
Install clang compiler failed
setup_crosstool failed

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
