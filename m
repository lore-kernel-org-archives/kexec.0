From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 18 Jan 2022 15:48:12 +0800
Subject: [PATCHv4 4/4] arm64: fix PAGE_OFFSET calc for flipped mm
In-Reply-To: <20220118074812.27702-1-piliu@redhat.com>
References: <20220118074812.27702-1-piliu@redhat.com>
Message-ID: <20220118074812.27702-5-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Kairui Song <kasong@tencent.com>

Since kernel commit 14c127c957c1 ('arm64: mm: Flip kernel VA space'),
the memory layout on arm64 have changed, and kexec-tools can no longer
get the the right PAGE_OFFSET based on _text symbol.

Prior to that, the kimage (_text) lays above PAGE_END with this layout:
0               -> VA_START                 : Usespace
VA_START        -> VA_START + 256M          : BPF JIT, Modules
VA_START + 256M -> PAGE_OFFSET - (~GB misc) : Vmalloc (KERNEL _text HERE)
PAGE_OFFSET     -> ...                      : * Linear map *

And here we have:
VA_START    = -1UL << VA_BITS
PAGE_OFFSET = -1UL << (VA_BITS - 1)
_text < -1UL << (VA_BITS - 1)

Kernel image lays somewhere between VA_START and PAGE_OFFSET, so we just
calc VA_BITS by getting the highest unset bit of _text symbol address,
and shift one less bit of VA_BITS to get page offset. This works as long
as KASLR don't put kernel in a too high location (which is commented inline).

And after that commit, kernel layout have changed:
0               -> PAGE_OFFSET              : Userspace
PAGE_OFFSET     -> PAGE_END                 : * Linear map *
PAGE_END        -> PAGE_END + 128M          : bpf jit region
PAGE_END + 128M -> PAGE_END + 256MB         : modules
PAGE_END + 256M -> ...                      : vmalloc (KERNEL _text HERE)

Here we have:
PAGE_OFFSET = -1UL << VA_BITS
PAGE_END    = -1UL << (VA_BITS - 1)
_text > -1UL << (VA_BITS - 1)

Kernel image now lays above PAGE_END, so we have to shift one more bit to
get the VA_BITS, and shift the exact VA_BITS for PAGE_OFFSET.

We can simply check if "_text > -1UL << (VA_BITS - 1)" is true to judge
which layout is being used and shift the page offset occordingly.

Signed-off-by: Kairui Song <kasong@tencent.com>
(rebased and stripped by Pingfan )
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-arm64.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 793799b..ce7a5bb 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -923,13 +923,25 @@ out:
 
 int get_page_offset(unsigned long *page_offset)
 {
+	unsigned long long text_sym_addr, kernel_va_mid;
 	int ret;
 
+	text_sym_addr = get_kernel_sym("_text");
+	if (text_sym_addr == 0) {
+		fprintf(stderr, "Can't get the symbol of _text to calculate page_offset.\n");
+		return -1;
+	}
+
 	ret = get_va_bits();
 	if (ret < 0)
 		return ret;
 
-	if (va_bits < 52)
+	/* Since kernel 5.4, kernel image is put above
+	 * UINT64_MAX << (va_bits - 1)
+	 */
+	kernel_va_mid = UINT64_MAX << (va_bits - 1);
+	/* older kernel */
+	if (text_sym_addr < kernel_va_mid)
 		*page_offset = UINT64_MAX << (va_bits - 1);
 	else
 		*page_offset = UINT64_MAX << va_bits;
-- 
2.31.1


