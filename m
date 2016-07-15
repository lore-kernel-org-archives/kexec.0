Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 09:31:02 +0200
Message-ID: <5547846.5l81k4b13o@wuerfel>
In-Reply-To: <3520758.yAgMzqF1PF@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4321972.HZgDox36RC@wuerfel> <3520758.yAgMzqF1PF@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On Thursday, July 14, 2016 10:44:14 PM CEST Thiago Jung Bauermann wrote:
> Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:

> > 
> > Right, but the question remains whether this helps while you allow the
> > boot loader to modify the dtb. If an attacker gets in and cannot modify
> > the kernel or initid but can modify the DT, a successful attack would
> > be a bit harder than having a modified kernel, but you may still need
> > to treat the system as compromised.
> 
> Yes, and the same question also remains regarding the kernel command line.
> 
> We can have the kernel perform sanity checks on the device tree, just as the 
> kernel needs to sanity check the command line.
> 
> There's the point that was raised about not wanting to increase the attack 
> surface, and that's a valid point. But at least in the way Petitboot works 
> today, it needs to modify the device tree and pass it to the kernel.
> 
> One thing that is unavoidable to come from userspace is 
> /chosen/linux,stdout-path, because it's Petitboot that knows from which 
> console the user is interacting with. The other modification to set 
> properties in vga@0 can be done in the kernel.
> 
> Given that on DTB-based systems /chosen is an important and established way 
> to pass information to the operating system being booted, I'd like to 
> suggest the following, then:
> 
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall would accept a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. The kernel can then add the properties in /chosen 
> to the device tree that it will pass to the next kernel.
> 
> What do you think?

I think that helps, as it makes the problem space correspond to that
of modifying the command line, but I can still come up with countless
attacks based on modifications of the /chosen node and/or the command
line, in fact it's probably easier than any other node.

What methods to we have in place for command line changes today on
other architectures?

	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
