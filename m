Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JhjVg-0000RV-2p
	for kexec@lists.infradead.org; Fri, 04 Apr 2008 10:51:05 +0000
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [Patch][RFC] makedumpfile: fix for xen-3.1.2
Date: Fri, 04 Apr 2008 19:48:47 +0900
MIME-Version: 1.0
In-Reply-To: <47F5FD6C.50702@mxs.nes.nec.co.jp>
References: <D4C895FC097B62takebe_akio@jp.fujitsu.com>
	<47F5FD6C.50702@mxs.nes.nec.co.jp>
Message-Id: <DBC89641760820takebe_akio@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, xen-devel <xen-devel@lists.xensource.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Itsuro ODA <oda@valinux.co.jp>, Akio Takebe <takebe_akio@jp.fujitsu.com>

Hi, Ohmichi-san

Thank you very much for you report.

>Akio Takebe wrote:
>> This patch fixes makedumpfile for xen-3.1.
>> xen-3.1.2+ hypervisor doesn't have idle_pg_table_l3,
>> we need to find a symbole of idle_pg_table.
>
>Thank you for the patch !
>I tested your patch with RHEL5.2-beta, and it worked fine on i386 machine.
>But it doesn't work on x86_64 machine. makedumpfile went to the loop in
>kvtop_xen_x86_64(), and it failed with a segmentation fault:
>
>makedumpfile/x86_64.c
> 196         if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR) <- 
>*HERE*
> 197                 return NOT_PADDR;
>
>
>If you know, please teach me. Should this patch fix the problem for
>not only the upstream but also RHEL5.2 ?
>Unfortunately I don't know the detail of xen, and I haven't used the
>upstream xen yet. 
Sorry for that. 
Yes, this patch will fix also RHEL5.2 because the base is 3.1.2.
https://www.redhat.com/archives/rhelv5-list/2008-March/msg00111.html

The bug may be occurred by changing __XEN_VIRT_START.
http://xenbits.xensource.com/xen-3.1-testing.hg?rev/a06a28ebad5d

So we may be able to fix it by changing DIRECTMAP_VIRT_START.

I didn't have x86_64 system.
I'll setup x86_64 system, and try to investigate it next week.

Best Regards,

Akio Takebe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
