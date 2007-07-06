Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I6nrR-0002EU-Rz
	for kexec@lists.infradead.org; Fri, 06 Jul 2007 09:28:42 -0400
Date: Fri, 6 Jul 2007 15:28:14 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Determine version of kernel that produced vmcore
Message-ID: <20070706132814.GA7079@suse.de>
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
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Hello,

does anybody know a _reliable_ way to determine the version the kernel
that produced a vmcore file? This means not scanning for a specific
string or something like that which can fail on random memory.

Would it make sense to add a ELF PT_NOTE section in the vmcore?

Thanks for input!



Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
