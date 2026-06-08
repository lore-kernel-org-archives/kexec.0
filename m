Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE75CD8CB9
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HeNvzEtTTeAyiynvrWR03BeK5a7m/jtKDrW58LkAIDk=; b=SjYVR8VJkOnRLuQSWrY6yhBSCp
	OPj0AvsZUHe7Kl/2gxnIvB8T/lwg/hr9O9z7WrIUGs95DtAXn365LvtbV+62TZj/JQZ5XcZ6olkL/
	+pR3a7mYGQLLraK1ROXrqFeBG7gqCR7J1RpssUCosYviQtAvlTd4gagbKnHhf9frvip/D+QHDcqa/
	yCKuZfuqdbcUhP+ZMuBJtymUbb0vknslTviYyVhWrgQezkehdjj82Yzmipc63tnxD6535sEZR9vik
	T1jqo4Wm//gpKntnimtorfMs8O/5mVyLUCfUldrvWEvg6ML/0+5n01RqarK7f3ZqraeC5/o1mVxeD
	urxXER8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCfy-00000006uML-1xSx;
	Wed, 10 Jun 2026 06:44:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWcY8-000000042C2-0e95;
	Mon, 08 Jun 2026 16:10:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FA9842DF0;
	Mon,  8 Jun 2026 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0E1F00893;
	Mon,  8 Jun 2026 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780935003;
	bh=HeNvzEtTTeAyiynvrWR03BeK5a7m/jtKDrW58LkAIDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NGHfBNMS1rlirWFtfC0pDdz7EzZeHjyxYg9Ca3Sjn1pulZaZLIDmOYvJmcZBYsc93
	 VQpg5Ivsba3rTH79/1M55QufUmF/lQ9H/jskqKdHB8HrOkPOEhSgnQUMV9M34B2Iz8
	 Fh7VryrdGwslXF2Cr1sq+hzZtoOSb/V4p5rwEeS0=
Date: Mon, 8 Jun 2026 09:10:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <rppt@kernel.org>,
 <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
 <ruirui.yang@linux.dev>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
 <kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
 <lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
 <leitao@debian.org>, <coxu@redhat.com>, <Liam.Howlett@oracle.com>,
 <ryan.roberts@arm.com>, <osandov@fb.com>, <jbohac@suse.cz>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
 <fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
 <guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>
In-Reply-To: <20260608073459.3119290-1-ruanjinjie@huawei.com>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 09 Jun 2026 23:44:32 -0700
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

On Mon, 8 Jun 2026 15:34:49 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

fyi, AI review might have found a bunch of issues in arch-specific
code, all of them pre-existing.

	https://sashiko.dev/#/patchset/20260608073459.3119290-1-ruanjinjie@huawei.com

