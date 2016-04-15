Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x241.google.com ([2607:f8b0:4001:c05::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqsAA-0002hT-2V
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 01:03:14 +0000
Received: by mail-ig0-x241.google.com with SMTP id g8so1096828igr.0
 for <kexec@lists.infradead.org>; Thu, 14 Apr 2016 18:02:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f80ca230bf1fab7527d355e535de305f@abdsec.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
Date: Thu, 14 Apr 2016 18:02:49 -0700
Message-ID: <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
From: Linus Torvalds <torvalds@linux-foundation.org>
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
To: Emrah Demir <ed@abdsec.com>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, kexec@lists.infradead.org, Zhengyu Zhang <zhezhang@redhat.com>, Dave Young <dyoung@redhat.com>

On Thu, Apr 14, 2016 at 1:27 PM, Emrah Demir <ed@abdsec.com> wrote:
> On 2016-04-14 13:40, Linus Torvalds wrote:
>>
>>
>> Actually, %pK is horrible in /proc and /sys files, and does the wrong
>> thing.
>
> I agree with that, but for now there is no way to make things right in /proc
> or /sys.

Well, there is now.

I've pushed out my attempt at fixing things properly. Please check
that kexec works - and if kexec ends up reading that file as non-root,
I don't know what to say/do.

Here's the three relevant cases:

   cat /proc/iomem
   sudo cat /proc/iomem
   sudo cat < /proc/iomem

and two of them will now show the resource ranges as just plain
zeroes. But yes, it needed extra infrastructure to be able to get this
right.

Note that while %pK is always wrong in /proc and /sys files, in this
case it would have been particularly wrong, since the values can be
64-bit even on a 32-bit architecture, so trying to show them as
pointers would have gotten not just the capability handling wrong, it
would have truncated a 64-bit value to 32 bits in that case.

                       Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
