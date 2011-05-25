Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPJed-0000uD-DJ
	for kexec@lists.infradead.org; Wed, 25 May 2011 19:22:04 +0000
Date: Wed, 25 May 2011 15:16:22 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <197408985.219307.1306350982473.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110525185524.GA6724@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, V Srivatsa <vatsa@linux.vnet.ibm.com>, Tachibana <tachibana@mxm.nes.nec.co.jp>, Reinhard <BUENDGEN@de.ibm.com>



----- Original Message -----
>
> > The data to be erased is poisoned with character 'X' (58 in Hex).
> >
> > The last two patches 7/8 and 8/8 introduces eraseinfo section into
> > filtered compressed kdump and ELF kdump file. The compressed kdump file
> > now carries additional fields namely offset_eraseinfo and size_eraseinfo in
> > kdump sub header that can help crash to identify whether filtering is
> > been done. Similarly, ELF kdump file now contains new ELF note of type
> > NT_ERASEINFO, that can help crash to identify whether the filtering has been
> > done or not.
> 
> And how this information is useful to crash? I mean why would crash care
> whether filtering has been done or not and if filtering has been done
> then do what?

It's not particularly useful to crash per se -- but rather it would be 
useful to a user trying to analyze the dumpfile.  If a prominent warning
message is displayed early on during invocation, then it won't be a big
surprise if/when things are subsequently broken/crippled.

Dave
 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
