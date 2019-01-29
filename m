Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUob-0000rN-Aq
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 14:56:45 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2] makedumpfile: honor the CFLAGS from environment
 variables
Date: Tue, 29 Jan 2019 14:56:08 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03567572@BPXM09GP.gisp.nec.co.jp>
References: <20190129031415.11205-1-kasong@redhat.com>
In-Reply-To: <20190129031415.11205-1-kasong@redhat.com>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kairui Song <kasong@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On 1/28/2019 10:14 PM, Kairui Song wrote:
> This makes it possible to pass in extra cflags, for example, hardening
> flags could be passed in with environment variable when building a
> hardened package.
> 
> Also introduce a CFLAGS_BASE to hold common CFLAGS, which simplify the
> CFLAGS definition.
> 
> Suggested-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
> Update from V1:
>   - Use a CFLAGS_BASE to simplify CFLAGS definition
>   - Use immediate set rather than lazy set to avoid unexpected
>     flag duplication
> 
>  Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 612b9d0..bca9984 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -8,11 +8,10 @@ ifeq ($(strip $CC),)
>  CC	= gcc
>  endif
> 
> -CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> -	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
> -	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> -CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> -		    -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> +CFLAGS_BASE := $(CFLAGS) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> +                -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> +CFLAGS      := $(CFLAGS_BASE) -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> +CFLAGS_ARCH := $(CFLAGS_BASE)
>  # LDFLAGS = -L/usr/local/lib -I/usr/local/include
> 
>  HOST_ARCH := $(shell uname -m)
> --
> 2.20.1
> 

Thank you Kairui, applied.

Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
