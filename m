Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19CBC3DA4B
	for <kexec@archiver.kernel.org>; Mon, 15 Jul 2024 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13xaSjbplUj+HWuBWAiV0ALQEDMG+qU9SvPQpIHzktY=; b=pCHHvT0D0A5rNi
	b0wiJlIXlG6iV583MBAW1R16cgwWSmwdyBQQAyGdBGS9511ksl+eWk2CvPQgvkbr5s6jOEVTEG7k+
	YTm/NWhj8u8GT7UXiN5RLKLGUGdnzRUojQwttuL0tP3ZJ6JLnGqLVCrOfUSarLQh7kbfz/vNDxY58
	2NddHXl2DLfbJ9aPWi1A8JRB0SuNboRxqeByEV6UqzbSjK22SpKFvgtwiobZq27emu2f4HsQMxu6M
	x5cVYUBAU+ZB1C5FVddw1+CvnCKuD8krz763RzgPRlSbdmuwrmgAWN0zJ9XZ+xgEHGB2CK/oo7j0P
	p/dLEeWWaTNmJMIreR1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTN0G-00000007RPS-3YYg;
	Mon, 15 Jul 2024 14:48:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTN0D-00000007RNu-1RN9
	for kexec@lists.infradead.org;
	Mon, 15 Jul 2024 14:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721054911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BkASY8k41Yge7TlrZ3/2PBxoq4fiGL0DmL3P/8JkIRs=;
	b=Lhuf45DPOXo+xGME5qe3stgp+ELqHojXw7WhKclmHBZWuTaBJd306BGqkDn1lha1wdL9Xl
	ecFGruofPmSlEo6OyBrUJ77UR1Qrm8tZhKGGC6ZD6YGWgrBn1J95o8fg8Y2bDhla4XuoLk
	fdmhEL0kjhbuGfcPygigsE5CTB3KrmE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-ZGslQ6mQM6mpsMimRaGtXw-1; Mon,
 15 Jul 2024 10:48:28 -0400
X-MC-Unique: ZGslQ6mQM6mpsMimRaGtXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92F9A1944B2A;
	Mon, 15 Jul 2024 14:48:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 911801955F3B;
	Mon, 15 Jul 2024 14:48:16 +0000 (UTC)
Date: Mon, 15 Jul 2024 22:48:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, akpm@linux-foundation.org
Cc: vgoyal@redhat.com, dyoung@redhat.com, austindh.kim@gmail.com,
	rmk+kernel@armlinux.org.uk, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Message-ID: <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240713014808.1689915-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_074833_474250_C118BE31 
X-CRM114-Status: GOOD (  15.89  )
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

On 07/13/24 at 09:48am, Jinjie Ruan wrote:
> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> as below:
> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> 
> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
> is also ok as below:
> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
> input size.

I am not sure if this is a good idea. Shouldn't we handle this in
arch_reserve_crashkernel() to check the system RAM size?

With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
kernel cmdline, then you will reserve 256M crashkernel in system, don't
you think that is confusing?

By the way, I am considering changing code to apply generic crashkernel
reservation to 32bit system. Maybe below draft code can prevent
crashkernel=,high from being parsed successfully on 32bit system.

What do you think?

diff --git a/arch/arm64/include/asm/crash_reserve.h b/arch/arm64/include/asm/crash_reserve.h
index 4afe027a4e7b..bf362c1a612f 100644
--- a/arch/arm64/include/asm/crash_reserve.h
+++ b/arch/arm64/include/asm/crash_reserve.h
@@ -7,4 +7,6 @@
 
 #define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
+
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
diff --git a/arch/riscv/include/asm/crash_reserve.h b/arch/riscv/include/asm/crash_reserve.h
index 013962e63587..8d7a8fc1d459 100644
--- a/arch/riscv/include/asm/crash_reserve.h
+++ b/arch/riscv/include/asm/crash_reserve.h
@@ -7,5 +7,7 @@
 #define CRASH_ADDR_LOW_MAX		dma32_phys_limit
 #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
 
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
+
 extern phys_addr_t memblock_end_of_DRAM(void);
 #endif
diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..24c2327f9a16 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -26,6 +26,7 @@ extern unsigned long swiotlb_size_or_default(void);
 #else
 # define CRASH_ADDR_LOW_MAX     SZ_4G
 # define CRASH_ADDR_HIGH_MAX    SZ_64T
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 #endif
 
 # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..c5213f123e19 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -306,7 +306,7 @@ int __init parse_crashkernel(char *cmdline,
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
 				crash_base, NULL);
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
 	/*
 	 * If non-NULL 'high' passed in and no normal crashkernel
 	 * setting detected, try parsing crashkernel=,high|low.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
