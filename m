Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxaQU-0005OH-7J
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 06:00:07 +0000
Message-ID: <4AD40E32.5000606@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 14:20:50 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 5/5] Read vmcoreinfo data from a kdump-compressed dumpfile.
References: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>	<20091010.165135.12569232.caiqian@redhat.com>
	<4AD3D19F.7000508@mxs.nes.nec.co.jp>
	<4AD40DB4.6030808@mxs.nes.nec.co.jp>
In-Reply-To: <4AD40DB4.6030808@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, tindoh@redhat.com, usui@mxm.nes.nec.co.jp, CAI Qian <caiqian@redhat.com>, anderson@redhat.com

[PATCH 5/5] Read vmcoreinfo data from a kdump-compressed dumpfile.

makedumpfile takes the data from a dumpfile in the kdump-compressed
format and uses the data for re-filtering.


Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-10-13 12:35:06.000000000 +0900
+++ b/makedumpfile.c	2009-10-13 12:34:44.000000000 +0900
@@ -871,6 +871,11 @@ get_kdump_compressed_header_info(char *f
 	}
 	memcpy(info->kh_memory, &kh, sizeof(kh));
 
+	if (dh.header_version >= 3) {
+		/* A dumpfile contains vmcoreinfo data. */
+		info->offset_vmcoreinfo = kh.offset_vmcoreinfo;
+		info->size_vmcoreinfo   = kh.size_vmcoreinfo;
+	}
 	return TRUE;
 error:
 	free(info->dh_memory);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
