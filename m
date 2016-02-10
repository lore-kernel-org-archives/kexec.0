Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTe02-0003JT-S6
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 23:16:43 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 09:16:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9410D357805A
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:16:18 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1ANGAbq39387292
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:16:18 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1ANFjQh023755
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:15:46 +1100
Message-ID: <1455146125.2538.231.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 21/22] ima: measure and appraise the IMA policy itself
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 18:15:25 -0500
In-Reply-To: <CACE9dm9=MRT50JgZeHrLTBVK0W+J6gYgUrzSrfzOGii_r2Ct7A@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-22-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm9=MRT50JgZeHrLTBVK0W+J6gYgUrzSrfzOGii_r2Ct7A@mail.gmail.com>
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
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R.
 Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, 2016-02-10 at 22:22 +0200, Dmitry Kasatkin wrote:
> On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Add support for measuring and appraising the IMA policy itself.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> 
> But from Documentation/CodingStyle
> 
> if (condition)
>     do_this();
> else
>     do_that();
> 
> This does not apply if only one branch of a conditional statement is a single
> statement; in the latter case use braces in both branches:
> 
> if (condition) {
>      do_this();
>      do_that();
> } else {
>      otherwise();
> }
> 
> 
> You have similar issue in other patches as well...
> 
> Dmitry

Ok, I'll find and fix them.  Thank you for the review!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
