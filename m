Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0hrT-0002j5-DM
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 00:18:39 +0000
Message-ID: <5109B855.1070600@zytor.com>
Date: Wed, 30 Jan 2013 16:18:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <51099A3E.5090705@zytor.com> <87ehh2l2z3.fsf@xmission.com>
 <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
In-Reply-To: <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, yinghai@kernel.org, vgoyal@redhat.com

On 01/30/2013 04:15 PM, Thomas Renninger wrote:
> 
> I guess both ways are a huge enhancement compared to what we have now.
> Which approach to finally take should not matter that much, but because
> of above I still prefer to go this way:
> - Pass a kernel command line option that just changes the kernels idea
>   of which memory it can touch
> 

The kernel command line is a human-oriented data structure with limited
size and fairly complex semantics.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
