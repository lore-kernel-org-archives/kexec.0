Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bCXEf-0003zG-Cz
 for kexec@lists.infradead.org; Mon, 13 Jun 2016 19:09:43 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DJ8lWX070999
 for <kexec@lists.infradead.org>; Mon, 13 Jun 2016 15:08:59 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23getm1arf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 13 Jun 2016 15:08:52 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 16:08:24 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E311B1DC006D
 for <kexec@lists.infradead.org>; Mon, 13 Jun 2016 15:08:14 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DJ8L5N28246514
 for <kexec@lists.infradead.org>; Mon, 13 Jun 2016 16:08:21 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DJ8Ltx017357
 for <kexec@lists.infradead.org>; Mon, 13 Jun 2016 16:08:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] kexec_file: Generalize kexec_add_buffer.
Date: Mon, 13 Jun 2016 16:08:19 -0300
In-Reply-To: <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465701022-11601-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160613072939.GD4974@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <11831785.bAnhpkoBlL@hactar>
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

Hello Dave,

Thanks for the quick review and for your comments.

I'll separate the change to add arch_walk_system_ram and the change to add 
kexec_locate_mem_hole into different patches, and add error handling for 
KEXEC_ON_CRASH.

Am Montag, 13 Juni 2016, 15:29:39 schrieb Dave Young:
> On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> > Allow architectures to specify different memory walking functions for
> > kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> > but PowerPC uses the memblock subsystem.
> 
> Can the crashk_res be inserted to iomem_resource so that only one
> weak function for system ram is needed?

Sorry, it's not clear to me what you mean by inserting crashk_res into 
iomem_resource, but I can add a bool for_crashkernel to arch_walk_system_ram 
so that it can decide which kind of memory to traverse, so the default 
implementation of kexec_file.c would be:

int __weak arch_walk_system_ram(bool for_crashkernel, unsigned long start,
				unsigned long end, bool top_down,
				void *data,
				int (*func)(u64, u64, void *))
{
	int ret;

	if (for_crashkernel)
		ret = walk_iomem_res_desc(crashk_res.desc,
					  IORESOURCE_SYSTEM_RAM |
					  IORESOURCE_BUSY,
					  start, end, data, func);
	else
		ret = walk_system_ram_res(start, end, data, func);

	if (ret != 1) {
		/* A suitable memory range could not be found for buffer */
		return -EADDRNOTAVAIL;
	}
}

and kexec_add_buffer / kexec_locate_mem_hole would call it with:

	if (image->type == KEXEC_TYPE_CRASH)
		ret = arch_walk_system_ram(true, crashk_res.start,
					   crashk_res.end, top_down, &buf,
					   locate_mem_hole_callback);
	else
		ret = arch_walk_system_ram(false, 0, -1, top_down, &buf,
					   locate_mem_hole_callback);

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
