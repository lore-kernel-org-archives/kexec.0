Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMslG-0006jP-RH
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 05:28:28 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: optimize is_zero_page
Date: Mon, 10 Mar 2014 05:25:53 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F41C5@BPXM01GP.gisp.nec.co.jp>
References: <20140305144957.18703.41199.sendpatchset@dhcp-33-231.bos.redhat.com>
In-Reply-To: <20140305144957.18703.41199.sendpatchset@dhcp-33-231.bos.redhat.com>
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

>There are local complaints that  filtering out only zero pages is slow.  I
>found that is_zero_page was inefficient.  It checks if the page contains any
>non-zero bytes - one byte at a time.
>
>Improve performance by checking for non-zero data 64 bits at a time.
>
>Did testing in x86_64 mode on an Intel Xeon x5560 system with 18GB RAM.
>Executed:
>  time makedumpfile -d 1 /proc/vmcore <destination>
>
>The amount of time taken in User space was reduced by 64%.  The total time to
>dump memory was reduced by 27%.
>
>Change Log:
>
>v1 => v2)
>
>o Eliminate loop unrolling as it is of minimal benefit based on CPU.

Thank you for fixing, I'll merge this into v1.5.6.

Atsushi Kumagai

>is_zero_page
>Signed-off-by: Marc Milgram <mmilgram at redhat.com>
>---
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 3d270c6..1751e3a 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1634,9 +1634,11 @@ static inline int
> is_zero_page(unsigned char *buf, long page_size)
> {
> 	size_t i;
>+	unsigned long long *vect = (unsigned long long *) buf;
>+	long page_len = page_size / sizeof(unsigned long long);
>
>-	for (i = 0; i < page_size; i++)
>-		if (buf[i])
>+	for (i = 0; i < page_len; i++)
>+		if (vect[i])
> 			return FALSE;
> 	return TRUE;
> }
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
