Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HoYz3-0006EO-Lx
	for kexec@lists.infradead.org; Thu, 17 May 2007 06:57:06 +0100
Date: Thu, 17 May 2007 14:56:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] Kexec for Xen on IA64 (v20070417)
Message-ID: <20070517055636.GA3271@verge.net.au>
References: <20070112012646.GA5373@verge.net.au>
	<20070112042204.GA14383@verge.net.au>
	<20070208081033.GH23574@verge.net.au>
	<20070214100956.GA16375@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070214100956.GA16375@verge.net.au>
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
To: xen-ia64-devel@lists.xensource.com, Kexec Mailing List <kexec@lists.infradead.org>
Cc: Akio Takebe <takebe_akio@jp.fujitsu.com>, Ian Campbell <Ian.Campbell@xensource.com>

Hi,

I'm happy to announce the another alpha release of Kexec for Xen on IA64.
The major change is the addition of /proc/iomem_hardware, which
allows kexec-tools to see what the EFI really looks like, rather
than some very limited virtualised view.

Most of the new changes are broken out into separate patches to make it
slightly easier to see what is changing. I have also been able to
remove a number of patches, particularly from the linux directory,
as they have been merged.

http://www.vergenet.net/linux/kexec/ia64-xen.shtml
http://www.vergenet.net/linux/kexec/ia64-xen/20070417/xen-ia64-kexec-20070417.tar.bz2
http://www.vergenet.net/linux/kexec/ia64-xen/20070417/broken_out/README
http://www.vergenet.net/linux/kexec/ia64-xen/20070417/broken_out/BUILD

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
