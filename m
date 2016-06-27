Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bHbBH-0007zx-Gu
 for kexec@lists.infradead.org; Mon, 27 Jun 2016 18:22:48 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RIJMPp061984
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 14:22:25 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sjvwu9fh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 14:22:25 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 15:22:23 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 202A41DC006F
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 14:22:14 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RIMLm329098424
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 15:22:21 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RIML0x020798
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 15:22:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v20 14/14] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Mon, 27 Jun 2016 15:22:18 -0300
In-Reply-To: <e212cd53fdf9d09923408eb906fe0228d22432a9.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
 <e212cd53fdf9d09923408eb906fe0228d22432a9.1466702804.git.geoff@infradead.org>
MIME-Version: 1.0
Message-Id: <9127562.8x2DzY0I6N@hactar>
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
To: Geoff Levand <geoff@infradead.org>, James Morse <james.morseatarm.com@hactar>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

Hello,

Am Donnerstag, 23 Juni 2016, 17:54:49 schrieb Geoff Levand:
> +linux,usable-memory
> +-------------------
> +
> +This property is set on PowerPC and arm64 by kexec-tools during kdump
> +to tell the crash kernel the base address of its reserved area of memory,
> and +the size. e.g.
> +
> +/ {
> +	chosen {
> +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> +	};
> +};

On powerpc, linux,usable-memory isn't in /chosen. It is put by kexec-tools 
in each /memory node and has the same format as the reg property. During 
early boot, the kernel goes through the /memory nodes to find usable memory 
and for each node, if there's a linux,usable-memory property it will use it 
instead of the reg property to find the ranges of memory it can use (see 
early_init_dt_scan_memory in drivers/of/fdt.c).

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
