Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1POTd5-0000c9-KI
	for kexec@lists.infradead.org; Fri, 03 Dec 2010 11:16:44 +0000
Date: Fri, 3 Dec 2010 12:16:38 +0100
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: kdump broken on 2.6.37-rc4
Message-ID: <20101203111623.GA2741@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

On my T-60 laptop, i686 system with 2.6.37-rc4 kernel,
"echo c > /proc/sysrq-trigger" just hung the system. Kdump
works on 2.6.36. Is this known issue? If not, what info
I should provide to solve it (I think the easiest way
to solve the problem would be bisect) ?

Stanislaw

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
