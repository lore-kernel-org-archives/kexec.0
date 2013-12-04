Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo5hD-0003Fn-93
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 06:12:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
Date: Wed, 4 Dec 2013 06:08:54 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971CAC5D@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE971CA130@BPXM01GP.gisp.nec.co.jp>
 <529D9ECB.1060402@jp.fujitsu.com>
In-Reply-To: <529D9ECB.1060402@jp.fujitsu.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "jingbai.ma@hp.com" <jingbai.ma@hp.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 2013/12/03 18:06:13, kexec <kexec-bounces@lists.infradead.org> wrote:
> >> This is a suggestion from different point of view...
> >>
> >> In general, data on crash dump can be corrupted. Thus, order contained in a page
> >> descriptor can also be corrupted. For example, if the corrupted value were a huge
> >> number, wide range of pages after buddy page would be filtered falsely.
> >>
> >> So, actually we should sanity check data in crash dump before using them for application
> >> level feature. I've picked up order contained in page descriptor, so there would be other
> >> data used in makedumpfile that are not checked.
> > 
> > What you said is reasonable, but how will you do such sanity check ?
> > Certain standard values are necessary for sanity check, how will
> > you prepare such values ?
> > (Get them from kernel source and hard-code them in makedumpfile ?)
> > 
> >> Unlike diskdump, we no longer need to care about kernel/hardware level data integrity
> >> outside of user-land, but we still care about data its own integrity.
> >>
> >> On the other hand, if we do it, we might face some difficulty, for example, hardness of
> >> maintenance or performance bottleneck; it might be the reason why we don't see sanity
> >> check in makedumpfile now.
> > 
> > There are many values which should be checked, e.g. page.flags, page._count,
> > page.mapping, list_head.next and so on.
> > If we introduce sanity check for them, the issues you mentioned will be appear
> > distinctly.
> > 
> > So I think makedumpfile has to trust crash dump in practice.
> > 
> 
> Yes, I don't mean such very drastic checking; I understand hardness because I often
> handle/write this kind of code; I don't want to fight tremendously many dependencies...
> 
> So we need to concentrate on things that can affect makedumpfile's behavior significantly,
> e.g. infinite loop caused by broken linked list objects, buffer overrun cauesd by large values
> from broken data, etc. We should be able to deal with them by carefully handling
> dump data against makedumpfile's runtime data structure, e.g., buffer size.
> 
> Is it OK to consider this is a policy of makedumpfile for data corruption?

Right. 
Of course, if there is a very simple and effective check for a dump data, 
then we can take it.


Thanks
Atsushi Kumagai

> -- 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
