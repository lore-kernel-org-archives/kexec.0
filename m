Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bOAHG-0003QE-Va
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 21:04:08 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6FL3hQJ073900
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:03:44 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 246hemqksm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 15 Jul 2016 17:03:43 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 15 Jul 2016 18:03:41 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 18:03:35 -0300
In-Reply-To: <3489461.zQnV5C1bXR@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715134209.GF1041@n2100.armlinux.org.uk> <3489461.zQnV5C1bXR@wuerfel>
MIME-Version: 1.0
Message-Id: <1808359.GMbkTHC4O6@hactar>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
> On Friday, July 15, 2016 2:42:10 PM CEST Russell King - ARM Linux wrote:
> > On other architectures, DT can also contain open-firmware "functions"
> > but I don't think there's much support in the kernel for that - maybe
> > the PPC folk can reply on that point.
> 
> The open firmware runtime interface are shut down by the time we have
> a flattened device tree, so those are not accessible any more. IIRC
> SPARC leaves the open firmware interface live, but it doesn't use
> fdt, so that's not relevant here.
> 
> However, the powerpc specific RTAS runtime services provide a similar
> interface to the UEFI runtime support and allow to call into
> binary code from the kernel, which gets mapped from a physical
> address in the "linux,rtas-base" property in the rtas device node.
> 
> Modifying the /rtas node will definitely give you a backdoor into
> priviledged code, but modifying only /chosen should not let you get
> in through that specific method.

Except that arch/powerpc/kernel/rtas.c looks for any node in the tree called 
"rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.

We can forbid subnodes in /chosen in the dtb passed to kexec_file_load, 
though that means userspace can't use the simple-framebuffer binding via 
this mechanism.

We also have to blacklist the device_type and compatible properties in 
/chosen to avoid the problem Mark mentioned.

Still doable, but not ideal. :-/

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
