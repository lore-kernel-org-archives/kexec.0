Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OphEW-0004N7-Hb
	for kexec@lists.infradead.org; Sun, 29 Aug 2010 12:43:36 +0000
Message-ID: <4C7A5455.7060905@kernel.org>
Date: Sun, 29 Aug 2010 14:36:37 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <779893521.1479771283083393771.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <779893521.1479771283083393771.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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

On 08/29/2010 02:03 PM, CAI Qian wrote:
> 
> ----- "Tejun Heo" <tj@kernel.org> wrote:
> 
>> On 08/29/2010 01:56 PM, CAI Qian wrote:
>>> It is easy to reproduce by passing maxcpus=1 to the first kernel.
>>
>> Do you mean booting w/ maxcpus=1 hangs the first kernel even w/o
>> kdump?
> Yes, here was the log,

Hmmm... I can't reproduce it here.  I wonder what the difference is.
Can you please trigger sysrq-t after the boot is hung and post the
result?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
