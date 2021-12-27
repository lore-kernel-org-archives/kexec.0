Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1f5Z-00G0T1-SI
 for kexec@lists.infradead.org; Mon, 27 Dec 2021 01:46:16 +0000
Date: Mon, 27 Dec 2021 09:45:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on kdump
Message-ID: <Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
 <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
 <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b817a4f-0bba-7d79-8aab-33c58e922293@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com, akpm@linux-foundation.org, feng.tang@intel.com, siglesias@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org

On 12/25/21 at 04:21pm, Guilherme G. Piccoli wrote:
> On 23/12/2021 22:35, Dave Young wrote:
> > Hi Guilherme,
> > [...]
> > If only the doc update, I think it is fine to be another follup-up
> > patch.
> > 
> > About your 1st option in patch log, there is crash_kexec_post_notifiers
> > kernel param which can be used to switch on panic notifiers before kdump
> > bootup.   Another way probably you can try to move panic print to be
> > panic notifier. Have this been discussed before? 
> > 
> 
> Hey Dave, thanks for the suggestion. I've considered that but didn't
> like the idea. My reasoning was: allowing post notifiers on kdump will
> highly compromise the reliability, whereas the panic_print is a solo
> option, and not very invasive.
> 
> To mix it with all panic notifiers would just increase a lot the risk of
> a kdump failure. Put in other words: if I'm a kdump user and in order to
> have this panic_print setting I'd also need to enable post notifiers,
> certainly I'll not use the feature, 'cause I don't wanna risk kdump too
> much.

Hi Guilherme, yes, I have the same concern.  But there could be more
things like the panic_print in the future, it looks odd to have more
kernel cmdline params though.

> 
> One other option I've considered however, and I'd appreciate your
> opinion here, would be a new option on crash_kexec_post_notifiers that
> allows the users to select *which few notifiers* they want to enable.
> Currently it's all or nothing, and this approach is too heavy/risky I
> believe. Allowing customization on which post notifiers the user wants
> would be much better and in this case, having a post notifier for
> panic_print makes a lot of sense. What do you think?

It is definitely a good idea, I'm more than glad to see this if you
would like to work on this! 

> 
> Thanks!
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
