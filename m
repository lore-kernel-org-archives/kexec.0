Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0EyT-0007aK-U1
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 00:59:43 +0000
References: <20190715082702.27308-1-svens@stackframe.org>
 <20190715082702.27308-3-svens@stackframe.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 2/7] kexec_elf: change order of elf_*_to_cpu() functions
In-reply-to: <20190715082702.27308-3-svens@stackframe.org>
Date: Tue, 20 Aug 2019 21:59:30 -0300
Message-ID: <87y2znmiz1.fsf@morokweng.localdomain>
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
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Sven Schnelle <svens@stackframe.org> writes:

> Change the order to have a 64/32/16 order, no functional change.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
