Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx7lu-0005m1-25
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 22:19:42 +0000
Date: Tue, 4 Nov 2008 09:19:39 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] make memcmp arguments const
Message-ID: <20081103221937.GA10026@verge.net.au>
References: <490F0BFC.5070504@suse.de>
MIME-Version: 1.0
In-Reply-To: <490F0BFC.5070504@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2125229383=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stefan Assmann <sassmann@suse.de>
Cc: kexec@lists.infradead.org

--===============2125229383==
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline

On Mon, Nov 03, 2008 at 03:34:36PM +0100, Stefan Assmann wrote:
> In purgatory/string.c the definition of memcmp is
> 	int memcmp(void *src1, void *src2, size_t len)
> man memcmp reveals
> 	int memcmp(const void *s1, const void *s2, size_t n)
> 
> Signed-off-by: Stefan Assmann <sassmann@suse.de>
> 
> ---
>  purgatory/string.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/purgatory/string.c
> +++ b/purgatory/string.c
> @@ -36,9 +36,9 @@ void* memcpy(void *dest, const void *src
>  }
> 
> 
> -int memcmp(void *src1, void *src2, size_t len)
> +int memcmp(const void *src1, const void *src2, size_t len)
>  {
> -	unsigned char *s1, *s2;
> +	const unsigned char *s1, *s2;
>  	size_t i;
>  	s1 = src1;
>  	s2 = src2;

Hi Stefan,

this change seems reasonable to me, but I think that
the declaration also needs to be updated. If the change
below is fine by you, could you please add it to your patch
and repost ?

# gcc --version
gcc (Debian 4.3.2-1) 4.3.2
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
...
gcc -Wall -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin -ffreestanding  -I./purgatory/include -I./purgatory/arch/i386/include -I./util_lib/include -I/usr/lib/gcc/i486-linux-gnu/4.3.2/include  -c -MD -o purgatory/string.o purgatory/string.c
purgatory/string.c:39: error: conflicting types for ‘memcmp’
./purgatory/include/string.h:9: error: previous declaration of ‘memcmp’ was
here
make: *** [purgatory/string.o] Error 1

Index: kexec-tools/purgatory/include/string.h
===================================================================
--- kexec-tools.orig/purgatory/include/string.h	2008-11-04 09:07:48.000000000 +1100
+++ kexec-tools/purgatory/include/string.h	2008-11-04 09:08:02.000000000 +1100
@@ -6,7 +6,7 @@
 size_t strnlen(const char *s, size_t max);
 void* memset(void* s, int c, size_t n);
 void* memcpy(void *dest, const void *src, size_t len);
-int memcmp(void *src1, void *src2, size_t len);
+int memcmp(const void *src1, const void *src2, size_t len);
 
 
 #endif /* STRING_H */

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en



--===============2125229383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2125229383==--
