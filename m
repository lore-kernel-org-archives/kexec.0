Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via
 kexec_file_load()
Date: Fri,  7 Dec 2018 10:14:39 +0000
Message-Id: <20181207101439.190918-1-james.morse@arm.com>
MIME-Version: 1.0
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
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, bhsharma@redhat.com, Frank Rowand <frowand.list@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, prudo@linux.ibm.com, dyoung@redhat.com, David Miller <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

Now that kexec_walk_memblock() can do the crash-kernel placement itself
architectures that don't support kdump via kexe_file_load() need to
explicitly forbid it.

We don't support this on arm64 until the kernel can add the elfcorehdr
and usable-memory-range fields to the DT. Without these the crash-kernel
overwrites the previous kernel's memory during startup.

Add a check to refuse crash image loading.

Signed-off-by: James Morse <james.morse@arm.com>
---

Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com

 arch/arm64/kernel/kexec_image.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1ad1d5f8f024..07bf740bea91 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
 	struct kexec_segment *kernel_segment;
 	int ret;
 
+	/* We don't support crash kernels yet. */
+	if (image->type == KEXEC_TYPE_CRASH)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * We require a kernel with an unambiguous Image header. Per
 	 * Documentation/booting.txt, this is the case when image_size
-- 
2.19.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
