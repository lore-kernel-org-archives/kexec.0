Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjMI4-0007Pu-Ds
	for kexec@lists.infradead.org; Thu, 12 Aug 2010 01:09:05 +0000
Date: Wed, 11 Aug 2010 21:08:58 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec problem on CentOS 5.3
Message-ID: <20100812010858.GC2258@localhost.localdomain>
References: <1281558332.1953.1058.camel@ijosh1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1281558332.1953.1058.camel@ijosh1>
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
To: Josh England <josh@tgsmc.com>
Cc: kexec@lists.infradead.org

On Wed, Aug 11, 2010 at 01:25:32PM -0700, Josh England wrote:
> I'm running CentOS 5.3 on x86_64 platform with kernel version
> 2.6.18-128.el5 and having issues running kexec.  I've got the kernel
> built with CONFIG_KEXEC and CONFIG_CRASH_DUMP, and I'm booting with
> crashkernel=64M@16M, but anytime I try to load a kernel with kexec I get
> the following:
> 
> Invalid memory segment (nil) - 0x309fff
> 
> Did I miss something somewhere?  I will provide any additional
> information if needed.
> 
ususally I see erors like that when you don't have sufficient memory reserved.
try bumping up your crashkernel allocation to 128M
Neil

> -JE
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
