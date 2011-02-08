Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp03.srv.cs.cmu.edu ([128.2.217.198])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PmuHI-0005yw-7f
	for kexec@lists.infradead.org; Tue, 08 Feb 2011 20:35:12 +0000
Received: from jaguar.home (pool-173-75-141-44.pitbpa.fios.verizon.net
	[173.75.141.44]) (authenticated bits=0)
	by smtp03.srv.cs.cmu.edu (8.13.6/8.13.6) with ESMTP id p18KZ9t6024865
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <kexec@lists.infradead.org>; Tue, 8 Feb 2011 15:35:10 -0500 (EST)
Received: from ecc by jaguar.home with local (Exim 4.72)
	(envelope-from <ecc@cmu.edu>) id 1PmuHF-000341-Od
	for kexec@lists.infradead.org; Tue, 08 Feb 2011 15:35:09 -0500
Date: Tue, 8 Feb 2011 15:35:09 -0500
From: Eric Cooper <ecc@cmu.edu>
Subject: kexec problems on kirkwood
Message-ID: <20110208203509.GA11748@localhost>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

I've been trying to use kexec on a Seagate DockStar (kirkwood-based).

Using a minimal kernel with a built-in initramfs, I've been able to
successfully kexec a ~1M kernel with a ~2.7M initrd.  But if I then
use *that* kernel to try to kexec itself (for example, using "reboot"
when the kexec-tools package is installed), it fails during the
"Uncompressing the kernel" code.

It fails with both gzip and lzma compressed images.  The precise
failure seems to depend on the size of the kernel -- sometimes it
complains about a corrupt image, sometimes it just hangs.  I added
some print statements to the decompress-inflate code, and I've seen
all sorts of error messages.

I then found the same failure-during-decompression occurs if I try to
use the minimal kernel to kexec itself, or the bigger kernel to kexec
anything.

So the successful kexec seems to be a lucky fluke, and there's still
something not set up correctly in the post-kexec environment.

Any suggestions on where to look or how to debug this would be very
welcome.

-- 
Eric Cooper             e c c @ c m u . e d u

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
