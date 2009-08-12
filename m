Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbNCY-0005eW-II
	for kexec@lists.infradead.org; Wed, 12 Aug 2009 23:25:55 +0000
Date: Thu, 13 Aug 2009 09:25:47 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
Message-ID: <20090812232547.GB11982@verge.net.au>
References: <20090810141351.GD3110@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090810141351.GD3110@in.ibm.com>
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

On Mon, Aug 10, 2009 at 07:43:51PM +0530, M. Mohan Kumar wrote:
> [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
> 
> kexec is creating a version 3 device tree to be backwards compatible. This
> version of the struct has 8-byte alignment for properties whose value is 8 or
> more bytes. As the code directly checks the pointer when deciding to add the
> alignment word, the struct memory must start on an 8 byte boundary. Force the
> dtstruct variable to be always 8 bytes aligned.
> 
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
