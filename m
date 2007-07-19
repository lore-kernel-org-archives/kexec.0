Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBZTF-0006eU-6i
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 13:07:22 -0400
Date: Thu, 19 Jul 2007 12:59:32 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070719165932.GO9623@redhat.com>
References: <20070716123633.GA10920@in.ibm.com>
	<20070718230740oomichi@mail.jp.nec.com>
	<20070719163915.GN9623@redhat.com> <20070719164953.GA5381@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070719164953.GA5381@suse.de>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, vgoyal@in.ibm.com, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dan Aloni <da-x@monatomic.org>

On Thu, Jul 19, 2007 at 06:49:53PM +0200, Bernhard Walle wrote:
> * Don Zickus <dzickus@redhat.com> [2007-07-19 18:39]:
> > 
> > I am not a big fan of this approach as it forces distros to require
> > kexec-tools when building a kernel.  Even Joe Hacker who wants a custom
> > kernel (and not interested in kexec) would have to not only download the
> > kernel.src.rpm but kexec-tools just to build a kernel that probably
> > doesn't have kexec enabled.
> 
> He would have to download makedumpfile, not kexec-tools.

My apologies.  Red Hat packages makedumpfile under kexec-tools, hence my
confusion.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
