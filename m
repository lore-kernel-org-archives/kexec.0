From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 13:59:33 +0800
Subject: [PATCH 1/2] arm64/crashdump-arm64: explicit type conversion to
 suppress compiler warning
In-Reply-To: <20220331055934.13608-1-piliu@redhat.com>
References: <20220331055934.13608-1-piliu@redhat.com>
Message-ID: <20220331055934.13608-2-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

elf_info.page_offset is 'unsigned long long', while get_page_offset()
has the input param as a type of 'unsigned long *'. It demands explicit
type casting to mute the compiler warning.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/crashdump-arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 7beb1fb..3098315 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -182,7 +182,7 @@ int load_crashdump_segments(struct kexec_info *info)
 	if (err)
 		return EFAILED;
 
-	get_page_offset(&elf_info.page_offset);
+	get_page_offset((unsigned long *)&elf_info.page_offset);
 	dbgprintf("%s: page_offset:   %016llx\n", __func__,
 			elf_info.page_offset);
 
-- 
2.31.1


