Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKrJ0-0003J7-SS
 for kexec@lists.infradead.org; Wed, 06 Jul 2016 18:12:15 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66I8f0u109612
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 14:11:53 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xn2nee-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 14:11:52 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 15:11:50 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
Date: Wed, 06 Jul 2016 15:11:45 -0300
In-Reply-To: <20160706075226.27609-2-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <2543175.KeBui093Sr@hactar>
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
To: kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, Mark Salter <msalter@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Mittwoch, 06 Juli 2016, 16:52:19 schrieb AKASHI Takahiro:
> On the startup of primary kernel, the memory region used by crash dump
> kernel must be specified by "crashkernel=" kernel parameter.
> reserve_crashkernel() will allocate and reserve the region for later use.
> 
> User space tools, like kexec-tools, will be able to find that region
> marked as "Crash kernel" in /proc/iomem.

On powerpc, userspace tools get everything from the device tree (exposed to 
userspace in /proc/device-tree/), not /proc/iomem.

In the case of the crashkernel reserved region, that information is in 
/chosen/linux,crashkernel-base and /chosen/linux,crashkernel-size.

Either way is fine I think. I'm just mentioning this for reference in case 
you want the ARM implementation to be closer to another arch which is also 
based on the device tree.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
