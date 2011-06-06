Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx0.aculab.com ([213.249.233.131])
	by canuck.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QTVh9-0006q9-84
	for kexec@lists.infradead.org; Mon, 06 Jun 2011 09:01:59 +0000
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 05801-02 for <kexec@lists.infradead.org>;
	Mon,  6 Jun 2011 10:01:48 +0100 (BST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC][PATCH] powerpc: Use the #address-cells information to
	parsememory/reg
Date: Mon, 6 Jun 2011 10:00:22 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
In-Reply-To: <4DEC7F49.8060000@in.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
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
To: Suzuki Poulose <suzuki@in.ibm.com>, Simon Horman <horms@verge.net.au>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> > Changed the add_usable_mem_property() to accept FILE* fp instead of
int fd,
> > as most of the other users of read_memory_region_limits() deals with
FILE*.
> >
> > Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> Could you please let me know your thoughts/comments about this patch ?

Is the change to use 'FILE *' actually progress?
I'd have thought that the randomly aligned read/lseek system calls
that this allows to happen are not desirable for anything that
isn't a true file.

I'd also suggest that the sizeof's should be applied to the
actual type of the variable being read/written, not arbitrarily
'long' or 'int', and this probably ought to be some fixed size type.

	David



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
