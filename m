Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QHhr4-0006Ol-18
	for kexec@lists.infradead.org; Wed, 04 May 2011 19:35:27 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p44JYvnC011133
	for <kexec@lists.infradead.org>; Thu, 5 May 2011 05:34:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p44JZHEv2494686
	for <kexec@lists.infradead.org>; Thu, 5 May 2011 05:35:18 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p44JZHPY020451
	for <kexec@lists.infradead.org>; Thu, 5 May 2011 05:35:17 +1000
Date: Thu, 5 May 2011 01:05:09 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [RFC] Kdump and memory error handling
Message-ID: <20110504193509.GA5342@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "Luck,
	Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, Vivek Goyal <vgoyal@redhat.com>

Hi All,
        We've been trying to study and improve the kdump behaviour when
a panic is triggered due to an unrecoverable memory error causing a
machine check exception (MCE) followed by a kernel panic.

In this context we foresee a few issues in capturing kdump and would
like to receive comments about the ways to handle them.

Probable Issues when capturing coredump through kdump following a memory
error
---------------------------
- First, a coredump of the memory from the crashing kernel isn't really
  helpful in debugging the crash that was caused due to a faulty memory.
  Collecting the same has some of the problems illustrated below. It should
  therefore suffice to let the user know the reason of the crash
  rather than provide a complete dump of the memory.

  For this, a 'slim' yet crash-tool readable coredump containing:
  - message about the cause (such as crash due to unrecoverable memory error)
    in the coredump's elf-note section.
  - and no data from the memory of the 'crashing' kernel (their elf
    sections can be reduced to zero length).
  may be suitable.

- Alternatively, if the kdump kernel decides to capture the coredump,
  its attempts to read the faulty memory location may lead to subsequent 
  faults in the context of kdump kernel with fatal consequences. This
  may either be avoided by:

  a) Pass the address of the corrupt memory location to the kdump kernel
  and skip reading that location while creating the vmcore. This needs
  an instance of 'struct mce' (from the 'crashing' kernel), which
  already contains the faulty memory address (in the physical address
  form, which should be confirmed using the IA32_MCi_MISC[8:6] bits stored
  in 'misc' field of 'struct mce') to be populated inside the elf
  (-notes?) section.

  b) Use modified copy applications (such as a modified 'cp' command)
  that can map the /dev/oldmem into user-space and then initiate the
  creation of vmcore. In this method, the user-space process performing
  the copy will receive a SIGBUS while consuming the faulty memory (through
  INT18 -> do_machine_check) but it must be modified to be resilient to the
  signal, while intelligently skipping to the subsequent memory location
  for further copying. Meanwhile the data for the faulty memory location
  can be represented using 'zero-ed' data and the vmcore enhanced to
  indicate the cause of the crash as one resulting from a fatal MCE.

Any thoughts/suggestions?

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
