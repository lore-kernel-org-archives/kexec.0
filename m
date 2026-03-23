Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D7D3941E
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnMGF1hF1WW6/Gtz51mz8K6u9S5YKJbEi/GgrCMRCcI=; b=Id13afWhJW56ugVn7ci0BVprGW
	LlZoL5GL4YqIqVzVZsL6s12ygLgVtUHTli4DMxFSkGggOcYHcJVIXVsxUrVvH1kV3uUa+9pz3dqrm
	71vgrgny+QFlNySiN7QLN/ICNjljgG3dF4noIpkTRpPU3JuduiVKTeyXVzh/ZuakYIxoEZqbXQvu2
	yvDHS4Myngqoob1lRvUExkpHD39StOuytWRziKPmg9nD9QQIpN8vDw4ng36xC1LJDIIWFFxIWmwpt
	628TW8yWpAYg4MKscOfjKcFs/Lv76zm+IMx/sWz1dxHxCk7h5qki7Th4YhjrAsaB99dHQzJn27QXQ
	JAI0uiAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFj-000000003oq-0kqV;
	Thu, 02 Apr 2026 12:34:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4UZF-0000000FsSg-1w1F;
	Mon, 23 Mar 2026 01:58:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82BAC43BA4;
	Mon, 23 Mar 2026 01:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC1C19424;
	Mon, 23 Mar 2026 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774231135;
	bh=BnMGF1hF1WW6/Gtz51mz8K6u9S5YKJbEi/GgrCMRCcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUjWpCugJPseIiCzojaappy2G56EwCcFlTk+RHuPMDdvwdR+EnL347w7LI3UCkvJb
	 p9PH86lqJGd5d9hIqvjbLcmg8iQU6feQ0ZVbWqW3VTot+FFLI/AX0mmwLJnk/ehCFb
	 exrnpKMx8yIqEq95ldNOVe4Nf90pZVklGv2yI3F8=
Date: Sun, 22 Mar 2026 18:58:53 -0700
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
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
 <lirongqing@baidu.com>, <fvdl@google.com>, <rppt@kernel.org>,
 <ardb@kernel.org>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
 <jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
 <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
 <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
 <junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
 <fuqiang.wang@easystack.cn>, <brgerst@gmail.com>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
In-Reply-To: <ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
	<ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_185857_549327_9ED75ED8 
X-CRM114-Status: UNSURE (   8.09  )
X-CRM114-Notice: Please train this message.
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

On Mon, 23 Mar 2026 09:44:21 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> If there are no other review comments, I'd like to ask if this is ready
> to be merged.

This patchset predates the introduction of the Sashiko AI review, and
that thing is proving very good at finding issues.

So can you please update the changelog footers for thus-far-received
acks/reviews and then resend?

Thanks.


