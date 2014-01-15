Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3FVV-0007kq-Or
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 01:43:02 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20140109153703.GE25897@redhat.com>
Date: Tue, 14 Jan 2014 17:42:13 -0800
In-Reply-To: <20140109153703.GE25897@redhat.com> (Vivek Goyal's message of
 "Thu, 9 Jan 2014 10:37:03 -0500")
Message-ID: <87a9eyaumi.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Query regarding ELF loader arg style
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> Hi Eric,
>
> I am looking at kexec ELF loader code and wondering what are arg style
> options.
>
> #define ARG_STYLE_ELF   0
> #define ARG_STYLE_LINUX 1
> #define ARG_STYLE_NONE  2
>
>
> I have looked at them many a times but frankly never fully understood
> what do they represent and what's the intention behind them. Can you
> please elaborate a bit on this.

There is no standard of what kind of arguments a standalone ELF
executable will receive from a bootloader.

Which means that in practice to support different OS's you either need
to pass nothing or make something up.

ARG_STYLE_ELF is my own invention and a sad attempt at coming up with an
OS agnostic standard.

ARG_STYLE_LINUX is an ELF image receiving the same arguments as the
linux kernel.  It is a mess but it is reasonably well documented.

ARG_STYLE_NONE should just be simpley passing nothing into an ELF image.

When moving the code into the kernel we should be able to simply use
ARG_STYLE_LINUX.  We can revist the other cases if there is ever a need.

The problem is real but I don't know if it needs to be solved any time soon.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
