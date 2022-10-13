Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69942C433FE
	for <kexec@archiver.kernel.org>; Thu, 13 Oct 2022 02:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gRAoNYATPcAXzvQfF9/kM7s3TrfveAcNtOMLcszz5cQ=; b=bpkN1E1aahInnq
	/vKPSZaQIoOSKYo7z1ywcbjG2xyx3Mo3wPqOLBRHckoFShhFSuwhiSzNDYQevdI5JBPs0MoXb7KWi
	7/wjWUrc7b33mH2BVJrSWjOcg7FI3Pn+JP6LQxb0Wrd70FecQwJfXhtpEDsL8qVCk1MPm8Pqfm5xx
	vIB/6WJj1LoumD8i8b3ml7Z7MjbR5LhbypdfCkf6E2WCLcWSi4zwco2EfF0P4MmsUoLrhw0kpyMiS
	98Tgm29LVO/Hh0vZF1A5+47xP3m248sItAnrJ651jAIR5FeRdCQsQCqBLWVu4S1Ck0xHDchPs86to
	PJP1s2WUbnZxq4wUEWrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oioQ5-00AQJJ-OA; Thu, 13 Oct 2022 02:58:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oioQ1-00AQHc-M2
	for kexec@lists.infradead.org; Thu, 13 Oct 2022 02:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665629872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8r6RnStRQqo5NB/KrjFNVz2NdBUb9m52H/iX7wovmR8=;
	b=BMWF0OCRfC9A8hJsbasqrl9I1SWyWTLnBj6itb7UVnQ56y/dc3Sf4FWSWVjzVE4fd6jbHs
	Q2zsG9uKSiYY2M80g+NY4g9z3vh44DYfJ3YxOox34prF6teeGLAN4XlOMapVC3RCswx29u
	o1adleVwI5BzjzmsQz5gBcceoLi1J04=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-XLfnMYOyMX6ON2Jqjhde1Q-1; Wed, 12 Oct 2022 22:57:49 -0400
X-MC-Unique: XLfnMYOyMX6ON2Jqjhde1Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B381C05AF3;
	Thu, 13 Oct 2022 02:57:43 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8432F492B0F;
	Thu, 13 Oct 2022 02:57:37 +0000 (UTC)
Date: Thu, 13 Oct 2022 10:57:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Eric DeVolder <eric.devolder@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
References: <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0cmaPTKQuWtwIRh@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_195758_641166_E4CA5DB4 
X-CRM114-Status: GOOD (  23.50  )
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

On 10/12/22 at 10:41pm, Borislav Petkov wrote:
> On Wed, Oct 12, 2022 at 03:19:19PM -0500, Eric DeVolder wrote:
> > We run here QEMU with the ability for 1024 DIMM slots.
> 
> QEMU, haha.
> 
> What is the highest count of DIMM slots which are hotpluggable on a
> real, *physical* system today? Are you saying you can have 1K DIMM slots
> on a board?

The concern to range number mainly is on Virt guest systems. On
baremetal system, basically only very high end server support memory hotplug.
I ever visited customer's lab and saw one server, it owns 8 slots, on
each slot a box containing about 20 cpus and 2T memory at most can be
plugged in at one time. So people won't make too many slots for
hotplugging since it's too expensive.

I checked user space kexec code, the maximum memory range number is
honored to x86_64 because of a HPE SGI system. After that, nobody
complains about it. Please see below user space kexec-tools commit in
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

The memory ranges may be not all made by different DIMM slots, could be
firmware reservatoin, e.g efi/BIOS diggged out physical memory, or the
cpu logical address space is occupied by pci or other stuffs. I don't
have a HPE SGI system at hand to check.

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

> 
> I hardly doubt that.

The questioning is reasonable. 32K truly looks too much. 

Now CONFIG_NR_CPUS has the maximum number as 8192. And user space 
kexec-tools has maximum memory range number as 2048. We can take
the current 8192 + 2048  = 10K as default value conservatively. Or
take 8192 + 2048 * 2 = 12K which has two times of maximum memory range
bumber in kexec-tools. What do you think?

> 
> > So, for example, 1TiB requires 1024 DIMMs of 1GiB each with 128MiB
> > memblocks, that results in 8K possible memory regions. So just going
> > to 4TiB reaches 32K memory regions.
> 
> Lemme see if I understand this correctly: when a system like that
> crashes, you want to kdump *all* those 4TiB in a vmcore? How long would
> that dump take to complete? A day?

That is not a problem. The time of vmcore dumping mainly depends on the
actual memory size, not on memory range numbers. when dumping vmcore,
people use makedumpfile to filter zero page, free page, cache page, or user
date page according to configuration. If memory is huge, they can use
nr_cpus=x to enable multiple cpu to do multi-thread dumping. Kdump now
support more than 10 TB vmcore dumping.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
