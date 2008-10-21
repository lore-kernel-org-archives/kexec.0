Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsLrs-0001nU-Ie
	for kexec@lists.infradead.org; Tue, 21 Oct 2008 18:22:14 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9LIM3bk012975
	for <kexec@lists.infradead.org>; Tue, 21 Oct 2008 14:22:03 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9LILtH6125952
	for <kexec@lists.infradead.org>; Tue, 21 Oct 2008 14:21:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9LILsu3004565
	for <kexec@lists.infradead.org>; Tue, 21 Oct 2008 14:21:54 -0400
Message-ID: <48FE1DBC.7030202@in.ibm.com>
Date: Tue, 21 Oct 2008 23:51:48 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Support for relocatable kdump kernel
References: <18684.5062.154465.668614@drongo.ozlabs.ibm.com>
	<1224485038.9055.34.camel@localhost> <48FC5097.5090908@in.ibm.com>
	<1224569019.8228.29.camel@localhost>
In-Reply-To: <1224569019.8228.29.camel@localhost>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: michael@ellerman.id.au
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, kexec <kexec@lists.infradead.org>

Michael Ellerman wrote:

> Does it? I see CONFIG_CRASH_DUMP depending on PPC64, so there is no
> 32-bit kdump possible. Or is someone working on it out-of-tree?
> 

IIUC Anton Vorontsov is working on the 32-bit kdump kernel support.

>> Do you expect a function to do the checking in iommu.c?
> 
> You'd use the function in iommu.c, but it should be defined in some
> header.
> 
Yeah, I will do that.

> OK. Does old purgatory ensure that the register is 0? Otherwise I think
> it's possible that a new kernel could get confused by cruft left in that
> register by an old purgatory - causing the 2nd kernel to think it's a
> kdump kernel when it shouldn't be.

__kdump_flag is by default is 0 and old purgatory code even won't know 
that it need to modify __kdump_flag. So unless __kdump_flag is 1, the 
kernel will behave as a normal one.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
