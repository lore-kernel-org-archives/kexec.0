Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8M67-0003Gm-IK
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 08:36:21 +0000
Date: Tue, 17 Apr 2018 16:36:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] kexec_file: do not add extra alignment to efi memmap
Message-ID: <20180417083600.GA1972@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: joeyli <jlee@suse.com>, linux-efi@vger.kernel.org, Randy Wright <rwright@hpe.com>

Chun-Yi reported a kernel warning message below:
WARNING: CPU: 0 PID: 0 at ../mm/early_ioremap.c:182 early_iounmap+0x4f/0x12c()
early_iounmap(ffffffffff200180, 00000118) [0] size not consistent 00000120

The problem is x86 kexec_file_load adds extra alignment to the efi memmap:
in bzImage64_load()
        efi_map_sz = efi_get_runtime_map_size();
        efi_map_sz = ALIGN(efi_map_sz, 16);

And __efi_memmap_init maps with the size including the alignment bytes
but efi_memmap_unmap use nr_maps * desc_size which does not include the
extra bytes.

The alignment in kexec code is only needed for the kexec buffer internal use
Actually kexec should pass exact size of the efi memmap to 2nd kernel.

Signed-off-by: Dave Young <dyoung@redhat.com>
Reported-by: joeyli <jlee@suse.com>
Tested-by: Randy Wright <rwright@hpe.com>
---
 arch/x86/kernel/kexec-bzimage64.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux.orig/arch/x86/kernel/kexec-bzimage64.c
+++ linux/arch/x86/kernel/kexec-bzimage64.c
@@ -398,11 +398,10 @@ static void *bzImage64_load(struct kimag
 	 * little bit simple
 	 */
 	efi_map_sz = efi_get_runtime_map_size();
-	efi_map_sz = ALIGN(efi_map_sz, 16);
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
 				MAX_ELFCOREHDR_STR_LEN;
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
-	kbuf.bufsz = params_cmdline_sz + efi_map_sz +
+	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
 				sizeof(struct efi_setup_data);
 
@@ -410,7 +409,7 @@ static void *bzImage64_load(struct kimag
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
-	efi_setup_data_offset = efi_map_offset + efi_map_sz;
+	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
 
 	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
 	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
