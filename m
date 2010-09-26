Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OzlAq-00023Q-50
	for kexec@lists.infradead.org; Sun, 26 Sep 2010 06:57:24 +0000
Message-ID: <4C9EEE98.7020906@kernel.org>
Date: Sat, 25 Sep 2010 23:56:24 -0700
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Subject: Re: kexec load failure introduced by "x86,
	memblock: Replace e820_/_early string with memblock_"
References: <637638372.1993021285484132309.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <637638372.1993021285484132309.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Cc: linux-next <linux-next@vger.kernel.org>, kexec <kexec@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>

On 09/25/2010 11:55 PM, CAI Qian wrote:
>>
>> are you kexec from 2.6.35+ to 2.6.36-rc3+?
> No, both kernels were the same version. I am sorry the above logs were misleading that were copy-and-pasted from different kernel versions.

can you check tip instead of next tree?

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
