Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWIrt-0006ey-3k
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 08:23:50 +0000
Date: Wed, 25 Jan 2017 09:23:16 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3] kexec: implemented XEN KEXEC STATUS to determine if
 an image is loaded
Message-ID: <20170125082316.GF16671@olila.local.net-space.pl>
References: <1485284135-3058-1-git-send-email-eric.devolder@oracle.com>
 <20170124191640.GC16671@olila.local.net-space.pl>
 <87de0f8a-21b9-8aa4-f07b-78083f2610c2@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87de0f8a-21b9-8aa4-f07b-78083f2610c2@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org

On Tue, Jan 24, 2017 at 04:47:09PM -0600, Eric DeVolder wrote:
> On 01/24/2017 01:16 PM, Daniel Kiper wrote:
> >On Tue, Jan 24, 2017 at 12:55:35PM -0600, Eric DeVolder wrote:

[...]

> >>diff --git a/kexec/kexec.c b/kexec/kexec.c
> >>index 500e5a9..defbbe3 100644
> >>--- a/kexec/kexec.c
> >>+++ b/kexec/kexec.c
> >>@@ -51,6 +51,9 @@
> >> #include "kexec-lzma.h"
> >> #include <arch/options.h>
> >>
> >>+#define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
> >>+#define KEXEC_CRASH_LOADED_PATH "/sys/kernel/kexec_crash_loaded"
> >>+
> >> unsigned long long mem_min = 0;
> >> unsigned long long mem_max = ULONG_MAX;
> >> static unsigned long kexec_flags = 0;
> >>@@ -58,6 +61,8 @@ static unsigned long kexec_flags = 0;
> >> static unsigned long kexec_file_flags = 0;
> >> int kexec_debug = 0;
> >>
> >>+static int kexec_loaded(const char *file);
> >>+
> >
> >Why are you shuffling this...
> >
> >> void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
> >> {
> >> 	int i;
> >>@@ -890,8 +895,6 @@ static int my_exec(void)
> >> 	return -1;
> >> }
> >>
> >>-static int kexec_loaded(void);
> >>-
> >
> >...and this. Could not you leave this forward declaration here (of
> >course with arg change)? Or is it possible to drop it at all?
>
> It is possible to relocate kexec_loaded() so that the forward
> declaration is not needed. I will do so.

Great!

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
