Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57DC181D.20206@arm.com>
Date: Fri, 16 Sep 2016 17:04:45 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v26 4/7] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-5-takahiro.akashi@linaro.org>
In-Reply-To: <20160907042908.6232-5-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 07/09/16 05:29, AKASHI Takahiro wrote:
> For the current crash utility, we need to know, at least,
>   - kimage_voffset
>   - PHYS_OFFSET
> to handle the contents of core dump file (/proc/vmcore) correctly due to
> the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
> This patch puts them as VMCOREINFO's into the file.
> 
>   - VA_BITS
> is also added for makedumpfile command.
> More VMCOREINFO's may be added later.


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
