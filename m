Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UApXD-0005iw-51
 for kexec@lists.infradead.org; Wed, 27 Feb 2013 22:31:35 +0000
Date: Wed, 27 Feb 2013 14:31:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] kexec: Use min_t to simplify logic
Message-Id: <20130227143133.7208d381.akpm@linux-foundation.org>
In-Reply-To: <512C789D.1090404@cn.fujitsu.com>
References: <512C44E4.70907@cn.fujitsu.com> <512C4881.90409@cn.fujitsu.com>
 <1361867881.2023.16.camel@joe-AO722>
 <512C76FE.4070109@cn.fujitsu.com>
 <20130226005328.e2d31a97.akpm@linux-foundation.org>
 <512C789D.1090404@cn.fujitsu.com>
Mime-Version: 1.0
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Joe Perches <joe@perches.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 26 Feb 2013 16:55:57 +0800
Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:

> ___ 2013___02___26___ 16:53, Andrew Morton ______:
> > On Tue, 26 Feb 2013 16:49:02 +0800 Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:
> > 
> >>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
> >>> []
> >>>> @@ -822,13 +822,9 @@ static int kimage_load_normal_segment(struct kimage *image,
> >>> []
> >>>> +		mchunk = min_t(size_t, mbytes,
> >>>> +			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
> >>>
> >>> #define min_t(type, x, y) ({			\
> >>> 	type __min1 = (x);			\
> >>> 	type __min2 = (y);			\
> >>> 	__min1 < __min2 ? __min1: __min2; })
> >>>
> >>>
> >>>
> >>
> >> Hmm, from the definition, the cast is redundant.
> >>
> >> Maybe I misunderstood what Andrew meant in the mail related to v2:
> >>
> >> "The types of PAGE_SIZE and PAGE_MASK are vague - iirc they once had
> >> different types on different architectures, so some form of casting is
> >> unavoidable here."
> >>
> >> Andrew, could you please explain the casting you meant above?
> > 
> > I mean that a cast (or min_t, which is a cast) will be needed. 
> > The code you have here casts the same thing two times, which isn't
> > necessary.
> > 
> > 
> 
> Thanks.
> 
> Should I resend the patch again? After removing this redundant cast,
> it is the same with v2.

That patch was pretty busted.   This should fix everything up:

--- a/kernel/kexec.c~kexec-use-min_t-to-simplify-logic-fix
+++ a/kernel/kexec.c
@@ -820,8 +820,8 @@ static int kimage_load_normal_segment(st
 		clear_page(ptr);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
-			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
-		uchunk = min_t(size_t, ubytes, mchunk);
+				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		uchunk = min(ubytes, mchunk);
 
 		result = copy_from_user(ptr, buf, uchunk);
 		kunmap(page);
@@ -868,8 +868,8 @@ static int kimage_load_crash_segment(str
 		ptr = kmap(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
-			       (size_t)(PAGE_SIZE - (maddr & ~PAGE_MASK)));
-		uchunk = min_t(size_t, ubytes, mchunk);
+				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		uchunk = min(ubytes, mchunk);
 		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
 			memset(ptr + uchunk, 0, mchunk - uchunk);
@@ -1451,7 +1451,7 @@ void vmcoreinfo_append_str(const char *f
 	r = vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	r = min_t(size_t, r, vmcoreinfo_max_size - vmcoreinfo_size);
+	r = min(r, vmcoreinfo_max_size - vmcoreinfo_size);
 
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
