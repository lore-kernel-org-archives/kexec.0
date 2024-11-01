Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87433E67494
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLHpFjxv+hu6JT9io1Oz+LO+Co95mb3fm9P6cDkuRSA=; b=1+HuUXHGEZDLXD
	hyNhde2BL+e3SfosT3vtLRZ7LBpoB/0NN1GG2ktPQfpHPRBoO2+BuUdH+GZ8Qypy/UxOLuExqQmHf
	z90J+NujfrRAE7JY6UT1jSHpe8zQt9auptaPF3r32/uT14JC06Ojlt3cHHHGyPvARFjHKMyFt7DJn
	Pj11FW81DtpRXzu75ki9ZZtZrCnP9UgVOo/GWYOWcQvg26HVeI8UfH+SSuWiuGjwHouz1qsxt05Tk
	oxwbuUW5xi9sP0Wm/dsO5MBcnia7AONIlceljE82zY2UE3ascWfccJCvPdBNuEEsDZSdrIhXHO2Ns
	Thx5YmSU+5YK2zbIq4Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gr4-00000005UQr-2Qqc;
	Fri, 01 Nov 2024 01:53:38 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gq5-00000005UBa-04JA
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 01:52:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A6AC3A42F7A;
	Fri,  1 Nov 2024 01:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A363EC4CEC3;
	Fri,  1 Nov 2024 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730425955;
	bh=rUYhonZQ44s7AHpyKlo7hmLgeKtjiBsbCXsQs2AM87c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mOA7IDOAhyGZXr2y5DJ0+z5H3EkStEeP+24bScIxzAUIsj7m8vmKF4Yr3wrnwFgXI
	 r+aW2Rs2YEa434G8cFDlj+sOmGj7fCzxMDqFpBr50XQLGkLCH6QYq51/8UwUuHNkbK
	 8t+H+zbZNSs3LeRcOWcbAoHK7clISQT7cj1+EA4o=
Date: Thu, 31 Oct 2024 18:52:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: <bobo.shaobowang@huawei.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <holzheu@linux.vnet.ibm.com>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/proc: Fix compile warning about variable
 'vmcore_mmap_ops'
Message-Id: <20241031185235.8bb482766ab10d2ab19fd3f6@linux-foundation.org>
In-Reply-To: <20241031072746.12897-1-xiqi2@huawei.com>
References: <20241031072746.12897-1-xiqi2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_185237_155807_65694154 
X-CRM114-Status: GOOD (  12.99  )
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

On Thu, 31 Oct 2024 15:27:46 +0800 Qi Xi <xiqi2@huawei.com> wrote:

> When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
> is defined but not used:
> 
> >> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
>      458 | static const struct vm_operations_struct vmcore_mmap_ops = {
> 
> Fix this by declaring it __maybe_unused.
> 

It's better to move the definition inside #ifdef CONFIG_MMU, perhaps this:

--- a/fs/proc/vmcore.c~a
+++ a/fs/proc/vmcore.c
@@ -457,10 +457,6 @@ static vm_fault_t mmap_vmcore_fault(stru
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @size: size of buffer
@@ -488,6 +484,11 @@ static inline char *vmcore_alloc_buf(siz
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.
_


Please check and test that and send it back at us a a v2 patch?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
