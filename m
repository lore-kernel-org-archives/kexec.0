Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1daEp2-0007ZD-JL
 for kexec@lists.infradead.org; Wed, 26 Jul 2017 05:25:26 +0000
Date: Wed, 26 Jul 2017 13:16:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Guest shutdown problem with kexec --load ... ; kexec --exec
 running under Xen on CentOS 7 (x86_64)
Message-ID: <20170726051601.GA5925@dhcp-128-65.nay.redhat.com>
References: <4155a1f4-d31e-e9b5-97ff-d4833f97ed73@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4155a1f4-d31e-e9b5-97ff-d4833f97ed73@linux.vnet.ibm.com>
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
To: cjashfor@us.ibm.com
Cc: vkuznets@redhat.com, kexec@lists.infradead.org

Cc Vitaly Kuznetsov, who is the expert of kdump on xen guest issues, but
I'm not sure if he ever tried kexec reboot..
 
On 07/21/17 at 01:27pm, Corey Ashford wrote:
> The platform is a PVHVM guest of CentOS 7 (x86_64) running on a XenServer
> (version 6.5 and 7.2 both have the same behavior).
> 
> This is the kexec-tools rpm build we are using:
> 
> kexec-tools-2.0.7-50.el7.x86_64
> 
> If we run these two commands:
> 
> kexec --load /boot/vmlinux-<current kernel> --initrd=/boot/initramfs
> <corresponding initramfs for current kernel> --reuse-cmdline
> 
> kexec --exec
> 
> The first line succeeds without errors, but the second one causes the VM to
> immediately shutdown, and there's no further output on the console. We've
> tried adding a number of different kernel command line options, such as:
> debug=1 early_printk=xen loglevel=9
> 
> We've also tried blacklisting the PV drivers.
> 
> This sequence works fine on KVM, VMware, and also on bare-metal machines.
> 
> Is this expected behavior on Xen with CentOS 7.x?  We have scoured the
> kexec-tools mailing list, googled extensively, and haven't come up with much
> help.  We've also tried changing various kernel config parameters related to
> Xen, but the behavior doesn't change.
> 
> Any info, debugging advice, suggestions would be appreciated.
> 
> Thanks for your consideration,
> 
> - Corey
> 
> Corey Ashford
> IBM Embedded Linux, software engineer
> cjashfor@us.ibm.com
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
