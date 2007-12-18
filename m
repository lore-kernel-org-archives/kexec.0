Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J4lp1-0003nv-Sn
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 23:26:06 +0000
Date: Tue, 18 Dec 2007 18:25:58 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
Message-ID: <20071218232558.GA14092@redhat.com>
References: <1197967675.854275.930419561848.0.gpush@pokey>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On Tue, Dec 18, 2007 at 05:47:55PM +0900, Jeremy Kerr wrote:
> Hi all,
> 
> This series of patches is aimed at simplifying the kexec build system,
> mainly in order to make cross-compilation much easier.
> 
> As well as cross-compiling, this makes it possible to separate the
> 'host' architecture (ie, the arch of the kexec binary built), and the
> 'target' architecture (ie, the arch of the kernel that we're kexecing).
> We can specify these with the standard --host and --target arguments
> to configure.
> 

Hi Jermey,

I got a stupid question.

- What's the advantage of building a 32bit binary for powerpc64 bit
  platforms? IOW, why do you need to build 32bit purgatory? Can't we
  launch 32bit kernel from 64bit purgatory?

> This allows us to kexec a powerpc64 kernel from a powerpc userspace.
> x86{,_64} users might find this handy too, but I don't have hardware
> to test.

I think x86 it already happens. I think I can launch 64bit kernel from
a 32bit kexec.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
