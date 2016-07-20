Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160720083530.GK1041@n2100.armlinux.org.uk>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com> <1468845964.2800.3.camel@gmail.com>
 <20160718132629.GB32512@redhat.com>
 <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk>
Date: Wed, 20 Jul 2016 20:47:45 +1000
Message-ID: <87zipc8u26.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Balbir Singh <bsingharora@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, arnd@arndb.de, Petr Tesarik <ptesarik@suse.cz>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Wed, Jul 20, 2016 at 01:45:42PM +1000, Balbir Singh wrote:
>> > IOW, if your kernel forced signature verification, you should not be
>> > able to do sig_enforce=0. If you kernel did not have
>> > CONFIG_MODULE_SIG_FORCE=y, then sig_enforce should be 0 by default anyway
>> > and you are not making it worse using command line.
>> 
>> OK.. I checked and you are right, but that is an example and there are
>> other things like security=, thermal.*, nosmep, nosmap that need auditing
>> for safety and might hurt the system security if used. I still think
>> think that assuming you can pass any command line without breaking security
>> is a broken argument.
>
> Quite, and you don't need to run code in a privileged environment to do
> any of that.
>
> It's also not trivial to protect against: new kernels gain new arguments
> which older kernels may not know about.  No matter how much protection
> is built into older kernels, newer kernels can become vulnerable through
> the addition of further arguments.

Indeed. A whitelist of allowed command line arguments is the only option.

But given the existing syscall has shipped without a whitelist of command line
arguments, you can't add a whitelist now without potentially breaking someone's
setup.

Getting back to the device tree, we could similarly have a whitelist of
nodes/properties that we allow to be passed in.

At least for stdout-path, I can't really see how that would significantly help
an attacker, but I'm all ears if anyone has ideas.

> Also, how sure are we that there are no stack overflow issues with kernel
> command line parsing?  Can we be sure that there's none?  This is
> something which happens early in the kernel boot, before the full memory
> protections have been set up.

Yeah that's also a good point. More so for the device tree, because the parsing
is more complicated. I think there has been some work done on fuzzing libfdt,
but we should probably do more.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
