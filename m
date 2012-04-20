Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SL30h-0006Xh-VQ
 for kexec@lists.infradead.org; Fri, 20 Apr 2012 01:51:46 +0000
Date: Fri, 20 Apr 2012 10:47:57 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 1/4] [makedumpfile] Add read_string routine
Message-Id: <20120420104757.7ce2ea60.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120216033535.7972.21257.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120216033535.7972.21257.stgit@suzukikp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org

Hello Suzuki,

On Thu, 16 Feb 2012 09:05:40 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> This patch adds a read_string() wrapper around readmem().
> 
> int read_string(int type_addr, unsigned long long addr, char *bufptr, size_t len);
> 
> The functionality is similar to that of readmem(), except that we stop reading
> when we find an end-of-string marker than reading 'len' bytes.
> 
> This will be useful for reading the name of the 'powerpc' platform which is
> needed for dynamic page address definition bits.
[...]
> +int
> +read_string(int type_addr, unsigned long long addr, char *buf, size_t len)
> +{
> +	int i;
> +
> +	memset(buf, 0, len);
> +	for (i = 0; i < len; i ++)
> +		if (!readmem(VADDR, addr + i, &buf[i], 1))
> +			break;
> +	return i;
> +}

Sorry for late reply. I reviewed your patches and I have question about
read_string().

You explained that read_string() stops reading when end-of-string appear,
but your code seems to read just 'len' bytes regardless of end-of-string. 
Maybe, do you expect readmem() to stop reading when end-of-string appear ?

Additionally, it is inefficient to call readmem() to read each byte of data.

Therefore, the code below may satisfy you ?

---------------------------------------------------------------------------
diff --git a/makedumpfile.c b/makedumpfile.c
index fea26af..5743d74 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -389,13 +389,29 @@ error:
 int
 read_string(int type_addr, unsigned long long addr, char *buf, size_t len)
 {
-       int i;
+       int i, remnant;
+       const int region = 512;

        memset(buf, 0, len);
-       for (i = 0; i < len; i ++)
-               if (!readmem(VADDR, addr + i, &buf[i], 1))
+       for (i = 0; i < len; i += region) {
+               /*
+                * buf[len] must be end-of-string.
+                */
+               remnant = len - i;
+               if (remnant == 1) {
                        break;
-       return i;
+               } else if (remnant <= region) {
+                       if (!readmem(type_addr, addr + i, &buf[i], remnant - 1 ))
+                               return ERROR;
+                       break;
+               }
+
+               if (!readmem(type_addr, addr + i, &buf[i], region))
+                       return ERROR;
+               if (strlen(buf) != i + region)
+                       break;
+       }
+       return strlen(buf);
 }


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
