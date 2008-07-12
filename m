Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.mail.vrmd.de ([81.28.224.28])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KHnNR-0001y0-T8
	for kexec@lists.infradead.org; Sat, 12 Jul 2008 22:15:38 +0000
From: Bernhard Walle <bernhard.walle@gmx.de>
Subject: firmware/memmap fixes
Date: Sun, 13 Jul 2008 00:15:31 +0200
Message-Id: <1215900933-27592-1-git-send-email-bernhard.walle@gmx.de>
In-Reply-To: <20080711173609.8310504d.akpm@linux-foundation.org>
References: <20080711173609.8310504d.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

This patch fixes the problems Andrew encountered in his review and also fixes a
boot problem on i386 in linux-next. That was not present while testing the
patch in tip tree.

However, I don't know how to merge that patches properly. Directly to
linux-next or via -mm? Or via x86?

The patches are against linux-next tree and were tested on i386.


Signed-off-by: Bernhard Walle <bwalle@suse.de>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
