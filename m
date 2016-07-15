Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNsBI-0003Ya-EF
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 01:44:45 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6F1dLWw098340
 for <kexec@lists.infradead.org>; Thu, 14 Jul 2016 21:44:22 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 246hejg1jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 14 Jul 2016 21:44:22 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 14 Jul 2016 22:44:20 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Thu, 14 Jul 2016 22:44:14 -0300
In-Reply-To: <4321972.HZgDox36RC@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1678419.ODVtyXKVYJ@hactar> <4321972.HZgDox36RC@wuerfel>
MIME-Version: 1.0
Message-Id: <3520758.yAgMzqF1PF@hactar>
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
To: Arnd Bergmann <arnd@arndb.de>, Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 11:18:04 PM CEST Thiago Jung Bauermann wrote:
> > Am Mittwoch, 13 Juli 2016, 21:59:18 schrieb Arnd Bergmann:
> > > On Wednesday, July 13, 2016 3:45:41 PM CEST Thiago Jung Bauermann 
wrote:
> > > > Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> > > > 
> > > > For secure boot, Petitboot needs to use kexec_file_load, because of
> > > > the
> > > > following two features which the system call enables:
> > > > 
> > > > 1. only allow loading of signed kernels.
> > > > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > > > 
> > > >    command line and other boot inputs for the Integrity Measurement
> > > >    Architecture subsystem.
> > > > 
> > > > Those can't be done with kexec_load.
> > > 
> > > Can't petitboot do both of these in user space?
> > 
> > To be honest I'm not sure if it *can't* be done from userspace but if
> > you do it from the kernel you can guarantee that any kernel image that
> > is loaded gets verified and measured.
> > 
> > Whereas if you verify and measure the kernel in userspace then if
> > there's a vulnerability in the system which allows an attacker to
> > upload their own binary, then they can use kexec_load directly and
> > bypass the verification and measurement.
> > 
> > So it's a more resilient design.
> 
> Right, but the question remains whether this helps while you allow the
> boot loader to modify the dtb. If an attacker gets in and cannot modify
> the kernel or initid but can modify the DT, a successful attack would
> be a bit harder than having a modified kernel, but you may still need
> to treat the system as compromised.

Yes, and the same question also remains regarding the kernel command line.

We can have the kernel perform sanity checks on the device tree, just as the 
kernel needs to sanity check the command line.

There's the point that was raised about not wanting to increase the attack 
surface, and that's a valid point. But at least in the way Petitboot works 
today, it needs to modify the device tree and pass it to the kernel.

One thing that is unavoidable to come from userspace is 
/chosen/linux,stdout-path, because it's Petitboot that knows from which 
console the user is interacting with. The other modification to set 
properties in vga@0 can be done in the kernel.

Given that on DTB-based systems /chosen is an important and established way 
to pass information to the operating system being booted, I'd like to 
suggest the following, then:

Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
accepting a complete DTB from userspace, the syscall would accept a DTB 
containing only a /chosen node. If the DTB contains any other node, the 
syscall fails with EINVAL. The kernel can then add the properties in /chosen 
to the device tree that it will pass to the next kernel.

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
