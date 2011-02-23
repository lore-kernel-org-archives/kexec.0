Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PsNJA-0006Xf-I0
	for kexec@lists.infradead.org; Wed, 23 Feb 2011 22:35:45 +0000
Date: Thu, 24 Feb 2011 07:35:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: extend KCORE_ELF_HEADERS_SIZE again
Message-ID: <20110223223537.GI7361@verge.net.au>
References: <E1PsHcr-0001Vm-Om@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1PsHcr-0001Vm-Om@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Wed, Feb 23, 2011 at 10:31:41AM -0600, Cliff Wickman wrote:
> 
> I thought that this patch was added to the kexec tree, but I don't find it in
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> So I'm submitting it again for your consideration.
> 
> A customer machine has run over the limit that we increased in October.
> 
> > When boot.kdump runs:
> > 
> > Loading kdump
> > 297 segments require a 16696-byte buffer
> > KCORE_ELF_HEADERS_SIZE 16384 too small
> > ELF core (kcore) parse failed
> > Cannot load /boot/vmlinuz-2.6.32.12-0.7.1-uv
> >                                                                     failed
> 
> Just barely overflowed. But I suggest doubling the buffer.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
