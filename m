Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF43C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnQYDbNf1O/dH1zz/2VAhmSeCCwJ5x8F/LTf+gjtwkY=; b=0KdONVXTcom1aYAI59dgsyOOrt
	iCxfVnuq3bqbxCLxghymFP++lvFP+8cyT0ocaQRCDquFj2F6MFLidZ4HmcvOpFCsB7KjaNrm+woCG
	wQW5Cev+G5iJBj7fi1NKT5ePjyhiTSr1iBo+ZY19eAP4xjZvkKbGvPTgHSpt6Tw8PfXyZYp3Oy08F
	XkOoDu/HbFLjj8o49BMcCR75aYwhiO1uXdd2GYqWm0TelyTbEELfu82hjdFduR2vLrnfntqAJnbuS
	q6LxmzdJTGE4Da7F+YF8HoBNfVSQiiQoyS2atOuS/HcCcDq6uuQjgNI2bd+12yF9SC6P90R82zasY
	ze85lZmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWHV-0000000GmEc-0yIu;
	Tue, 30 Jun 2026 11:05:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWHS-0000000GmCU-3fPZ;
	Tue, 30 Jun 2026 11:05:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DFB38600FF;
	Tue, 30 Jun 2026 11:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5952C1F00A3A;
	Tue, 30 Jun 2026 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817529;
	bh=hnQYDbNf1O/dH1zz/2VAhmSeCCwJ5x8F/LTf+gjtwkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EsY9VY65AjqqaljnNdL/WAs6WuJcvoLAqplQsn0gWbo46qXa6s2y0w/oWEJAsCFIq
	 ehVh4d2Xrv5dg7VFvLnBVF0Bwi3oC7zeA4QBQkDruvHtUzZE+vdzY2exsFb48TALvV
	 F6rHNDZ2Z5uRiAFcgPnzuLf5YseFMDpBfcyp6KeLRXWUqYdCgpModVNc8XE3tA4Vqu
	 2888Gy8eyH6AkwcHD5Jj/9gW+J+tL+7jVxdMPWVDBZspAfBVc0qAPpUgiPDcFYWwHO
	 zrJu7UPonWZbRh3C4lAEQjGI48ohqR0WwYaeiZn2/THLKWRk/pGT4pFQUA2t3zKj4Y
	 Y2Ts2iKbbGafA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 01/10] kexec/crash: provide crash_exclude_mem_range()
 stub when CONFIG_CRASH_DUMP=n
In-Reply-To: <20260630074715.4126796-2-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:05 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-2-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:05:23 +0200
Message-ID: <2vxzqzloi8zw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Prepare for an upcoming change that excludes non-dumpable reserved
> regions from the kdump vmcore and will call crash_exclude_mem_range()
> from generic, non-arch code.
>
> No functional change.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

