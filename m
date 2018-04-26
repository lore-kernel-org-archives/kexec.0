Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fBcix-0006Dy-Lu
 for kexec@lists.infradead.org; Thu, 26 Apr 2018 08:57:57 +0000
Received: by mail-pf0-f195.google.com with SMTP id a14so7258107pfi.1
 for <kexec@lists.infradead.org>; Thu, 26 Apr 2018 01:57:44 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2] arm64: Add support to supply 'kaslr-seed' to secondary
 kernel
Date: Thu, 26 Apr 2018 14:27:32 +0530
Message-Id: <1524733052-3276-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, Bhupesh Sharma <bhsharma@redhat.com>, bhupesh.linux@gmail.com, dyoung@redhat.com, horms@verge.net.au

This patch adds the support to supply 'kaslr-seed' to secondary kernel,
when we do a 'kexec warm reboot to another kernel' (although the
behaviour remains the same for the 'kdump' case as well) on arm64
platforms using the 'kexec_load' invocation method.

Lets consider the case where the primary kernel working on the arm64
platform supports kaslr (i.e 'CONFIG_RANDOMIZE_BASE' was set to y and
we have a compliant EFI firmware which supports EFI_RNG_PROTOCOL and
hence can pass a non-zero (valid) seed to the primary kernel).

Now the primary kernel reads the 'kaslr-seed' and wipes it to 0 and
uses the seed value to randomize for e.g. the module base address
offset.

In the case of 'kexec_load' (or even kdump for brevity),
we rely on the user-space kexec-tools to pass an appropriate dtb to the
secondary kernel and since 'kaslr-seed' is wiped to 0 by the primary
kernel, the secondary will essentially work with *nokaslr* as
'kaslr-seed' is set to 0 when it is passed to the secondary kernel.

This can be true even in case the secondary kernel had
'CONFIG_RANDOMIZE_BASE' and 'CONFIG_RANDOMIZE_MODULE_REGION_FULL' set to
y.

This patch addresses this issue by first checking if the device tree
provided by the firmware to the kernel supports the 'kaslr-seed'
property and verifies that it is really wiped to 0. If this condition is
met, it fixes up the 'kaslr-seed' property by using the getrandom()
syscall to get a suitable random number.

I verified this patch on my Qualcomm arm64 board and here are some test
results:

1. Ensure that the primary kernel is boot'ed with 'kaslr-seed'
   dts property and it is really wiped to 0:

   [root@qualcomm-amberwing]# dtc -I dtb -O dts /sys/firmware/fdt | grep -A 10 -i chosen
   	chosen {
		kaslr-seed = <0x0 0x0>;
		...
	}

