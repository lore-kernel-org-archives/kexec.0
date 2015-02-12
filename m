Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLoli-0002hO-Mc
 for kexec@lists.infradead.org; Thu, 12 Feb 2015 08:05:03 +0000
Received: by mail-oi0-f45.google.com with SMTP id i138so1901427oig.4
 for <kexec@lists.infradead.org>; Thu, 12 Feb 2015 00:04:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150211230807.GA6735@verge.net.au>
References: <1423172184-8076-1-git-send-email-2ameya@gmail.com>
 <20150211230807.GA6735@verge.net.au>
Date: Thu, 12 Feb 2015 00:04:41 -0800
Message-ID: <CAFAJAEweOaeMBvQsNnZcQRwFU0gsVL7=t6Vx8izY2TUzUZVbcg@mail.gmail.com>
Subject: Re: [PATCH] multiboot: fix crash on NULL kernel command line
From: Ameya Palande <2ameya@gmail.com>
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

On Wed, Feb 11, 2015 at 3:08 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Feb 05, 2015 at 01:36:24PM -0800, Ameya Palande wrote:
>> If "--command-line" option is not specified, then kexec segfaults while
>> dereferencing NULL command line string pointer. While we are at it, also
>> fix indentation and use '{' and '}' consistently.
>>
>> Signed-off-by: Ameya Palande <2ameya@gmail.com>
>
> Somehow I missed this. Please CC me on patches for kexec-tools as
> it makes it easier for me to see them.

Sure!

> Please resubmit this patch split up so that fixes and cleanups are separate.
> One patch per issue is the rule of thumb. This makes it easier to review
> and prioritise patches.

Looks like you already applied it :) Thanks!

Cheers,
Ameya.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
