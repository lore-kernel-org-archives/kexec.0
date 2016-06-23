Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bG6hy-00046M-VX
 for kexec@lists.infradead.org; Thu, 23 Jun 2016 15:38:23 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NFY0CS098878
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 11:38:00 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qq3ma43b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 11:37:59 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 12:37:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AA293352005C
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 11:37:38 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NFbtZE16646558
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 12:37:55 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5NFbtSQ017673
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 12:37:55 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Thu, 23 Jun 2016 12:37:49 -0300
In-Reply-To: <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160623023052.GB12575@dhcp-128-11.nay.redhat.com>
 <2090497645.1524307.1466660647378.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Message-Id: <4923900.bfxGnX6mM2@hactar>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> Hmm, hold on. For declaring a struct in a header file, comment should be
> just after each fields, like below, your format is for a function instead:
> struct pci_slot {
>         struct pci_bus *bus;            /* The bus this slot is on */
>         struct list_head list;          /* node in list of slots on this
> bus */ struct hotplug_slot *hotplug;   /* Hotplug info (migrate over
> time) */ unsigned char number;           /* PCI_SLOT(pci_dev->devfn) */
> struct kobject kobj;
> };

The comment style you mention above is not extractable documentation. The 
style I used is what is described in section "kernel-doc for structs, 
unions, enums, and typedefs" in Documentation/kernel-doc-nano-HOWTO.txt.
 
> BTW, what is @size? there's no size field in kexec_buf. I think it is not
> necessary to add these comment, they are easy to understand. If you really
> want, please rewrite them correctly, for example "image" description is
> wrong. It is not only for searching memory only, top_down description is
> also bad.

Sorry, I moved these comments from kexec_locate_mem_hole but forgot to 
rename the parameters to what they are called in struct kexec_buf. @size 
should have been @memsz (other fields also have wrong names, I'll fix them 
as well). The image description is correct in the context of where struct 
kexec_buf is used and explains what it will be used for in the function 
taking kexec_buf as an argument. It is not meant as a general description of 
the purpose of struct kimage. What is bad about the description of top_down?

I decided to add these comments because struct kexec_buf is now part of the 
kernel API for kexec. kernel-doc-nano-HOWTO.txt says:

> We definitely need kernel-doc formatted documentation for functions
> that are exported to loadable modules using EXPORT_SYMBOL.
> 
> We also look to provide kernel-doc formatted documentation for
> functions externally visible to other kernel files (not marked
> "static").
> 
> We also recommend providing kernel-doc formatted documentation
> for private (file "static") routines, for consistency of kernel
> source code layout.  But this is lower priority and at the
> discretion of the MAINTAINER of that kernel source file.

If you think they are not necessary or just add clutter I can leave them 
out.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
