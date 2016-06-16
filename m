Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDdOb-0004N6-TQ
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 19:56:10 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GJs2Y4039256
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 15:55:46 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ktnhvh86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 15:55:46 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 16:55:44 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5846B352005C
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 15:55:24 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5GJteoX17433000
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 16:55:40 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5GJtdGq028075
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 16:55:39 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/9] kexec_file_load implementation for PowerPC
Date: Thu, 16 Jun 2016 16:55:33 -0300
In-Reply-To: <1466056110.5400.8.camel@ellerman.id.au>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466056110.5400.8.camel@ellerman.id.au>
MIME-Version: 1.0
Message-Id: <17475630.nMjKSPkg4b@hactar>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Am Donnerstag, 16 Juni 2016, 15:48:30 schrieb Michael Ellerman:
> On Tue, 2016-06-14 at 11:59 -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > This patch series implements the kexec_file_load system call on PowerPC.
> 
> Can you tell me what this syscall does and why I would want it?

Sorry, should have provided the motivation when I posted the patches.

This system call moves the reading of the kernel, initrd and the device tree 
from the userspace kexec tool to the kernel. This is needed if you want to 
do one or both of the following:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel command 
line and other boot inputs for the  Integrity Measurement Architecture 
subsystem.

The above are the functions kexec already has built into kexec_file_load. I 
will soon post a set of patches which will allow a third feature:

3. have IMA pass-on its event log (where integrity measurements are 
registered) accross kexec to the second kernel, so that the event history is 
preserved.

Because OpenPower uses an intermediary Linux instance as a boot loader 
(skiroot), feature 1 is needed to implement secure boot for the platform, 
while features 2 and 3 are needed to implement trusted boot.

There's an LWN article giving more context on the origins of the system 
call, if you are interested:

https://lwn.net/Articles/603116/

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
