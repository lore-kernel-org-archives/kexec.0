Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by pentafluge.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JJqQN-0000Jn-LY
	for kexec@lists.infradead.org; Tue, 29 Jan 2008 13:22:59 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m0TDKuEs016967 for <kexec@lists.infradead.org> (envelope-from
	takebe_akio@jp.fujitsu.com); Tue, 29 Jan 2008 22:20:56 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C8EB53C06E
	for <kexec@lists.infradead.org>; Tue, 29 Jan 2008 22:20:56 +0900 (JST)
Received: from s8.gw.fujitsu.co.jp (s8.gw.fujitsu.co.jp [10.0.50.98])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id E6026240080
	for <kexec@lists.infradead.org>; Tue, 29 Jan 2008 22:20:55 +0900 (JST)
Received: from s8.gw.fujitsu.co.jp (s8 [127.0.0.1])
	by s8.gw.fujitsu.co.jp (Postfix) with ESMTP id B5F3E1718044
	for <kexec@lists.infradead.org>; Tue, 29 Jan 2008 22:20:55 +0900 (JST)
Received: from fjm506.ms.jp.fujitsu.com (fjm506.ms.jp.fujitsu.com
	[10.56.99.86])
	by s8.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C8E41718041
	for <kexec@lists.infradead.org>; Tue, 29 Jan 2008 22:20:55 +0900 (JST)
Received: from fjmscan503.ms.jp.fujitsu.com (fjmscan503.ms.jp.fujitsu.com
	[10.56.99.143])by fjm506.ms.jp.fujitsu.com with ESMTP id
	m0TDKDmn009532
	for <kexec@lists.infradead.org>; Tue, 29 Jan 2008 22:20:13 +0900
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: [Patch] makedumpfile: support -F option on xen
Date: Tue, 29 Jan 2008 22:20:11 +0900
MIME-Version: 1.0
Message-Id: <94C86279ACDA80takebe_akio@jp.fujitsu.com>
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
To: kexec-ml <kexec@lists.infradead.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

Hi,

makdumpfile doesn't support -F option on xen.
The following patch support it.

Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>

Best Regards,

Akio Takebe

--- makedumpfile/makedumpfile.c.orig	2007-11-14 20:34:36.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-01-28 13:50:34.000000000 +0900
@@ -5803,12 +5803,22 @@ handle_xen()
 	if (!create_dump_bitmap_xen())
 		goto out;
 
+	if (info->flag_flatten) {
+		if (!write_start_flat_header())
+			goto out;
+	}
+
 	if (!write_elf_header())
 		goto out;
 
 	if (!write_elf_pages())
 		goto out;
 
+	if (info->flag_flatten) {
+		if (!write_end_flat_header())
+			goto out;
+	}
+
 	if (!close_files_for_creating_dumpfile())
 		goto out;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
