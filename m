Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F1CD342F
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5YIWZdeRu5igWR5hp45nmf8lM6VbTZlT79HfocWMqI=; b=26Ddjcb5a0SQT83IPi5qxsvILk
	S1vEFJiPIxypojhM8kU0X5+S3NDlvsHUBkFUqRzeYNhmZMQnRhCCzyeSf56p7MCjUrJtSNkDfcHB4
	9DASOr6J0jW/O3b/ZkOpfR8V0tArTkhU1NSCme3xcjba4vRDBpnfzgj3IYh6/1T+8TLM5gSe78zD0
	w2t5n20brVkCJAZfqDzOdPjPjnI+bFDJo6xGOluYSQKjjgGhoyo+i/LjqnsE/V4rBB+weY0RW9WzV
	ukYguw1/1aCSqX1oKSiEzM9Z1M1LKUkI0zj33lJF+T3FOnyolBH/KMtNkOUl6LLxl0WeMRg+p/tiW
	Wfqkc0SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRMm-00000000S1V-1I8C;
	Wed, 06 May 2026 01:48:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRMj-00000000S0f-2LaB;
	Wed, 06 May 2026 01:47:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 07DDC43F40;
	Wed,  6 May 2026 01:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE19C2BCB4;
	Wed,  6 May 2026 01:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032074;
	bh=dq4n2rXi6bWQ/HXhC18pEK/hPmy2rLxTxVTfaCPfj8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdyS+2DLodBz71jljKCplG4FZBljdfyl2Rw0roX/XQ85aOtU2I7CcqNF2A0kG5A//
	 NzyKhanO+oBs1GKJZ/+jVaIKfFY1ZBu5EXHaUhFVvqz6fwAGFvkin91L8ubjNXtnh7
	 o25ZvGb8CQLR9N4h85xEbobLDSeXWT/n1Q6fa988WYtAIuPdBY1VEZwO7nD4RnobgI
	 hyBa9xCzUrYXv2WXolzNYAFjhR6OgRye3m/99B2127B4m11IA4kwZI6hPk2QBxAwE3
	 wn65bgWJy/bPSIzurdvUiJVpeFoe6RVWkqcBEpBwZLwzQd1mqa4EEK201gJwibItot
	 gn/oAoZtWy6wQ==
Date: Tue, 5 May 2026 20:47:52 -0500
From: Rob Herring <robh@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	chenwandun@lixiang.com, zhaomeijing@lixiang.com, everyzhao@126.com
Subject: Re: [PATCH 01/11] of: reserved_mem: fix region count for nodes with
 multiple reg entries
Message-ID: <20260506014752.GA280279-robh@kernel.org>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
 <20260429065831.1510858-2-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429065831.1510858-2-chenwandun@lixiang.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_184757_624760_6CDD3081 
X-CRM114-Status: GOOD (  12.81  )
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

On Wed, Apr 29, 2026 at 02:58:21PM +0800, Chen Wandun wrote:
> When a reserved-memory node contains multiple reg entries (e.g.,
> reg = <base1 size1>, <base2 size2>), the count used for
> total_reserved_mem_cnt is wrong in two places:
> 
> 1) __reserved_mem_reserve_reg() returns 0 on success regardless of how
>    many regions it reserved in memblock. The caller in
>    fdt_scan_reserved_mem() then increments count by just 1.

Just to make sure, more than 1 worked before the referenced commits? It 
would be easier to just define we only expect/support 1 entry.

> 
> 2) fdt_scan_reserved_mem_late() uses of_flat_dt_get_addr_size() which
>    only reads the first reg entry. Subsequent entries are never
>    initialized via fdt_init_reserved_mem_node(), so their metadata is
>    lost.
> 
> Fix both issues:
>  - Make __reserved_mem_reserve_reg() return the actual number of
>    regions successfully reserved. Update the caller to accumulate
>    the returned count.
>  - Rewrite fdt_scan_reserved_mem_late() to use
>    of_flat_dt_get_addr_size_prop() and iterate all reg entries,
>    initializing each one via fdt_init_reserved_mem_node().
> 
> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")

