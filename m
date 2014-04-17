Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wairu-0001XO-Gv
 for kexec@lists.infradead.org; Thu, 17 Apr 2014 09:44:31 +0000
Date: Thu, 17 Apr 2014 17:45:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 9/9] x86: Pass memory range via E820 for kdump
Message-ID: <20140417094533.GD11676@dhcp-16-126.nay.redhat.com>
References: <1397487341-17287-10-git-send-email-chaowang@redhat.com>
 <20140417052913.GB4889@dhcp-16-126.nay.redhat.com>
 <20140417053541.GC4889@dhcp-16-126.nay.redhat.com>
 <20140417061736.GA1849@dhcp-17-89.nay.redhat.com>
 <20140417063244.GF4889@dhcp-16-126.nay.redhat.com>
 <20140417065749.GC1849@dhcp-17-89.nay.redhat.com>
 <20140417070713.GA11676@dhcp-16-126.nay.redhat.com>
 <20140417071726.GE1849@dhcp-17-89.nay.redhat.com>
 <20140417073045.GB11676@dhcp-16-126.nay.redhat.com>
 <20140417084225.GF1849@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417084225.GF1849@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

> 
> It comes to me that in the future there are two places that can be
> improved or cleaned up. I summarize them as the followings:
> 
> - clean up cmdline_add_memmap and cmdline_add_memmap_acpi
> - Dropping hard limitation memory maps, like CRASH_MAX_MEMMAP_NR

Hmm, kernel E820MAX is 128 in case non EFI like below, likely 1024
is enough, so keep current limitation is good:

#ifdef CONFIG_EFI
#include <linux/numa.h>
#define E820_X_MAX (E820MAX + 3 * MAX_NUMNODES)
#else   /* ! CONFIG_EFI */
#define E820_X_MAX E820MAX
#endif

> 
> Do you have additional issues needed to be addressed?

Another in mind is using one array for both 1st kernel and 2nd kernel
if possible.

Thanks
dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
