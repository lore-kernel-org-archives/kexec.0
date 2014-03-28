Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t1627.atlanta.hp.com ([15.192.137.10])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTVxG-0003p5-TA
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 12:32:15 +0000
Message-ID: <53356BB4.4010001@hp.com>
Date: Fri, 28 Mar 2014 20:31:48 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [BUG] makedumpfile v1.5.5
References: <5332B587.3030407@hp.com>
 <20140327.022032.54368351.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140327.022032.54368351.d.hatayama@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, jingbai.ma@hp.com

On 03/27/2014 09:20 AM, HATAYAMA Daisuke wrote:
>
> Sorry. This was fixed by the following patch.
>
> commit 4404368a0860e3b6c845eb41782e97a9bf7593b8
> Author: WANG Chao <chaowang@redhat.com>
> Date:   Wed Dec 18 22:34:43 2013 +0900
>
>      [PATCH] memset() in cyclic bitmap initialization introduce segment fault.
>
> Thanks.
> HATAYAMA, Daisuke
>

I have applied this patch, the problem still exists, so I investigated 
on it a bit more, I found the root cause.
I have sent a patch to fix it:
http://lists.infradead.org/pipermail/kexec/2014-March/011408.html


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
