Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dYeWb-0003Id-NH
 for kexec@lists.infradead.org; Fri, 21 Jul 2017 20:27:51 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LKOWaI082430
 for <kexec@lists.infradead.org>; Fri, 21 Jul 2017 16:27:27 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2buqp3sx5e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 21 Jul 2017 16:27:27 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <cjashfor@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 16:27:26 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6LKROjL20709508
 for <kexec@lists.infradead.org>; Fri, 21 Jul 2017 20:27:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD6AF2803D
 for <kexec@lists.infradead.org>; Fri, 21 Jul 2017 16:27:17 -0400 (EDT)
Received: from [9.70.82.79] (unknown [9.70.82.79])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 7E5472803A
 for <kexec@lists.infradead.org>; Fri, 21 Jul 2017 16:27:17 -0400 (EDT)
From: Corey Ashford <cjashfor@linux.vnet.ibm.com>
Subject: Guest shutdown problem with kexec --load ... ; kexec --exec running
 under Xen on CentOS 7 (x86_64)
Date: Fri, 21 Jul 2017 13:27:22 -0700
MIME-Version: 1.0
Content-Language: en-US
Message-Id: <4155a1f4-d31e-e9b5-97ff-d4833f97ed73@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: cjashfor@us.ibm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The platform is a PVHVM guest of CentOS 7 (x86_64) running on a 
XenServer (version 6.5 and 7.2 both have the same behavior).

This is the kexec-tools rpm build we are using:

kexec-tools-2.0.7-50.el7.x86_64

If we run these two commands:

kexec --load /boot/vmlinux-<current kernel> --initrd=/boot/initramfs 
<corresponding initramfs for current kernel> --reuse-cmdline

kexec --exec

The first line succeeds without errors, but the second one causes the VM 
to immediately shutdown, and there's no further output on the console. 
We've tried adding a number of different kernel command line options, 
such as: debug=1 early_printk=xen loglevel=9

We've also tried blacklisting the PV drivers.

This sequence works fine on KVM, VMware, and also on bare-metal machines.

Is this expected behavior on Xen with CentOS 7.x?  We have scoured the 
kexec-tools mailing list, googled extensively, and haven't come up with 
much help.  We've also tried changing various kernel config parameters 
related to Xen, but the behavior doesn't change.

Any info, debugging advice, suggestions would be appreciated.

Thanks for your consideration,

- Corey

Corey Ashford
IBM Embedded Linux, software engineer
cjashfor@us.ibm.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
