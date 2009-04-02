Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]
	helo=VA3EHSOBE005.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LpRqh-0000Yn-Py
	for kexec@lists.infradead.org; Thu, 02 Apr 2009 18:41:20 +0000
Message-ID: <49D506BB.9030409@am.sony.com>
Date: Thu, 2 Apr 2009 11:40:59 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: kexec trouble with gcc-4.3
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: kexec@lists.infradead.org
Cc: cbe-oss-dev@ozlabs.org

Hi,

I tried building kexec with gcc-4.3 from the cell sdk-3.1
and the resulting binary didn't work correctly.  It works
OK with the gcc-4.1 from the same (sdk-3.1).

Here is the last thing seen, then the system hangs:

Starting new kernel
kexec: waiting for cpu 1 (physical 1) to go down
Invalid tag 26 scanning flattened device tree !
Invalid tag 26 scanning flattened device tree !
Invalid tag 26 scanning flattened device tree !

Does anyone have any ideas?

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
