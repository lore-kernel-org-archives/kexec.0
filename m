Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4455CC4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 03:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=54a0VLe+qjRi3bHTe5aZtF/nTe/sKNMww8+r5VYxI6c=; b=spw4Jsza4i+TKL
	W3leEGrd1VrNHPYgPAV3pHtQgjkf1p0mH7RzwdfYcEgDt2OMjDVRUZYFnjr6LkQFogQ9DtBPxBok9
	Rvn2oLEZXSTZfS8WGre0P5MzvoESIDiMK741G9rTP8kWHZ35Y4VGXQmC1t0l0dgSX2sdJqHPURcDN
	xnxUYKB8W3H7TzFXdSBvw2B8+b99Evz2jhd+fH6atKVHFP57PWyfzNaiHD51yhJXv9fv9QjQ6JIXo
	4oJQb1TezS8fmtU/DkqGPhfQ5IU/g1BDy49UoaNe/8F2oU1wg47KJmcbSUZPyGtblT3L7qGqqkH1u
	ifvDIxd4ZonBv2IyZrpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rELOZ-005GSW-1a;
	Sat, 16 Dec 2023 03:31:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rELOV-005GPl-30
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 03:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702697471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZ9SxEQn8rRrb11+0ab5wOKztDWIMe9VsB+AvmCW9TM=;
	b=W38TNaBCJmS6sDB4Z9jJibt046wZdIxSJ2jVikEB7ckqP8l1MkCZbh/QkgZKKmrUhd0Ic/
	ShRpVn7VJN3G9IwoXqjuwKfRaAidBXZzhOzdh+0UcSFnLeXLX3nXYZWiqQ/3abIopUkTdR
	jxatb9GeEvszN7FF1M6jdxYLZ9iO9Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-3b-9erIjOJGT6bBxpg4DbQ-1; Fri, 15 Dec 2023 22:31:09 -0500
X-MC-Unique: 3b-9erIjOJGT6bBxpg4DbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E844B85CBA2;
	Sat, 16 Dec 2023 03:31:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE96DC159B0;
	Sat, 16 Dec 2023 03:31:07 +0000 (UTC)
Date: Sat, 16 Dec 2023 11:31:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
	dyoung@redhat.com, eric.devolder@oracle.com, hbathini@linux.ibm.com,
	hpa@zytor.com, kexec@lists.infradead.org, lijiang@redhat.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, seanjc@google.com,
	sourabhjain@linux.ibm.com, tglx@linutronix.de, tiwai@suse.de,
	vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-ID: <ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
 <20231216015410.188924-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231216015410.188924-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_193116_035305_C9783078 
X-CRM114-Status: GOOD (  32.06  )
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

On 12/16/23 at 09:54am, Yuntao Wang wrote:
> On Fri, 15 Dec 2023 23:15:10 +0800, Baoquan He wrote:
> > On 12/15/23 at 12:38am, Yuntao Wang wrote:
> > > The purpose of crash_exclude_mem_range() is to remove all memory ranges
> > > that overlap with [mstart-mend]. However, the current logic only removes
> > > the first overlapping memory range.
> > > 
> > > Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
> > > handle overlapping ranges") attempted to address this issue, but it did not
> > > fix all error cases.
> > 
> > Hmm, this is a specific function for kdump kernel loading. So far it's
> > sufficiently meet demands. Say so because we only need to exclude
> > crashk_res and crashk_low_res when constructing elfcorehdr. region
> > crashk_res/crashk_low_res are digged out from system RAM region. That's
> > why the break is taken in the for loop in the current code. X86 needs
> > exclude low 1M, the low 1M could span several system RAM regions because
> > BIOS under low 1M reserved some spaces. And the elfcorehdr exluding from
> > crashkernel region taken in x86 is also a splitting.
> > 
> > Generally speaking, crashk_res/crashk_low_res is inside a big chunk of
> > continuous region. On x86, low 1M spans several complete region on x86,
> > elfcorehdr region is inside continuous crashk_res region.
> > 
> > You can see why crash_exclude_mem_range() looks like now it is. This patch
> > makes crash_exclude_mem_range() be a generic region removing function. I do
> > see the memmove can improve code readbility, while I have concern about the
> > while loop.
> > 
> > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > Then after excluding the 256M from a region, it should stop. But now, this patch
> > will make it continue scanning. Not sure if it's all in my mind.
> 
> Hi Baoquan,
> 
> Thank you for such a detailed reply. Now I finally understand why the code is
> written this way.
> 
> However, if we can guarantee its correctness, wouldn't it be better to use the
> generic region removing logic? At least it is more concise and clear, and other
> people reading this code for the first time wouldn't get confused like me.
> 
> As for your concern about the while loop, I think it wouldn't affect performance
> much because the total number of loops is small.

Well, see below kexec-tools commit, you wouldn't say that. And when you
understand the code, you will feel a little uncomfortable about the
sustaining useless scanning. At least, we should stop scanning after
needed exluding is done.

Or, we may need add a generic region removing function so that it
can be shared, e.g e820 memory region removing, memblock region removing.
Otherwise, I can't see why a specific region excluding need a generic 
region removing function.

commit 4a6d67d9e938a7accf128aff23f8ad4bda67f729
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Thu Mar 23 19:16:59 2017 +0800

    x86: Support large number of memory ranges
    
    We got a problem on one SGI 64TB machine, the current kexec-tools
    failed to work due to the insufficient ranges(MAX_MEMORY_RANGES)
    allowed which is defined as 1024(less than the ranges on the machine).
    The kcore header is insufficient due to the same reason as well.
    
    To solve this, this patch simply doubles "MAX_MEMORY_RANGES" and
    "KCORE_ELF_HEADERS_SIZE".
    
    Signed-off-by: Xunlei Pang <xlpang@redhat.com>
    Tested-by: Frank Ramsay <frank.ramsay@hpe.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 33df3524f4e2..51855f8db762 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -1,7 +1,7 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
-#define MAX_MEMORY_RANGES 1024
+#define MAX_MEMORY_RANGES 2048
 
 enum coretype {
        CORE_TYPE_UNDEF = 0,
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
