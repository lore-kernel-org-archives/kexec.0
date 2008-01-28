Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJazh-0005kF-Qr
	for kexec@lists.infradead.org; Mon, 28 Jan 2008 20:54:24 +0000
Date: Mon, 28 Jan 2008 15:53:24 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080128205324.GC1174@hmsreliant.think-freely.org>
References: <20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080128202041.GD32765@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Jan 28, 2008 at 03:20:41PM -0500, Vivek Goyal wrote:
> >  
> >  struct x86_linux_header {
> > @@ -206,7 +210,10 @@ struct x86_linux_header {
> >  #else
> >  	uint32_t kernel_alignment;		/* 0x230 */
> >  	uint8_t  relocatable_kernel;		/* 0x234 */
> > -	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
> > +	uint32_t cmdline_size;                  /* 0x235 */
> > +	uint32_t hardware_subarch;              /* 0x239 */
> > +	uint64_t hardware_subarch_data;         /* 0x23D */
> 
> We need a padding of 3 bytes here too between relocatable kernel and
> cmdline_size, in the same way as x86_linux_param_header?
> 

Oh, good catch, yes we do need that.  I expect it passed my testing because the
garbage that wound up in cmdline_size was big enough to pass the check in
do_bzImage_load.

New patch, same summary as before, with the above correction

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 include/x86/x86-linux.h         |   20 ++++++++++++++------
 kexec/arch/i386/kexec-bzImage.c |    7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)


diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index afe66bd..6e4f984 100644
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
index 8fde799..4f2a294 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -134,6 +134,13 @@ int do_bzImage_load(struct kexec_info *info,
 		return -1;
 	}
 
+	if (setup_header.protocol_version >= 0x0206) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
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
