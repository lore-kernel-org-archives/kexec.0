Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I9GwB-0006Fu-2Q
	for kexec@lists.infradead.org; Fri, 13 Jul 2007 04:55:44 -0400
Date: Fri, 13 Jul 2007 17:55:35 +0900
From: Horms <horms@verge.net.au>
Subject: [ANNOUNCE] Kexec for Xen on IA64 (v20070713)
Message-ID: <20070713085533.GA16653@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
The major changes are:

* SMP kexec now works!!! <-- this was a real pain
* The serial port now works in the second kernel on HP rx2620 hardware

I have trimed down the problems file, removing issues that have been
resolved, and happily it is now of a much more managable size.

http://www.vergenet.net/linux/kexec/ia64-xen.shtml
http://www.vergenet.net/linux/kexec/ia64-xen/20070713/xen-ia64-kexec-20070713.tar.bz2
http://www.vergenet.net/linux/kexec/ia64-xen/20070713/broken_out/README
http://www.vergenet.net/linux/kexec/ia64-xen/20070713/broken_out/BUILD
http://www.vergenet.net/linux/kexec/ia64-xen/20070713/broken_out/PROBLEMS


-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
