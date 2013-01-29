Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00gE-00017N-7S
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:12:10 +0000
Message-ID: <51072FEF.50000@zytor.com>
Date: Mon, 28 Jan 2013 18:11:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de> <510721C6.6080705@zytor.com>
 <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
In-Reply-To: <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On 01/28/2013 06:10 PM, Yinghai Lu wrote:
>
> kexec-tools will change that to E820_KDUMP_RESERVED (or other good name).
>
> We only need to update kernel to get old max_pfn by
> checking E820_KDUMP_RESERVED.
>

OK, I have asked this before, but I still have not gotten any acceptable 
answer:

Why do we still have max_*_pfn at all?  Shouldn't it all be based on 
memblocks by now?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
