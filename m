Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T0GOh-0006K2-4N
 for kexec@lists.infradead.org; Sat, 11 Aug 2012 18:26:53 +0000
Received: by pbbrq8 with SMTP id rq8so3497579pbb.36
 for <kexec@lists.infradead.org>; Sat, 11 Aug 2012 11:26:49 -0700 (PDT)
Date: Sat, 11 Aug 2012 11:26:44 -0700
From: Jerry Snitselaar <dev@snitselaar.org>
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
Message-ID: <20120811182644.GA1787@cantor.Home>
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com> <1343145331.16290.45.camel@cr0>
 <500F3B7C.70009@jp.fujitsu.com> <20120811175759.GA1814@cantor.Home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120811175759.GA1814@cantor.Home>
Reply-To: Jerry Snitselaar <dev@snitselaar.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>, amwang@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, xiyou.wangcong@gmail.com, hpa@zytor.com, rjw@sisk.pl, yinghai.lu@oracle.com, tiwai@suse.de, kexec@lists.infradead.org

On Sat Aug 11 12, Jerry Snitselaar wrote:
> On Wed Jul 25 12, Takao Indoh wrote:
> > >Thanks for tracking this, Takao!
> > >
> > >I bet you are using x86_64 not x86 PAE? If so, could you try this patch
> > >https://patchwork.kernel.org/patch/1195751/
> > >? I already reviewed it.
> > 
> > Great, I applied it and now kdump works. Thanks!
> > 
> > Thanks,
> > Takao Indoh
> > 
> 
> This patch from Jacob Shin solves the problem, and seems like it might
> be a better solution.
> 
> [PATCH 2/5] x86: find_early_table_space based on memory ranges that
> are being mapped
> 
> https://lkml.org/lkml/2012/8/9/540
> 
Actually, apply that series of 5 patches.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
