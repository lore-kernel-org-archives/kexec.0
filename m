Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989CCD3941F
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WO1vn6Tln5KFquM2TJaKxzbEqp7cPSRmlLOOnQm4DBk=; b=y+S7DHga+3U/GwLCzf/Wp1Q00+
	08NyRBwc4xAPabxE4TMnmRwRMdAfP9JxEgkYFyjvbrPPAoF6IN76BOe1JY94Brnsdc0OlJOvJWbDd
	tfToLrW7jgIgJhLOc7RqNr1ksF23a7ImZ6AhJGd3+LHUtSh1YVKAYsRnbN+UwjcjCsFNfg2nn8UQb
	VCBNNU6zeN3A/UhnRjEuQXrfkN9aP/2oLvTgCgGx84k09QTtkLWwy6GwAw93TKqfXiE9e2FeJ9+w3
	88dvcQ1wQZGHdBNp204HI+HWBlocUI7hD2qP/TTMmAt7OyzeUwdzDSFVYqOiUi+39XLIIhdqU2qyJ
	wDiB03Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HGB-000000004j6-0Hj0;
	Thu, 02 Apr 2026 12:34:55 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w78it-0000000Awd1-0BU7;
	Mon, 30 Mar 2026 09:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=WO1vn6Tln5KFquM2TJaKxzbEqp7cPSRmlLOOnQm4DBk=; b=IjoUdYg7H5HjzhmD9Ya8KzCZED
	MOdt/f/iybG0j7ZLGmiC7aJOgf9EGEZ5AT6v30A7lr8C+eX+qUGhl5lLwhUy7Ag2vW87+rI4cKgR0
	IreKmv/ogatlCLSyoDgJQL/Bm0oZPTC3Ph6N6bEB8K2FbqIE9a2RJzwF5rC3QyiVtqaFsRExlbFnq
	w6kBr9fPUeAdfZ2RsOnmOj6jLS7FgdEY+TwNyaPu3c4DAiLI7ICVb5EP/dox4qH2GHtCEzV9jz6MU
	LmEcDrV31BMlEKYMm8KfrbhCwKfgUBdd6N399NiMCtz+aDHCvorriy5EW4hCaA9xT6qUKgk0TT0qt
	Qm7u5jxA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w78hH-001L8R-10;
	Mon, 30 Mar 2026 09:14:10 +0000
Date: Mon, 30 Mar 2026 02:13:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, peterz@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, ardb@kernel.org, cfsworks@gmail.com, osandov@fb.com, 
	jbohac@suse.cz, tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, 
	ritesh.list@gmail.com, eajames@linux.ibm.com, songshuaishuai@tinylab.org, 
	kevin.brodsky@arm.com, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
	coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com, 
	guoren@kernel.org, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v11 10/11] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <aco-v4BuRSiZx7yy@gmail.com>
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
 <20260328074013.3589544-11-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328074013.3589544-11-ruanjinjie@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_021551_084218_64308AC9 
X-CRM114-Status: GOOD (  11.14  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

On Sat, Mar 28, 2026 at 03:40:12PM +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Tested-by: Breno Leitao <leitao@debian.org>

