Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIQfH-0001KU-0M
	for kexec@lists.infradead.org; Sun, 21 Jun 2009 17:17:18 +0000
Date: Sun, 21 Jun 2009 13:17:09 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Need for KEXEC_PRESERVE_CONTEXT flag ?
Message-ID: <20090621171709.GA3358@localhost.localdomain>
References: <48e37220906182330w6a6e83bctb3b3a27f7bfc6afb@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48e37220906182330w6a6e83bctb3b3a27f7bfc6afb@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Indraneel Mukherjee <indro.ml@gmail.com>
Cc: kexec@lists.infradead.org

On Fri, Jun 19, 2009 at 12:00:44PM +0530, Indraneel Mukherjee wrote:
> Hi,
> 
> The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this code
> 
> ------snip----
> 
>  if (flags & KEXEC_PRESERVE_CONTEXT)
>             image->preserve_context = 1;
> 
> ------snip----
> 
> Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even defined
> in kexec-tools-2.0.0.
> 
> Consequently, all the code inside the condition  if(image->preserve_context)
>   is also useless?
> 
> Am i missing something here?
> 
Yes, the code you're looking at in the first definition is part of the kernel,
while you're looking for the definition of KEXEC_PRESERVE_CONTEXT in the
kexec-tools userspace code.  You need to look for the definition of
KEXEC_PRESERVE_CONTEXT in the kernel code (you'll find it in
include/linux/kexec.h).  kexec-tools might use it one day, but not using it
doesn't mean we should remove it from the kernel.

Neil

> Regards,
> Indro

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
