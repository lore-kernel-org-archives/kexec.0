Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94656FD530E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0f2eSr9rmaNS1+79aXS+wFuWYZUMMuO+mzVaId9UwP4=; b=OG6eSmWAPl+BdGxV7A7Whs/msc
	PMecB2H/1VSOecnwrHV/SAYpJqTNBrMWPL/zQj+5vo5/SmHMUgmmXbPrcxKqsStqLVl6FqNpNIE+U
	SiUebeRpEsq5btI7by2Zlm83V/zUzawiN1w30Zw3mBFdS16wFECwq7tKFIpspDnO3mEdMwAU49CU3
	KHW9UaKfXDkctAX1QmCAYnmvsykHwe1pq/ovYInne1RXmENFSFqjojDuxs7VsCMk6cxYv/Y3vDgAO
	Zz07yZ+tUMLbsXJVV2/QOSBsNL9GCJZmIhU42HenIyeypiqhtYNZPlDaYknnVdXfDrGREibCQiv7c
	ou6pQNZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtL5-00000007zVW-21Np;
	Fri, 27 Feb 2026 08:36:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXc3-00000005nWj-1WFz
	for kexec@bombadil.infradead.org;
	Thu, 26 Feb 2026 09:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0f2eSr9rmaNS1+79aXS+wFuWYZUMMuO+mzVaId9UwP4=; b=PQu4Yzph7YQ+v2dxNpHi38A3Kf
	Nl2tlJdEH/ul0AcZkYwQhkMBzpJ0DJNGwmpKicZ81Zg/gLoDkM2P2858zTEpcjrtdqZ3uPNWWUQnF
	3eZ42FKStta84RoKU0tMT1Y4p7OtTHPsUJc2cCWllvt7TevX91SAUUlpxus6hpAHKy7S8VLVl6PLj
	k/0D1vjeofm9paxeKDXU/TpCrdf9Q4vRs0jbTWSs0TGawl1ebt+QbJ5aQE8ftOahzpdfcgQWu0c3v
	5yivYsEI+JARt7EEE0EK3ycIk05M8b6svYAfPTkyZKRsEtDBkdD9pj5PlM9myUBhdafaJFrOlDlN2
	c3I5VQEw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXc0-0000000AbeZ-14Y2
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 09:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772097885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0f2eSr9rmaNS1+79aXS+wFuWYZUMMuO+mzVaId9UwP4=;
	b=cIBtQzPdoSW3g6B0sGf0xK3u4TeJI8EBHTuWWzgaRiyj9jM/cbdjGlpEJa7qdo0o8ql0oN
	sPVTV2Z8kPuMe3B9F5mKnR2e6WRd6aMiTkiAaadGHgPVzxgLTMITYZN0u31jE3BPcEjaZK
	V8xGSzeaQCUwdvX7p7ncY8JPi/mBPfg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772097885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0f2eSr9rmaNS1+79aXS+wFuWYZUMMuO+mzVaId9UwP4=;
	b=cIBtQzPdoSW3g6B0sGf0xK3u4TeJI8EBHTuWWzgaRiyj9jM/cbdjGlpEJa7qdo0o8ql0oN
	sPVTV2Z8kPuMe3B9F5mKnR2e6WRd6aMiTkiAaadGHgPVzxgLTMITYZN0u31jE3BPcEjaZK
	V8xGSzeaQCUwdvX7p7ncY8JPi/mBPfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-X0rGY6nTMuu-QJYjQSsSnw-1; Thu,
 26 Feb 2026 04:24:42 -0500
X-MC-Unique: X0rGY6nTMuu-QJYjQSsSnw-1
X-Mimecast-MFC-AGG-ID: X0rGY6nTMuu-QJYjQSsSnw_1772097877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D399F1956089;
	Thu, 26 Feb 2026 09:24:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAD4B1800348;
	Thu, 26 Feb 2026 09:24:25 +0000 (UTC)
Date: Thu, 26 Feb 2026 17:24:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, vgoyal@redhat.com,
	dyoung@redhat.com, rdunlap@infradead.org, pmladek@suse.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, paulmck@kernel.org,
	lirongqing@baidu.com, arnd@arndb.de, ardb@kernel.org,
	leitao@debian.org, rppt@kernel.org, cfsworks@gmail.com,
	ryan.roberts@arm.com, sourabhjain@linux.ibm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, samuel.holland@sifive.com,
	kevin.brodsky@arm.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	fuqiang.wang@easystack.cn, jbohac@suse.cz, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v6 1/5] powerpc/crash: sort crash memory ranges before
 preparing elfcorehdr
Message-ID: <aaARRZh9k_0oG3Qo@MiWiFi-R3L-srv>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
 <20260224085342.387996-2-ruanjinjie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20260224085342.387996-2-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 7O4R8h2hET6yUg5utOa9jXzgjCiIi-sb9gwfd4ej7lY_1772097877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_092448_526059_BC436F66 
X-CRM114-Status: GOOD (  17.06  )
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:36:44 -0800
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

On 02/24/26 at 04:53pm, Jinjie Ruan wrote:
> From: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
> the removed memory. While updating the crash memory ranges for this
> operation, the crash memory ranges array can become unsorted. This
> happens because remove_mem_range() may split a memory range into two
> parts and append the higher-address part as a separate range at the end
> of the array.
> 
> So far, no issues have been observed due to the unsorted crash memory
> ranges. However, this could lead to problems once crash memory range
> removal is handled by generic code, as introduced in the upcoming
> patches in this series.
> 
> Currently, powerpc uses a platform-specific function,
> remove_mem_range(), to exclude hot-removed memory from the crash memory
> ranges. This function performs the same task as the generic
> crash_exclude_mem_range() in crash_core.c. The generic helper also
> ensures that the crash memory ranges remain sorted. So remove the
> redundant powerpc-specific implementation and instead call
> crash_exclude_mem_range_guarded() (which internally calls
> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

You should add your own Signed-off-by since you sent it out.

> ---
>  arch/powerpc/include/asm/kexec_ranges.h |  4 +-
>  arch/powerpc/kexec/crash.c              |  5 +-
>  arch/powerpc/kexec/ranges.c             | 87 +------------------------
>  3 files changed, 7 insertions(+), 89 deletions(-)
......snip...


