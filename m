Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0202C87FDB
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uak9uMoSf1hFQNv+gxLqBrTo+PAvamtwLxZZOi8jwac=; b=dUAMSklo6Y2y7mf9oHPWF5hzPK
	Zf2UI+YPtryb3mDW1MH0i32Zt9Sklog8wg5KMX3x12fzttMeyTmiDLLQPntK7Bv+z/5/clVuHJyPs
	uRzHb1+uTXpHFydC3+TOb9HNavmhwE6FSpf+0MCSwQIrjaLGpG+9hV4RF6dgLxwVagx4lhSzNMZeU
	CbP0x0X+FE6VL0YDMff3y5AV6wtR+Kol2qUd1AvdMJHhp1w9z7kS/PxhPLuiFgDnAq60aS8NkGdiF
	VX/74Qpz/UayazrAvwWXyDOHbuTZT/Cs/qsCi1MOXVeSZ2hNiLVYHPPUcGQ8s8Z8svYn4phFPDZt3
	VucRLK7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSFA-00000007lQM-1CWe;
	Mon, 11 Aug 2025 13:07:16 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSBP-00000007ksb-1tQO;
	Mon, 11 Aug 2025 13:03:24 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754917402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uak9uMoSf1hFQNv+gxLqBrTo+PAvamtwLxZZOi8jwac=;
	b=XZO+njxBaetbKcIwqfljGMkgIa5Zeyna5UbnXeGA5/ZWOVWdem0bMc0gbPhwaqJibZppBN
	lhJB/aTzKYeLDzgliK6Pmwk0o3YVcSSCM9qULRAau3dr2ec1RDUit/lDnNIk2zOGBJNGFw
	L54UYuQurl26uH529YlO0OAyKS9yv+65PiGv5iFCQIArxV2KXkuEMNtY7JoORNOPfzrPc5
	FfVXlXLOl4h1N0E1fMhvvMc0eYR9EWNfLS2OsyObj1aqQEV9l2T1kg6qfX99uNyuyF2r7X
	oaLmX99jDar4TuvZgTOSVZ3P59HJjmfc+KZ87NpyvccPxvG8tZdv9w7fr7rHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754917402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uak9uMoSf1hFQNv+gxLqBrTo+PAvamtwLxZZOi8jwac=;
	b=Nrv9aKmSaQqacXYMrZ9mwNow7CXAggaX2DJMyZkYm+KYRyt21towuYSwZZ+FNdT5BQS8+c
	jubCXSbpCj8csPAQ==
To: Coiby Xu <coxu@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kexec@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [Regression] kdump fails to get DHCP address unless booting
 with pci=nomsi or without nr_cpus=1
In-Reply-To: <87bjom8106.ffs@tglx>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
Date: Mon, 11 Aug 2025 15:03:21 +0200
Message-ID: <878qjq80yu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_060323_639468_BCCD615A 
X-CRM114-Status: GOOD (  10.22  )
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

On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:

CC+ Marc

> On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> Recently I met an issue that on certain virtual machines, the kdump
>> kernel fails to get DHCP IP address most of times starting from
>> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>>
>>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>>      # Provide MSI parent infrastructure
>>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>>      # Prepare for PCI MSI/MSIX
>>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>
> There were follow up fixes on this, so isolating this one is not really
> conclusive.
>
> Is the problem still there on v6.16 and v6.17-rc1?
>
> Thanks,
>
>         tglx

