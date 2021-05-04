Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le4B6-004KEq-MN
 for kexec@lists.infradead.org; Tue, 04 May 2021 23:10:10 +0000
Received: by mail-qk1-x72d.google.com with SMTP id i17so10403829qki.3
 for <kexec@lists.infradead.org>; Tue, 04 May 2021 16:10:07 -0700 (PDT)
Date: Tue, 4 May 2021 19:09:54 -0400
From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Setting "orig_video_isVGA" when handing off Linux framebuffer
Message-ID: <20210504190954.46edf191@gmail.com>
In-Reply-To: <20210423154657.40324d86@gmail.com>
References: <20210423154657.40324d86@gmail.com>
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
To: kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>, Dave Young <dyoung@redhat.com>

Hi,

In regard to how kexec hands off the framebuffer to the newly-booted
kernel:

Commit 060eee589dd1 (2018-01-28) added the "blindly try old boot time
video type" behavior, without doing any checking to see if the
framebuffer is compatible with the stated format.

Commit fb5a8792e6e4 (2019-03-05) made this behavior conditional on the
--reuse-video-type option.  The commit message observes that:

    Currently kernel hanging is inspected on some hyper-v VMs after this
    commit, because hyperv_fb will mimic EFI (or VESA) VGA on first boot
    up, but after the real driver is loaded, it will switch to new mode
    and no longer compatible with EFI/VESA VGA. Keep setting
    orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded
    and try to manipulate the framebuffer in a wrong way.

It's clear to me that various bad things *might* happen if kexec
pretends that the framebuffer is "VESA-compatible" or "EFI-compatible"
when in fact it isn't.

Yet, in many cases, the Linux framebuffer is VESA/EFI-compatible, at
least to the extent that blindly setting orig_video_isVGA = 0x23 or
0x70 results in a usable display.  So I have to wonder, in the
situation mentioned above:

 - was the framebuffer not in a compatible format to begin with?

 - was the framebuffer address not correctly reported by the existing
   kernel driver?

 - did the original bootloader give wrong information and somehow that
   broke the newly booted kernel?

Kairui, can you please clarify what sort of kernel hangs you were
seeing and what specific hardware and drivers you were using?

Benjamin Moody

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
