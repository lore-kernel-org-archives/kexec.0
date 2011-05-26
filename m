Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPeQA-0002sI-K5
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:32:32 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4QHQvdZ002551
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:26:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4QHW5gq729284
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:32:05 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4QHW4Tm027803
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:32:05 +1000
Date: Thu, 26 May 2011 23:01:56 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 0/6] slimdump: Enable slimdump if crashing kernel
	memory is not required
Message-ID: <20110526173156.GC18295@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526170722.GB23266@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 26, 2011 at 10:37:22PM +0530, K.Prasad wrote:
> Hi All,

A small correction related to patch description...

> 
> Summary of the patches
> ----
> Patch 1, 2 - Patches from Andi Kleen's tree
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-mce-2.6.git which
> introduce an enhanced panic function - xpanic().
> 

Patch 3 - A small bugfix for patch 1,2

Patch 4 - Introduces a new PANIC_MCE flag to signal the need for slimdump
for MCE initiated panic calls. Appends a new elf-note inside coredump
containing MCE related registers.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
