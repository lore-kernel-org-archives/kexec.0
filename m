Return-path: <kexec-bounces@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ihqta-00058O-FC
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 19:12:03 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9GI8IR5015579
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 14:08:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9GI8I6t562138
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 14:08:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9GI8IWx011211
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 14:08:18 -0400
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20071016162858.545617122@strauss.suse.de>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
Date: Tue, 16 Oct 2007 11:08:16 -0700
Message-Id: <1192558097.17464.15.camel@localhost>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

On Tue, 2007-10-16 at 18:28 +0200, Bernhard Walle wrote:
> 
> @@ -736,7 +736,7 @@ static int __init smp_scan_config (unsig
>                         smp_found_config = 1;
>                         printk(KERN_INFO "found SMP MP-table at %08lx\n",
>                                                 virt_to_phys(mpf));
> -                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
> +                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE, 0);
>                         if (mpf->mpf_physptr) {
>                                 /* 

Could you give all of these 0's a name?  I really hate seeing random
magic numbers in these things.  0 completely kills the ability of
someone to read the code and figure out what it is trying to do without
going and looking at reserve_bootmem().

Or, alternatively, do something like this:

-extern void reserve_bootmem(unsigned long addr, unsigned long size);
+/*
+ * If flags is 0, then the return value is always 0 (success). If
+ * flags contains BOOTMEM_EXCLUSIVE, then -EBUSY is returned if the
+ * memory already was reserved.
+ */
+extern int reserve_bootmem(unsigned long addr, unsigned long size, int flag);
+int reserve_bootmem(unsigned long addr, unsigned long size)
+{
+	/* the 0 is because we don't
+	return reserve_bootmem_exclusive(addr, size, 0);
+}

Where all of the existing callers stay the same.  But, the ones wanting
exclusive access actually call the _exclusive() variant.  

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
