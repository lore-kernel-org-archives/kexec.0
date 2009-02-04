Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LUpV1-0002b8-VT
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 21:41:38 +0000
Date: Wed, 4 Feb 2009 16:41:15 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
Message-ID: <20090204214115.GA8026@hmsreliant.think-freely.org>
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
	<20090120150958.GB18207@hmsreliant.think-freely.org>
	<20090120152255.GB5125@redhat.com>
	<20090127001211.f847ea5a.akpm@linux-foundation.org>
	<20090128041109.GA4943@verge.net.au>
	<m1ljsnz1up.fsf@fess.ebiederm.org>
	<20090204120549.GA2182@hmsreliant.think-freely.org>
	<m1y6wmxlg3.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1y6wmxlg3.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 04, 2009 at 07:37:16AM -0800, Eric W. Biederman wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> >> 
> >> That aside we aren't currently exporting log_buf_len, so I don't
> >> think this code works actually works.
> >> 
> >> Neil can you add a comment in kernel/printk.c of the algorithm
> >> necessary for external tools to decode the ring buffer?
> >> 
> >> We need the comment because people working on kernel/printk.c
> >> need to know what is happening and without having to review lots
> >> of user space code, and we need the comment to verify that we
> >> are exporting the right things.
> >> 
> >
> > Ok, as per Erics comment, I've written this.  It applies on top of whats already
> > in your tree Andrew.  It adds some comments on the function in question so that
> > anyone working on printk.c will know why we're exporting their symbols.  It also
> > modifies slightly the symbols we are exporting so that we can handle dmesg
> > buffers that are longer than the standard PAGE_SIZE configuration, and lets us
> > detect and handle buffer wraps.
> 
> Looks like a good start but what is the algorithm for using the variables?
> Given a kernel core file how do you extract the dmesg ring buffer?
> 
Its the same as for every other symbol in vmcoreinfo:
1) kexec copies the symbol info for each symbol specified from
/sys/kernel/vmcoreinfo to an ELF note in the vmcore pre-defined header when the
kexec kernel is loaded into protected memory

2) on a crash, that ELF note is saved to the vmcore file along with the rest of
the data

3) apps (in this case makedumpfile) reads that ELF note so it knows where to
seek into the vmcore file to find the contents of that symbol.


> It still does not appear obvious to me that you are extracting the
> dmesg ring buffer correctly or easily.
> 
You know this patch doesn't do that right?  The functionality for that is in a
user app (in this case makedumpfile).  I have a patch here:
https://sourceforge.net/tracker/index.php?func=detail&aid=2521075&group_id=178938&atid=887142
for makedumpfile that uses this symbol info to extract the dmesg log quite well.
ken'ichi has an updated version to be posted soon which handles ring wrap and
log sizes > PAGE_SIZE as well.

Neil

> Eric
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
