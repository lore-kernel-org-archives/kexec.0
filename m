From: Lichen Liu <lichliu@redhat.com>
Date: Wed, 30 Mar 2022 19:05:06 +0800
Subject: [PATCH v2] kexec-tools: Determine if the image is lzma commpressed
In-Reply-To: <YkQfIPAwuZRsXN41@vergenet.net>
References: <20220330053326.3220260-1-lichliu@redhat.com>
 <YkQfIPAwuZRsXN41@vergenet.net>
Message-ID: <CAPmSd0NALNvQ4wQ7Bc03cv7iVxntr7m2AsMNmTNhaphV3g30Vg@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Simon,

I will send a new patch to fix it.

Thanks!


On Wed, Mar 30, 2022 at 5:14 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Wed, Mar 30, 2022 at 01:33:26PM +0800, Lichen Liu wrote:
> > Currently there are 2 functions for decompressing compressed image. The
> > zlib_decompress_file() will determine if the image is compressed by gzip
> > before read, but lzma_decompress_file() will not. This can cause misleading
> > information to be printed when the image is not compressed by lzma and
> > debug option is used:
> >
> > ]# kexec -d -s -l /boot/vmlinuz-5.14.10-300.fc35.x86_64 \
> > --initrd /boot/initramfs-5.14.10-300.fc35.x86_64.img \
> > --reuse-cmdline
> > Try gzip decompression.
> > Try LZMA decompression.
> > lzma_decompress_file: read on /boot/vmlinuz-5.14.10-300.fc35.x86_64 of
> > 65536 bytes failed
> >
> > Add a helper function is_lzma_file() to help behave consistently.
> >
> > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > ---
> > Changes in v2:
> > - add a fclose() when file is too small.
>
> Hi Lichen Liu,
>
> I have already applied v1 of this patch,
> so could you consider providing a follow-up patch
> which contains the delta between v1 and v2?
>
> Thanks!
>
> Ref: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/1b03cf7adc3c
>
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


