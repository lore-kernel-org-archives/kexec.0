Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ED9CD6E6A
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P70qjRmAyMymwJPTMfOq+4DYcvFmuGavpK8tS3QAMZ8=; b=ARiBf87WZq1XBXUaRDmFHlBbFh
	QNfMsRVrW8JMZVI3FLFfxw5sp4W4csB/YahhfWPHGfinba78fK56c/pmkHkEKav0iGOPSIn0eyWJq
	WW1aG1ynnUd7R0rSgiS+ZmC0848v/ePGI57dLXNaGqJyJuaKBhUdN8KbjM4eCEakOpz3M/zotBpVN
	VTK/ZELctn2SENyYmiNoXCJaj5PWDmtNd5mnlMM3jWGqOuVKzNA6zqm8pt9Xwplk+BJHXWporFcM2
	XgJAYKS8AK78QZxxm1tBBQVCcMF/UxRojD+oJZXISJVwnsy0Jf/0k1csmj8qGMYzwd/3BMil4ntm/
	OUbAvpTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQr7-0000000DI2G-0LTq;
	Tue, 02 Jun 2026 15:16:37 +0000
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFSn-0000000CCpz-1m5L
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:06:47 +0000
Date: Tue, 2 Jun 2026 11:06:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780369591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P70qjRmAyMymwJPTMfOq+4DYcvFmuGavpK8tS3QAMZ8=;
	b=FfbPNmSqGFBVUXMW60W8WZklD/5OswTsE3vOOKJWBoPQkE+ieiKrsI/w+0/boUf1oyoQTr
	a6KYsX23L/elGm5bXPqfLcPYLugymhGemNGpdBX9bswHkYCZ207Y83Ojwb0HZ4Gy7cbZDl
	Ei0P5PYrgBGvOUgIoJMhYqqLwwkMndo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, kuba@kernel.org,
	lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org,
	sourabhjain@linux.ibm.com, thuth@redhat.com, ardb@kernel.org,
	masahiroy@kernel.org, gshan@redhat.com, james.morse@arm.com,
	maz@kernel.org, leitao@debian.org, yeoreum.yun@arm.com,
	coxu@redhat.com, suzuki.poulose@arm.com, cfsworks@gmail.com,
	osandov@fb.com, jbohac@suse.cz, ryan.roberts@arm.com,
	tangyouling@kylinos.cn, ritesh.list@gmail.com,
	adityag@linux.ibm.com, hbathini@linux.ibm.com, bjorn@rivosinc.com,
	songshuaishuai@tinylab.org, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, djordje.todorovic@htecgroup.com,
	austin.kim@lge.com, namcao@linutronix.de, djbw@kernel.org,
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn,
	liaoyuanhong@vivo.com, makb@juniper.net, graf@amazon.com,
	piliu@redhat.com, rafael.j.wysocki@intel.com,
	mario.limonciello@amd.com, jbouron@amazon.com,
	chenjiahao16@huawei.com, guoren@kernel.org, bauerman@linux.ibm.com,
	bgwin@google.com, takahiro.akashi@linaro.org, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v15 00/23] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <ah5Ioxs9aLxKIKWg@MiWiFi-R3L-srv>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
 <ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv>
 <1a459706-80db-43d8-b163-76fc09da338d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a459706-80db-43d8-b163-76fc09da338d@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_200645_904511_05D09A5A 
X-CRM114-Status: GOOD (  30.69  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:16:35 -0700
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

On 06/02/26 at 09:43am, Jinjie Ruan wrote:
> 
> 
> On 6/1/2026 9:40 PM, Baoquan He wrote:
> > Hi Jinjie,
> > 
> > On 06/01/26 at 05:47pm, Jinjie Ruan wrote:
> > ...snip... 
> >> Changes in v15:
> >> - Unify the subject prefix formats as Huacai suggested.
> >> - Fix powerpc pre-existing NULL pointer dereference [Sashiko [1]]
> >> - Fix powerpc pre-existing __merge_memory_ranges() memory range
> >>   truncation [Sashiko [1]].
> >> - Fix pre-existing arm64 CMA page leaks [Sashiko[2]].
> >> - Fix pre-existing crash_load_dm_crypt_keys() Use-After-Free and
> >>   Double Free issue [Sashiko[3]].
> >> - Fix vfree(headers) and uninitialized variables issue
> >>   and simplify the fix [Sashiko[2]].
> >> - As walk_system_ram_res() and for_each_mem_range() use different
> >>   lock, unify and simplify the fix of TOCTOU buffer overflow via memory
> >>   region padding [Sashiko[4]].
> >> - Fix the arm64 crash dump issues in Sashiko[5].
> >> - Link to v14: https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com/
> > 
> > Do these Fixes have anything with the main target of this patch series
> > you mentioned in cover-letter:"arm64/riscv: Add support for crashkernel CMA"?
> > The patches become more and more in each new version, I am wondering if
> > it relies on these Fixes patches to implement your adding support for
> > crashkernel CMA on arm64/risc-v.
> > 
> > If not relying on them, could you split them into different patchset
> > on different purpose? 
> 
> Hi Baoquan,
> 
> Thank you for your valuable guidance.
> 
> You are absolutely right. Most of these fix patches are indeed not
> strictly related to the core implementation of the crashkernel CMA
> support. They are pre-existing bugs in the surrounding kexec/crash code
> that were flagged during our review.
> 
> Previously, Andrew suggested taking a look at the code review comments
> from the Sashiko AI system, which is why these fixes kept expanding. I
> completely agree with your advice that there is no need to keep them
> together. I will split them into two completely different patchsets
> based on their purpose:
> 
> 1. A cleaner version of this series, strictly focused on adding the core
> crashkernel CMA support for arm64/riscv.
> 
> 2. One standalone bugfix patchset dedicated entirely to fixing these
> pre-existing issues.
> 
> By the way, I would also appreciate some advice on how to handle further
> AI reviews. It seems that the more code we touch or refactor to fix
> these pre-existing issues, the more tangential bugs the AI flags in the
> newly exposed areas, making the series extremely difficult to converge.
> 
> Should I continue to address all AI-reported bugs associated with the
> surrounding code in this series, or should we draw a strict line
> and only focus on the core CMA logic moving forward?

Then please post patches to focus on the core implementation of the
crashkernel CMA support. If any AI reported bugs are raised but not
relatd to it, you can add note in cover-letter or explain somewhere
to tell whehter it's caused by the core code and how you want
to deal with it. Otherwise, you could go round and round of new posting
and still can't see when it ends up.


