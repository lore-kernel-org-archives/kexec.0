Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbNCu-0005fP-EI
	for kexec@lists.infradead.org; Wed, 12 Aug 2009 23:26:17 +0000
Date: Thu, 13 Aug 2009 09:26:11 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] Support R_PPC64_REL32 relocation type
Message-ID: <20090812232611.GC11982@verge.net.au>
References: <20090810141442.GE3110@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090810141442.GE3110@in.ibm.com>
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
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, nhorman@redhat.com, kexec@lists.infradead.org, miltonm@bga.com

On Mon, Aug 10, 2009 at 07:44:42PM +0530, M. Mohan Kumar wrote:
> [PATCH 2/2] Support R_PPC64_REL32 relocation type
> 
> gcc-4.4 compiler creates R_PPC64_REL32 relocation type in the ppc64
> purgatory code. Add support to handle R_PPC64_REL32 relocation type.
> 
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>

Thanks, applied this one too.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
