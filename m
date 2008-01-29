Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJerf-0000nr-Kx
	for kexec@lists.infradead.org; Tue, 29 Jan 2008 01:02:22 +0000
Received: from localhost (adsl-065-013-154-094.sip.rdu.bellsouth.net
	[65.13.154.94]) (authenticated bits=0)
	by ra.tuxdriver.com (8.14.0/8.13.7) with ESMTP id m0T11MjQ003248
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <kexec@lists.infradead.org>; Mon, 28 Jan 2008 20:02:07 -0500
Date: Mon, 28 Jan 2008 20:01:22 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080129010122.GA11935@hmsreliant.think-freely.org>
References: <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
	<20080128212910.GA21889@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080128212910.GA21889@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Mon, Jan 28, 2008 at 10:29:10PM +0100, Bernhard Walle wrote:
> * Neil Horman <nhorman@tuxdriver.com> [2008-01-28 21:53]:
> >  		return -1;
> >  	}
> >  
> > +	if (setup_header.protocol_version >= 0x0206) {
> > +		if (command_line_len > setup_header.cmdline_size) {
> > +			dbgprintf("Kernel command line too long for kernel!\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> >  	if (setup_header.protocol_version >= 0x0205) {
> >  		relocatable_kernel = setup_header.relocatable_kernel;
> >  		dbgprintf("bzImage is relocatable\n");
> 
> I know that there was a kernel release with 2048 _and_ still the old
> boot protocol, but wouldn't it be better to warn the user if the size
> is beyond 256 and the old kernel is used? I think new kexec-tools
> should still support old kernels without problems ...
> 

I don't know how important that really is, but I don't see a particular problem 
with it either.  From my reading of i386/boot.txt, versions prior to boot 
protocol 2.02 only supported a 256 bytes command line patch, so what if we just 
add an extra check in do_bzImage_load.  If the protocol version of the boot 
header is lexx than 0x0202, then we fail if the command line length is more than 
256 bytes.  Note there are two other locations where we use a linux boot 
protocol header, but they are both constructed heders, not read headers, and use 
protocol version 2.03, which support 2048 byte command lines.

So, patch to clean up command line header construction in kexec.  Does 5 
things:

1) moves command line out of the zero page (struct bootparam)

2) extends command line length to support 2K command lines

3) adds a check to ensure that command line length is reasonably sized for new 
boot protocols

4) adds a check to ensure that command line length is reasonably sized for old 
boot protocols

5) imports variables from latest struct setup_header in kernel bootparams.h

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 include/x86/x86-linux.h         |   20 ++++++++++++++------
 kexec/arch/i386/kexec-bzImage.c |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 6 deletions(-)


diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index afe66bd..4f3507e 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -144,18 +144,22 @@ struct x86_linux_param_header {
 	/* 2.04+ */
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  reserved15[0x2d0 - 0x235];	/* 0x230 */
+	uint8_t  reserved15[3];			/* 0x235 */
+	uint32_t cmdline_size;			/* 0x238 */
+	uint32_t hardware_subarch;		/* 0x23C */
+	uint64_t hardware_subarch_data;		/* 0x240 */
+	uint8_t  reserved16[0x2d0 - 0x248];	/* 0x248 */
 #endif
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 2048 
 };
 
 struct x86_linux_faked_param_header {
 	struct x86_linux_param_header hdr;	/* 0x00 */
-	uint8_t reserved16[688];		/* 0x550 */
-	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x800 */
-	uint8_t reserved17[1792];		/* 0x900 - 0x1000 */
+	uint8_t reserved17[0xab0];		/* 0x550 */
+	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x1000 */
+	uint8_t reserved18[0x200];		/* 0x1800 - 0x2000 */
 };
 
 struct x86_linux_header {
@@ -206,7 +210,11 @@ struct x86_linux_header {
 #else
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
+	uint8_t  reserved6[3];			/* 0x235 */
+	uint32_t cmdline_size;                  /* 0x238 */
+	uint32_t hardware_subarch;              /* 0x23C */
+	uint64_t hardware_subarch_data;         /* 0x240 */
+	uint8_t  tail[32*1024 - 0x248];		/* 0x248 */
 #endif
 } PACKED;
 
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 8fde799..6b1d818 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -134,6 +134,20 @@ int do_bzImage_load(struct kexec_info *info,
 		return -1;
 	}
 
+	if (setup_header.protocol_version >= 0x0206) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
+			return -1;
+		}
+	}
+
+	if (setup_header.protocol_version < 0x0202) {
+		if (command_line_len > 256) {
+			dbgprintf("Kernel only supports 256 byte command line!\n");
+			return -1;
+		}
+	}
+
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
 		dbgprintf("bzImage is relocatable\n");

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
