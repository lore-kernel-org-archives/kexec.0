Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0951CD4F54
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIaFU2XJHtIVIU1Q+1dhMPDocgMYReg2MIrRHb6jNU8=; b=12AGCngWo9EiMiiBvrA8gbyAvB
	9YpI5WioNhtHj/O3xAlk8ejk3c7VStgZDe1KtxDDD2vs5h4x7Ta1LnYNIFr5MJ+jyOMfOmVNttDW1
	ljt8Zl8JczQ8YQdDkz0FmZgRvIN+CUgfCGn1di/g2FWVHFtr7YPP7u/6n0o1LYAT/AjEDTF1afXH8
	srA/T92CznUs4uL5USDbvMUCyKB1xsJ4frgcuiL0/FFit+rDbIl8uWnS+R19olzVYXuinkkSBmUMW
	5ikzEj4m9j1Qxa4h1WBvM5ib9TxfT8zU+HnwjowQTZX1too/M/BBiRkDHoVubn5xXDVmXP9PDQHxQ
	3GK/Hulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSalw-00000005mR1-3oLV;
	Thu, 28 May 2026 13:27:40 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSalq-00000005mQO-0tnT
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 13:27:36 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779974848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIaFU2XJHtIVIU1Q+1dhMPDocgMYReg2MIrRHb6jNU8=;
	b=josbuxqjhdehCdKhRzCAofaZT19xUuNwvPu4XI9pv5Rw6SamLbNKucKkEI4Wb1/H3gyJbI
	l80ijGXpaziRBx6DZ8+SUi2O0JTyy1IlEV17nK3TwuhmoFskCTLjgEw0Bx8H03v67+m9Mw
	tjAEe8Oa46o35M9DXOW9m13hw7z1f6c=
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: chenhuacai@kernel.org,
	dongtai.guo@linux.dev,
	graf@amazon.com,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 1/7] LoongArch: Add KHO basic support
Date: Thu, 28 May 2026 21:26:53 +0800
Message-Id: <20260528132653.190981-1-dongtai.guo@linux.dev>
In-Reply-To: <2vxztsrv5r6y.fsf@kernel.org>
References: <2vxztsrv5r6y.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_062734_416908_A890DBE9 
X-CRM114-Status: UNSURE (   8.50  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 25 2026, Pratyush Yadav wrote:

Hi Pratyush,

> Do you have nothing else for a bootloader to pass data to the kernel?
> Passing this via the command line seems crazy... All these addresses are
> now available directly to unprivileged userspace. Can't you use the
> device tree like we do on ARM64?
>
> Also, this commandline parameter isn't documented anywhere.

I have tried the FDT /chosen approach, storing the KHO metadata as
linux,kho-fdt and linux,kho-scratch properties (the same properties
that drivers/of/kexec.c:kho_add_chosen() writes
and drivers/of/fdt.c:early_init_dt_check_kho() reads).

This passes the KHO selftest when the system boots with FDT.

I am currently debugging the ACPI boot case.

Thanks for your advice!

--
Regards,
George Guo

