Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKsW5-000286-TE
 for kexec@lists.infradead.org; Wed, 06 Jul 2016 19:29:50 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66JSog9052197
 for <kexec@lists.infradead.org>; Wed, 6 Jul 2016 15:29:27 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xmd5xr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 15:29:27 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 16:29:25 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Wed, 06 Jul 2016 16:29:18 -0300
In-Reply-To: <20160706075226.27609-9-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <6483018.WWW2TSJB10@hactar>
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
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi,

Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
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

Again, this description is wrong for PowerPC. See messages from myself and 
Michael Ellerman:

https://lists.infradead.org/pipermail/kexec/2016-June/016250.html

https://lists.infradead.org/pipermail/kexec/2016-June/016253.html

IMHO, it would be simpler if ARM used linux,usable-memory in the same way 
that PowerPC does, for consistency.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
