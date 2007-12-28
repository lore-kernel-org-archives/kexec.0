Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J8LIJ-0000dp-Bp
	for kexec@lists.infradead.org; Fri, 28 Dec 2007 19:55:05 +0000
Date: Fri, 28 Dec 2007 14:54:45 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20071228195445.GA6245@hmsendeavour.rdu.redhat.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071228124532.GB32643@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> Hi Vivek,
> 
> I can't seem to get the latest -mm (2.6.24-rc6-mm1) to boot with
> kexec. It just gets stuck at "Starting new kernel".
> 
> It does boot normally when booted as the first kernel.
> 
> Any hints debugging? (x86 architecture)
> 
> -- 
> regards,
> Dhaval
> 
Out of curiosity, how are you booting the kexec kernel?  Are you doing a kexec
-l, or a kexec -p, followed by a system panic?  If its the later, what are you
doing to panic the system?  sysrq-c, custom module executing explicit
crash-code, hang followed by nmi panic?

Regards
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
