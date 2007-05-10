Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hly9m-0001m7-MC
	for kexec@lists.infradead.org; Wed, 09 May 2007 22:13:29 -0400
Date: Thu, 10 May 2007 11:13:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 1/2] kexec remove last remaining dfprintf
Message-ID: <20070510021318.GA30920@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com>
	<20070508061204.GD8170@verge.net.au> <46423FC4.605@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46423FC4.605@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Wed, May 09, 2007 at 02:40:20PM -0700, Geoff Levand wrote:
> Remove the last remaining dfprintf call and remove the dfprintf
> definition.

So we are standardising on stdout for debug messages?
Thats fine by me. However, curiously with your patch I get
the following error. Perhaps we should choose a different name?

i686-unknown-linux-gnu-gcc -Wall -O2 -fomit-frame-pointer -pipe -Wall -g -fno-strict-aliasing -Wstrict-prototypes -I/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/include -I./include -I./util_lib/include -DVERSION='"20070330-git"' -DRELEASE_DATE='"30th March 2007"' -DPACKAGE='"kexec-tools-testing"' -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_ZLIB_H=1 -Wall -g -fno-strict-aliasing -Wstrict-prototypes -I/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/include -Ikexec/arch/i386/include -o /home/horms/lang/c/kexec-tools/kexec-tools-testing-geoff-levand/objdir-i686-unknown-linux-gnu/kexec/kexec.o -c kexec/kexec.c
In file included from kexec/kexec.c:36:
kexec/kexec.h:224: error: conflicting types for 'dprintf'
/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.5/../../../../i686-unknown-linux-gnu/sys-include/stdio.h:384:
error: previous declaration of 'dprintf' was here
kexec/kexec.h:224: error: conflicting types for 'dprintf'
/home/horms/local/opt/crosstool/i686/gcc-3.4.5-glibc-2.3.6/i686-unknown-linux-gnu/bin/../lib/gcc/i686-unknown-linux-gnu/3.4.5/../../../../i686-unknown-linux-gnu/sys-include/stdio.h:384:
error: previous declaration of 'dprintf' was here
make: ***
[/home/horms/lang/c/kexec-tools/kexec-tools-testing-geoff-levand/objdir-i686-unknown-linux-gnu/kexec/kexec.o] Error 1


The relevant section of stdio.h is:

#ifdef __USE_GNU
/* Write formatted output to a string dynamically allocated with `malloc'.
   Store the address of the string in *PTR.  */
extern int vasprintf (char **__restrict __ptr, __const char *__restrict __f,
		      _G_va_list __arg)
     __THROW __attribute__ ((__format__ (__printf__, 2, 0)));
extern int __asprintf (char **__restrict __ptr,
		       __const char *__restrict __fmt, ...)
     __THROW __attribute__ ((__format__ (__printf__, 2, 3)));
extern int asprintf (char **__restrict __ptr,
		     __const char *__restrict __fmt, ...)
     __THROW __attribute__ ((__format__ (__printf__, 2, 3)));

/* Write formatted output to a file descriptor.

   These functions are not part of POSIX and therefore no official
   cancellation point.  But due to similarity with an POSIX interface
   or due to the implementation they are cancellation points and
   therefore not marked with __THROW.  */
extern int vdprintf (int __fd, __const char *__restrict __fmt,
		     _G_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, __const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));
#endif

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
