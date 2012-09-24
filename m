Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TGHjJ-000146-Cb
 for kexec@lists.infradead.org; Mon, 24 Sep 2012 23:06:21 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay2.corp.sgi.com (Postfix) with ESMTP id 9B7B430404E
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 16:06:17 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id 795CC7000720
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 18:06:17 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1TGHkf-0006ZB-22
 for kexec@lists.infradead.org; Mon, 24 Sep 2012 18:07:45 -0500
Subject: 896MB address limit
Message-Id: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 24 Sep 2012 18:07:45 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Gentlemen,

In dumping very large memories we are running up against the 896MB 
limit in SLES11SP2 (3.0.38 kernel).

arch/x86/kernel/setup.c
/*
 * Keep the crash kernel below this limit.  On 32 bits earlier kernels
 * would limit the kernel to the low 512 MiB due to mapping restrictions.
 * On 64 bits, kexec-tools currently limits us to 896 MiB; increase this
 * limit once kexec-tools are fixed.
 */
#ifdef CONFIG_X86_32
# define CRASH_KERNEL_ADDR_MAX  (512 << 20)
#else
# define CRASH_KERNEL_ADDR_MAX  (896 << 20)
#endif

/sbin/kexec we are using is from kexec-tools-2.0.0-53.43.10

Can you tell me if this is limit is removed in the current kexec-tools? And
if so, can I use a later release of kexec-tools with this kernel?
Or, perhaps you can point me to a patch that removes this limit.

Thanks.
-Cliff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
