Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from iolanthe.rowland.org ([192.131.102.54])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IIrvV-0007WZ-6p
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 16:14:42 -0400
Date: Wed, 8 Aug 2007 16:07:59 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
In-Reply-To: <46B9F983.9020700@googlemail.com>
Message-ID: <Pine.LNX.4.44L0.0708081557450.3925-100000@iolanthe.rowland.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, Mark Hindley <mark@hindley.org.uk>, Greg KH <gregkh@suse.de>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 8 Aug 2007, Michal Piotrowski wrote:

> USB
> 
> Subject         : 2.6.23-rc1: uhci_hcd. irq 4: nobody cared
> References      : http://lkml.org/lkml/2007/7/29/75
> Last known good : ?
> Submitter       : Mark Hindley <mark@hindley.org.uk>
> Caused-By       : ?
> Handled-By      : Alan Stern <stern@rowland.harvard.edu>
> Status          : unknown

Mark has determined that this is not a regression but rather an 
already-existing problem, caused by invoking kexec from within an xterm 
window.  See

	http://marc.info/?l=linux-usb-users&m=118648557203179&w=2

Of course, this means there's liable to be something wrong with the way
kexec interacts with uhci-hcd or the other drivers sharing the same 
IRQ.  Failure to call the shutdown() method could cause the problem.  
But I don't see why using an xterm should make any difference (unless 
the only device being used was a mouse, and it was not in use while X 
wasn't running).

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
