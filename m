Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OpgXD-0000Lb-80
	for kexec@lists.infradead.org; Sun, 29 Aug 2010 11:58:51 +0000
Message-ID: <4C7A49F9.1030400@kernel.org>
Date: Sun, 29 Aug 2010 13:52:25 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <1236896997.1479691283083005518.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1236896997.1479691283083005518.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Cc: kexec <kexec@lists.infradead.org>, linux-next@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>

On 08/29/2010 01:56 PM, CAI Qian wrote:
> It is easy to reproduce by passing maxcpus=1 to the first kernel.

Do you mean booting w/ maxcpus=1 hangs the first kernel even w/o
kdump?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
