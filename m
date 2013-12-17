Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vt1Fu-0001LC-VO
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 20:28:39 +0000
Date: Tue, 17 Dec 2013 21:28:07 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 3/4] makedumpfile/xen: Fail immediately on every
 architecture if dump level is invalid
Message-ID: <20131217202807.GJ3401@olila.local.net-space.pl>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
 <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C9FF0@BPXM01GP.gisp.nec.co.jp>
 <20131203194501.GD21544@olila.local.net-space.pl>
 <0910DD04CBD6DE4193FCF86B9C00BE971CCA93@BPXM01GP.gisp.nec.co.jp>
 <20131210103949.GJ3916@olila.local.net-space.pl>
 <0910DD04CBD6DE4193FCF86B9C00BE971D10DF@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971D10DF@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "david.vrabel@citrix.com" <david.vrabel@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Fri, Dec 13, 2013 at 06:59:06AM +0000, Atsushi Kumagai wrote:
> On 2013/12/10 19:41:54, kexec <kexec-bounces@lists.infradead.org> wrote:

[...]

> > Docs are not consistent because man and help displayed from makedumpfile
> > are different. Additionally, even man says nothing how to use this feature
> > on Xen vmcore file. If you use makedumpfile e.g.
> >
> > makedumpfile -Ed 2 /proc/vmcore vmcore
> >
> > it will not work because it uses VMCOREINFO_XEN instead of VMCOREINFO.
> > I discovered that if you would like to use feature from above mentioned
> > patch you must run makedumpfile in following way:
> >
> > makedumpfile -Ed 2 -x vmlinux /proc/vmcore vmcore
> >
> > Then makedumpfile will get info about dom0 directly from vmlinux.
>
> Certainly the documents should be fixed as you said, I'll do it.

Thanks.

> > However, It looks that there is another bug which prevents usage
> > of this feature. It looks it is related to change in P2M tree Linux
> > code. Once P2M levels where changed from 2 to 3. I fixed similar
> > issue in crash tool once.
>
> Thanks for your pointing out, I hope that you will fix that issue
> also in makedumpfile.

Yes, I am going to do that but not now. I am just very busy. Additionally,
I have discovered that this feature code is broken in more places because
it was not maintained more than four years. So, to be honest, it is simply
unusable right now.

> > When are you going to make a new makedumpfile release? I am going
> > to fix this issue before next release but now I am quite busy
> > with other stuff.
>
> I must release the new version(v1.5.5) in the next week at the latest
> because I announced the release date will be the beginning of December
> and there are already many patches for v1.5.5.
> So I would like to slip that fix you mentioned to v1.5.6.

OK.

> > Could you apply patches 1, 2 and 4 from this patch series?
> > It looks that they are not controversial.
>
> Sure, the three patches will be merged into v1.5.5.

Thanks.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
