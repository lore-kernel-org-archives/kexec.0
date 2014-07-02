Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2FhL-0005Wn-2s
 for kexec@lists.infradead.org; Wed, 02 Jul 2014 08:15:23 +0000
Date: Wed, 2 Jul 2014 16:13:49 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140702081349.GA20309@dhcp-16-105.nay.redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140611135701.GA1592@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9722440E@BPXM01GP.gisp.nec.co.jp>
 <20140623125723.GB29112@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
 <20140626123118.GB11136@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723B033@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9723B033@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 07/02/14 at 12:25am, Atsushi Kumagai wrote:
> >On Thu, Jun 26, 2014 at 08:21:58AM +0000, Atsushi Kumagai wrote:

> >I still don't understand that why makedumpfile can't provide an estimate
> >* of that momement * reasonably.
> 
> I think *estimate* is inappropriate to express this feature since it just
> analyze the memory usage at that moment, I want to avoid a misunderstanding
> that this feature is a prediction. 

I agree that understanding it as analyze memory usage is better.

> 
> >I don't want to implement a separate utility for this as makedumpfile
> >already has all the logic to go through pages, prepare bitmaps and figure
> >out which ones will be dumped. It will be just duplication of code and
> >waste of effort.
> >
> >We have a real problem at our hand. What do we tell customers that how
> >big your dump partition should be. They have a multi tera byte machine. Do
> >we tell them that create a multi tera byte dedicated dump partition.
> >That's not practical at all.
> >
> >And asking them to guess is not reasonable either. makedumpfile can make
> >much more educated guesses. It is not perfect but it is still much better
> >than user making a wild guess.
> 
> Well, fine. I have 2 requests for accepting this feature:
> 
>   - Make this feature as simple as possible.
>     I don't want to take time to maintain this, so I prefer the
>     other idea which, Baoquan said, is like HP UX's feature.

OK, I will try. In fact it's simple to just show the number of dumpable
pages.

> 
>   - Don't provide this feature as "vmcore size estimate", it just
>     show the number of dumpable pages at the moment. Then please show
>     the WARNING message to inform users about it.

OK, good suggestion. Will do.

> 
> Could you remake your patch, Baoquan?
> 
> 
> Thanks
> Atsushi Kumagai
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
