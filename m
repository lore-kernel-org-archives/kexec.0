Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL3u5-000245-45
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 04:58:05 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: optimize is_zero_page
Date: Wed, 5 Mar 2014 04:55:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F1ACC@BPXM01GP.gisp.nec.co.jp>
References: <20140303194412.7864.20862.sendpatchset@dhcp-33-231.bos.redhat.com>
In-Reply-To: <20140303194412.7864.20862.sendpatchset@dhcp-33-231.bos.redhat.com>
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
To: "mmilgram@redhat.com" <mmilgram@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Marc,

>There are local complaints that  filtering out only zero pages is slow.  I
>found that is_zero_page was inefficient.  It checks if the page contains any
>non-zero bytes - one byte at a time.
>
>Improve performance by checking for non-zero data 64 bits at a time.  Also,
>unroll the loop for additional performance.
>
>Did testing in x86_64 mode on an Intel Xeon x5560 system with 18GB RAM.
>Executed:
>  time makedumpfile -d 1 /proc/vmcore <destination>
>
>The amount of time taken in User space was reduced by 75%.  The total time to
>dump memory was reduced by 28%.

Thanks for your good work, but...

>is_zero_page
>Signed-off-by: Marc Milgram <mmilgram at redhat.com>
>---
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 3d270c6..0f211c4 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1634,10 +1634,27 @@ static inline int
> is_zero_page(unsigned char *buf, long page_size)
> {
> 	size_t i;
>+	unsigned long long *vect = (unsigned long long *) buf;
>+	long page_len = page_size / (sizeof(unsigned long long));
>
>-	for (i = 0; i < page_size; i++)
>-		if (buf[i])
>+	for (i = 0; i < page_len; i+=8) {
>+		if (vect[i])
> 			return FALSE;
>+		if (vect[i+1])
>+			return FALSE;
>+		if (vect[i+2])
>+			return FALSE;
>+		if (vect[i+3])
>+			return FALSE;
>+		if (vect[i+4])
>+			return FALSE;
>+		if (vect[i+5])
>+			return FALSE;
>+		if (vect[i+6])
>+			return FALSE;
>+		if (vect[i+7])
>+			return FALSE;
>+	}
> 	return TRUE;
> }

It looks messy, I don't like such a manual loop unrolling and it
seems to affect performance a little according to my small test:

(test results for 4k page)
   8 bits x   1 line  x 4096 loops (current code):      user  0m7.045s
  64 bits x   1 line  x  512 loops               :      user  0m1.847s
  64 bits x   8 lines x   64 loops (your patch)  :      user  0m1.546s
  64 bits x 512 lines x    1 loop                :      user  0m1.642s

(dump information)
    Original pages  : 0x000000000013073b
      Excluded pages   : 0x0000000000108b4e
        Pages filled with zero  : 0x0000000000108b4e
        Cache pages             : 0x0000000000000000
        Cache pages + private   : 0x0000000000000000
        User process data pages : 0x0000000000000000
        Free pages              : 0x0000000000000000
        Hwpoison pages          : 0x0000000000000000
      Remaining pages  : 0x0000000000027bed
      (The number of pages is reduced to 13%.)
    Memory Hole     : 0x000000000003f8c5
    --------------------------------------------------
    Total pages     : 0x0000000000170000

So I think the loop unrolling is unnecessary.


Thanks
Atsushi Kumagai

>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
