Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam03on0612.outbound.protection.outlook.com
 ([2a01:111:f400:fe4a::612]
 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e47tl-0003yQ-Dq
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 16:05:51 +0000
Subject: Re: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON
 CPUs.
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-4-david.daney@cavium.com>
 <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
Date: Mon, 16 Oct 2017 09:05:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, David Daney <david.daney@cavium.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org

On 10/15/2017 11:56 PM, Simon Horman wrote:
> On Thu, Oct 12, 2017 at 02:02:27PM -0700, David Daney wrote:
>> The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
>> 0x8000000000000000ULL, which is differs from other CPUs.
>>
>> Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
>> patch the page_offset so that usable kdump core files are produced.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Is it possible to read this offset from the system rather than
> checking for an Octeon CPU? It seems that such an approach, if possible,
> would be somewhat more general.
> 

Before implementing this scanning of /proc/cpuinfo, I thought long and 
hard about this, and couldn't think of how the PAGE_OFFSET could be 
derived from information available in userspace.

Ralf (MIPS maintainer) may have an idea, but these address bits don't 
show up in /proc/kallsyms or any other file in /proc or /sys that I am 
aware of.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
