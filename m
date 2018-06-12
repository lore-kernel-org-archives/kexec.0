Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fSjSb-0005hU-RR
 for kexec@lists.infradead.org; Tue, 12 Jun 2018 13:36:14 +0000
From: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
Subject: [RFC] fitImage support on ARM64
Message-ID: <5e99ff9a-cc16-ba15-3391-909253046ae5@sigfox.com>
Date: Tue, 12 Jun 2018 15:35:27 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EF63C4B0D60D8D92E3EFE508"
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

This is a multi-part message in MIME format.
--------------EF63C4B0D60D8D92E3EFE508
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I started working on implementing fitImage support in kexec.

Regarding image parsing & loading, things are going quite well, but I 
realized the only way to load a device tree and/or initramfs for now was 
to have them stored in files separated from the kernel.

I came up with a solution that requires appending new fields to the 
kexec_info structure (see attached patch), and wonder if that sounds 
right to you ? I guess other architectures might benefit from this 
support, so I didn't want an ARM64-specific solution.

Any comment will be welcome !

Regards,
Arnaud

--------------EF63C4B0D60D8D92E3EFE508
Content-Type: text/x-patch;
 name="kexec-arm64-fitimage-loading.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kexec-arm64-fitimage-loading.patch"

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f3758..5888a6c 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -544,6 +544,10 @@ int arm64_load_other_segments(struct kexec_info *info,
 	if (arm64_opts.dtb) {
 		dtb.name = "dtb_user";
 		dtb.buf = slurp_file(arm64_opts.dtb, &dtb.size);
+	} else if (info->dtb) {
+		dtb.name = "dtb_fit";
+		dtb.buf = info->dtb;
+		dtb.size = info->dtb_size;
 	} else {
 		result = read_1st_dtb(&dtb);

@@ -568,8 +572,13 @@ int arm64_load_other_segments(struct kexec_info *info,
 	else
 		hole_max = ULONG_MAX;

-	if (arm64_opts.initrd) {
-		initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
+	if (arm64_opts.initrd || info->initrd) {
+		if (arm64_opts.initrd)
+			initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
+		else {
+			initrd_buf = info->initrd;
+			initrd_size = info->initrd_size;
+		}

 		if (!initrd_buf)
 			fprintf(stderr, "kexec: Empty ramdisk file.\n");
diff --git a/kexec/kexec.h b/kexec/kexec.h
index d445fbe..9ac1537 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -166,6 +166,10 @@ struct kexec_info {
 	int initrd_fd;
 	char *command_line;
 	int command_line_len;
+	char *initrd;
+	off_t initrd_size;
+	char *dtb;
+	off_t dtb_size;
 };

 struct arch_map_entry {

--------------EF63C4B0D60D8D92E3EFE508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------EF63C4B0D60D8D92E3EFE508--

