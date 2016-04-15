Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x242.google.com ([2607:f8b0:4001:c05::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ar6vX-0004D3-Fa
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 16:49:06 +0000
Received: by mail-ig0-x242.google.com with SMTP id g8so3634803igr.0
 for <kexec@lists.infradead.org>; Fri, 15 Apr 2016 09:48:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0cc6c4836fae00b175b4595446e1ed4f@abdsec.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
 <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
 <CAGXu5jLRnabqSBjdPoaAs-h2VCd_Hn3=hj3JSWTsJvi-cPEjtg@mail.gmail.com>
 <0cc6c4836fae00b175b4595446e1ed4f@abdsec.com>
Date: Fri, 15 Apr 2016 09:48:42 -0700
Message-ID: <CA+55aFywMZ+X2o7LRt3KVNO9+gJt2yBmdyWR8M-k8WHhjJbf9w@mail.gmail.com>
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
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Zhengyu Zhang <zhezhang@redhat.com>, Kees Cook <keescook@google.com>, Dave Young <dyoung@redhat.com>

On Fri, Apr 15, 2016 at 8:46 AM, Emrah Demir <ed@abdsec.com> wrote:
>
> file_ns_capable bring some problems.

No it does not. file_ns_capable() is _required_ for security. We have
had several security issues with file IO doing "capable()", and it's
wrong and insecure.

> I used capable and now there is no problem as far as I tested.

You just screwed up the security, and with your change, a suid
application can be fooled into making the hidden data available to
non-secure users.

"capable()" is wrong. For file reading,  you *have* to use
file_ns_capable(). It really is that simple. You should not test the
capabilities of the process, you should be testing the capabilities of
the file descriptor, which comes from the *open-time* capabilities.

It sounds like you applied just the patch to kernel/resource.c,
without applying the infrastructure patch.

You also need commit 34dbbcdbf633 ("Make file credentials available to
the seqfile interfaces").

          Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
