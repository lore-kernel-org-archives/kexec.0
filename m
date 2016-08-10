Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXOsM-0005yH-EL
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 08:28:38 +0000
Received: by mail-yb0-f180.google.com with SMTP id g133so11902622ybf.2
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 01:28:12 -0700 (PDT)
Date: Wed, 10 Aug 2016 13:58:08 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Query about ARM64 virt_to_phys and vice versa implementation
Message-ID: <20160810082808.GA24137@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kexec@lists.infradead.org, ard.biesheuvel@linaro.org

Hi,

Would like to discuss virt_to_phys() and phys_to_virt() conversion in latest
kernel. I can see that if VA < PAGE_OFFSET, then we just subtract kimage_voffset
from VA and we get the PA. However, there is no such condition for
phys_to_virt(). phys_to_virt is always done by (PA - PHYS_OFFSET + PAGE_OFFSET).
So, how does phys_to_virt() work for all the cases? I must be missing something.

-- I am using a platform with VA bits = 42.
   Therefore PAGE_OFFSET on my platform is 0xfffffe0000000000
   PHYS_OFFSET is 0x8000000000
   kimage_voffset is 0xfffffb8006000000

Now lets find physical address of log_buf:
# cat /proc/kallsyms | grep -w "d log_buf"
fffffc0008ca6b40 d log_buf

Since VA < PAGE_OFFSET (fffffc0008ca6b40 < fffffe0000000000)
Therefore as per definition of virt_to_phys() from asm/memory.h:
PA = VA - kimage_voffset = fffffc0008ca6b40 - fffffb8006000000 = 8002CA6B40

Now convert PA=8002CA6B40 to VA.
VA = PA - PHYS_OFFSET + PAGE_OFFSET = 8002CA6B40 - 8000000000 + fffffe0000000000
= fffffe0002CA6B40 which not equal to fffffc0008ca6b40.

So, do we have dual mapping for all physical addresses? If not, how does it
work? What I am missing. 

If its dual mapping, then probably we will need to fix couple of things in
kexec-tools.

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
