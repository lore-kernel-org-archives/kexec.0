Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1CcI-00F4km-AW
 for kexec@lists.infradead.org; Sat, 25 Dec 2021 19:22:09 +0000
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on kdump
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
Date: Sat, 25 Dec 2021 16:21:17 -0300
MIME-Version: 1.0
In-Reply-To: <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com, akpm@linux-foundation.org, feng.tang@intel.com, siglesias@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org

On 23/12/2021 22:35, Dave Young wrote:
> Hi Guilherme,
> [...]
> If only the doc update, I think it is fine to be another follup-up
> patch.
> 
> About your 1st option in patch log, there is crash_kexec_post_notifiers
> kernel param which can be used to switch on panic notifiers before kdump
> bootup.   Another way probably you can try to move panic print to be
> panic notifier. Have this been discussed before? 
> 

Hey Dave, thanks for the suggestion. I've considered that but didn't
like the idea. My reasoning was: allowing post notifiers on kdump will
highly compromise the reliability, whereas the panic_print is a solo
option, and not very invasive.

To mix it with all panic notifiers would just increase a lot the risk of
a kdump failure. Put in other words: if I'm a kdump user and in order to
have this panic_print setting I'd also need to enable post notifiers,
certainly I'll not use the feature, 'cause I don't wanna risk kdump too
much.

One other option I've considered however, and I'd appreciate your
opinion here, would be a new option on crash_kexec_post_notifiers that
allows the users to select *which few notifiers* they want to enable.
Currently it's all or nothing, and this approach is too heavy/risky I
believe. Allowing customization on which post notifiers the user wants
would be much better and in this case, having a post notifier for
panic_print makes a lot of sense. What do you think?

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
