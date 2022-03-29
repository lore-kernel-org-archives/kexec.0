From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Mar 2022 11:14:56 +0200
Subject: [PATCH] kexec-tools: Determine if the image is lzma commpressed
In-Reply-To: <20220325070615.2408455-1-lichliu@redhat.com>
References: <20220325070615.2408455-1-lichliu@redhat.com>
Message-ID: <YkLOEFjuMksgLnNx@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Mar 25, 2022 at 03:06:15PM +0800, Lichen Liu wrote:
> Currently there are 2 functions for decompressing compressed image. The
> zlib_decompress_file() will determine if the image is compressed by gzip
> before read, but lzma_decompress_file() will not. This can cause misleading
> information to be printed when the image is not compressed by lzma and
> debug option is used:
> 
> ]# kexec -d -s -l /boot/vmlinuz-5.14.10-300.fc35.x86_64 \
> --initrd /boot/initramfs-5.14.10-300.fc35.x86_64.img \
> --reuse-cmdline
> Try gzip decompression.
> Try LZMA decompression.
> lzma_decompress_file: read on /boot/vmlinuz-5.14.10-300.fc35.x86_64 of
> 65536 bytes failed
> 
> Add a helper function is_lzma_file() to help behave consistently.
> 
> Signed-off-by: Lichen Liu <lichliu@redhat.com>

Thanks, applied.

