Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QOyW4-0003ap-HA
	for kexec@lists.infradead.org; Tue, 24 May 2011 20:47:49 +0000
Date: Tue, 24 May 2011 16:47:32 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110524203542.GH3860@redhat.com>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, V Srivatsa <vsrivatsa@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Reinhard <BUENDGEN@de.ibm.com>



----- Original Message -----
> On Wed, May 18, 2011 at 01:29:06AM +0530, Mahesh J Salgaonkar wrote:
> > Hi All,
> >
> > Please find the version 2 of makedumpfile enhancement patchset that introduces
> > a data filtering feature which enables makedumpfile to filter out desired kernel
> > symbol data and it's members from the specified VMCORE file. The data to be
> > filtered out is poisoned with character 'X' (58 in Hex).
> >
> > This feature will be very useful for the customers who wants to erase the
> > customer sensitive data like security keys and other confidential data, in
> > DUMPFILE before sending it to support team for analysis.
> 
> Mahesh,
> 
> Apart from security keys, what are the other examples of data which needs
> to be removed?
> 
> By erasing the data, you mean you set it to zero? Will it make sense to
> poison it with some specific pattern so that if crash or other tool
> are looking into it they know it has been posioned and it is not a
> case of corruption. This might help if a user erased a symbol which was
> required by crash for some analysis etc.
> 
> Thanks
> Vivek

As I said when the first patch-set was proposed, there is no way
that I am going to put code into the crash utility that will somehow 
"work around" memory that has been poisoned.  The only thing I plan to
do is to check whether the new segments exist in the compressed
kdump or ELF kdump headers -- and if they do, print a warning message 
during invocation informing the user of that fact.  If Mahesh wants to
dump the contents of the sections, he can post a patch to the crash-utility
list.

And then, whatever breaks, breaks -- it is not the crash utility's
problem to handle.  Just looking at the examples in the documentation
made me nervous -- IIRC the kernel "vmlist" pointer, and "vm_struct.addr"
are shown -- both of which would cripple the crash utility.

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
