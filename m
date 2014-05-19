Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 19 May 2014 17:09:48 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH Resend] ARM: kdump: makes second kernel use strict
 pfn_valid
Message-ID: <20140519160947.GM15130@arm.com>
References: <1400464443-34816-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400464443-34816-1-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Geng Hui <hui.geng@huawei.com>, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, May 19, 2014 at 02:54:03AM +0100, Wang Nan wrote:
> When SPARSEMEM and CRASH_DUMP both selected, simple pfn_valid prevents
> the second kernel ioremap first kernel's memory if the address falls
> into second kernel section. This limitation requires the second kernel
> occupies a full section, and elfcorehdr must resides in another section.
> 
> This patch makes crash dump kernel use strict pfn_valid, removes such
> limitation.
> 
> For example:
> 
>   For a platform with SECTION_SIZE_BITS == 28 (256MiB) and
>   crashkernel=128M@0x28000000 in kernel cmdline, the second
>   kernel is loaded at 0x28000000. Kexec puts elfcorehdr at
>   0x2ff00000, and passes 'elfcorehdr=0x2ff00000 mem=130048K' to
>   second kernel. When second kernel start, it tries to use
>   ioremap to retrive its elfcorehrd. In this case, elfcodehdr is at the
>   same section of the second kernel, pfn_valid will recongnize
>   the page as valid, so ioremap will refuse to map it.

So isn't the issue here that you're passing an incorrect mem= parameter
to the crash kernel?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
