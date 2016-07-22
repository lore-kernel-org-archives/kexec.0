Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQhGv-0005oU-Ex
 for kexec@lists.infradead.org; Fri, 22 Jul 2016 20:42:14 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6MKd1ux094021
 for <kexec@lists.infradead.org>; Fri, 22 Jul 2016 16:41:52 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24bhktkasm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 22 Jul 2016 16:41:51 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 22 Jul 2016 17:41:50 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 22 Jul 2016 17:41:40 -0300
In-Reply-To: <878twutmaj.fsf@concordia.ellerman.id.au>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4197460.etrDupniY8@hactar> <878twutmaj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1732711.nTAkJm8nA3@hactar>
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
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Freitag, 22 Juli 2016, 12:54:28 schrieb Michael Ellerman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > So even if not ideal, the solution above is desirable for powerpc. We
> > would like to preserve the ability of allowing userspace to pass
> > parameters to the OS via the DTB, even if secure boot is enabled.
> > 
> > I would like to turn the above into a proposal:
> > 
> > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > instead of accepting a complete DTB from userspace, the syscall accepts
> > a DTB containing only a /chosen node. If the DTB contains any other
> > node, the syscall fails with EINVAL. If the DTB contains any subnode in
> > /chosen, or if there's a compatible or device_type property in /chosen,
> > the syscall fails with EINVAL as well.
> > 
> > The kernel can then add the properties in /chosen to the device tree
> > that it will pass to the next kernel.
> > 
> > What do you think?
> 
> I think we will inevitably have someone who wants to pass something
> other than a child of /chosen.
> 
> At that point we would be faced with adding yet another syscall, or at
> best a new flag.
> 
> I think we'd be better allowing userspace to pass a DTB, and having an
> explicit whitelist (in the kernel) of which nodes & properties are
> allowed in that DTB.

Sounds good to me.

> For starters it would only contain /chosen/stdout-path (for example).
> But we would be able to add new nodes & properties in future.

If we allow things outside of chosen, we can keep the offb.c hook in 
Petitboot and whitelist the framebuffer properties it adds to the vga node.

> The downside is userspace would have no way of detecting the content of
> the white list, other than trial and error. But in practice I'm not sure
> that would be a big problem.

For our use case in OpenPower I don't think it would be a problem, since the 
userspace and the kernel are developed together.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
