Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from z5.mailgun.us ([104.130.96.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfJSI-0008Ee-6E
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 09:08:48 +0000
MIME-Version: 1.0
Date: Wed, 18 Nov 2020 14:38:39 +0530
From: aadiga@qti.qualcomm.com
Subject: Facing issue with va to pa conversion in arm64/makedumpfile
Message-ID: <698954d8fcee05aee74833235800829f@qti.qualcomm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: k-hagio-ab@nec.com, panand@redhat.com
Cc: arunks@codeaurora.org, vatsa@codeaurora.org, kexec@lists.infradead.org

Hi Pratyush/ Kazuhito ,

While attempting to create dumpfile on arm64, I was face issues with 
virtual address to physical address conversion when kalsr is enable. 
Linux kernel version is 5.4.42 stable kernel.

The following patch seems to add patch to enable kalsr support :

[PATCH 10/10] arm64: fix memory layout as per changes in v4.6 kernel

https://sourceforge.net/p/makedumpfile/code/ci/b6fe70c7ffef9affb540412407702b15d4a196e9


static unsigned long long
+__pa(unsigned long vaddr)
+{
+       if (kimage_voffset == NOT_FOUND_NUMBER ||
+                       (vaddr >= PAGE_OFFSET))
+               return (vaddr - PAGE_OFFSET + info->phys_base);
+       else
+               return (vaddr - kimage_voffset);
+}


I see that even when kimage_voffset is available , it calculates pa 
using PAGE_OFFSET.
But as KALSR is enabled it should ideally use kimage_voffset.

Not sure what is the significance of the check (vaddr >= PAGE_OFFSET) if 
kimage_voffset is available.

i think this should be something like

+       if (kimage_voffset == NOT_FOUND_NUMBER) && (vaddr >= 
PAGE_OFFSET))
+               return (vaddr - PAGE_OFFSET + info->phys_base);
+       else
+               return (vaddr - kimage_voffset);



Because we want to check vaddr is greater than PAGE_OFFSET when we are 
considering linear mapping without kaslr seed.

Or may be we should have a separate check which will error out all vaddr 
less than PAGE_OFFSET and kimage_voffset.

+       if  (vaddr < PAGE_OFFSET)
+              return -EINVAL;
+       if (kimage_voffset == NOT_FOUND_NUMBER)
+               return (vaddr - PAGE_OFFSET + info->phys_base);
+       else
+               return (vaddr - kimage_voffset);

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
