Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evzh2-000541-9z
 for kexec@lists.infradead.org; Wed, 14 Mar 2018 06:15:22 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [makedumpfile PATCH] Always use bigger SECTION_MAP_MASK
Date: Wed, 14 Mar 2018 06:14:20 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011829B8@BPXM01GP.gisp.nec.co.jp>
References: <20180202091857.09299610@ezekiel.suse.cz>
 <61D4E5D821F1674CB87C99F080A210BE011825C6@BPXM01GP.gisp.nec.co.jp>
 <20180313105931.3fce6e44@ezekiel.suse.cz>
In-Reply-To: <20180313105931.3fce6e44@ezekiel.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>, kexec mailing list <kexec@lists.infradead.org>

Hi Petr,

Thank you for your explanation.
I understand.
I think we have to show it's not a bug for the future people.
Would you insert comments before definition of SECTION_MAP_LAST_BIT
and resend the patch ?
For example. (Better English is welcome.)

#define SECTION_IS_ONLINE       (1UL<<2)
/*
 * In case of upstream kernels before 4.13;
 * 1. SECTION_MAP_LAST_BIT must be (1UL<<2), but it's dependent on distribution
 *    whether the bit shift should be 2 or 3.
 * 2. It has been verified that (1UL<<2) bit is not set.
 * So for both old kernels and new ones, we use 3.
 */
#define SECTION_MAP_LAST_BIT    (1UL<<3)

Thanks
Tachibana

> -----Original Message-----
> From: Petr Tesarik [mailto:ptesarik@suse.com]
> Sent: Tuesday, March 13, 2018 7:00 PM
> To: Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> Cc: kexec mailing list <kexec@lists.infradead.org>; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>
> Subject: Re: [makedumpfile PATCH] Always use bigger SECTION_MAP_MASK
> 
> Hi,
> 
> On Tue, 13 Mar 2018 09:18:54 +0000
> Masaki Tachibana <mas-tachibana@vf.jp.nec.com> wrote:
> 
> > Hi Petr,
> >
> > Sorry for the late reply.
> 
> Never mind. I was on vacation, anyway. ;-)
> 
> > > -----Original Message-----
> > > From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Petr Tesarik
> > > Sent: Friday, February 02, 2018 5:19 PM
> > > To: kexec mailing list <kexec@lists.infradead.org>; Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>; Nakayama
> > > Takuya() <tak-nakayama@tg.jp.nec.com>; Nishimura Daisuke() <dai-nishimura@rc.jp.nec.com>
> > > Subject: [makedumpfile PATCH] Always use bigger SECTION_MAP_MASK
> > >
> > > It is not necessary to distinguish between different kernel
> > > versions. Kernel commit 2d070eab2e82 merely reuses a previously
> > > unused bit (see clarification in kernel commit def9b71ee651a). The
> > > bit was always zero even before that commit, so it is safe to mask
> > > it off even for kernel versions before 4.13, removing some of the
> > > complexity.
> > >
> > > More importantly, makedumpfile fails on kernels which backport the
> > > patch on top of an older version (for example SLES15).
> >
> > I understand circumstances of SLES.
> > However I am worried;
> > - Is it good that we correct the following specified code for the
> >   particular distribution?
> 
> No, absolutely not. That's why I'm not trying to fix a particular
> distribution, but rather make it work for all distributions (including
> my own).
> 
> > - Is it good that makedumpfile ignores the bit because the kernel
> >   isn't using it?
> 
> I've given it a serious thought before writing my patch. Let me explain.
> 
> First, what happens if the bit is set?
> 
>   A. If the kernel version is at least 4.13.0, then my patch does not
>      change makedumpfile's behaviour.
> 
>   B. If the kernel version is older than 4.13.0, then I have verified
>      that the bit must not be set. If it is set, then this is a bug in
>      the kernel or random memory corruption. The kernel would then use
>      an incorrect memmap address, probably crashing in short time.
>      Without my patch, makedumpfile will most likely fail to produce
>      any output. With my patch, it may produce some output.
> 
> Second, my patch simplifies makedumpfile code, which is good in itself,
> because it reduces the maintenance burden going forward. A few years
> from now everybody will be too afraid of regressions to do such cleanup.
> 
> The only downside is that in case B above, makedumpfile may silently
> produce incorrect output instead of failing mysteriously with an
> error message such as: "Can't convert a virtual address
> (f000000001000000) to physical address".
> 
> Just my two cents,
> Petr Tesarik



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
