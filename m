Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K0uv9-0005IU-9Y
	for kexec@lists.infradead.org; Tue, 27 May 2008 08:52:39 +0000
Message-ID: <483BCB75.4050901@wpkg.org>
Date: Tue, 27 May 2008 10:51:01 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: kexec on mips - anyone has it working?
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
To: Kexec Mailing List <kexec@lists.infradead.org>, linux-mips@linux-mips.org

I'm trying to use kexec on a ASUS WL-500gP router (BCM47XX, little 
endian MIPS) with a 2.6.25.4 kernel with some additional changes from 
OpenWRT.

Unfortunately, it doesn't work for me - when I load a new kernel and try 
to execute it, it just says "Bye" and the router is dead:

# kexec -l vmlinux
# kexec -e
(...)
Bye


I signalled the issue before in the past, with a 2.6.23.1 kernel:

http://lists.infradead.org/pipermail/kexec/2008-February/001315.html


Ideas? Ways to debug it?



-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
