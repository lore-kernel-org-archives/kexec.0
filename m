From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Mar 2022 11:14:47 +0200
Subject: [PATCH v2] purgatory: do not enable vectorization automatically
 for purgatory compiling
In-Reply-To: <YkLbjMVdz8o+SAYY@MiWiFi-R3L-srv>
References: <20220329100155.328474-1-bhe@redhat.com>
 <YkLbjMVdz8o+SAYY@MiWiFi-R3L-srv>
Message-ID: <YkQfh7KIume8VLjU@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Mar 29, 2022 at 06:12:28PM +0800, Baoquan He wrote:
> Redhat CKI reported kdump kernel will hang a while very early after crash
> triggered, then reset to firmware to reboot.
> 
> This failure can only be observed with kdump or kexec reboot via
> kexec_load system call. With kexec_file_load interface, both kdump and
> kexec reboot work very well. And further investigation shows that gcc
> version 11 doesn't have this issue, while gcc version 12 does.
> 
> After checking the release notes of the latest gcc, Dave found out it's
> because gcc 12 enables auto-vectorization for -O2 optimization level.
> Please see below link for more information:
> 
>   https://www.phoronix.com/scan.php?page=news_item&px=GCC-12-Auto-Vec-O2
> 
> Adding -fno-tree-vectorize to Makefile of purgatory can fix the issue.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Thanks, applied.

