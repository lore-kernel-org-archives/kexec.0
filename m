Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VenB8-000583-AR
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 14:36:55 +0000
Message-Id: <527D04FE02000078001013F5@nat28.tlf.novell.com>
Date: Fri, 08 Nov 2013 14:36:30 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for
 use with pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527CE397.10101@citrix.com>
 <527CF3050200007800101354@nat28.tlf.novell.com>
 <527CEEB8.4070609@citrix.com>
In-Reply-To: <527CEEB8.4070609@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Keir Fraser <keir@xen.org>, DanielKiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org

>>> On 08.11.13 at 15:01, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> On 08/11/13 13:19, Jan Beulich wrote:
>>>>> On 08.11.13 at 14:13, David Vrabel <david.vrabel@citrix.com> wrote:
>>> Keir,
>>>
>>> Sorry, forgot to CC you on this series.
>>>
>>> Can we have your opinion on whether this kexec series can be merged?
>>> And if not, what further work and/or testing is required?
>> Just to clarify - unless I missed something, there was still no
>> review of this from Daniel or someone else known to be
>> familiar with the subject. If Keir gave his ack, formally this
>> could go in, but I wouldn't feel too well with that (the more
>> that apart from not having reviewed it, Daniel seems to also
>> continue to have problems with it).
> 
> Can I have myself deemed to be familiar with the subject as far as this
> is concerned?
> 
> A noticeable quantity of my contributions to Xen have been in the kexec
> / crash areas, and I am the author of the xen-crashdump-analyser.

I'm sorry, I didn't mean to offend you in any way. In fact David
and I briefly discussed this situation on the summit, and he sort
of understood that I consider your review valuable, but ...

> I do realise that I certainly not impartial as far as this series is
> concerned, being a co-developer.

... possibly/likely biased. Not the least because both of you work
for Citrix. I'm therefore rather after a second, really independent
review.

Please forgive me not having expressed myself correctly.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
