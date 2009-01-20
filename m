Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LPIF1-0004uD-PI
	for kexec@lists.infradead.org; Tue, 20 Jan 2009 15:10:14 +0000
Date: Tue, 20 Jan 2009 10:09:58 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
Message-ID: <20090120150958.GB18207@hmsreliant.think-freely.org>
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090120141551.GA5125@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: hbabu@us.ibm.com, akpm@linux-foundation.org, horms@verge.net.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Jan 20, 2009 at 09:15:51AM -0500, Vivek Goyal wrote:
> On Mon, Jan 19, 2009 at 04:21:27PM -0500, Neil Horman wrote:
> > Hey all-
> > 	It would be nice to be able to extract the dmesg log from a vmcore file
> > without needing to keep the debug symbols for the running kernel handy all the
> > time.  We have a facility to do this in /proc/vmcore.  This patch adds the
> > log_buf and log_end symbols to the vmcoreinfo area so that tools (like
> > makedumpfile) can easily extract the dmesg logs from a vmcore image.
> > 
> 
> It would be nice to get dmesg log if debug symbols are not around. Can't
> we use System.map for getting symbol addresses? vmcoreinfo had started
> small and seems to be growing now. I am thinking down the line will making
> use of System.map for such cases make sense?
> 

System.map only include exported and public symbols.  log_buf and log_end are
static, and not reported in the System.map.  Its a nice idea, but not
comprehensive for everything in the kernel.

><snip>
> 
> Will it be an issue if we make log_buf and log_end non static and directly
> access these in kexec.c?
> 
I had considered that, but was a bit hesitant to do so, since it exposes the
internal implementation of the dmesg buffer.  In the event someone disables
CONFIG_PRINTK, thats just more code we need to ifdef.  With this implementation
we just stub out the log_buf_setup function, and let that be that.  It seems
more consice to me this way.

Regards
Neil

> Thanks
> Vivek
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
