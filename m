Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYR8m-0007ff-HM
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:24:30 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH RESEND v5 08/10] x86, cleanup: Add a funtion add_setup_data()
Date: Fri, 11 Apr 2014 10:23:29 +0800
Message-Id: <1397183011-1526-9-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

add_setup_data() is used to add an instance to the single linked list
of setup_data structure.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index e04e45d..8ed36cc 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -603,6 +603,22 @@ struct efi_info {
 };
 
 /*
+ * Add another instance to single linked list of struct setup_data.
+ * Please refer to kernel Documentation/x86/boot.txt for more details
+ * about setup_data structure.
+ */
+static void add_setup_data(struct kexec_info *info,
+			   struct x86_linux_param_header *real_mode,
+			   struct setup_data *sd)
+{
+	int sdsize = sizeof(struct setup_data) + sd->len;
+
+	sd->next = real_mode->setup_data;
+	real_mode->setup_data = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
+			    0x100000, ULONG_MAX, INT_MAX);
+}
+
+/*
  * setup_efi_data will collect below data and pass them to 2nd kernel.
  * 1) SMBIOS, fw_vendor, runtime, config_table, they are passed via x86
  *    setup_data.
@@ -611,11 +627,11 @@ struct efi_info {
 static int setup_efi_data(struct kexec_info *info,
 			  struct x86_linux_param_header *real_mode)
 {
-	int64_t setup_data_paddr, memmap_paddr;
+	int64_t memmap_paddr;
 	struct setup_data *sd;
 	struct efi_setup_data *esd;
 	struct efi_mem_descriptor *maps;
-	int nr_maps, size, sdsize, ret = 0;
+	int nr_maps, size, ret = 0;
 	struct efi_info *ei = (struct efi_info *)real_mode->efi_info;
 
 	ret = access("/sys/firmware/efi/systab", F_OK);
@@ -648,10 +664,8 @@ static int setup_efi_data(struct kexec_info *info,
 	sd->len = sizeof(*esd);
 	memcpy(sd->data, esd, sizeof(*esd));
 	free(esd);
-	sdsize = sd->len + sizeof(struct setup_data);
-	setup_data_paddr = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
-					0x100000, ULONG_MAX, INT_MAX);
-	real_mode->setup_data = setup_data_paddr;
+
+	add_setup_data(info, real_mode, sd);
 
 	size = nr_maps * sizeof(struct efi_mem_descriptor);
 	memmap_paddr = add_buffer(info, maps, size, size, getpagesize(),
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
