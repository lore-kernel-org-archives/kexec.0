Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRPXK-0001nu-1Z
 for kexec@lists.infradead.org; Thu, 25 Oct 2012 15:39:59 +0000
Date: Thu, 25 Oct 2012 11:39:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121025153937.GE9377@redhat.com>
References: <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
 <20121023145920.GD16496@redhat.com>
 <20121023154123.GA30730@srcf.ucam.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121023154123.GA30730@srcf.ucam.org>
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
To: Matthew Garrett <mjg@redhat.com>
Cc: "Kasatkin, Dmitry" <dmitry.kasatkin@intel.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Tue, Oct 23, 2012 at 04:41:24PM +0100, Matthew Garrett wrote:
> On Tue, Oct 23, 2012 at 10:59:20AM -0400, Vivek Goyal wrote:
> 
> > But what about creation of a new program which can call kexec_load()
> > and execute an unsigned kernel. Doesn't look like that will be
> > prevented using IMA.
> 
> Right. Trusting userspace would require a new system call that passes in 
> a signature of the userspace binary, and the kernel would then have to 
> verify the ELF object in memory in order to ensure that it 
> matches the signature.

[ CC lkml and IMA/EVM developers ]

Not sure how much of this is feasible. There is initialized data which
can change. That means we shall have to exclude initialized data from
digest. And then initialized data can be changed by attacker.

I think in the context of kexec, purgatory (which is actually a
relocatable executable), is embedded in kexec binary as "const char
purgatory[]". I am assuming that it will show up as initialized data
in /sbin/kexec. And if we do not include initialized data in digest
calculation, then one can overwrite purgatory with its own executable
code and kexec will load it into the kernel and let it run at priviliged
level.

So looks like even above will not be foolproof. (Assuming we can do
this. I thought we lost all the elf headers after loading elf 
binary and now we don't know which mmpaed areas need to be included
in digest and which should not be).
 
> Verifying that the copy on the filesystem is 
> unmodified isn't adequate - an attacker could simply have paused the 
> process and injected code.

This is an interesting point. So even if we verify the signature of
/sbin/kexec, parent can change the code (using ptrace() interface?).
And we are again prone to attack. So this will work if we are doing
integrity/authenticity checks on all root processes and not just
one /sbin/kexec.

> Realistically, the only solution here is for 
> the kernel to verify that the kernel it's about to boot is signed and 
> for it not to take any untrusted executable code from userspace.

Hmm.., given above, looks like implementing a new system call to pass
in full kernel and initramfs (along with some command line or other
parameters), becomes interesting.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
