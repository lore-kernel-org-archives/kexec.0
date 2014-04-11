Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYXi8-0005xf-KI
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 09:25:25 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile memmory usage seems high with option -E
Date: Fri, 11 Apr 2014 09:22:58 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
References: <20140410214433.GF18808@redhat.com>
In-Reply-To: <20140410214433.GF18808@redhat.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>

Hello Vivek,

>Hi Atsushi/Hatayama,
>
>We noticed in our testing that makedumpfile gets OOM killed if we happen
>to use -E option. Saving to compressed kdump format works just fine.
>
>Also we noticed that with -E if we disable cyclic mode then it works just
>fine.
>
>So looks like something is going on with -E and cyclic mode enabled. I am
>not sure what it is.
>
>Do you suspect something?

At first, I supposed the function to calculate cyclic buffer size may
be related to this issue, but I haven't found the answer yet...

int
calculate_cyclic_buffer_size() {

        if (info->flag_elf_dumpfile) {
                free_size = get_free_memory_size() * 0.4;
                needed_size = (info->max_mapnr * 2) / BITPERBYTE;
        } else {
                free_size = get_free_memory_size() * 0.8;
                needed_size = info->max_mapnr / BITPERBYTE;
        }
        [...]
        info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;


I've found this function has an issue about memory allocation.
When -E is specified, info->bufsize_cyclic will be the total size of
the 1st and 2nd bitmap if free memory is enough. Then,
info->bufsize_cyclic will be used to allocate each bitmap in
prepare_bitmap_buffer_cyclic() like below:

        if ((info->partial_bitmap1 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
                ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
                       strerror(errno));
                return FALSE;
        }
        if ((info->partial_bitmap2 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
                ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
                       strerror(errno));
                return FALSE;
        }

It's a too much allocation definitely, but it mustn't exceed 80% of free
memory due to the condition check in calculate_cyclic_buffer_size(), so
I think the OOM issue will not happen by this issue.
I'll fix this too much allocation with the patch below, but it will not
resolve your OOM issue... 

BTW, what are your version of makedumpfile and crashkernel= size and
the system memory size? and does the issue happen even if you specify
--cyclic-buffer which is small enough to fit the available memory ?
I'm curious to know the details of the condition which cause the issue.


Thanks
Atsushi Kumagai


diff --git a/makedumpfile.c b/makedumpfile.c
index 75092a8..ae9e69a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8996,7 +8996,7 @@ out:
  */
 int
 calculate_cyclic_buffer_size(void) {
-	unsigned long long free_size, needed_size;
+	unsigned long long limit_size, bitmap_size;
 
 	if (info->max_mapnr <= 0) {
 		ERRMSG("Invalid max_mapnr(%llu).\n", info->max_mapnr);
@@ -9009,18 +9009,17 @@ calculate_cyclic_buffer_size(void) {
 	 * within 80% of free memory.
 	 */
 	if (info->flag_elf_dumpfile) {
-		free_size = get_free_memory_size() * 0.4;
-		needed_size = (info->max_mapnr * 2) / BITPERBYTE;
+		limit_size = get_free_memory_size() * 0.4;
 	} else {
-		free_size = get_free_memory_size() * 0.8;
-		needed_size = info->max_mapnr / BITPERBYTE;
+		limit_size = get_free_memory_size() * 0.8;
 	}
+	bitmap_size = info->max_mapnr / BITPERBYTE;
 
 	/* if --split was specified cyclic buffer allocated per dump file */
 	if (info->num_dumpfile > 1)
-		needed_size /= info->num_dumpfile;
+		bitmap_size /= info->num_dumpfile;
 
-	info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
+	info->bufsize_cyclic = (limit_size <= bitmap_size) ? limit_size : bitmap_size;
 
 	return TRUE;
 }
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
