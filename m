Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG5RF-0007bR-67
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 10:31:13 +0000
Date: Thu, 14 Mar 2013 19:30:59 +0900 (JST)
Message-Id: <20130314.193059.73439285.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kexec: check size before trying the malloc
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130314.192610.502672204.d.hatayama@jp.fujitsu.com>
References: <5140B469.8080308@gmail.com> <20130314083702.GB11196@verge.net.au>
 <20130314.192610.502672204.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, zhangyanfei.yes@gmail.com

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kexec: check size before trying the malloc
Date: Thu, 14 Mar 2013 19:26:10 +0900

> From: Simon Horman <horms@verge.net.au>
> Subject: Re: [PATCH] kexec: check size before trying the malloc
> Date: Thu, 14 Mar 2013 09:37:03 +0100
> 
>> On Thu, Mar 14, 2013 at 01:16:25AM +0800, Zhang Yanfei wrote:
>>> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>>> 
>>> If size is zero, it is unnecessary to do the malloc operation.
>>> So checking size first is better than doing malloc first.
>>> 
>>> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>> 
>> Thanks, applied.
>> 
> 
> Wait. The check should not be removed.

Sorry, Android screen is so small that I wrongly read the patch. I
have no objection.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
