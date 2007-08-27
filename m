Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPi1X-0007LF-9A
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 13:05:14 -0400
Date: Mon, 27 Aug 2007 13:02:53 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-ID: <20070827170253.GE27516@redhat.com>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
	<20070824170139.021be621.rdunlap@xenotime.net>
	<20070826132305.GA15555@hmsendeavour.rdu.redhat.com>
	<20070826100431.e36f92e7.rdunlap@xenotime.net>
	<20070827165538.GE20548@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070827165538.GE20548@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, kexec@lists.infradead.org

On Mon, Aug 27, 2007 at 12:55:38PM -0400, Neil Horman wrote:
> > crashkernel=64M@16M
> > 
> Hmm, well that should be enough.  looking at your log, it appears as though you
> have a 512k chunk allocatable, which should seem sufficient to go on a little
> longer.  The fact that your not seems to indicate that you are allocating a
> suspiciously large single chunk of ram.  I'd configure your initramfs to drop to
> a shell prompt before it sets up lp0.  Then you can step through the actions of
> the init script and monitor the contents of /proc/slabinfo to get an idea of
> whats eating up all your lowmem prior to the oom kill.
> 
> Neil
> 

<snipped from Randy's output>

Out of memory: kill process 680 (boot) score 309 or a child
Killed process 701 (S01boot.udev)

Heh, it's udev again.  What a surprise! </sarcasm>

Neil, didn't we solve this with an init 1 or something (ignoring the whole
busybox thing).

Cheers,
Don


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
