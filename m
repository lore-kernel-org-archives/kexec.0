Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Opg32-0001l2-SK
	for kexec@lists.infradead.org; Sun, 29 Aug 2010 11:27:41 +0000
Message-ID: <4C7A42AA.1000806@kernel.org>
Date: Sun, 29 Aug 2010 13:21:14 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <633505726.1479321283081093502.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <633505726.1479321283081093502.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: torvalds@linux-foundation.org, linux-next@vger.kernel.org, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hello,

On 08/29/2010 01:24 PM, CAI Qian wrote:
>> On 08/29/2010 09:01 AM, caiqian@redhat.com wrote:
>>> Further bisect indicated this bad commit from the merge. Given kdump
>>> kernel was running with maxcpus=1, I guess this work caused fs/bio.c
>>> hung in the workqueue on UP. Reverted the whole merge let kdump work
>>> again.
>>
>> Can you please pull from the following git tree and see whether it
>> fixes the problem?  There was a bug in nr_active accounting.
>
> It had the same problem.

I see.  Hmm... a different issue then.  Can you please tell me how to
reproduce the problem?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
