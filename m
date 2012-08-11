Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T0Gap-0004ue-H0
 for kexec@lists.infradead.org; Sat, 11 Aug 2012 18:39:24 +0000
Message-ID: <5026A6D1.8070403@zytor.com>
Date: Sat, 11 Aug 2012 11:39:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com> <1343145331.16290.45.camel@cr0>
 <500F3B7C.70009@jp.fujitsu.com> <20120811175759.GA1814@cantor.Home>
 <20120811182644.GA1787@cantor.Home> <5026A5AE.6050608@zytor.com>
In-Reply-To: <5026A5AE.6050608@zytor.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>, amwang@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, xiyou.wangcong@gmail.com, rjw@sisk.pl, yinghai.lu@oracle.com, tiwai@suse.de, kexec@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Jacob Shin <jacob.shin@amd.com>

On 08/11/2012 11:34 AM, H. Peter Anvin wrote:
> On 08/11/2012 11:26 AM, Jerry Snitselaar wrote:
>>>
>>> This patch from Jacob Shin solves the problem, and seems like it might
>>> be a better solution.
>>>
>>> [PATCH 2/5] x86: find_early_table_space based on memory ranges that
>>> are being mapped
>>>
>>> https://lkml.org/lkml/2012/8/9/540
>>>
>> Actually, apply that series of 5 patches.
>>
>
> I was hoping Tejun would comment on it, but I think I'll pull it into -tip.
>
> However, the real question is what we should do for -stable; applying
> the full patch series seems a big aggressive for that.  On the other
> hand, if it really is The Right Thing then perhaps we should do so anyway.
>

Ah, right... still waiting for a rev of the patch to address Yinghai's 
legitimate request for minor code restructuring.  Other than that, the 
patchset is really The Right Thing.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
