Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cROgz-0000YR-MF
 for kexec@lists.infradead.org; Wed, 11 Jan 2017 19:36:19 +0000
Received: by mail-oi0-x242.google.com with SMTP id j15so23461528oih.0
 for <kexec@lists.infradead.org>; Wed, 11 Jan 2017 11:35:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5851D2F6.4020009@redhat.com>
References: <20161210002202.19829-1-robert@leblancnet.us>
 <20161210024927.GD1034@x1>
 <CAANLjFq92OLqsPmoz0FMHw9ZEyAm60s3M1UgkqTLtHabuQL6DA@mail.gmail.com>
 <5850B791.4040209@redhat.com>
 <CAANLjFokKcoDZR2YW2NR4ymRwwkJYLa66xWQUWsVoAg515jg=Q@mail.gmail.com>
 <5851D2F6.4020009@redhat.com>
From: Robert LeBlanc <robert@leblancnet.us>
Date: Wed, 11 Jan 2017 12:35:55 -0700
Message-ID: <CAANLjFpbk=jNi4xxqo+YGWwGic3OAAWbcmb_rCTNZ7VsZML2SQ@mail.gmail.com>
Subject: Re: [PATCH] Add +~800M crashkernel explaination
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
To: xlpang@redhat.com
Cc: kexec@lists.infradead.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org

On Wed, Dec 14, 2016 at 4:17 PM, Xunlei Pang <xpang@redhat.com> wrote:
> As I replied in another post, if you really want to detail the behaviour, should mention
> "crashkernel=size[KMG][@offset[KMG]]" with @offset[KMG] specified explicitly, after
> all, it's handled differently with no upper bound limitation, but doing this may put
> the first kernel at the risk of lacking low memory(some devices require 32bit DMA),
> must use it with care because the kernel will assume users are aware of what they
> are doing and make a successful reservation as long as the given range is available.

crashkernel=1024M@0x10000000

I can't get the offset to work. It seems that it allocates the space
and loads the crash kernel, but I couldn't get it to actually boot
into the crash kernel. Does it work for you? I'm using the 4.9 kernel.

Thanks

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
