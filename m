Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1429291343.5479.22.camel@infradead.org>
Subject: Re: [PATCH RFC 6/6] arm64: wait for transmit completion before next
 character transmission
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 17 Apr 2015 10:22:23 -0700
In-Reply-To: <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
> Previous transmission must be completed before next character to be
> transmitted, otherwise TX buffer may saturate and we will not see all
> the characters on screen.
> 
> @@ -34,6 +38,8 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>  "     --lite                Fast reboot, no memory integrity checks.\n"
>  "     --page-offset         Kernel page-offset for binary image load.\n"
>  "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> +"     --port-lsr=ADDRESS    Purgatory output port line status ADDRESS.\n"
> +"     --port-lsr-val=VALUE  Purgatory output port Line status expected SET value when TX empty.\n"
>  "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>  "     --reuse-cmdline       Use command line arg of primary kernel.\n";

We just need to put some chars to the screen, so I want to avoid a lot
of parameters.

Usually the status register is at a fixed offset from the TX port.  Is
that not the case for the ARM uarts?

Can't we just poll port-lsr until empty then start writing again?  That
will at least eliminate port-lsr-val.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