2. Now issue 'kexec_load' to load the secondary kernel (let's assume
   that we are using the same kernel as the secondary kernel):
   # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
     -r`.img --reuse-cmdline -d

3. Issue 'kexec -e' to warm boot to the secondary:
   # kexec -e

4. Now after the secondary boots, confirm that the load address of the
   modules is randomized in every successive boot:

   [root@qualcomm-amberwing]# cat /proc/modules
   sunrpc 524288 1 - Live 0xffff0307db190000
   vfat 262144 1 - Live 0xffff0307db110000
   fat 262144 1 vfat, Live 0xffff0307db090000
   crc32_ce 262144 0 - Live 0xffff0307d8c70000
   ...

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - Addressed Akashi's comments regarding the goto label path.
 - v1 can be viewed here: https://marc.info/?l=kexec&m=152373724406110&w=2

 kexec/arch/arm64/kexec-arm64.c | 138 +++++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 38 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f37585b788..a206c172b1aa 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -15,6 +15,11 @@
 #include <linux/elf-em.h>
 #include <elf.h>
 
+#include <unistd.h>
+#include <syscall.h>
+#include <errno.h>
+#include <linux/random.h>
+
 #include "kexec.h"
 #include "kexec-arm64.h"
 #include "crashdump.h"
@@ -392,11 +397,13 @@ static int fdt_setprop_range(void *fdt, int nodeoffset,
 static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 {
 	uint32_t address_cells, size_cells;
-	int range_len;
-	int nodeoffset;
+	uint64_t fdt_val64;
+	uint64_t *prop;
 	char *new_buf = NULL;
+	int len, range_len;
+	int nodeoffset;
 	int new_size;
-	int result;
+	int result, kaslr_seed;
 
 	result = fdt_check_header(dtb->buf);
 
@@ -407,47 +414,103 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 
 	result = set_bootargs(dtb, command_line);
 
-	if (on_crash) {
-		/* determine #address-cells and #size-cells */
-		result = get_cells_size(dtb->buf, &address_cells, &size_cells);
-		if (result) {
-			fprintf(stderr,
-				"kexec: cannot determine cells-size.\n");
-			result = -EINVAL;
-			goto on_error;
-		}
+	/* determine #address-cells and #size-cells */
+	result = get_cells_size(dtb->buf, &address_cells, &size_cells);
+	if (result) {
+		fprintf(stderr, "kexec: cannot determine cells-size.\n");
+		result = -EINVAL;
+		goto on_error;
+	}
 
-		if (!cells_size_fitted(address_cells, size_cells,
-					&elfcorehdr_mem)) {
-			fprintf(stderr,
-				"kexec: elfcorehdr doesn't fit cells-size.\n");
+	if (!cells_size_fitted(address_cells, size_cells,
+				&elfcorehdr_mem)) {
+		fprintf(stderr, "kexec: elfcorehdr doesn't fit cells-size.\n");
+		result = -EINVAL;
+		goto on_error;
+	}
+
+	if (!cells_size_fitted(address_cells, size_cells,
+				&crash_reserved_mem)) {
+		fprintf(stderr, "kexec: usable memory range doesn't fit cells-size.\n");
+		result = -EINVAL;
+		goto on_error;
+	}
+
+	/* duplicate dt blob */
+	range_len = sizeof(uint32_t) * (address_cells + size_cells);
+	new_size = fdt_totalsize(dtb->buf)
+		+ fdt_prop_len(PROP_ELFCOREHDR, range_len)
+		+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
+
+	new_buf = xmalloc(new_size);
+	result = fdt_open_into(dtb->buf, new_buf, new_size);
+	if (result) {
+		dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
+				fdt_strerror(result));
+		result = -ENOSPC;
+		goto on_error;
+	}
+
+	/* fixup 'kaslr-seed' with a random value, if supported */
+	nodeoffset = fdt_path_offset(new_buf, "/chosen");
+	prop = fdt_getprop_w(new_buf, nodeoffset,
+			"kaslr-seed", &len);
+	if (!prop || len != sizeof(uint64_t)) {
+		dbgprintf("%s: no kaslr-seed found\n",
+				__func__);
+		/* for kexec warm reboot case, we don't need to fixup
+		 * other dtb properties
+		 */
+		if (!on_crash) {
+			dump_reservemap(dtb);
+			if (new_buf)
+				free(new_buf);
+
+			return result;
+		}
+	} else {
+		kaslr_seed = fdt64_to_cpu(*prop);
+
+		/* kaslr_seed must be wiped clean by primary
+		 * kernel during boot
+		 */
+		if (kaslr_seed != 0) {
+			dbgprintf("%s: kaslr-seed is not wiped to 0.\n",
+					__func__);
 			result = -EINVAL;
 			goto on_error;
 		}
 
-		if (!cells_size_fitted(address_cells, size_cells,
-					&crash_reserved_mem)) {
-			fprintf(stderr,
-				"kexec: usable memory range doesn't fit cells-size.\n");
+		/*
+		 * Invoke the getrandom system call with
+		 * GRND_NONBLOCK, to make sure we
+		 * have a valid random seed to pass to the
+		 * secondary kernel.
+		 */
+		result = syscall(SYS_getrandom, &fdt_val64,
+				sizeof(fdt_val64),
+				GRND_NONBLOCK);
+
+		if(result == -1) {
+			dbgprintf("%s: Reading random bytes failed.\n",
+					__func__);
 			result = -EINVAL;
 			goto on_error;
 		}
 
-		/* duplicate dt blob */
-		range_len = sizeof(uint32_t) * (address_cells + size_cells);
-		new_size = fdt_totalsize(dtb->buf)
-			+ fdt_prop_len(PROP_ELFCOREHDR, range_len)
-			+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
-
-		new_buf = xmalloc(new_size);
-		result = fdt_open_into(dtb->buf, new_buf, new_size);
+		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		result = fdt_setprop_inplace(new_buf,
+				nodeoffset, "kaslr-seed",
+				&fdt_val64, sizeof(fdt_val64));
 		if (result) {
-			dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
-				fdt_strerror(result));
-			result = -ENOSPC;
+			dbgprintf("%s: fdt_setprop failed: %s\n",
+					__func__, fdt_strerror(result));
+			result = -EINVAL;
 			goto on_error;
 		}
+	}
 
+	if (on_crash) {
 		/* add linux,elfcorehdr */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
 		result = fdt_setprop_range(new_buf, nodeoffset,
@@ -455,7 +518,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 				address_cells, size_cells);
 		if (result) {
 			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
-				fdt_strerror(result));
+					fdt_strerror(result));
 			result = -EINVAL;
 			goto on_error;
 		}
@@ -467,18 +530,17 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 				address_cells, size_cells);
 		if (result) {
 			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
-				fdt_strerror(result));
+					fdt_strerror(result));
 			result = -EINVAL;
 			goto on_error;
 		}
-
-		fdt_pack(new_buf);
-		dtb->buf = new_buf;
-		dtb->size = fdt_totalsize(new_buf);
 	}
 
-	dump_reservemap(dtb);
+	fdt_pack(new_buf);
+	dtb->buf = new_buf;
+	dtb->size = fdt_totalsize(new_buf);
 
+	dump_reservemap(dtb);
 
 	return result;
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
