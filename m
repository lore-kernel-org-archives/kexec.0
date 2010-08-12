Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from zimbra.tgsmc.com ([63.118.209.91])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ojbzo-0007k2-JF
	for kexec@lists.infradead.org; Thu, 12 Aug 2010 17:55:17 +0000
Subject: Re: kexec problem on CentOS 5.3
From: Josh England <josh@tgsmc.com>
In-Reply-To: <20100812010858.GC2258@localhost.localdomain>
References: <1281558332.1953.1058.camel@ijosh1>
	<20100812010858.GC2258@localhost.localdomain>
Date: Thu, 12 Aug 2010 10:55:14 -0700
Message-ID: <1281635714.1939.50.camel@ijosh1>
Mime-Version: 1.0
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, 2010-08-11 at 21:08 -0400, Neil Horman wrote:
> On Wed, Aug 11, 2010 at 01:25:32PM -0700, Josh England wrote:
> > Invalid memory segment (nil) - 0x309fff
> > 
> ususally I see erors like that when you don't have sufficient memory reserved.
> try bumping up your crashkernel allocation to 128M

I just tried crashkernel=128M@16M and also crashkernel=256M@16M and it
keeps giving me the same error.  Shouldn't the (nil) actually be
something like 0x100000, corresponding to the 16M physical memory offset
of the kernel?  Looking at my kernel config, it doesn't even have a
CONFIG_PHYSICAL_START setting available.

-JE



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
