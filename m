Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bO53d-0000Ge-AL
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 15:29:42 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6FFTHjx012056
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 11:29:20 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 246hek73mw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 11:29:20 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 12:29:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 12:29:09 -0300
In-Reply-To: <20160715133346.GD19840@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715132610.GD23514@redhat.com> <20160715133346.GD19840@leverpostej>
MIME-Version: 1.0
Message-Id: <1565504.8BCDUlPeYg@hactar>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Vivek Goyal <vgoyal@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

Am Freitag, 15 Juli 2016, 14:33:47 schrieb Mark Rutland:
> On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> > On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> > > On Thursday, July 14, 2016 10:44:14 PM CEST Thiago Jung Bauermann 
wrote:
> > > > Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> > > > > Right, but the question remains whether this helps while you allow
> > > > > the
> > > > > boot loader to modify the dtb. If an attacker gets in and cannot
> > > > > modify
> > > > > the kernel or initid but can modify the DT, a successful attack
> > > > > would
> > > > > be a bit harder than having a modified kernel, but you may still
> > > > > need
> > > > > to treat the system as compromised.
> > > > 
> > > > Yes, and the same question also remains regarding the kernel command
> > > > line.
> > > > 
> > > > We can have the kernel perform sanity checks on the device tree,
> > > > just as the kernel needs to sanity check the command line.
> > > > 
> > > > There's the point that was raised about not wanting to increase the
> > > > attack surface, and that's a valid point. But at least in the way
> > > > Petitboot works today, it needs to modify the device tree and pass
> > > > it to the kernel.
> > > > 
> > > > One thing that is unavoidable to come from userspace is
> > > > /chosen/linux,stdout-path, because it's Petitboot that knows from
> > > > which
> > > > console the user is interacting with. The other modification to set
> > > > properties in vga@0 can be done in the kernel.
> > > > 
> > > > Given that on DTB-based systems /chosen is an important and
> > > > established way to pass information to the operating system being
> > > > booted, I'd like to suggest the following, then:
> > > > 
> > > > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > > > instead of accepting a complete DTB from userspace, the syscall
> > > > would accept a DTB containing only a /chosen node. If the DTB
> > > > contains any other node, the syscall fails with EINVAL. The kernel
> > > > can then add the properties in /chosen to the device tree that it
> > > > will pass to the next kernel.
> > > > 
> > > > What do you think?
> > > 
> > > I think that helps, as it makes the problem space correspond to that
> > > of modifying the command line, but I can still come up with countless
> > > attacks based on modifications of the /chosen node and/or the command
> > > line, in fact it's probably easier than any other node.
> > 
> > I don't know anything about DTB. So here comes a very basic question.
> > Does DTB allow passing an executable blob to kernel or pass the
> > location of some unsigned executable code at kernel level. I think from
> > secureboot point of view that would be a concern. Being able to trick
> > kernel to execute an unsigned code at privileged level.
> 
> The DTB itself won't contain executable code.
> 
> However, arbitrary bindings could point kernel at such code. For
> instance, /chosen/linux,uefi-system-table could point the kernel at a
> faked EFI system table, with pointers to malicious code. So
> arbitrary modification of /chosen is not safe.

PowerPC doesn't have UEFI so this option is not a concern in that 
architecture. I'm having a look at what a PowerPC kernel gets from /chosen 
and haven't found anything of concern so far, but I'm still looking.

On the other hand, the kernel command line has the option acpi_rsdp, which 
is used to pass the address of the RSDP. I don't really know much about EFI 
so I'm not sure if it can be used to point to code that the kernel can 
execute, but it does point to tables that contain AML code.

> Bindings describe arbitrary system features (devices, firmware
> interfaces, etc), so in general they might provide mechanisms to execute
> code.

Even bindings in /chosen?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
