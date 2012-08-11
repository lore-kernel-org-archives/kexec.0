Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T0HRK-0006jZ-9m
 for kexec@lists.infradead.org; Sat, 11 Aug 2012 19:33:39 +0000
Received: by pbbrq8 with SMTP id rq8so3569145pbb.36
 for <kexec@lists.infradead.org>; Sat, 11 Aug 2012 12:33:32 -0700 (PDT)
Date: Sat, 11 Aug 2012 12:33:27 -0700
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
Message-ID: <20120811193327.GB2874@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com> <1343145331.16290.45.camel@cr0>
 <500F3B7C.70009@jp.fujitsu.com> <20120811175759.GA1814@cantor.Home>
 <20120811182644.GA1787@cantor.Home> <5026A5AE.6050608@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5026A5AE.6050608@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai.lu@oracle.com, Takao Indoh <indou.takao@jp.fujitsu.com>, amwang@redhat.com, tiwai@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, xiyou.wangcong@gmail.com, akpm@linux-foundation.org, dyoung@redhat.com

On Sat, Aug 11, 2012 at 11:34:22AM -0700, H. Peter Anvin wrote:
> On 08/11/2012 11:26 AM, Jerry Snitselaar wrote:
> >>
> >>This patch from Jacob Shin solves the problem, and seems like it might
> >>be a better solution.
> >>
> >>[PATCH 2/5] x86: find_early_table_space based on memory ranges that
> >>are being mapped
> >>
> >>https://lkml.org/lkml/2012/8/9/540
> >>
> >Actually, apply that series of 5 patches.
> >
> 
> I was hoping Tejun would comment on it, but I think I'll pull it into -tip.

Wasn't cc'd.  Will take a look.

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
