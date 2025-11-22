Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2715DCFC539
	for <kexec@archiver.kernel.org>; Sat, 22 Nov 2025 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cBD25WHvqvimUX161O9Xcdajk+rB/gauVTWiODhYTog=; b=lGKIaMwoJK/wFATOgIe77Dnhov
	5BLb6V+xytkKsjQT7P+PnGMZALdGa8AkGccFEAadTe8SYK+9507gTgO7YFkPLrasWsmFMPFH5FLYZ
	HV4gUAVx32exOnSRx2exsDxTisOSjoWFwDp296D4X1XLyxrDdNbfsIoNyZJfp/R3uXSNf5JF/ERem
	i9xONk0keCrh3CTIBzuxXddzr//KSIfIGhesLWVk5v5S3NJCPuyTCLMB4aINFgfyMobw8+ggq3mLK
	KjF+Ip8BNP3C03y+SJnD2erjanZ0Lp9VIT8mqbTS8zBBPUsH4O2rkSu0MigOUHvkw4gVJe4MzYWgY
	dO+aqKgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMrsW-00000009mHU-0CNb;
	Sat, 22 Nov 2025 17:58:32 +0000
Received: from m16.mail.163.com ([117.135.210.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMrsS-00000009mH2-3aEr
	for kexec@lists.infradead.org;
	Sat, 22 Nov 2025 17:58:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cB
	D25WHvqvimUX161O9Xcdajk+rB/gauVTWiODhYTog=; b=RUvPt/l8AlX147sonr
	R42c5ndf9KU2rPuLLXCufoO2tVBYfn5T75hWq6QEAHw7GkyiwQNXxbaVwPMnGADB
	X4e0jKY5IHGECkaLD6nuuZL4PdKrhYVuHnsC/xNjY8fsmbNnycQl9Xp/h0nxdD8+
	Yah2c14scDHnp3C+exVNW0BoU=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHehGP+SFptyDHBw--.20298S2;
	Sun, 23 Nov 2025 01:57:36 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	changyuanl@google.com,
	graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rppt@kernel.org
Subject: Re: [PATCH 2/2] liveupdate: Fix boot failure due to kmemleak access to unmapped pages
Date: Sat, 22 Nov 2025 17:57:35 +0000
Message-ID: <20251122175735.92578-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mafs05xb43ch3.fsf@kernel.org>
References: <mafs05xb43ch3.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHehGP+SFptyDHBw--.20298S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4kKr1kZw15Gw1UJrWfGrg_yoW8tFW8pr
	yUK3Wjyw4Dt39IyrZrA3W8uryI9ayfKrWUAr1UuryfZr9xWFySqr4FyayvvFy3GF48GF40
	qF48tFyxXryjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUo5lUUUUUU=
X-Originating-IP: [117.176.242.91]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEBYOTGkh99AiCwAAsC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_095829_241132_625F6A9B 
X-CRM114-Status: UNSURE (   9.37  )
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

>On Thu, Nov 20 2025, ranxiaokai627@163.com wrote:
>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> When booting with debug_pagealloc=on while having:
>> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
>> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
>> the system fails to boot due to page faults during kmemleak scanning.
>>
>> This occurs because:
>> With debug_pagealloc enabled, __free_pages() invokes
>> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
>> freed pages in the direct mapping.
>> Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>> releases the KHO scratch region via init_cma_reserved_pageblock(),
>> unmapping its physical pages. Subsequent kmemleak scanning accesses
>> these unmapped pages, triggering fatal page faults.
>
>I don't know how kmemleak works. Why does kmemleak access the unmapped
>pages? If pages are not mapped, it should learn to not access them,
>right?
>
>>
>> Call kmemleak_no_scan_phys() from kho_reserve_scratch() to
>> exclude the reserved region from scanning before
>> it is released to the buddy allocator.
>
>kho_reserve_scratch() is called on the first boot. It allocates the
>scratch areas for subsequent boots. On every KHO boot after this,
>kho_reserve_scratch() is not called and kho_release_scratch() is called
>instead since the scratch areas already exist from previous boot.
>
>Eventually both paths converge to kho_init() and call
>init_cma_reserved_pageblock().
>
>So shouldn't you call kmemleak_no_scan_phys() from kho_init() instead?
>This would reduce code duplication and cover both paths.

Thanks for your review!

Yes, both paths converge to kho_init(),
for the first boot, kho_get_fdt() returns NULL and
init_cma_reserved_pageblock() is called, but for KHO boot,
kho_get_fdt() returns non-NULL, kho_init() returns before
calling init_cma_reserved_pageblock().

However, in KHO boot, calling kmemleak_no_scan_phys() is unnecessary
because kmemleak objects are created when called memblock_phys_alloc() and
KHO boot does not invoke memblock_phys_alloc(),
moving the kmemleak_no_scan_phys() call into kho_init() both resolves the issue
and reduces code duplication.


