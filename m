Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhQ8c-0000sI-TV
 for kexec@lists.infradead.org; Mon, 23 Jul 2018 01:59:52 +0000
Received: by mail-pl0-x241.google.com with SMTP id 94-v6so7540537ple.12
 for <kexec@lists.infradead.org>; Sun, 22 Jul 2018 18:59:38 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 3/5] efi/arm: preserve early mapping of UEFI memory map
 longer for BGRT
Date: Mon, 23 Jul 2018 10:57:30 +0900
Message-Id: <20180723015732.24252-4-takahiro.akashi@linaro.org>
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The BGRT code validates the contents of the table against the UEFI
memory map, and so it expects it to be mapped when the code runs.

On ARM, this is currently not the case, since we tear down the early
mapping after efi_init() completes, and only create the permanent
mapping in arm_enable_runtime_services(), which executes as an early
initcall, but still leaves a window where the UEFI memory map is not
mapped.

So move the call to efi_memmap_unmap() from efi_init() to
arm_enable_runtime_services().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c    | 1 -
 drivers/firmware/efi/arm-runtime.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index b5214c143fee..388a929baf95 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -259,7 +259,6 @@ void __init efi_init(void)
 
 	reserve_regions();
 	efi_esrt_init();
-	efi_memmap_unmap();
 
 	memblock_reserve(params.mmap & PAGE_MASK,
 			 PAGE_ALIGN(params.mmap_size +
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..59a8c0ec94d5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
 		return 0;
 	}
 
+	efi_memmap_unmap();
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
-- 
2.18.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
