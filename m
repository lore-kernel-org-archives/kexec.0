Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <4197460.etrDupniY8@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
 <4197460.etrDupniY8@hactar>
Date: Fri, 22 Jul 2016 12:54:28 +1000
Message-ID: <878twutmaj.fsf@concordia.ellerman.id.au>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Freitag, 15 Juli 2016, 18:03:35 schrieb Thiago Jung Bauermann:
>> Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
>> > However, the powerpc specific RTAS runtime services provide a similar
>> > interface to the UEFI runtime support and allow to call into
>> > binary code from the kernel, which gets mapped from a physical
>> > address in the "linux,rtas-base" property in the rtas device node.
>> > 
>> > Modifying the /rtas node will definitely give you a backdoor into
>> > priviledged code, but modifying only /chosen should not let you get
>> > in through that specific method.
>> 
>> Except that arch/powerpc/kernel/rtas.c looks for any node in the tree
>> called "rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.
>> 
>> We can forbid subnodes in /chosen in the dtb passed to kexec_file_load,
>> though that means userspace can't use the simple-framebuffer binding via
>> this mechanism.
>> 
>> We also have to blacklist the device_type and compatible properties in
>> /chosen to avoid the problem Mark mentioned.
>> 
>> Still doable, but not ideal. :-/
>
> So even if not ideal, the solution above is desirable for powerpc. We would 
> like to preserve the ability of allowing userspace to pass parameters to the 
> OS via the DTB, even if secure boot is enabled.
>
> I would like to turn the above into a proposal:
>
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall accepts a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
> there's a compatible or device_type property in /chosen, the syscall fails 
> with EINVAL as well.
>
> The kernel can then add the properties in /chosen to the device tree that it 
> will pass to the next kernel.
>
> What do you think?

I think we will inevitably have someone who wants to pass something
other than a child of /chosen.

At that point we would be faced with adding yet another syscall, or at
best a new flag.

I think we'd be better allowing userspace to pass a DTB, and having an
explicit whitelist (in the kernel) of which nodes & properties are
allowed in that DTB.

For starters it would only contain /chosen/stdout-path (for example).
But we would be able to add new nodes & properties in future.

The downside is userspace would have no way of detecting the content of
the white list, other than trial and error. But in practice I'm not sure
that would be a big problem.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
