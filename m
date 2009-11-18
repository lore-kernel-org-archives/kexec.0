Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NAhsx-0000Tq-TO
	for kexec@lists.infradead.org; Wed, 18 Nov 2009 10:35:44 +0000
Received: by pxi33 with SMTP id 33so677852pxi.28
	for <kexec@lists.infradead.org>; Wed, 18 Nov 2009 02:35:38 -0800 (PST)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Nov 2009 19:30:20 +0900
Message-Id: <20091118103020.11992.28478.sendpatchset@rxone.opensource.se>
Subject: [PATCH] add kexec-tools support for armv7l processors
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
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Add kexec-tools support for arm processors identifying themselves
as armv7l. This includes sh7377 and the omap3 on my beagle board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 kexec/arch/arm/kexec-arm.c |    1 +
 1 file changed, 1 insertion(+)

--- 0004/kexec/arch/arm/kexec-arm.c
+++ work/kexec/arch/arm/kexec-arm.c	2009-11-17 15:02:00.000000000 +0900
@@ -111,6 +111,7 @@ int arch_process_options(int argc, char 
 const struct arch_map_entry arches[] = {
 	{ "arm", KEXEC_ARCH_ARM },
 	{ "armv6l", KEXEC_ARCH_ARM },
+	{ "armv7l", KEXEC_ARCH_ARM },
 	{ 0 },
 };
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
