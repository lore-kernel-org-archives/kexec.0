Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7182CD3423
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/kcAa+eYw+w8N+t1zkqKB0Re/K/IdRQcrTEU3juInUg=; b=qi8e+XKqaT23oBgKZohwRH0Pch
	QW0tyVMoByIo1rTfmElDZ731FsiCoJu1hby1wRkbEZyUHMr48zHSLM1R6TumnZERIJHJWaxCJ/nfg
	hahirKIr1LTQVWmjv0brLhyQzDgMol0SsfaN/QHye06IJEMZPYjZK0OfM0YMl2spRl3jJ0kL//pqI
	AWo1WcvCTYwQySJdT2HR7KaPqUGrUFnldr77APOjxRMNuh4HYKAT0Z11C3xc5dZOAWN9DEowaG1e0
	Ji5noiY4TLymsG47Z6b2vbJeWghJedihis0ACogXXtPu6/NfHv8e6b/FcrxhdllXB4ssOtj0Dm0Ta
	qWlAbVhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIY68-00000005vJ9-3gto;
	Thu, 30 Apr 2026 20:35:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHg3o-00000001Dpv-1zeW;
	Tue, 28 Apr 2026 10:53:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A3D860141;
	Tue, 28 Apr 2026 10:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE5C2BCAF;
	Tue, 28 Apr 2026 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777373579;
	bh=FAkK0ftN7gWUbuk+HZ/TnP99n+RR4S9QM3ioJ/hUWvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qsqv6r1lJZq/c7ZPtIt0sZl/DuaHenFFdJWV+kUZfKy9lze4sbNHOT4ldBEvZsMcI
	 IzA4ewciHKUUGkWs11knSBEVXzjvVrxdGd/P9JBd6VWThd9m0HhwDsNHUrAT8OtKfZ
	 vkIpz9kt+ca77YyWoiGiskB7TOq8ICE0RWcWLVHM=
Date: Tue, 28 Apr 2026 03:52:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
 <leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>, <guoren@kernel.org>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
 <fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
 <takahiro.akashi@linaro.org>, <james.morse@arm.com>,
 <lizhengyu3@huawei.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260428035256.cbb3ac77c4bbb89bb7efcc19@linux-foundation.org>
In-Reply-To: <dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
	<dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 13:34:59 -0700
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

On Tue, 28 Apr 2026 11:30:13 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> It seems the patches for crash core rework, powerpc, riscv, and arm64
> are mostly ready to be merged. Could any maintainer help pick these up,
> or should I rebase the entire series against v7.1-rc1?

April 2 is prehistoric ;)

Yes, refresh, retest, resend.  Note that there have been maintainership
shuffles in this area.  

KDUMP
M:	Andrew Morton <akpm@linux-foundation.org>
M:	Baoquan He <bhe@redhat.com>
M:	Mike Rapoport <rppt@kernel.org>
M:	Pasha Tatashin <pasha.tatashin@soleen.com>
M:	Pratyush Yadav <pratyush@kernel.org>
R:	Dave Young <ruirui.yang@linux.dev>
L:	kexec@lists.infradead.org
S:	Maintained
F:	Documentation/admin-guide/kdump/
F:	fs/proc/vmcore.c
F:	include/linux/crash_core.h
F:	include/linux/crash_dump.h
F:	include/uapi/linux/vmcore.h
F:	kernel/crash_*.c

I believe that Pasha/Mike/Pratyush are setting up a git tree, but there
isn't one listed here?


