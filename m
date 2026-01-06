Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C5BC47BC5
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJIbYSfSK52lKhhoL+Hqgsx6BnLJaDz2mdyD5+Wu3vQ=; b=KRZBV9HAw0WI5bk7CJCV0wHMzD
	II7Aex1H8VyE2OUIbRzIqlNKwKu9hMb0sjDPv+duZoflthPIytCJa1SBa2QTkjcCvtPN5uOnlIAFs
	g1sje921b1ztJxcJMeIUUsN/GUIXwEkMFC2pUfL56xTDHJ4FossM/DuzHfsD5fNz/ThhAF8F/l5Uc
	aXGx0CVgWrpSULrr2jE/SAzkq+9CeETqkm1dS2potgvm6DcnSiQy/KJsH2Vt7LPDYvcPP9nbIyy2s
	2KlK/lRlWSXfEIRH3VW/5pkdXUWjb+nw6oCS/abUVtDK1hqkgiWJCmVFJ6f2kDPa2kqFfdVkN2ETy
	PP7SpPbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1ps-0000000CYcE-3JCJ;
	Tue, 06 Jan 2026 07:50:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1pj-0000000CYaE-3SSz
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 07:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767685826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJIbYSfSK52lKhhoL+Hqgsx6BnLJaDz2mdyD5+Wu3vQ=;
	b=G5JEf0SgRbu8rI2bCfoy2aq3SERxGClJa0PeeGZN6yCFQhZAubc+Wt/vg9GTEzNeAtDOm0
	H9oXXbOlrkQKLIPeJDE3r/hQnZ3ELZiTMAMYcwzZKAcjhKupbdyW9dWVJtdlXB/VRvaZGu
	p1OQOFtJ56MMjsyFJdsRVCgIUkudpt0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-QhpOGBi6PE2rkIH8KGIk3A-1; Tue, 06 Jan 2026 02:50:23 -0500
X-MC-Unique: QhpOGBi6PE2rkIH8KGIk3A-1
X-Mimecast-MFC-AGG-ID: QhpOGBi6PE2rkIH8KGIk3A_1767685822
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f21951c317so677281b3a.2
        for <kexec@lists.infradead.org>; Mon, 05 Jan 2026 23:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767685822; x=1768290622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJIbYSfSK52lKhhoL+Hqgsx6BnLJaDz2mdyD5+Wu3vQ=;
        b=g4F8R1O3cTTM8EBa8RrbbhkAXIim55oTx+BQVibY3fahicO5jAqgLkuZqCsaBzDlhN
         qDQjZMDX9NqM1nINdkhNfHFshgqLHZ1hBsRtgZMl9m+WHywxsqZB00zGKiwelrdb466J
         E891wSsuc2V4dvUikB5zEuh3nu+HanCQeZz91fbmWOVwJRBouwOXxq9O07CgsVbrXpNe
         i3Kx6TYwx9NvaXA2BhdzKlJNUy3amR9CqLxZqULrWtj+uu7J1u7011JgShsezbpwEBDU
         PRl/I8xH4oD0s+knX4H1VVdgZVUQKd085f/+O4Nw9KoBkDSzu33SN/CgexxEOjd+w+0F
         3xug==
X-Gm-Message-State: AOJu0Yx0WdJ12cVL5sg1K3rmsZaO4J+bRGJJz17/UZVl5whPzTAVoh1P
	WeVkOBup/C/vGlIbkWYhRTG5ZF1x9f59u0GbWIDE8cx14/XzS3DwecY9gIsYegtaB70pvM+V9nq
	5YDeNxxfwl3htvVdjKGNKA35k6FXMN2dKABCMxR9tsgFlwasH7/+7UVoi6LXF8g==
X-Gm-Gg: AY/fxX7Q7RQs3ebGkxP3scNyDelqPQ7uBUI0SB8mNpEqXa8x4JO3dWIG+2dHiFIBa6J
	XJdTeLVn27UNX6IMfhRluvNKrFAyKD99XTFRFJBTEA501nYg/wNkA0Mx5A33PzE/CxqOwAz868G
	3BmVwKl1Yn0NLrlMng2M05vUtkfEmZER/A5OI6MJy1AoHnXCUK/II0jfeKbbIe4RqAykUSGm0EC
	KvNrLJtuIOonvd+FiDgn1+l1FSUIiFqyLE0KnZDjn3Q5q4wpvJ2GmupuUx8s1LksjV1Lmg/94nB
	21TUQOrbQTiOLcrxtvt9i5Ko7Qb1hXIqYbcgIfKiT5/V+mxCUvmDhVzEREp+CdWuEx8MZc0uyF2
	A
X-Received: by 2002:a05:6a00:1d25:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-81882ddd7c3mr1845204b3a.63.1767685821898;
        Mon, 05 Jan 2026 23:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDKsDXMRpPACVaN2GdRV6l0Fy6KDBpzSzhtqSYzxT7W76UAFruKAKNIbDHoNo+0oE4mtloEg==
X-Received: by 2002:a05:6a00:1d25:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-81882ddd7c3mr1845179b3a.63.1767685821335;
        Mon, 05 Jan 2026 23:50:21 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb0ddf97sm1263404b3a.19.2026.01.05.23.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:50:20 -0800 (PST)
Date: Tue, 6 Jan 2026 15:46:57 +0800
From: Coiby Xu <coxu@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Thomas Staudt <tstaudt@de.ibm.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aVy9qfeSDZyKybIC@Rk>
References: <20251226140636.1378505-1-coxu@redhat.com>
 <202512272218.ghBaSjzO-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202512272218.ghBaSjzO-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DDF4MbcKLddItxdz4o3e7-YTNOrh9uqGRxAjHzQbAuo_1767685822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_235032_069924_2072B0A8 
X-CRM114-Status: GOOD (  12.04  )
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

On Sat, Dec 27, 2025 at 10:35:11PM +0800, kernel test robot wrote:
>Hi Coiby,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/powerpc-kdump-pass-dm-crypt-keys-to-kdump-kernel/20251226-220726
>base:   ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
>patch link:    https://lore.kernel.org/r/20251226140636.1378505-1-coxu%40redhat.com
>patch subject: [PATCH] powerpc/kdump: pass dm-crypt keys to kdump kernel
>config: powerpc64-randconfig-001-20251227 (https://download.01.org/0day-ci/archive/20251227/202512272218.ghBaSjzO-lkp@intel.com/config)
>compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251227/202512272218.ghBaSjzO-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202512272218.ghBaSjzO-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>>> arch/powerpc/kexec/elf_64.c:95:9: error: call to undeclared function 'crash_load_dm_crypt_keys'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      95 |                 ret = crash_load_dm_crypt_keys(image);
>         |                       ^
>   1 error generated.

This issue has been addressed in v2
https://lore.kernel.org/all/20260106074039.564707-1-coxu@redhat.com/

Thanks!

-- 
Best regards,
Coiby


