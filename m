Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DE8CD5BA4
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dwsvFwpHn9qH84sDH5sE6cRIyeZ87q2CTInHWEsehMc=; b=4/LfqNQeoSroclP15XfZ1DnZJt
	r+T5hTA+luRj4HGPsZoKtWhhIneP7ebEd4sDitfNl0UimwHFK3Ge8/cfe13mvzkHCNu1wv+9WUrFE
	ZXC7lULTdGJXifyUaEBf2EAtp1u3sAPGOOt0jwWypa1DKdj7uH/gVF+XAmmyGRWvcQ0RSK5V7xfsM
	zUA0QKbrB8H7fgK6JHTuqaDjecbfTW4qBnSDsn4xM2jzOZBVJ5vFvvBRo6NZSm9diUVP1dVMubC8A
	EqJUHrIG8VgDu0NfOsce214jfIy0G/u8Z9RQ8J47stTgvsnVkayzTC4YWn/g0RYi1GrZumJX/4c/d
	Wzo+F5Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJo4-00000001W6h-11pm;
	Tue, 19 May 2026 12:44:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJo0-00000001W3d-2iWI
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 12:44:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 98BEF4196B;
	Tue, 19 May 2026 12:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61520C2BCC6;
	Tue, 19 May 2026 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194655;
	bh=W3sjW+J59BILhQs9q4qvFdsNvR/S2M1kFA3fu5NJcCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXASY9kCFeTO/bzX/u6LjD3ZD/LpnK/Alfah4bwiJBLSFwTF2VxqvLXyH8Eg/HCmm
	 ickAZzplppBNm9Kh3Ts7U/cpcR+fVeATAgtlPeVSLTw9INLKqzP/TA7b3vbBlqxk3P
	 WkjcsX94yGTNrTEbVeVBJQ275hvpsfqz15Z6IbkVN7qhDTprh7/c47aw/NpVL60vfx
	 MF3w2MZMaOrXm8lae+iDvn8Jc1ojW33xZUmzWmAnqvI8RfrGCVqS3kjeJK/leQYBl0
	 C0XNIwE+3T8rdEXa3qDWSe4hrj0r5Pac55csxM3yKxTQye1fST/qzbDAhiLwa+T1nW
	 QqIt3axiDJ7YA==
Date: Tue, 19 May 2026 13:44:12 +0100
From: Simon Horman <horms@kernel.org>
To: hu.shengming@zte.com.cn
Cc: kexec@lists.infradead.org, luo.haiyang@zte.com.cn, zhang.run@zte.com.cn,
	yang.tao172@zte.com.cn
Subject: Re: [PATCH 3/3] RISC-V: add bss section to kernel text elf header
Message-ID: <20260519124412.GB227450@horms.kernel.org>
References: <20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn>
 <20260518150140578xGhdr-ct94HGGS4gmP_it@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518150140578xGhdr-ct94HGGS4gmP_it@zte.com.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_054416_739801_83AF00DE 
X-CRM114-Status: GOOD (  10.31  )
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

On Mon, May 18, 2026 at 03:01:40PM +0800, hu.shengming@zte.com.cn wrote:
> From: Luo Haiyang <luo.haiyang@zte.com.cn>
> 
> The kdump service reported the following error:
> 
>   No program header covering vaddr 0xffffffff819fa200 found kexec bug?
>   saving vmcore-dmesg.txt failed
> 
> prb stores the address of printk_rb_dynamic. Since printk_rb_dynamic
> resides in the bss segment and the PHDR (Program Header) does not include
> the bss segment address. Therefore,  add the bss segment to the Kernel text.
> 
> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>

Hi,

I am wondering if to_be_excluded() also needs to be updated.
And, if so, should that change also be made for ARM64.

Review assisted by gemini-3-pro-preview

