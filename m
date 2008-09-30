Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KkcfL-0007Nd-Lo
	for kexec@lists.infradead.org; Tue, 30 Sep 2008 10:41:16 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m8UAds8Z009040
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 20:39:54 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8UAcPRK213140
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 20:38:25 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8UAcOKx005561
	for <kexec@lists.infradead.org>; Tue, 30 Sep 2008 20:38:24 +1000
Message-ID: <48E20195.9090306@in.ibm.com>
Date: Tue, 30 Sep 2008 16:08:13 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] kdump: add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
References: <200809241718.59719.chandru@in.ibm.com>
In-Reply-To: <200809241718.59719.chandru@in.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org

Chandru wrote:
> /proc/device-tree on power6 machines has ibm,dynamic-reconfiguration-memory 
> node which stores in it the memory representation for most part of the system 
> memory. This memory was earlier represented in 'memory@' nodes of the device 
> tree.  Following patch series makes kexec-tools aware of this dynamic 
> reconfiguration memory node. These patches were sent earlier for RFC. In 
> addition to this, a change in the kernel was also required. The kernel change 
> has been accepted in powerpc git tree. 
> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=cf00085d8045cddd80a8aabad97de96fa8131793
> Some part of the patch here is re-organization of the existing code to 
> accommodate dynamic reconf memory. 
>
>   
I tested this patch series on a ppc64 box and they work fine.
Without these patches i get a zero size vmcore on a power(power6)
box which has support for dynamic-reconfiguration-memory.

Horms could you please consider this patch series and merge them
if found suitable.

Regards
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
