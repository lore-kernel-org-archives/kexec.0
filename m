Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDQQU-0000aC-0Z
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 22:33:34 +0000
Date: Thu, 26 Nov 2009 09:33:27 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Write to HVC terminal from purgatory cod
Message-ID: <20091125223327.GJ4794@verge.net.au>
References: <20091016062602.GC4995@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091016062602.GC4995@in.ibm.com>
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
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, miltonm@bga.com

On Fri, Oct 16, 2009 at 11:56:02AM +0530, M. Mohan Kumar wrote:
> [PATCH] Write to HVC terminal from purgatory code
> 
> Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to serial
> console/VGA while executing the purgatory code.  Implement this feature for
> POWERPC pseries platform by using the H_PUT_TERM_CHAR hypervisor call by
> printng to hvc console.
> 
> Includes the changes suggested by Michael Ellerman

Sorry for the long delay, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
