Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eg4MP-0002LU-8B
 for kexec@lists.infradead.org; Mon, 29 Jan 2018 08:00:19 +0000
Date: Mon, 29 Jan 2018 15:59:54 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH kexec-tools] x86: use old screen_info if needed
Message-ID: <20180129075954.GA6020@dhcp-128-65.nay.redhat.com>
References: <20180128055231.GA1744@dhcp-128-65.nay.redhat.com>
 <20180129072135.pyzaawl7i6ny3piv@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180129072135.pyzaawl7i6ny3piv@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 01/29/18 at 08:21am, Simon Horman wrote:
> On Sun, Jan 28, 2018 at 01:52:31PM +0800, Dave Young wrote:
> > With modern drm/kms graphic driver kexec-tools does not setup screen_info
> > correctly so one will only see screen output after those drm drivers
> > reinitializing after rebooting. Copying the old screen info from original
> > boot_params will help during my test, although it could not work for some
> > potential cases, but it is not worse than before.  This has been used in
> > the kernel kexec_file_load.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Thanks, applied.

Hi Simon,

Thanks for taking it.  I tested the original version on my laptop with
efi boot.  either of below two changes work for me:

a) use the setup_linux_vesafb() detected values and change the orig_video_isVGA
to 0x70 (copy from boot params)

b) copy all screen_info from boot params.

I actually was hesitating which one is better and finally I sent the b).
But maybe a) + b) will be better, since my case is a framebuffer, I'm
not sure non-framebuffer case though it will be not worse with the
patch.  Could you consider an appending patch below?

---
In current kexec-tools we have already vesafb detecting code,
but in case unsupported vesa fb types it just return and do nothing
During my test copying the old boot time screen info works for me with
efi booted machine. And the vesa fb detected values also work even if the
fb fix.id is "inteldrmfb", thus change the code to use those values
detected with fb ioctl first for framebuffer systems.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -123,6 +123,7 @@ void setup_linux_bootloader_parameters_h
 	cmdline_ptr[cmdline_len - 1] = '\0';
 }
 
+static int get_bootparam(void *buf, off_t offset, size_t size);
 static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
 {
 	struct fb_fix_screeninfo fix;
@@ -144,8 +145,13 @@ static int setup_linux_vesafb(struct x86
 		/* VIDEO_TYPE_EFI */
 		real_mode->orig_video_isVGA = 0x70;
 	} else {
-		/* cannot handle and other types */
-		goto out;
+		int err;
+		off_t offset = offsetof(typeof(*real_mode), orig_video_isVGA);
+
+		/* blindly try old boot time video type */
+		err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
+		if (err)
+			goto out;
 	}
 	close(fd);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
