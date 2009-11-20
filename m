Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxo44.mail.genotec.ch ([2001:1b50::82:195:224:44])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NBXaU-0004Lc-NU
	for kexec@lists.infradead.org; Fri, 20 Nov 2009 17:48:04 +0000
From: Marc Andre Tanner <mat@brain-dump.org>
Subject: Architecture detection code
Date: Fri, 20 Nov 2009 18:38:11 +0100
Message-Id: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: damm@opensource.se, horms@verge.net.au

Hi,

I recently had the same problem as Magnus and came up with the
following patch. It changes the architecture detection code to
also accept partiall matches. Which means and "arm" entry in
arch_map_entry will work for all arm* versions.

Please consider applying this patch and reverting the two from
Magnus. 

Thanks,
Marc


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
