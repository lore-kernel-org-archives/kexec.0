Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NjKbD-0006Oq-EA
	for kexec@lists.infradead.org; Sun, 21 Feb 2010 22:48:31 +0000
Date: Mon, 22 Feb 2010 09:48:25 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: mip64: kexec: Probem in allocating resevr mem
Message-ID: <20100221224825.GI5712@verge.net.au>
References: <4d358c531001280506p2169fad8gdde3c23d989870e1@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d358c531001280506p2169fad8gdde3c23d989870e1@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vishnu Yadav <vishnuyadav@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>, kexec@lists.infradead.org

On Thu, Jan 28, 2010 at 06:36:07PM +0530, Vishnu Yadav wrote:
> Hi
> I am  not able to reserve the memory in mips 64 plateform for "crash kernel"
> 
> in below function of arch/mips/kernel/setup.c file of kernel code
> reserve_bootmem(start, size , flags)
> if i put flags= BOOTMEM_DEFAULT then this function succeeds but doesnt
> reserve  mem of crash kernel .. i verified it by seeing /proc/iomem
> 
> but if i put flags= BOOTMEM_EXCLUSIVE .. this function itself fails and
> again no memry is reseved.
> 
> 
> Pls suggest me how to resevre mem regio for "crash kernel" in mips 64. NOTE-
> I have applied kernel as well as user spaces patches for running kexec on
> mips64.

Does Maxim Uvarov's recent patch help you at all?

http://lists.infradead.org/pipermail/kexec/2010-February/003816.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
