Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSbQY-0005aX-Ko
 for kexec@lists.infradead.org; Fri, 30 Nov 2018 05:33:24 +0000
Received: by mail-pg1-f196.google.com with SMTP id d72so1994724pga.9
 for <kexec@lists.infradead.org>; Thu, 29 Nov 2018 21:33:12 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 4/4] kexec/kexec-arm64.c: Add missing error handling paths
Date: Fri, 30 Nov 2018 11:02:45 +0530
Message-Id: <1543555965-14399-5-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1543555965-14399-1-git-send-email-bhsharma@redhat.com>
References: <1543555965-14399-1-git-send-email-bhsharma@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, bhsharma@redhat.com, bhupesh.linux@gmail.com, Simon Horman <horms@verge.net.au>

While creating the 2nd dtb to be passed to the secondary kernel
for arm64, we need to handle the return values from helper fdt
functions properly, to make sure that we can handle various command-line
options being passed to 'kexec' both for kexec load and kdump
purposes.

This will provide proper error reporting to the calling
function in case something goes wrong.

Without this patch, we get misleading error FDT_ERR_BADOFFSET reported
when we pass a .dtb to 'kexec -p' using '--dtb' option, which doesn't
contain the '/chosen' node (for e.g. the rockchip sapphire board
dtb -> rk3399-sapphire.dtb).

   # kexec -d -p Image --reuse-cmdline --dtb rk3399-sapphire.dtb
   <..snip..>
   load_crashdump_segments: elfcorehdr 0xbfff0000-0xbfff33ff
   get_cells_size: #address-cells:2 #size-cells:2
   cells_size_fitted: bfff0000-bfff33ff
   cells_size_fitted: 8ee00000-bfffffff
   setup_2nd_dtb: no kaslr-seed found
   setup_2nd_dtb: fdt_setprop failed: FDT_ERR_BADOFFSET
   kexec: setup_2nd_dtb failed.
   kexec: load failed.

Now after the fix, we get the correct error FDT_ERR_NOTFOUND reported
to the calling function:

   # kexec -d -l Image --append 'debug' --dtb rk3399-sapphire.dtb
   <..snip..>
   load_crashdump_segments: elfcorehdr 0xbfff0000-0xbfff33ff
   get_cells_size: #address-cells:2 #size-cells:2
   cells_size_fitted: bfff0000-bfff33ff
   cells_size_fitted: 8ee00000-bfffffff
   setup_2nd_dtb: /chosen node not found - can't create dtb for dump kernel: FDT_ERR_NOTFOUND
   kexec: setup_2nd_dtb failed.
   kexec: load failed.


Cc: Simon Horman <horms@verge.net.au>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index f4913b2e9480..560d83455f95 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -515,6 +515,11 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		}
 
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		if (nodeoffset < 0) {
+			result = nodeoffset;
+			goto on_error;
+		}
+
 		result = fdt_setprop_inplace(new_buf,
 				nodeoffset, "kaslr-seed",
 				&fdt_val64, sizeof(fdt_val64));
@@ -529,6 +534,14 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 	if (on_crash) {
 		/* add linux,elfcorehdr */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		if (nodeoffset < 0) {
+			result = nodeoffset;
+			dbgprintf("%s: /chosen node not found - can't create "
+				"dtb for dump kernel: %s\n", __func__,
+				fdt_strerror(result));
+			goto on_error;
+		}
+
 		result = fdt_setprop_range(new_buf, nodeoffset,
 				PROP_ELFCOREHDR, &elfcorehdr_mem,
 				address_cells, size_cells);
@@ -541,6 +554,14 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 
 		/* add linux,usable-memory-range */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		if (nodeoffset < 0) {
+			result = nodeoffset;
+			dbgprintf("%s: /chosen node not found - can't create "
+				"dtb for dump kernel: %s\n", __func__,
+				fdt_strerror(result));
+			goto on_error;
+		}
+
 		result = fdt_setprop_range(new_buf, nodeoffset,
 				PROP_USABLE_MEM_RANGE, &crash_reserved_mem,
 				address_cells, size_cells);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
