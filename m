Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPKER-0001ct-6v
	for kexec@lists.infradead.org; Wed, 25 May 2011 19:59:05 +0000
Date: Wed, 25 May 2011 15:53:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-ID: <20110525195321.GD6724@redhat.com>
References: <20110524203542.GH3860@redhat.com>
	<1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
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
To: Reinhard Buendgen <BUENDGEN@de.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>

On Wed, May 25, 2011 at 10:41:55AM +0200, Reinhard Buendgen wrote:
> Hi,
> 
> to answer Vivek questions first: Eventually we want to be able to erase 
> all data that a customer may consider sensitive to her privacy. In 
> addition to encryption key that may be the contents (i.e. payload within) 
> of all kinds of I/O buffers. Consider you are running a kvm based 
> hypervisor and want its dump to be analyized while promising your 
> customers whose guests you run on that hypervisor that none of their data 
> will be externalized. Or consider your system reads a spreadsheat with 
> bank account or health information. You might not want to send fractions 
> of that information sitting in some buffers to a service organization.

So for direct IO, buffer is still in user space and should be filtered
out when we filter out user space pages using mkdumpfile. For kvm, I am
assuming that all the pages belong to qemu process and once we are
filtering out user space pages, any data belonging to guest will go away.

So atleast for above examples it does not sound as if we need symbol
erase infrastructure.

> 
> to answer Daves concern: there is no intention that crash should ever look 
> into the erased structures. In theroy it should not be needed because the 
> contents of structures to be deleted should be irrelevant to kernel 
> debugging.

So what are those kernel structures which we are planning to delete and
are irrelevant to kernel debugging by crash?

I think we are missing something here. If there are only few known
structures we want to get rid of, lets hardcode it in makedumpfile
instead of giving user a generic infrastructure. That way we know
that we are not leaking information at the same time making sure
that analysis tools are working.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
