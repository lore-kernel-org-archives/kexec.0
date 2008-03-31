Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgNlj-0003Zb-2d
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 17:26:04 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m2VHQ0s7012161 for <kexec@lists.infradead.org> (envelope-from
	takebe_akio@jp.fujitsu.com); Tue, 1 Apr 2008 02:26:01 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 8A7D353C033
	for <kexec@lists.infradead.org>; Tue,  1 Apr 2008 02:26:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 65A7724014E
	for <kexec@lists.infradead.org>; Tue,  1 Apr 2008 02:26:00 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1 [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C8B5133C020
	for <kexec@lists.infradead.org>; Tue,  1 Apr 2008 02:26:00 +0900 (JST)
Received: from fjm505.ms.jp.fujitsu.com (fjm505.ms.jp.fujitsu.com
	[10.56.99.83])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0ACE5133C018
	for <kexec@lists.infradead.org>; Tue,  1 Apr 2008 02:26:00 +0900 (JST)
Received: from fjmscan502.ms.jp.fujitsu.com (fjmscan502.ms.jp.fujitsu.com
	[10.56.99.142])by fjm505.ms.jp.fujitsu.com with ESMTP id
	m2VHPgxa024828
	for <kexec@lists.infradead.org>; Tue, 1 Apr 2008 02:25:42 +0900
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: [Patch] fix error case of xen
Date: Tue, 01 Apr 2008 02:24:32 +0900
MIME-Version: 1.0
Message-Id: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
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
To: kexec-ml <kexec@lists.infradead.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

Hi,

Curret kdump-xen with makdumpfile always return 0.
So if we fail to kdump, we will get $?=0.
This patch improve it.

Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>

--- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
+++ makedumpfile.mod/makedumpfile.c	2008-04-01 02:14:12.000000000 +0900
@@ -993,6 +993,8 @@ get_symbol_addr(char *symname)
 		if (!strcmp(sym_name, symname)) {
 			symbol = sym.st_value;
 			break;
+		} else if (i >= (shdr.sh_size/shdr.sh_entsize)-1) {
+			DEBUG_MSG("Can't get symbol of %s.\n", symname);
 		}
 	}
 out:
@@ -6146,7 +6148,8 @@ main(int argc, char *argv[])
 			goto out;
 		}
 		info->dump_level |= DL_EXCLUDE_XEN;
-		return handle_xen();
+		if (!handle_xen())
+			goto out;
 
 	} else if (info->flag_rearrange) {
 		if (!open_files_for_rearranging_dumpdata())


Best Regards,

Akio Takebe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
