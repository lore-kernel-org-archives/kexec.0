Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RH9py-0007k8-1H
	for kexec@lists.infradead.org; Fri, 21 Oct 2011 07:48:18 +0000
Date: Fri, 21 Oct 2011 16:48:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
Message-ID: <20111021074811.GE5487@verge.net.au>
References: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
	<4E92C08F.4050908@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E92C08F.4050908@in.ibm.com>
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 10, 2011 at 03:23:19PM +0530, Suzuki Poulose wrote:
> On 10/03/11 15:48, Suzuki K. Poulose wrote:
> >Disable backup regions for BookE in case of a CRASH Dump, as they can
> >be run from anywhere.
> >
> >The patch introduces --with-booke option to support the BookE.
> >
> >With the patch, we get :
> >
> >## On a 256M machine:
> >
> ># busybox cat /proc/cmdline
> >init=/bin/init console=ttyS0,16550 crashkernel=128M@100M
> ># kexec -p root/vmlinux
> >usable memory rgns size:1 base:6400000 size:8000000
> >CRASH MEMORY RANGES
> >0000000000000000-0000000006400000
> >000000000e400000-0000000010000000
> >Command line after adding elfcorehdr:  elfcorehdr=112380K
> >Command line after adding elfcorehdr:  elfcorehdr=112380K savemaxmem=256M
> >
> >Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
> Simon,
> 
> Could you please pick up the patch, if no one has any issues ?

Hi,

sorry for not noticing this earlier.
I have pushed the change to the kexec-tools tree which is currently living
at git://github.com/horms/kexec-tools.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
