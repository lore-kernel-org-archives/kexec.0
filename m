Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJv4R-0000og-Q5
	for kexec@lists.infradead.org; Tue, 29 Jan 2008 18:20:32 +0000
Date: Tue, 29 Jan 2008 19:17:01 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kexec command line length
Message-ID: <20080129181701.GB535@suse.de>
References: <20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
	<20080128212910.GA21889@suse.de>
	<20080129010122.GA11935@hmsreliant.think-freely.org>
	<20080129154104.GA12219@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080129154104.GA12219@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

* Vivek Goyal <vgoyal@redhat.com> [2008-01-29 16:41]:
> 
> I think 2048 command line support came much later. I think it came between
> version 2.05 and 2.06 (But somebody needs to dive into archive to verify).
> Because command line size could go beyond 256, we introduced cmdline_size
> parameter in version 2.06 to let a boot loader know.

Large command line support was added with

    cca97de1184f6000d22b4106d47687b31cca1fa3
    v2.6.20-1929-gcca97de

which means that it was merged 2.6.21.

> What Bernanrd seems to be talking about a small window where boot protocol
> was 2.05 but supported command line size was still 2048.

2.05 was added with

    be274eeaf20b4c7155242645d5e2c48b023e609b
    v2.6.19-1394-gbe274ee

which means that it was merged 2.6.20. But it got implemented for i386
only that time, so x86_64 still had the 2.04 version.

The command line length in the boot protocol was added with

    8f9aeca7a081d81c4c9862be1e04f15b5ab5461f
    v2.6.21-1864-g8f9aeca

which menas that it was merged 2.6.22.

> if (protocol version > 2.06)
> 	error user depending on cmdline_size;
> else if (protocol version > 2.05 && protocol version < 2.06)
> 	warn on cmdline being more than 256. We don't know for sure.
> else
> 	error out if cmdline is greater than 256

The problem is 2.6.21: It had on x86_64 2.04 boot protocol but
2048 command line size. I just verified this via the tarball. :(

Maybe it could be implemented with versions ...


        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
