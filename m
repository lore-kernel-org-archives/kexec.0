Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Opzr5-00035h-Ge
	for kexec@lists.infradead.org; Mon, 30 Aug 2010 08:36:39 +0000
Message-ID: <4C7B6C07.6010800@kernel.org>
Date: Mon, 30 Aug 2010 10:29:59 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <1888320510.1487031283139773505.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1888320510.1487031283139773505.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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

On 08/30/2010 05:42 AM, CAI Qian wrote:
>> Hmmm... I can't reproduce it here.  I wonder what the difference is.
>> Can you please trigger sysrq-t after the boot is hung and post the
>> result?
> Sysrq keys did not work at this early stage of booting for me even
> adding sysrq_always_enabled.

I see.  I'll prepare a debug patch which tries to catch long execution
delays in workqueue but in the meantime can you please turn on
hangcheck timer and see whether it triggers after the kernel hangs
during boot?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
