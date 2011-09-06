Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0xqP-0001Nw-OJ
	for kexec@lists.infradead.org; Tue, 06 Sep 2011 15:45:52 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p86Fjdl8017239
	for <kexec@lists.infradead.org>; Tue, 6 Sep 2011 21:15:39 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p86FjceN2646054
	for <kexec@lists.infradead.org>; Tue, 6 Sep 2011 21:15:38 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p86Fjbsu027685
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 01:45:38 +1000
Date: Tue, 6 Sep 2011 21:14:52 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in
	compressed kdump file
Message-ID: <20110906154452.GA18186@in.ibm.com>
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110819151659.6cfd324b.oomichi@mxs.nes.nec.co.jp>
	<20110822115757.GA23157@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110822115757.GA23157@in.ibm.com>
Reply-To: mahesh@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Dave Anderson <anderson@redhat.com>

On 2011-08-22 17:27:58 Mon, Mahesh J Salgaonkar wrote:
> On 2011-08-19 15:16:59 Fri, Ken'ichi Ohmichi wrote:
> > 
> > Hi Mahesh,
> > 
> > Sorry about many responses of this patch.
> > 
> > On Wed, 18 May 2011 01:36:17 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > >
> > > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > > 
> > > Include the erase information in the makedumpfile generated dumpfile. The
> > > erased information contains only effective lines from the filter
> > > configuration file. This patch supports inclusion of erase information in
> > > kdump compressed, flatten and split dumpfiles. On re-filtering, the erase
> > > information from input dumpfile (if any) will be carried over to resulting
> > > dumpfile.
> > > 
> > > This patch introduces new members offset_eraseinfo, size_eraseinfo into the
> > > sub header in compressed kdump file.
> > > 
> > > The erased information would contain *multiple* erased symbol names.
> > > For example, the following is based on your above example.
> > > 
> > > 	struct S1 {
> > > 		int a;
> > > 		int b;
> > > 		int c;
> > > 	};
> > > 	struct S2 {
> > > 		struct S1 *mystruct1;
> > > 		struct S1 *mystruct2;
> > > 	};
> > > 
> > > 	struct S2 mystruct2;
> > > 
> > > 	#Filter command
> > > 	erase mystruct2.mystruct1.a
> > > 	erase mystruct2.mystruct1.c
> > > 	erase mystruct2.mystruct2.b
> > > 
> > > 	#The erased information
> > > 	erase mystruct2.mystruct1.a 4
> > > 	erase mystruct2.mystruct1.c 4
> > > 	erase mystruct2.mystruct2.b 4
> > 
> > While testing this feature, I noticed the description format of
> > makedumpfile.conf is different from the one of eraseinfo.
> > The former contains "size", but the later does not.
> > 
> > Are there any reasons of different formats ?
> 
> There is no specific reason, since it is just an information I thought we
> can follow a simple format.
> 
> > I feel the same format will be useful.
> 
> Sure, will make the change.
> 
> Thanks,
> -Mahesh.

Hi Ken'ichi,

Please find the patch below that now maintain the same format for
eraseinfo data.

Thanks,
-Mahesh.


makedumpfile: Use the same format as erase commands for eraseinfo data.

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The format of eraseinfo data differs from that of erase commands. This patch
makes sure eraseinfo data format is same as erase commands.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 IMPLEMENTATION |    4 ++--
 makedumpfile.c |    4 ++--
 makedumpfile.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index c11bd36..f0f3135 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -26,9 +26,9 @@
     |                        :                 |
     |         page data (pfn Z)                |
     +------------------------------------------+ offset_eraseinfo
-    | erase mystruct2.mystruct1.var 4          |
+    | erase mystruct2.mystruct1.var size 4     |
     | erase mystruct2.mystruct1.ptr nullify    |
-    | erase mystruct2.mystruct.array 100       |
+    | erase mystruct2.mystruct.array size 100  |
     +------------------------------------------+
 
 
diff --git a/makedumpfile.c b/makedumpfile.c
index 1a88171..2c49bbe 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3949,7 +3949,7 @@ write_elf_header(struct cache_data *cd_header)
 		if (fl_info->nullify)
 			sprintf(size_str, "nullify\n");
 		else
-			sprintf(size_str, "%ld\n", fl_info->size);
+			sprintf(size_str, "size %ld\n", fl_info->size);
 
 		size_eraseinfo += strlen("erase ") +
 				strlen(ei->symbol_expr) + 1 +
@@ -4799,7 +4799,7 @@ write_eraseinfo(struct cache_data *cd_page, unsigned long *size_out)
 			continue;
 		for (j = 0; j < erase_info[i].num_sizes; j++) {
 			if (erase_info[i].sizes[j] > 0)
-				sprintf(size_str, "%ld\n",
+				sprintf(size_str, "size %ld\n",
 						erase_info[i].sizes[j]);
 			else if (erase_info[i].sizes[j] == -1)
 				sprintf(size_str, "nullify\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 8b1bd4f..2741903 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -411,7 +411,7 @@ do { \
 
 #define SIZE_XEN_CRASH_INFO_V2	(sizeof(unsigned long) * 10)
 
-#define MAX_SIZE_STR_LEN (21)
+#define MAX_SIZE_STR_LEN (26)	/* strlen("size ") + 21 */
 
 /*
  * The value of dependence on machine


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
