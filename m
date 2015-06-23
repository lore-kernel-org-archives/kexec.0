Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z7XTP-0006i4-Ut
 for kexec@lists.infradead.org; Tue, 23 Jun 2015 23:19:24 +0000
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: timur@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id F37ED140EB4
 for <kexec@lists.infradead.org>; Tue, 23 Jun 2015 23:19:01 +0000 (UTC)
Received: by igboe5 with SMTP id oe5so101374898igb.1
 for <kexec@lists.infradead.org>; Tue, 23 Jun 2015 16:19:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
Date: Tue, 23 Jun 2015 18:19:01 -0500
Message-ID: <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: Timur Tabi <timur@codeaurora.org>
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
To: Pratyush Anand <panand@redhat.com>
Cc: virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com, asamson@codeaurora.org, kexec@lists.infradead.org

On Fri, May 15, 2015 at 1:30 PM, Pratyush Anand <panand@redhat.com> wrote:
> Patch adds support for ARM64 in makedumpfile. It takes care of vmalloc,
> vmemmap, module and directly map kernel memory region's translation.
>
> Currently we only support 2 leverl 64K pages and VA_BITS as 42. Support
> to find these machine specific parameters dynamically and then to act
> accordingly can be added latter.

So ARM64 kernels are typically compiled with 3-level 4KB pages:

CONFIG_ARM64_4K_PAGES=y
# CONFIG_ARM64_64K_PAGES is not set
CONFIG_ARM64_VA_BITS_39=y
# CONFIG_ARM64_VA_BITS_48 is not set
CONFIG_ARM64_VA_BITS=39

Does this mean that your patch won't work on such a kernel?  If so, do
you have any plans to add support for 4K 3-level pages?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
