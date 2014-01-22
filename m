Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <52DFC1BA.8030001@huawei.com>
Date: Wed, 22 Jan 2014 21:03:54 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] ARM: kexec: copying code to ioremapped area
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>	<1390389916-8711-3-git-send-email-wangnan0@huawei.com>
 <CANacCWz2DdLvns9htszpwWnASrYGXQt+tHMsw4aBbjoyw-DmeQ@mail.gmail.com>
In-Reply-To: <CANacCWz2DdLvns9htszpwWnASrYGXQt+tHMsw4aBbjoyw-DmeQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Geng Hui <hui.geng@huawei.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 2014/1/22 20:56, Vaibhav Bedia wrote:
> On Wed, Jan 22, 2014 at 6:25 AM, Wang Nan <wangnan0@huawei.com <mailto:wangnan0@huawei.com>> wrote:
> 
>     ARM's kdump is actually corrupted (at least for omap4460), mainly because of
>     cache problem: flush_icache_range can't reliably ensure the copied data
>     correctly goes into RAM. After mmu turned off and jump to the trampoline, kexec
>     always failed due to random undef instructions.
> 
>     This patch use ioremap to make sure the destnation of all memcpy() is
>     uncachable memory, including copying of target kernel and trampoline.
> 
> 
> AFAIK ioremap on RAM in forbidden in ARM and device memory that ioremap()
> ends up creating is not meant for executable code.
> 
> Doesn't this trigger the WARN_ON() in _arm_ioremap_pfn_caller)?

This patch is depend on the previous one:

ARM: Premit ioremap() to map reserved pages

However, Russell is opposed to it.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
