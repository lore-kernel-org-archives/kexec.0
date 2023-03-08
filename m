Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAABC678D5
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dntxumuKCC1/E949VaAuJbJk53QaG9TnebNXh3USHl4=; b=0hTujEfuH0ZH+a
	GUU/6idbY82U/JAlXErYx0J2mgDUOzSyEw0dFlA9xO58VuacLboFAuohbXzGnN//Db+G9SD3DFg+l
	o59WHcwJVNm7qcL5p6ZXEcCEs8eAhXHZrsmDVl+pMIB+SLC9F+9E0sTwd7CF5WvcHxOGpAJAcuQQc
	Equv7zZ204uH/c1TmtPXLG022YhN8nVNfIlghKJa/jxWisxaMxV0FA8og78GMcqsUmQek6eShxFlF
	tz5lN5R1sKYSTQtUY5LjiQO/K7rcRzQlEgodKJyq5VFLC8v+nRESE1HrAkURMEaVgY0XEteWfk+E1
	ERns2/Y/Td5aFZvvAYVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZtGC-004vrG-RH; Wed, 08 Mar 2023 12:51:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZtGA-004vqX-Sc
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 12:51:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3C13C61783;
	Wed,  8 Mar 2023 12:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55CC433EF;
	Wed,  8 Mar 2023 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678279869;
	bh=hj+CAP4sRATw6qdx8/9prGlg5RY392PLVZZlTUyx0zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmTutHXCen85qAykPJoxu2E/V8R8T6kLhmj29LjTn75H8VTOKEF8lWmes6rWUzxM9
	 A2RNWi2B0pdLIslqY1+oviluDCQEOFSWNWZZLAaAz2jz9KCvip2/EViX9iYSXKHQUt
	 MmFiYg6xoBrRPOjeGs3IS6lW8hs/QMK1jZQL6B3vOxxYwQmibcDoN7BGx2/MeQ4tbA
	 ozRs0lU+dqCsSH6ENHUbcFEQWyneUWjHuWWJ1LJwc091TSJrYLaTtPeUuDg+KWW7Ld
	 uL/rLTbFHw8+HRUpOxASVNY4nl+37HQWOrqFtQQchpSSnM1FTBzuSp/tKRNkJTpXak
	 4iCQNZpuD/RKA==
Date: Wed, 8 Mar 2023 13:51:06 +0100
From: Simon Horman <horms@kernel.org>
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH v2 2/2] LoongArch: kdump: Set up kernel image segment
Message-ID: <ZAiEujL9VLZwq0vc@kernel.org>
References: <1677899351-31098-1-git-send-email-tangyouling@loongson.cn>
 <1677899351-31098-2-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1677899351-31098-2-git-send-email-tangyouling@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_045110_980214_0B66C5CA 
X-CRM114-Status: GOOD (  11.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Mar 04, 2023 at 11:09:11AM +0800, Youling Tang wrote:
> On LoongArch, we can use the same kernel image as 1st kernel when
> 3f89765d622 ("LoongArch: kdump: Add single kernel image implementation")
> is merged, but we have to modify the entry point as well as segments
> addresses in the kernel elf header (or PE format vmlinux.efi) in order
> to load them into correct places.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
